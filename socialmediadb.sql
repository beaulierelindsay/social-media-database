-- Drop the existing database if it exists
DROP DATABASE IF EXISTS socialmedia;
-- Create a new database called "socialmedia"
CREATE DATABASE socialmedia;
-- Use newly created database 
USE socialmedia;

-- Create the USER table
CREATE TABLE user (
   userID INT PRIMARY KEY,
)