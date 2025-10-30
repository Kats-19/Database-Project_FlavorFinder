<?php
include 'connect.php';
$minFav = $_GET['minFav'];

$sql = "SELECT u.userID, u.name, COUNT(f.recipeID) AS fav_count
        FROM User u
        LEFT JOIN Favourite f ON u.userID = f.userID
        GROUP BY u.userID
        HAVING fav_count >= $minFav
        ORDER BY fav_count DESC";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
  echo "<ul>";
  while ($row = $result->fetch_assoc()) {
    echo "<li><a href='user_detail.php?id={$row['userID']}'>
            {$row['name']} – {$row['fav_count']} favourites
          </a></li>";
  }
  echo "</ul>";
} else {
  echo "<p>No users found.</p>";
}
$conn->close();
?>