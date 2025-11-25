🍽️ **FlavorFinder — Web Project**
FlavorFinder is a recipe search platform where users can search for recipes based on ingredients, difficulty, cuisine, and other filters.
This project was developed across Assignments 1–10 for the Databases and Web Services course.

🚀 **Project Overview**
FlavorFinder is a PHP + MySQL web application that allows users to:
Search recipes by ingredient
View recipe details
View favorite recipes
Display analytics and logs
Support maintenance mode
Implement logging and monitoring
Deploy with XAMPP on localhost

📂 **Project Structure**
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

🛠️  **Technologies Used**
Technology	Purpose
PHP	Backend logic
MySQL	Database for users, recipes, ingredients
Apache (XAMPP)	Local web server
HTML/CSS	Frontend structure & styling
Python	Log parsing for Assignment 8
GitHub Pages	Public showcase (static part only)

🗃️ **Database Schema**
Tables
User
Recipe
Ingredient
Contains
Favourite
Provide

Example:
User (userID PK) ——< Favourite >—— Recipe (title PK)
User —< Provide >— Ingredient
Recipe —< Contains >— Ingredient

🔍 **Core Search Functionality**
Ingredient Search (ingredient_search.php)

Users enter an ingredient → backend searches all recipes containing it:

SELECT r.title, r.cuisine, r.difficulty
FROM Recipe r
JOIN Contains c ON r.title = c.recipeTitle
WHERE c.ingredientName LIKE '%input%';

📑  **Assignment Summaries**
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


▶️ **How to Run the Project Locally**

Install XAMPP
Start Apache and MySQL
Import your flavorfinder.sql database in phpMyAdmin
Place the project folder inside:
C:\xampp\htdocs\flavorfinder

Visit:
http://localhost/flavorfinder/index.html

🧪 **Testing Checklist**
Feature	Status
Ingredient search	✅
Recipe detail page	✅
Maintenance mode	✅
Database connection	✅
Query results	✅
Logs collected	✅
Python parsing	✅

👥**Team**
Keni Sackey
Fatima Zafar

📌 ## **Final Notes**
PHP does not work on GitHub Pages → this is expected.
Everything dynamic must run with XAMPP.
Your TA will be able to test your full search functionality.
