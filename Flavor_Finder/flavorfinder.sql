CREATE DATABASE flavorfinder;
USE flavorfinder;

CREATE TABLE User (
  userID INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE Recipe (
  title VARCHAR(100) PRIMARY KEY,
  cuisine VARCHAR(50),
  difficulty ENUM('easy', 'hard'),
  prepTime INT
);

CREATE TABLE Ingredient (
  name VARCHAR(100) PRIMARY KEY,
  type ENUM('main', 'other')
);

CREATE TABLE Favourite (
  userID INT,
  recipeTitle VARCHAR(100),
  FOREIGN KEY (userID) REFERENCES User(userID),
  FOREIGN KEY (recipeTitle) REFERENCES Recipe(title)
);

CREATE TABLE Provide (
  userID INT,
  ingredientName VARCHAR(100),
  FOREIGN KEY (userID) REFERENCES User(userID),
  FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
);

CREATE TABLE Contains (
  recipeTitle VARCHAR(100),
  ingredientName VARCHAR(100),
  quantity INT,
  units VARCHAR(20),
  FOREIGN KEY (recipeTitle) REFERENCES Recipe(title),
  FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
);

/* Sample data */
INSERT INTO User VALUES
(1, 'Keni', 'keni@email.com'),
(2, 'Fatima', 'fatima@email.com');

INSERT INTO Recipe VALUES
('Pasta', 'Italian', 'easy', 25),
('Butter Chicken', 'Indian', 'hard', 50),
('Salad', 'Mediterranean', 'easy', 15);

INSERT INTO Ingredient VALUES
('tomato', 'main'),
('chicken', 'main'),
('onion', 'other'),
('garlic', 'other');

INSERT INTO Contains VALUES
('Pasta', 'tomato', 2, 'pcs'),
('Butter Chicken', 'chicken', 1, 'kg'),
('Salad', 'tomato', 1, 'pcs'),
('Salad', 'onion', 1, 'pcs');

INSERT INTO Favourite VALUES
(1, 'Pasta'),
(2, 'Butter Chicken');

INSERT INTO Provide VALUES
(1, 'tomato'),
(2, 'chicken');

/*6 queries */
-- Query 1
SELECT r.title, r.cuisine, r.difficulty
FROM Recipe r
JOIN Contains c ON r.title = c.recipeTitle
WHERE c.ingredientName = 'tomato';

-- Query 2
SELECT u.name, r.title
FROM User u
JOIN Favourite f ON u.userID = f.userID
JOIN Recipe r ON f.recipeTitle = r.title
ORDER BY u.name;

-- Query 3
SELECT c.recipeTitle, COUNT(c.ingredientName) AS total_ingredients
FROM Contains c
GROUP BY c.recipeTitle;

-- Query 4
SELECT title, cuisine, prepTime
FROM Recipe
WHERE difficulty = 'easy' AND prepTime < 20;

-- Query 5
SELECT c.ingredientName, COUNT(DISTINCT c.recipeTitle) AS recipe_count
FROM Contains c
GROUP BY c.ingredientName
HAVING COUNT(DISTINCT c.recipeTitle) > 1;

-- Query 6
SELECT DISTINCT u.name, r.title
FROM User u
JOIN Provide p ON u.userID = p.userID
JOIN Contains c ON p.ingredientName = c.ingredientName
JOIN Recipe r ON c.recipeTitle = r.title
WHERE p.ingredientName = 'chicken';
