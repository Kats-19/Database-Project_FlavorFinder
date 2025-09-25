-- FlavorFind SQL schema
CREATE DATABASE IF NOT EXISTS flavorfind
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE flavorfind;

-- Drop tables if they exist (for clean re-run)
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
    difficulty VARCHAR(20) CHECK (difficulty IN ('Easy', 'Hard')),
    prepTime INT
);

CREATE TABLE Ingredient (
    ingredientID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('Main', 'Other'))
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
