<!--
	Scriptul de la index.html pentru File upload
	File upload
	
	1. Pentru a folosi:
	In locatia asta sa rulez: php -S localhost:8080

	2. Am nevoie de:
	Sa am instalat php: sudo apt-get install php
-->
<?php
$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"])). " has been uploaded.";
  } else {
    echo "Sorry, there was an error uploading your file.";
  }
?>
