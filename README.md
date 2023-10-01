# phppoly

Script to create a polyglot files. It combines the content of a PHP file with an existing JPG image.

## Running the script

```
ruby phppoly.rb test.jpg my_php_exploit.php
```

This will not affect the input files. If successful, it will create two new files in both JPG and PHP format. Output file names can be configured by changing the `out_filename` variable's value (*avatar* by default).

There's a Proof of Concept created, more info on the [POC README.md](https://github.com/DariusPirvulescu/phppoly/blob/main/proof_of_concept/README.md).

Copy the two new files to the POC folder.
```
cp avatar.jpg avatar.php proof_of_concept
```



Inspired by https://github.com/Wuelle/js_jpeg_polyglot

