-- FlavorFind SQL schema
CREATE DATABASE IF NOT EXISTS flavorfind
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE flavorfind;

-- USERS
CREATE TABLE users (
  user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  user_type ENUM('regular','chef','admin') NOT NULL DEFAULT 'regular',
  bio TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ISA: Chefs (subclass of users) -- class-table inheritance
CREATE TABLE chefs (
  user_id INT UNSIGNED PRIMARY KEY,
  chef_speciality VARCHAR(150),
  rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 5),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- INGREDIENTS (superclass for ISA: perishable)
CREATE TABLE ingredients (
  ingredient_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  ingredient_type ENUM('produce','spice','dairy','meat','grain','other') NOT NULL DEFAULT 'other',
  is_perishable BOOLEAN NOT NULL DEFAULT FALSE
);

-- ISA: perishable_ingredients (subclass)
CREATE TABLE perishable_ingredients (
  ingredient_id INT UNSIGNED PRIMARY KEY,
  shelf_life_days INT UNSIGNED,
  storage_instructions TEXT,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE CASCADE
);

-- CUISINES
CREATE TABLE cuisines (
  cuisine_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE
);

-- RECIPES
CREATE TABLE recipes (
  recipe_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  cuisine_id INT UNSIGNED,
  difficulty ENUM('easy','medium','hard') NOT NULL DEFAULT 'medium',
  prep_time_minutes INT UNSIGNED DEFAULT 0,
  cook_time_minutes INT UNSIGNED DEFAULT 0,
  servings INT UNSIGNED DEFAULT 1,
  chef_id INT UNSIGNED,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (cuisine_id) REFERENCES cuisines(cuisine_id) ON DELETE SET NULL,
  FOREIGN KEY (chef_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- RECIPE STEPS (weak entity, ordered)
CREATE TABLE recipe_steps (
  recipe_id INT UNSIGNED NOT NULL,
  step_no INT UNSIGNED NOT NULL,
  instruction TEXT NOT NULL,
  PRIMARY KEY (recipe_id, step_no),
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);

-- RELATIONSHIP: recipe_ingredients
CREATE TABLE recipe_ingredients (
  recipe_id INT UNSIGNED NOT NULL,
  ingredient_id INT UNSIGNED NOT NULL,
  quantity DECIMAL(8,2) DEFAULT NULL,
  unit VARCHAR(32) DEFAULT NULL,
  optional_flag BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (recipe_id, ingredient_id),
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT
);

-- DIETARY RESTRICTIONS
CREATE TABLE dietary_restrictions (
  dietary_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE
);

-- RELATIONSHIP: recipe_dietary
CREATE TABLE recipe_dietary (
  recipe_id INT UNSIGNED NOT NULL,
  dietary_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (recipe_id, dietary_id),
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE,
  FOREIGN KEY (dietary_id) REFERENCES dietary_restrictions(dietary_id) ON DELETE CASCADE
);

-- USER INGREDIENTS (what user has at home)
CREATE TABLE user_ingredients (
  user_id INT UNSIGNED NOT NULL,
  ingredient_id INT UNSIGNED NOT NULL,
  quantity DECIMAL(8,2) DEFAULT NULL,
  unit VARCHAR(32) DEFAULT NULL,
  PRIMARY KEY (user_id, ingredient_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT
);

-- SAVED RECIPES (user saves recipe)
CREATE TABLE saved_recipes (
  user_id INT UNSIGNED NOT NULL,
  recipe_id INT UNSIGNED NOT NULL,
  saved_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);

-- REVIEWS
CREATE TABLE reviews (
  review_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  recipe_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED DEFAULT NULL,
  rating TINYINT UNSIGNED NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);
CREATE INDEX idx_recipes_cuisine ON recipes(cuisine_id);
CREATE INDEX idx_ingredient_name ON ingredients(name);
CREATE INDEX idx_recipe_title ON recipes(title(100));
