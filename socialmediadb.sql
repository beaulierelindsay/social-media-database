-- Drop the existing database if it exists
DROP DATABASE IF EXISTS socialmedia;
-- Create a new database called "socialmedia"
CREATE DATABASE socialmedia;
-- Use newly created database 
USE socialmedia;

-- Create the USER table
CREATE TABLE User (
   UserID INT PRIMARY KEY,    -- Primary Key
   Username VARCHAR(50),
   DoB DATE,
   Phone VARCHAR(15),
   Email VARCHAR(100),
   Password VARCHAR(255),
   DateJoined DATE,
   Location VARCHAR(50),
   PrivacySetting VARCHAR(10)
)

-- Create the POST table
CREATE TABLE Post (
   PostID INT PRIMARY KEY,    -- Primary Key
   UserID INT,                -- Foreign Key
   PostCaption VARCHAR(255),
   MediaURL VARCHAR(255),
   PostTimestamp TIMESTAMP,
   Location VARCHAR(50),
   Visibility VARCHAR(10),
   FOREIGN KEY (UserID) REFERENCES User(UserID)
)

-- Create the COMMENT table
CREATE TABLE Comment (
   CommentID INT PRIMARY KEY,    -- Primary Key
   PostID INT,                   -- Foreign Key
   UserID INT,                   -- Foreign Key
   Content VARCHAR(255),
   CommentTimestamp TIMESTAMP,
   FOREIGN KEY (PostID) REFERENCES Post(PostID),
   FOREIGN KEY (UserID) REFERENCES User(UserID)
)
CREATE TABLE user (
   userID INT PRIMARY KEY,
   
);


-- Create the MESSAGE table
CREATE TABLE Message (
    MessageID INT PRIMARY KEY,
    SenderID INT,
    ReceiverID INT,
    Content TEXT,
    Timestamp DATE,
    read_status VARCHAR(10),
    FOREIGN KEY (SenderID) REFERENCES User(UserID),
    FOREIGN KEY (ReceiverID) REFERENCES User(UserID)
);

-- Create the NOTIFICATION table
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    RelatedPostID INT,
    RelatedMessageID INT,
    notification_type VARCHAR(20),
    Content TEXT,
    Timestamp DATE,
    read_status VARCHAR(10),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (RelatedPostID) REFERENCES Post(PostID),
    FOREIGN KEY (RelatedMessageID) REFERENCES Message(MessageID)
);

-- Create the GROUP table
CREATE TABLE Group (
    GroupID INT PRIMARY KEY,
    CreatorID INT,
    group_name VARCHAR(20),
    privacy_setting VARCHAR(10),
    date_created DATE,
    FOREIGN KEY (CreatorID) REFERENCES User(UserID)
);
