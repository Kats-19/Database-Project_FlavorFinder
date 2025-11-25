<?php
// 1. Get client IP address
$ip = $_SERVER['REMOTE_ADDR'];

// When using localhost, ipinfo sees "127.0.0.1"
// We override it for testing:
if ($ip == "127.0.0.1" || $ip == "::1") {
    $ip = "8.8.8.8"; // Google Public DNS for demo (USA)
}

// 2. Request geo info from ipinfo.io
$api_url = "https://ipinfo.io/{$ip}/json";
$response = file_get_contents($api_url);
$data = json_decode($response, true);

// 3. Extract latitude + longitude
$coords = explode(",", $data['loc']);
$lat = $coords[0];
$lon = $coords[1];
?>
<!DOCTYPE html>
<html>
<head>
    <title>Geo Location Map</title>

    <!-- Leaflet CSS + JS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        #map {
            height: 400px;
            width: 80%;
            margin: 20px auto;
            border: 2px solid black;
        }
    </style>
</head>
<body>

<h1>Your Location Based on IP</h1>
<p><strong>IP Address:</strong> <?php echo $ip; ?></p>

<div id="map"></div>

<script>
// Initialize Leaflet map
var map = L.map('map').setView([<?php echo $lat; ?>, <?php echo $lon; ?>], 10);

// Add OpenStreetMap tiles
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 18
}).addTo(map);

// Add marker
L.marker([<?php echo $lat; ?>, <?php echo $lon; ?>])
    .addTo(map)
    .bindPopup("<b>Your IP:</b> <?php echo $ip; ?>")
    .openPopup();
</script>

</body>
</html>