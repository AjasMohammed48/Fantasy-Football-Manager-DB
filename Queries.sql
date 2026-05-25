-- Andrew Harrison
-- Sudhir Ray
-- Team 9
-- Dr. Lopa
-- Project - Fantasy Manager Database

-- SQL Queries

-- =============================================================================================================================================== Query 1: Andrew Harrison

-- Select columns from Team and Player tables
SELECT T.Team_ID,    
       T.Team_Name,  
       P.Player_ID,  
       P.First_Name,
       P.Last_Name,  
       P.Position 
	   
FROM Team AS T       -- From the Team table, aliased as T

-- Perform an inner join with the Player table, aliased as P
INNER JOIN Player AS P 

-- Join condition: Match Team_ID in both tables
ON T.Team_ID = P.Team_ID  -- The join is made where Team IDs match between Team and Player tables

ORDER BY T.Team_ID ASC,  -- Orders the results by Team ID in ascending order
         P.Position ASC; -- Then orders by Player Position in ascending order

-- =============================================================================================================================================== Query 2: Andrew Harrison

-- Select player information along with team names, injury status, and positions
SELECT T.Team_Name,     
       P.First_Name,     
       P.Last_Name,    
       P.Injury_Status,    
       P.Position          

FROM Player AS P           -- From the Player table, aliased as P

INNER JOIN Team AS T       -- Inner join with the Team table, aliased as T
ON P.Team_ID = T.Team_ID   -- Join is made where Team IDs match between Player and Team tables

WHERE P.Team_ID IS NOT NULL  -- Filter to include only players with an actual team

ORDER BY T.Team_Name ASC,   -- Order the results by team name in ascending order
         P.Position ASC;    -- Then, order by player position in ascending order

-- =============================================================================================================================================== Query 3: Andrew Harrison

-- Select the position, first name, and last name
SELECT P.Position,          
       MAX(P.Market_Value) as Max_Value, -- Select the maximum market value for players in each position
       MAX(P.First_Name) as First_Name,
       MAX(P.Last_Name) as Last_Name 

FROM Player AS P                        -- From the Player table, aliased as P

GROUP BY P.Position;                 -- Group the results by the player's position

-- =============================================================================================================================================== Query 4: Andrew Harrison

-- Select the real world team name and calculate the average market value of players
SELECT RWT.Real_World_Team_Name,                   
       AVG(P.Market_Value) as Avg_Market_Value    

FROM Real_World_Team RWT                        -- From the Real_World_Team table, aliased as RWT

JOIN Player P                                   -- Join with the Player table, aliased as P
ON RWT.Real_World_Team_ID = P.Real_World_Team_ID  -- Join condition: match the real-world team ID from both tables

GROUP BY RWT.Real_World_Team_Name;              -- Group the results by the real-world team name

-- =============================================================================================================================================== Query 5: Andrew Harrison

-- Select first name, last name, position, market value, and availability status of players with market value >= 75
SELECT First_Name, Last_Name, Position, Market_Value,
       CASE
           WHEN Team_ID IS NULL THEN 'Unavailable'  -- If the player doesn't have a team, their availability is "Unavailable"
           ELSE 'Available'                          -- If the player has a team, their availability is "Available"
       END AS Availability
FROM Player
WHERE Market_Value >= 75  -- Filter for players with a market value greater than or equal to 75
ORDER BY Market_Value DESC; -- Order the results by market value in descending order

-- =============================================================================================================================================== Query 6: Sudhir Ray

-- Retrieve usernames and fantasy team names for all users
SELECT User.Username, Team.Team_Name
FROM User
JOIN Team ON User.User_ID = Team.User_ID;

-- =============================================================================================================================================== Query 7: Sudhir Ray

-- Fetch real-world team names and players associated with each team
SELECT Real_World_Team.Real_World_Team_Name, Player.First_Name, Player.Last_Name, Player.Position
FROM Real_World_Team
JOIN Player ON Real_World_Team.Real_World_Team_ID = Player.Real_World_Team_ID
ORDER BY Real_World_Team_Name;

-- =============================================================================================================================================== Query 8: Sudhir Ray

-- Selecting info of all Undrafted Players
SELECT Player.Player_ID, Player.First_Name, Player.Last_Name, Player.Position, Player.Market_Value, TransferMarket.Transfer_Type, Real_World_Team.Real_World_Team_Name
FROM Player AS Player
LEFT JOIN TransferMarket AS TransferMarket ON Player.Player_ID = TransferMarket.Player_ID
LEFT JOIN Real_World_Team AS Real_World_Team ON Player.Real_World_Team_ID = Real_World_Team.Real_World_Team_ID
WHERE Player.Team_ID IS NULL;
     
-- =============================================================================================================================================== Query 9: Sudhir Ray

-- Display upcoming game matches and participating fantasy teams with only dates
SELECT DATE(Match_Start_Date) AS Match_Start_Date, 
       DATE(Match_End_Date) AS Match_End_Date, 
       Team1.Team_Name AS Home_Team, 
       Team2.Team_Name AS Away_Team, 
       Match_Outcome
FROM GameMatch                     
INNER JOIN Team AS Team1 ON GameMatch.Team1_ID = Team1.Team_ID  
INNER JOIN Team AS Team2 ON GameMatch.Team2_ID = Team2.Team_ID 
ORDER BY Match_Start_Date ASC;

-- =============================================================================================================================================== Query 10: Sudhir Ray

-- Fetch users and players transferred by each user
SELECT User.Username, Player.First_Name, Player.Last_Name
FROM User
JOIN TransferMarket ON User.User_ID = TransferMarket.User_ID
JOIN Player ON TransferMarket.Player_ID = Player.Player_ID;

-- =============================================================================================================================================== Query 11: Extra

