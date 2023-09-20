<?php include_once('header.php'); ?>

<?php
  // PHP file
  echo "<h3>Polyglot file as .php</h3>";
  if (file_exists('avatar.php')) {
    echo 'Avatar (with injected PHP code): <br/>';
    echo '<img src="avatar.php"/>';

    // Identify the image
    echo "<br/><br/>";
    echo "Detected filetype for 'avatar.php': <br/>";
    $finfo = finfo_open(FILEINFO_MIME_TYPE); // Return MIME type
    $filename = 'avatar.php';
    echo finfo_file($finfo, $filename) . "<br/>";
    finfo_close($finfo);
  } else {
    echo "<p>Add the polyglot file <b>avatar.php</b> to this project.</p>";
  };
?>

<hr />

<?php
  // JPG file
  echo "<h3>Polyglot file as .jpg</h3>";

  if (file_exists('avatar.jpg')) {
    echo 'Avatar JPG: <br/>';
    echo '<img src="avatar.jpg" style="width: 150;height: 170;"/>';

    // Identify the image
    echo "<br/><br/>";
    echo "Detected filetype for 'avatar.jpg': <br/>";
    $finfo = finfo_open(FILEINFO_MIME_TYPE); // Return MIME type
    $filename = 'avatar.jpg';
    echo finfo_file($finfo, $filename) . "<br/>";
    finfo_close($finfo);
  } else {
    echo "<p>Add the polyglot file <b>avatar.jpg</b> to this project.</p>";
  };
?>

<?php include_once('footer.php'); ?>
