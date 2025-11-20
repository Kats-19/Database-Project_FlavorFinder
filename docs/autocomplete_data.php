<?php
include 'connect.php';

$term = $_GET['term'] ?? '';

$sql = "SELECT DISTINCT ingredientName 
        FROM Contains 
        WHERE ingredientName LIKE '%$term%' 
        LIMIT 10";

$result = $conn->query($sql);

$data = [];

while($row = $result->fetch_assoc()) {
    $data[] = $row['ingredientName'];
}

echo json_encode($data);
?>