<?php
include 'connect.php';
$title = $_GET['title'];

$sql = "SELECT r.title, r.cuisine, r.difficulty, r.prepTime,
               GROUP_CONCAT(c.ingredientName SEPARATOR ', ') AS ingredients
        FROM Recipe r
        JOIN Contains c ON r.title = c.recipeTitle
        WHERE r.title = '$title'
        GROUP BY r.title";

$result = $conn->query($sql);
if ($row = $result->fetch_assoc()) {
  echo "<h1>{$row['title']}</h1>";
  echo "<p>Cuisine: {$row['cuisine']}</p>";
  echo "<p>Difficulty: {$row['difficulty']}</p>";
  echo "<p>Prep Time: {$row['prepTime']} min</p>";
  echo "<p>Ingredients: {$row['ingredients']}</p>";
} else {
  echo "<p>No details found for recipe.</p>";
}
$conn->close();
?>
<a href='search_recipe.html'>Back to search</a>