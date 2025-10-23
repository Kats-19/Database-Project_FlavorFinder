<?php
include 'connect.php';
$title = $_POST['title'];
$cuisine = $_POST['cuisine'];
$difficulty = $_POST['difficulty'];
$prepTime = $_POST['prepTime'];

$sql = "INSERT INTO Recipe (title, cuisine, difficulty, prepTime)
        VALUES ('$title', '$cuisine', '$difficulty', '$prepTime')";
if ($conn->query($sql) === TRUE) {
  echo "Recipe added successfully!";
} else {
  echo "Error: " . $conn->error;
}
$conn->close();
?>