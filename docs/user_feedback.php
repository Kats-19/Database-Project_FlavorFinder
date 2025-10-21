<?php
include 'connect.php';

$name = $_POST['name'];
$email = $_POST['email'];

$sql = "INSERT INTO User (name, email) VALUES ('$name', '$email')";

if ($conn->query($sql) === TRUE) {
  echo "<h2>User added successfully!</h2>";
} else {
  echo "<h2>Error: " . $conn->error . "</h2>";
}

echo '<a href="maintenance.html">Back to Maintenance Page</a>';
$conn->close();
?>