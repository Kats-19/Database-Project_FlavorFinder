$servername = "localhost";
$username = "root";
$password = ""; // or "root" if you’re on MAMP
$dbname = "flavorfinder";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
} else {
  echo "✅ Database connected successfully!";
}
$conn->close();
?>