-- Select statement to retrieve data
SELECT COUNT(*) AS DraftedPlayers  -- Count the number of rows and rename the result as "DraftedPlayers"
FROM Player                       -- Specify the table "Player" to retrieve data from
WHERE Team_ID IS NOT NULL;        -- Filter the rows to include only those where "Team_ID" is not NULL

-- =============================================================================================================================================== Query 12: Extra

-- Select statement to retrieve data
SELECT COUNT(*) AS UndraftedPlayers  -- Count the number of rows and rename the result as "UndraftedPlayers"
FROM Player                       -- Specify the table "Player" to retrieve data from
WHERE Team_ID IS NULL;        -- Filter the rows to include only those where "Team_ID" is NULL

-- =============================================================================================================================================== Query 13: Extra

-- Select the match start and end dates (without time), first team, and second team
SELECT DATE(GM.Match_Start_Date) AS Match_Start_Date, 
       DATE(GM.Match_End_Date) AS Match_End_Date,
       T1.Team_Name AS Home_Team, 
       T2.Team_Name AS Away_Team,   

    -- Determines the likely winner based on total market value comparison
    CASE 
        WHEN T1.Total_Market_Value > T2.Total_Market_Value THEN T1.Team_Name
        WHEN T1.Total_Market_Value < T2.Total_Market_Value THEN T2.Team_Name
        ELSE 'Tie'  -- If the market values are equal, the result is a 'Tie'
    END AS Likely_Winner

FROM GameMatch AS GM  -- From the GameMatch table, aliased as GM

-- Joining the GameMatch table with a subquery that calculates each team's total market value
JOIN (SELECT T.Team_ID, 
             T.Team_Name,
             SUM(P.Market_Value) AS Total_Market_Value  -- Calculating the total market value for each team
     FROM Team AS T  -- From the Team table, aliased as T
     
	 JOIN Player AS P ON T.Team_ID = P.Team_ID  -- Join with the Player table to include player market values
     
	 GROUP BY T.Team_ID, T.Team_Name) T1 ON GM.Team1_ID = T1.Team_ID  -- Join condition for the first team

JOIN (SELECT T.Team_ID, 
             T.Team_Name,
             SUM(P.Market_Value) AS Total_Market_Value  -- Repeating the process for the second team
     FROM Team AS T
     
	 JOIN Player AS P ON T.Team_ID = P.Team_ID
     
	 GROUP BY T.Team_ID, T.Team_Name) T2 ON GM.Team2_ID = T2.Team_ID  -- Join condition for the second team

ORDER BY GM.Match_Start_Date ASC;  -- Ordering the results by the match start date in ascending order


-- =============================================================================================================================================== Query 14: Extra

SELECT T.Team_Name,
       IFNULL(WinCount.Predicted_Wins, 0) AS Predicted_Wins
FROM Team AS T

LEFT JOIN (SELECT Winner.Team_Name,
                  COUNT(*) AS Predicted_Wins
     
	 FROM (SELECT CASE 
                      WHEN T1.Total_Market_Value > T2.Total_Market_Value THEN T1.Team_Name
                      WHEN T1.Total_Market_Value < T2.Total_Market_Value THEN T2.Team_Name
                      ELSE NULL 
                  END AS Team_Name
           FROM GameMatch AS GM
           
		   JOIN (SELECT T.Team_ID, 
                        T.Team_Name,
                        SUM(P.Market_Value) AS Total_Market_Value
                 FROM Team AS T
                
				 JOIN Player AS P ON T.Team_ID = P.Team_ID
                 
				 GROUP BY T.Team_ID, T.Team_Name) T1 ON GM.Team1_ID = T1.Team_ID
           
		   JOIN (SELECT T.Team_ID, 
                        T.Team_Name,
                        SUM(P.Market_Value) AS Total_Market_Value
                 FROM Team AS T
               
			     JOIN Player AS P ON T.Team_ID = P.Team_ID
               
			     GROUP BY T.Team_ID, T.Team_Name) T2 ON GM.Team2_ID = T2.Team_ID
                ) Winner
     WHERE Winner.Team_Name IS NOT NULL
     
	 GROUP BY Winner.Team_Name) WinCount ON T.Team_Name = WinCount.Team_Name

ORDER BY Predicted_Wins DESC;

-- =============================================================================================================================================== Query 15: Extra

SELECT CASE 
         WHEN T.Team_Name IS NULL THEN 'Undrafted'
         ELSE T.Team_Name
       END AS Team_Name,     
       P.First_Name,     
       P.Last_Name,    
       CASE 
         WHEN P.Injury_Status = 'Injured' THEN '**Injured**'
         ELSE P.Injury_Status
       END AS Injury_Status,   
       P.Position          

FROM Player AS P           -- From the Player table, aliased as P

LEFT JOIN Team AS T        -- Left join with the Team table, aliased as T
ON P.Team_ID = T.Team_ID   -- Join is made where Team IDs match between Player and Team tables

ORDER BY Team_Name ASC,    -- Order the results by team name (including 'Undrafted') in ascending order
         P.Position ASC;   -- Then, order by player position in ascending order

-- =============================================================================================================================================== Query 16: Extra

-- Display match week, teams, outcome, and score
SELECT DATE(Match_Start_Date) AS Week_Start, 
       DATE(Match_End_Date) AS Week_End, 
       Team1.Team_Name AS Home_Team, 
       Team2.Team_Name AS Away_Team, 
       Match_Score,
       Match_Outcome
FROM GameMatch                     
INNER JOIN Team AS Team1 ON GameMatch.Team1_ID = Team1.Team_ID  
INNER JOIN Team AS Team2 ON GameMatch.Team2_ID = Team2.Team_ID 
ORDER BY Week_Start ASC;