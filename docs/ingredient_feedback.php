<?php
include 'connect.php';
$name = $_POST['name'];
$type = $_POST['type'];

$sql = "INSERT INTO Ingredient (name, type) VALUES ('$name', '$type')";
if ($conn->query($sql) === TRUE) {
  echo "Ingredient added successfully!";
} else {
  echo "Error: " . $conn->error;
}
$conn->close();
?>