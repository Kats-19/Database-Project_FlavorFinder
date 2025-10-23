📘 FlavorFinder — Assignment 5
🧩 Overview

This project extends our FlavorFinder database system by adding data entry forms using PHP + MySQL.
The website allows inserting data into the main entities and relationships of the FlavorFinder database.

⚙️ Requirements

To test this project, please ensure:

XAMPP (or MAMP) is installed.

Both Apache and MySQL are running.

PHP version 8.0+ is supported.

🗂 Folder Structure
flavorfinder/
├── connect.php
├── maintenance.html
├── user_input.html
├── user_feedback.php
├── recipe_input.html
├── recipe_feedback.php
├── ingredient_input.html
├── ingredient_feedback.php
├── favourite_input.html
├── favourite_feedback.php
├── flavorfinder_a3.sql
└── img/

🧱 Step 1 — Database Setup

Open http://localhost/phpmyadmin
.

Click New → name the database flavorfinder → click Create.

Click Import, choose the file flavorfinder_a3.sql, and click Go.

You should now see tables such as:

User, Recipe, Ingredient, Favourite, Provide, Contains

⚙️ Step 2 — Move Project to Web Root

Place the entire flavorfinder folder inside:

C:\xampp\htdocs\


For Mac (MAMP):

/Applications/MAMP/htdocs/

🔗 Step 3 — Database Connection

connect.php

<?php
$servername = "localhost";
$username = "root";
$password = ""; // Use "root" if using MAMP
$dbname = "flavorfinder";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
?>

🧠 Step 4 — How to Run

Start Apache and MySQL in XAMPP.

Open your browser and visit:

http://localhost/flavorfinder/maintenance.html


Use the links to access input forms:

Add User

Add Recipe

Add Ingredient

Add Favourite

Each form will insert data into the database.

To verify, open http://localhost/phpmyadmin
 → select flavorfinder → check the tables.

🧾 Step 5 — Forms Included
Form	Files	Description
User	user_input.html + user_feedback.php	Add new user
Recipe	recipe_input.html + recipe_feedback.php	Add new recipe
Ingredient	ingredient_input.html + ingredient_feedback.php	Add new ingredient
Favourite	favourite_input.html + favourite_feedback.php	Add favourite (User–Recipe link)
Maintenance	maintenance.html	Links to all forms
🧩 Step 6 — Testing

Use the following test flow:

Add a new User

Add a new Recipe

Add a new Ingredient

Add a Favourite linking that user and recipe

Verify the entries in phpMyAdmin

Expected output for each successful insert:

“Record added successfully!”

📦 Files for Submission

Complete flavorfinder folder (HTML, PHP, CSS)

flavorfinder_a3.sql

This README.md file

💡 Notes

Default MySQL user: root

Default MySQL password: (empty string)

Database name: flavorfinder

Tested on XAMPP (Apache + MySQL)

Compatible with any local LAMP/WAMP stack.
