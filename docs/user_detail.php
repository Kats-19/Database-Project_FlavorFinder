<?php
include 'connect.php';
$id = $_GET['id'];

$sql = "SELECT u.name, r.title
        FROM User u
        JOIN Favourite f ON u.userID = f.userID
        JOIN Recipe r ON f.recipeID = r.recipeID
        WHERE u.userID = $id";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
  $user = "";
  echo "<h1>Favourites</h1><ul>";
  while ($row = $result->fetch_assoc()) {
    $user = $row['name'];
    echo "<li>{$row['title']}</li>";
  }
  echo "</ul>";
  echo "<p>User: $user</p>";
} else {
  echo "<p>No favourites found for this user.</p>";
}
$conn->close();
?>