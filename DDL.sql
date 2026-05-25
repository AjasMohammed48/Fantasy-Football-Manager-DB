-- Andrew Harrison
-- Sudhir Ray
-- Team 9
-- Dr. Lopa
-- Project - Fantasy Manager Database

-- DDL Statements

-- ================================================================================================================================================= Create Table: League

-- Create a table for representing Leagues
CREATE TABLE League (
    League_ID INT PRIMARY KEY,     -- Unique identifier for each league
    League_Name VARCHAR(30),       -- Name of the league
    Total_Teams INT                -- Total number of teams in the league
);

-- =============================================================================================================================================== Create Table: User

-- Create a table for representing Users
CREATE TABLE User (
    User_ID INT PRIMARY KEY,       -- Unique identifier for each user
    Username VARCHAR(255),         -- Username of the user
    Email VARCHAR(255),            -- Email address of the user
    Password VARCHAR(255),         -- Password of the user (Note: In practice, this should be hashed)
    League_ID INT,                 -- Foreign key referencing the League the user is associated with
    FOREIGN KEY (League_ID) REFERENCES League(League_ID)  -- Establish a relationship with the League table
);

-- =============================================================================================================================================== Create Table: Team

-- Create a table for representing Teams
CREATE TABLE Team (
    Team_ID INT PRIMARY KEY,       -- Unique identifier for each team
    Team_Name VARCHAR(255),        -- Name of the team
    Total_Points INT,              -- Total points earned by the team
    User_ID INT,                   -- Foreign key referencing the User who owns the team
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)  -- Establish a relationship with the User table
);

-- =============================================================================================================================================== Create Table: Real World Team

-- Create a table for representing Real World Teams
CREATE TABLE Real_World_Team (
    Real_World_Team_ID INT PRIMARY KEY,       -- Unique identifier for each real-world team
    Real_World_Team_Name VARCHAR(50)          -- Name of the real-world team
);

-- =============================================================================================================================================== Create Table: Player

-- Create a table for representing Players
CREATE TABLE Player (
    Player_ID INT PRIMARY KEY,               -- Unique identifier for each player
    First_Name VARCHAR(255),                -- First name of the player
    Last_Name VARCHAR(255),                 -- Last name of the player
    Position VARCHAR(50),                   -- Position played by the player
    Market_Value DECIMAL(10, 2),            -- Market value of the player
    Injury_Status VARCHAR(50),              -- Injury status of the player
    Team_ID INT,                            -- Foreign key referencing the Team the player belongs to
    Real_World_Team_ID INT,                 -- Foreign key referencing the real-world team associated with the player
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),                   -- Establish a relationship with the Team table
    FOREIGN KEY (Real_World_Team_ID) REFERENCES Real_World_Team(Real_World_Team_ID)  -- Establish a relationship with the Real_World_Team table
);

-- =============================================================================================================================================== Create Table: Game Match

-- Create a table for representing Game Matches
CREATE TABLE GameMatch (
    Team1_ID INT,                            -- Foreign key referencing the first team in the match
    Team2_ID INT,                            -- Foreign key referencing the second team in the match
    Match_Start_Date DATETIME,               -- Start date and time of the match
    Match_End_Date DATETIME,                 -- End date and time of the match
    Match_Score VARCHAR(20),                 -- Score of the match
    Match_Outcome VARCHAR(20),               -- Outcome of the match
    PRIMARY KEY (Team1_ID, Team2_ID),        -- Composite primary key for match uniqueness
    FOREIGN KEY (Team1_ID) REFERENCES Team(Team_ID),   -- Relationship with the Team table for Team1
    FOREIGN KEY (Team2_ID) REFERENCES Team(Team_ID)    -- Relationship with the Team table for Team2
);

-- =============================================================================================================================================== Create Table: Transfer Market

-- Create a table for representing Transfer Market
CREATE TABLE TransferMarket (
    TransferMarket_ID INT AUTO_INCREMENT PRIMARY KEY,		-- Auto generates TransferMarketID
    Player_ID INT,											-- Foreign Key for PlayerID
    User_ID INT NULL,										-- Foreign Key for UserID
    Transfer_Type VARCHAR(50),								-- Transfer Type
    UNIQUE KEY Player_User_Unique (Player_ID, User_ID),		-- Creates Unique Key For easier transfers
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),	-- Establish a relationship with the PlayerID
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)			-- Establish a relationship with the UserID
);