<?php
include 'connect.php';
$minCount = $_GET['minCount'];

$sql = "SELECT c.recipeTitle, COUNT(c.ingredientName) AS total_ingredients
        FROM Contains c
        GROUP BY c.recipeTitle
        HAVING COUNT(c.ingredientName) >= $minCount";

$result = $conn->query($sql);
echo "<h1>Recipes with at least $minCount ingredients</h1>";

if ($result->num_rows > 0) {
  echo "<ul>";
  while ($row = $result->fetch_assoc()) {
    echo "<li><a href='count_detail.php?title=" . urlencode($row['recipeTitle']) . "'>"
       . $row['recipeTitle'] . " (" . $row['total_ingredients'] . " ingredients)</a></li>";
  }
  echo "</ul>";
} else {
  echo "<p>No recipes found.</p>";
}
$conn->close();
?>