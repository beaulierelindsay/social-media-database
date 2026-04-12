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
   DateJoined DATE,
   Location VARCHAR(50),
   PrivacySetting VARCHAR(10)
);

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
);

-- Create the COMMENT table
CREATE TABLE Comment (
   CommentID INT PRIMARY KEY,    -- Primary Key
   PostID INT,                   -- Foreign Key
   UserID INT,                   -- Foreign Key
   Content VARCHAR(255),
   CommentTimestamp TIMESTAMP,
   FOREIGN KEY (PostID) REFERENCES Post(PostID),
   FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Create the MESSAGE table
CREATE TABLE Message (
    MessageID INT PRIMARY KEY,
    SenderID INT,
    ReceiverID INT,
    Content TEXT,
    MessageTimestamp TIMESTAMP,
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
    NotifTimestamp TIMESTAMP,
    read_status VARCHAR(10),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (RelatedPostID) REFERENCES Post(PostID),
    FOREIGN KEY (RelatedMessageID) REFERENCES Message(MessageID)
);

-- Create the GROUP table
CREATE TABLE MediaGroup (
    GroupID INT PRIMARY KEY,
    CreatorID INT,
    group_name VARCHAR(20),
    privacy_setting VARCHAR(10),
    date_created DATE,
    FOREIGN KEY (CreatorID) REFERENCES User(UserID)
);


-- Create the FRIENDSHIP table
CREATE TABLE Friendship (
   friend_user1 INT,
   friend_user2 INT,
   status VARCHAR(20) NOT NULL,
   request_sent_date TIMESTAMP NOT NULL,
   request_answered_date TIMESTAMP,

   PRIMARY KEY (friend_user1, friend_user2),
   FOREIGN KEY (friend_user1) REFERENCES User(UserID),
   FOREIGN KEY (friend_user2) REFERENCES User(UserID)
);

-- Create the FOLLOW table
CREATE TABLE Follow (
   follower_id INT,
   following_id INT,
   date_followed TIMESTAMP,

   PRIMARY KEY (follower_id, following_id),
   FOREIGN KEY (follower_id) REFERENCES User(UserID),
   FOREIGN KEY (following_id) REFERENCES User(UserID)
);

-- Create the LIKE table
CREATE TABLE Like(
   like_user_id INT,
   like_post_id INT,
   like_timestamp TIMESTAMP,

   PRIMARY KEY (like_user_id, like_post_id),
   FOREIGN KEY (like_user_id) REFERENCES User(UserID),
   FOREIGN KEY (like_post_id) REFERENCES Post(PostID)
);

-- CREATE the GROUPMEMBERSHIP table
CREATE TABLE GroupMembership (
   groupmembership_group_id INT,
   groupmembership_user_id INT,
   role VARCHAR(20),
   date_joined TIMESTAMP,

   PRIMARY KEY (groupmembership_group_id, groupmembership_user_id),
   FOREIGN KEY (groupmembership_group_id) REFERENCES MediaGroup(GroupID),
   FOREIGN KEY (groupmembership_user_id) REFERENCES User(UserID)
);
