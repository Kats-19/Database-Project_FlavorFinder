<?php
include 'connect.php';
$ingredient = $_GET['ingredient'];

$sql = "SELECT r.title, r.cuisine, r.difficulty
        FROM Recipe r
        JOIN Contains c ON r.title = c.recipeTitle
        WHERE c.ingredientName LIKE '%$ingredient%'";

$result = $conn->query($sql);
echo "<h1>Recipes with ingredient: $ingredient</h1>";

if ($result->num_rows > 0) {
  echo "<ul>";
  while ($row = $result->fetch_assoc()) {
    echo "<li><a href='recipe_detail.php?title=" . urlencode($row['title']) . "'>"
       . $row['title'] . " (" . $row['cuisine'] . ", " . $row['difficulty'] . ")</a></li>";
  }
  echo "</ul>";
} else {
  echo "<p>No recipes found for '$ingredient'.</p>";
}
$conn->close();
?>