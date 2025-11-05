<?php
session_start();
include 'connect.php';

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT * FROM AdminUser WHERE username='$username' AND password='$password'";
$result = $conn->query($sql);

if ($result->num_rows == 1) {
  $_SESSION['loggedin'] = true;
  $_SESSION['username'] = $username;
  header("Location: maintenance.html");
} else {
  echo "<h3>❌ Invalid username or password</h3>";
  echo "<a href='login.html'>Try again</a>";
}
$conn->close();
?>