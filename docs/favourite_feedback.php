<?php
include 'connect.php';

$userID = $_POST['userID'];
$recipeID = $_POST['recipeID'];

$sql = "INSERT INTO Favourite (userID, recipeID) VALUES ('$userID', '$recipeID')";

if ($conn->query($sql) === TRUE) {
  echo "<h2>Favourite added successfully!</h2>";
} else {
  echo "<h2>Error: " . $conn->error . "</h2>";
}

echo '<a href="maintenance.html">Back to Maintenance Page</a>';
$conn->close();
?>