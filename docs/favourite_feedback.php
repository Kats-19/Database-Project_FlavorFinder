<?php
include 'connect.php';
$userID = $_POST['userID'];
$recipeID = $_POST['recipeID'];

$sql = "INSERT INTO Favourite (userID, recipeID) VALUES ('$userID', '$recipeID')";
if ($conn->query($sql) === TRUE) {
  echo "Favourite added successfully!";
} else {
  echo "Error: " . $conn->error;
}
$conn->close();
?>