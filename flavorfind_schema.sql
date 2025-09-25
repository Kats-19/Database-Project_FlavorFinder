-- FlavorFind SQL schema
CREATE TABLE User (
    userID INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Recipe (
    recipeID INT PRIMARY KEY,
    title VARCHAR(100),
    cuisine VARCHAR(50),
    difficulty VARCHAR(20), -- could be 'Easy' or 'Hard'
    prepTime INT
);

CREATE TABLE Ingredient (
    ingredientID INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50) -- could be 'Main' or 'Other'
);

CREATE TABLE Favourite (
    userID INT,
    recipeID INT,
    PRIMARY KEY (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
);

CREATE TABLE Provide (
    userID INT,
    ingredientID INT,
    PRIMARY KEY (userID, ingredientID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID)
);

CREATE TABLE Contains (
    recipeID INT,
    ingredientID INT,
    quantity DECIMAL(5,2),
    units VARCHAR(20),
    PRIMARY KEY (recipeID, ingredientID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID),
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID)
);

CREATE TABLE EasyRecipe (
    recipeID INT PRIMARY KEY,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
);

CREATE TABLE HardRecipe (
    recipeID INT PRIMARY KEY,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
);

CREATE TABLE MainIngredient (
    ingredientID INT PRIMARY KEY,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID)
);

CREATE TABLE OtherIngredient (
    ingredientID INT PRIMARY KEY,
    FOREIGN KEY (ingredientID) REFERENCES Ingredient(ingredientID)
);
