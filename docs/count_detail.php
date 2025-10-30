<?php
include 'connect.php';
$title = $_GET['title'];

$sql = "SELECT c.ingredientName, c.quantity, c.units
        FROM Contains c
        WHERE c.recipeTitle = '$title'";

$result = $conn->query($sql);
echo "<h1>Ingredients for $title</h1>";

if ($result->num_rows > 0) {
  echo "<ul>";
  while ($row = $result->fetch_assoc()) {
    echo "<li>{$row['ingredientName']} – {$row['quantity']} {$row['units']}</li>";
  }
  echo "</ul>";
} else {
  echo "<p>No ingredients found.</p>";
}
$conn->close();
?>
<a href='search_count.html'>Back to search</a>