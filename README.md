1. Requirements
To run FlavorFinder, you need:
XAMPP (recommended)
Apache
MySQL
PHP
phpMyAdmin (included with XAMPP)
A modern browser (Chrome, Firefox, Safari)

2. Starting the Server
Open XAMPP Control Panel
Start the following modules:
Apache
MySQL
🔥 If Apache or MySQL are NOT running, database features like search will not work.

3. Database Setup
Step 1: Create Database
Open the browser and go to: http://localhost/phpmyadmin
Create a new database named: flavorfinder

Step 2: Import the Schema
You can either:
Import the provided .sql file
OR
Copy/paste all SQL statements from init.sql / your schema file
This creates tables:
User
Recipe
Ingredient
Favourite
Provide
Contains
And adds sample data.

4. Project File Placement
Place the entire project folder into: xampp/htdocs/flavorfinder/
Your website entry URL becomes: http://localhost/flavorfinder/index.php

5. Database Connection Configuration
Ensure your connect.php file contains:
<?php
$host = "localhost";
$user = "root";     // XAMPP default
$pass = "";
$db = "flavorfinder";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

6. Maintenance Mode
Maintenance Mode uses three files:
1. maintenance.flag
Controls whether the site is in maintenance mode.
If the file exists, the website redirects to the maintenance page.
If the file is deleted, the site runs normally.

2. maintenance.php
This is the page shown during maintenance mode.

3. maintenance_check.php
This is included at the top of every page:
include 'maintenance_check.php';
It checks whether maintenance.flag exists and redirects accordingly.

7. Enabling/Disabling Maintenance Mode
Enable Maintenance Mode
Create an empty file named: maintenance.flag
OR via terminal: touch maintenance.flag
→ Website becomes unavailable
→ Visitors see maintenance.php

Disable Maintenance Mode
Delete the file: maintenance.flag
→ Website works normally again

8. Testing Search Functionality
To test search by ingredient: http://localhost/flavorfinder/search.php?ingredient=tomato

Expected output:
A list of recipes that contain the ingredient
Titles should link to recipe details

If you see "No recipes found", check:
MySQL is running
Tables have data
The Contains table includes matching ingredients
Database credentials in connect.php are correct

🍽️ FlavorFinder — Web Project

FlavorFinder is a recipe search platform where users can search for recipes based on ingredients, difficulty, cuisine, and other filters.
This project was developed across Assignments 1–10 for the Databases and Web Services course.

🚀 Project Overview

FlavorFinder is a PHP + MySQL web application that allows users to:

Search recipes by ingredient

View recipe details

View favorite recipes

Display analytics and logs

Support maintenance mode

Implement logging and monitoring

Deploy with XAMPP on localhost

📂 Project Structure
public_html/
│── index.html
│── ingredient_search.html
│── recipe_detail.php
│── ingredient_search.php
│── search_results.php
│── favourites.php
│── maintenance.html
│── maintenance.php
│── includes/
│    ├── connect.php
│    ├── header.php
│    ├── footer.php
│── assets/
│    ├── style.css
│    ├── logo.png
│── logs/
│    ├── access.log
│    ├── error.log

🛠️ Technologies Used
Technology	Purpose
PHP	Backend logic
MySQL	Database for users, recipes, ingredients
Apache (XAMPP)	Local web server
HTML/CSS	Frontend structure & styling
Python	Log parsing for Assignment 8
GitHub Pages	Public showcase (static part only)
🗃️ Database Schema
Tables

User

Recipe

Ingredient

Contains

Favourite

Provide

ER Diagram (Assignment 2)

Insert your diagram image here once exported

Example:

User (userID PK) ——< Favourite >—— Recipe (title PK)
User —< Provide >— Ingredient
Recipe —< Contains >— Ingredient

🔍 Core Search Functionality
Ingredient Search (ingredient_search.php)

Users enter an ingredient → backend searches all recipes containing it:

SELECT r.title, r.cuisine, r.difficulty
FROM Recipe r
JOIN Contains c ON r.title = c.recipeTitle
WHERE c.ingredientName LIKE '%input%';

📑 Assignment Summaries
Assignment 1–3: Database creation + queries

Created schema

Inserted sample data

Wrote 6 SQL queries with joins, group by, aggregation

Assignment 4: GitHub + public_html setup

Repo created

Project folder added

Pushed via VSCode

Assignment 5: PHP Forms

Ingredient search form

PHP handling file

Connected to MySQL

Assignment 6: Search component

Dynamic results page

Recipe links to detail page

Assignment 7: Maintenance Mode

maintenance.php checks toggle

Redirects all pages if ON

Assignment 8: Access & Error Log Analysis

Extracted entries from XAMPP logs

Parsed using Python

Created timeline + stats

Assignment 9: Refactoring & API-like structure

Added includes (header.php, footer.php)

Centralized DB connection

Replaced repeated code

Assignment 10: Finalization

Cleanup

README creation

Ensure search works when Apache & MySQL are running

⚠️ Important Note About Running the Project
✔️ For search and PHP pages to work:

Apache + MySQL MUST be running locally.

❗ GitHub Pages will NOT run PHP

GitHub Pages only hosts static files.

Your TA running the project locally => the search will work.
If your partner’s laptop doesn’t run MySQL/Apache, the search won’t work but the TA’s will.

▶️ How to Run the Project Locally

Install XAMPP

Start Apache and MySQL

Import your flavorfinder.sql database in phpMyAdmin

Place the project folder inside:

C:\xampp\htdocs\flavorfinder


Visit:

http://localhost/flavorfinder/index.html

🧪 Testing Checklist
Feature	Status
Ingredient search	✅
Recipe detail page	✅
Maintenance mode	✅
Database connection	✅
Query results	✅
Logs collected	✅
Python parsing	✅
Project runs on TA machine	🟢 confirmed
👥 Team

Keni Sackey

Partner Name

📸 Screenshots (Add once you take them)

You can add:

Homepage

Search page

Results page

Recipe detail page

Maintenance mode

Log analysis graph

Example Markdown:

### 🔍 Search Page
![Search Page](assets/screenshots/search.png)

📌 Final Notes

PHP does not work on GitHub Pages → this is expected.

Everything dynamic must run with XAMPP.

Your TA will be able to test your full search functionality.
