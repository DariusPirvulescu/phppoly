# frozen_string_literal: true

# Adds contents of a PHP file into a JPG image
# Usage ./phppoly <jpg_filepath> <php_filepath>
# TODO: change - Will create a out.php file

jpg_filepath = ARGV[0]
php_filepath = ARGV[1]
php_code = File.read(php_filepath) if php_filepath
out_filename = 'avatar'
usage_string = 'Usage: ./phppoly <destination_jpg_file> <source_php_file>'

# Validation
if ARGV.length != 2
  puts usage_string
  exit
end

# Check if destination is not JPG
unless %w[.jpg .jpeg].include? File.extname(jpg_filepath)
  puts "Destination file extension must be .jpg or .jpeg\n#{usage_string}"
  exit
end

# Check if source is not PHP
unless %w[.php].include? File.extname(php_filepath)
  puts "Destination file extension must be .php\n#{usage_string}"
  exit
end

if php_code == ''
  puts "PHP file cannot be empty\n#{usage_string}"
  exit
end

def bin_to_hex(buff)
  buff.unpack('H*').first.scan(/../)
end

def hex_to_bin(bytes)
  bytes.map { |x| x.hex }.pack('c*')
end

def write_out(filename, buf)
  ['.php', '.jpg'].each do |ext|
    name = filename + ext
    out_file = File.new(name, 'w')
    puts "Writing to file #{name} ..."
    out_file.print(buf)
    out_file.close
  end
end

out = []

File.open(jpg_filepath, 'rb') do |file|
  jpg_buffer = file.read
  hex_rep = bin_to_hex(jpg_buffer)

  # JPEG always starts with \xFF\xD8, keep the existing ones
  out = hex_rep[0..1]

  # Strip code
  stripped_code = php_code.strip
  # Get size of code
  code_size = stripped_code.size
  # Transform size into
  size_marker = '%.4x' % (code_size + 2)

  # Check if it has Quantization table (bytes \xFF\xDB)
  has_quantization_table = hex_rep[2..3].join == 'ffdb'
  if has_quantization_table
    # Add comment marker (\xFF\xFE) + size + comment
    out.concat %w[ff fe]
    out.concat size_marker.scan(/../)
    out.concat bin_to_hex(stripped_code)

    # Add the rest of bytes
    out.concat hex_rep[2..]

  else

    # Add the App0 + header size markers
    out.concat hex_rep[2..5]
    # Check the header size + marker size
    header_size = hex_rep[4..5].join.hex

    # Add the JFIF APP0 identifier (always \x4A\x46\x49\x46\x00)
    jfif_app0 = %w[4a 46 49 46 00]
    out.concat jfif_app0

    # Add the rest of the header + with marker size
    out.concat hex_rep[(6 + jfif_app0.size)..(header_size + 3)]

    # Add comment + size markers and comment
    out.concat %w[ff fe]
    out.concat size_marker.scan(/../)
    out.concat bin_to_hex(stripped_code)

    # Add the rest, after SOI (2) + App0 (2) + header (variable size - header_size)
    size_left = header_size + 4
    out.concat hex_rep[size_left..]
  end

  write_out(out_filename, hex_to_bin(out))
  puts 'Code added'
end
