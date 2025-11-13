-- Assignment 3: Complete SQL schema, sample data, and 6 ideal SELECT queries for team size N=2 (with ISA hierarchy usage)

CREATE DATABASE IF NOT EXISTS flavorfind CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE flavorfind;

-- Drop tables in FK order
DROP TABLE IF EXISTS Favourite, Provide, Contains, EasyRecipe, HardRecipe, MainIngredient, OtherIngredient, Recipe, Ingredient, User;

-- Entity Tables
CREATE TABLE User (
    userID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Recipe (
    recipeID INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    difficulty VARCHAR(20),
    prepTime INT
);

CREATE TABLE Ingredient (
    ingredientID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50)
);

-- Relationship Tables
CREATE TABLE Favourite (
    userID INT,
    recipeID INT,
    PRIMARY KEY (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID) ON DELETE CASCADE
);

CREATE TABLE Provide (
    userID INT,
    ingredientID INT,
    PRIMARY KEY (userID, ingredientID),
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID) ON DELETE CASCADE
);

CREATE TABLE Contains (
    recipeID INT,
    ingredientID INT,
    quantity DECIMAL(5,2),
    units VARCHAR(20),
    PRIMARY KEY (recipeID, ingredientID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID) ON DELETE CASCADE,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID) ON DELETE CASCADE
);

-- ISA Hierarchies (Subtype Tables)
CREATE TABLE EasyRecipe (
    recipeID INT PRIMARY KEY,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID) ON DELETE CASCADE
);

CREATE TABLE HardRecipe (
    recipeID INT PRIMARY KEY,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID) ON DELETE CASCADE
);

CREATE TABLE MainIngredient (
    ingredientID INT PRIMARY KEY,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID) ON DELETE CASCADE
);

CREATE TABLE OtherIngredient (
    ingredientID INT PRIMARY KEY,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID) ON DELETE CASCADE
);

-- Sample Data

-- Users
INSERT INTO User VALUES
(1, 'Keni', 'keni@email.com'),
(2, 'Fatima', 'fatima@email.com'),
(3, 'Alex', 'alex@email.com'),
(4, 'Maria', 'maria@email.com');

-- Recipes
INSERT INTO Recipe VALUES
(101, 'Pasta', 'Italian', 'Easy', 25),
(102, 'Butter Chicken', 'Indian', 'Hard', 50),
(103, 'Salad', 'Mediterranean', 'Easy', 15),
(104, 'Pizza', 'Italian', 'Hard', 40),
(105, 'Tacos', 'Mexican', 'Easy', 20);

-- Ingredients
INSERT INTO Ingredient VALUES
(201, 'tomato', 'Main'),
(202, 'chicken', 'Main'),
(203, 'onion', 'Other'),
(204, 'garlic', 'Other'),
(205, 'cheese', 'Main'),
(206, 'beef', 'Main'),
(207, 'lettuce', 'Other'),
(208, 'olive oil', 'Other');

-- ISA: Recipe subtypes
INSERT INTO EasyRecipe VALUES (101), (103), (105);
INSERT INTO HardRecipe VALUES (102), (104);

-- ISA: Ingredient subtypes
INSERT INTO MainIngredient VALUES (201), (202), (205), (206);
INSERT INTO OtherIngredient VALUES (203), (204), (207), (208);

-- Contains (recipe-ingredient-quantity-units)
INSERT INTO Contains VALUES
(101, 201, 2, 'pcs'),      -- Pasta - tomato
(101, 203, 1, 'pcs'),      -- Pasta - onion
(101, 204, 2, 'cloves'),   -- Pasta - garlic
(102, 202, 1, 'kg'),       -- Butter Chicken - chicken
(102, 203, 2, 'pcs'),      -- Butter Chicken - onion
(102, 204, 3, 'cloves'),   -- Butter Chicken - garlic
(102, 201, 4, 'pcs'),      -- Butter Chicken - tomato
(103, 201, 1, 'pcs'),      -- Salad - tomato
(103, 203, 1, 'pcs'),      -- Salad - onion
(103, 207, 3, 'leaves'),   -- Salad - lettuce
(104, 205, 2, 'cups'),     -- Pizza - cheese
(104, 201, 3, 'pcs'),      -- Pizza - tomato
(104, 203, 1, 'pcs'),      -- Pizza - onion
(105, 206, 1, 'kg'),       -- Tacos - beef
(105, 207, 2, 'leaves'),   -- Tacos - lettuce
(105, 203, 1, 'pcs'),      -- Tacos - onion
(105, 201, 2, 'pcs'),      -- Tacos - tomato
(104, 208, 1, 'tbsp');     -- Pizza - olive oil

-- Favourite (user-recipe)
INSERT INTO Favourite VALUES
(1, 101), (1, 104),
(2, 102), (2, 105),
(3, 104), (3, 103),
(4, 103), (4, 102);

-- Provide (user-ingredient)
INSERT INTO Provide VALUES
(1, 201), (1, 203),
(2, 202), (2, 207),
(3, 205), (3, 208),
(4, 206), (4, 204);

-- =========================
-- 6 IDEAL SELECT QUERIES FOR N=2 (with natural language comments)
-- =========================

-- Query 1: (Join, Central) 
-- List all recipes favorited by users, including each user's name and the recipe title.
SELECT u.name, r.title
FROM User u
JOIN Favourite f ON u.userID = f.userID
JOIN Recipe r ON f.recipeID = r.recipeID
ORDER BY u.name;

-- Query 2: (Join, Aggregation, GROUP BY)
-- Show the number of recipes each user has favorited.
SELECT u.name, COUNT(f.recipeID) AS num_favorites
FROM User u
LEFT JOIN Favourite f ON u.userID = f.userID
GROUP BY u.userID, u.name;

-- Query 3: (Aggregation, GROUP BY, HAVING)
-- List all ingredients that appear in more than two recipes.
SELECT i.name, COUNT(DISTINCT c.recipeID) AS recipe_count
FROM Contains c
JOIN Ingredient i ON c.ingredientID = i.ingredientID
GROUP BY c.ingredientID, i.name
HAVING COUNT(DISTINCT c.recipeID) > 2;

-- Query 4: (Join, Central, ISA hierarchy)
-- List all easy recipes and their cuisines.
SELECT r.title, r.cuisine
FROM Recipe r
JOIN EasyRecipe e ON r.recipeID = e.recipeID;

-- Query 5: (Join, Aggregation, GROUP BY)
-- Show the total quantity of 'tomato' used per recipe.
SELECT r.title, SUM(c.quantity) AS total_tomato
FROM Recipe r
JOIN Contains c ON r.recipeID = c.recipeID
JOIN Ingredient i ON c.ingredientID = i.ingredientID
WHERE i.name = 'tomato'
GROUP BY r.recipeID, r.title;

-- Query 6: (Join, ISA hierarchy)
-- List all main ingredients and the recipes they appear in.
SELECT i.name AS main_ingredient, r.title AS recipe
FROM Ingredient i
JOIN MainIngredient m ON i.ingredientID = m.ingredientID
JOIN Contains c ON i.ingredientID = c.ingredientID
JOIN Recipe r ON c.recipeID = r.recipeID
ORDER BY i.name, r.title;