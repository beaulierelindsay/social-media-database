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

-- Create the MEDIAGROUP table
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

-- Insert data into the USER table
INSERT INTO User (UserID, Username, DoB, Phone, Email, DateJoined, Location, PrivacySetting) VALUES
(1, 'johndoe', '2000-03-20', '347-128-2983', 'johndoe@gmail.com', '2025-12-28', 'Singapore', 'private'),
(2, 'janedoe', '2001-04-12', '646-128-2983', 'janedoe@gmail.com', '2026-02-05', 'United States', 'public'),
(3, 'michellerocks123', '1999-05-27', '347-128-8000', 'michellerocks@gmail.com', '2023-12-28', 'United States', 'public'),
(4, 'mattybdeng', '1998-07-12', '718-561-2999', 'mattdeng@gmail.com', '2019-09-18', 'United States', 'private'),
(5, 'lindsaywowo', '1997-06-29', '347-432-1000', 'lindsaywow@gmail.com', '2017-10-05', 'United States', 'private');


-- Insert data into the POST table
INSERT INTO Post (PostID, UserID, PostCaption, MediaURL, PostTimestamp, Location, Visibility) VALUES
(1, 1, 'litty', 'https://cdn.socialapp.com/posts/1.jpg', '2026-02-01 13:00:00', 'Singapore', 'friends-only'),
(2, 2, 'look at my cool fit', 'https://cdn.socialapp.com/posts/2.jpg', '2026-07-23 12:04:00', 'United States', 'public'),
(3, 3, 'beach day', 'https://cdn.socialapp.com/posts/3.jpg', '2025-07-01 07:25:00', 'United States', 'friends-only'),
(4, 4, 'night out', 'https://cdn.socialapp.com/posts/4.jpg', '2026-03-21 23:00:00', 'United States', 'friends-only'),
(5, 5, 'wow', 'https://cdn.socialapp.com/posts/5.jpg', '2026-04-05 00:00:00', 'United States', 'private');


-- Insert data into COMMENT table
INSERT INTO Comment (CommentID, PostID, UserID, Content, CommentTimestamp) VALUES
(1, 3, 1, 'that view is really nice!!', '2025-07-01 16:00:00'),
(2, 1, 2, 'wow super lit john', '2025-12-30 01:50:00'),
(3, 4, 5, 'oo fancy drink', '2026-03-23 09:23:00'),
(4, 4, 3, 'i went to that place too', '2026-04-01 20:09:00'),
(5, 2, 4, 'fire fit', '2026-07-23 17:19:00');

-- Insert into MESSAGE table
INSERT INTO Message (MessageID, SenderID, ReceiverID, Content, Timestamp, read_status) VALUES
(1, 4, 5, 'Hello, how are you?', '2025-06-01 10:00:00', 'read'),
(2, 5, 4, 'I am good, thanks! How about you?', '2025-06-01 10:05:00', 'read'),
(3, 4, 5, 'I am doing well too. Thanks for asking!', '2025-06-01 10:10:00', 'unread'),
(4, 3, 2, 'Hey, are you coming to the party tonight?', '2025-06-01 11:00:00', 'read'),
(5, 2, 3, 'Yes, I will be there. Looking forward to it!', '2025-06-01 11:05:00', 'unread');

-- Insert into NOTIFICATION table

-- Insert into MEDIAGROUP table
INSERT INTO MediaGroup (GroupID, CreatorID, group_name, privacy_setting, date_created) VALUES
(1, 1, 'Book Club', 'private', '2025-06-01 13:00:00'),
(2, 2, 'Travel Enthusiasts', 'public', '2025-06-01 13:05:00'),
(3, 3, 'Food Lovers', 'private', '2025-06-01 13:10:00'),
(4, 4, 'Fitness Fanatics', 'public', '2025-06-01 13:15:00'),
(5, 2, 'Movie Buffs', 'private', '2025-06-01 13:20:00');