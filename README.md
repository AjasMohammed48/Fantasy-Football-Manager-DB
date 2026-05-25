# ⚽ Fantasy Football Manager — MySQL Database Project

A relational database system built with MySQL that powers a fantasy football (soccer) management platform. Users can create fantasy teams, draft real-world Premier League players, track match outcomes, and manage player transfers — all backed by a structured, normalized database.

---

## 👥 Author

- **Ajas Mohammed**
---

## 📁 Repository Structure

```
fantasy-football-manager-db/
│
├── DDL.sql                  # Table creation scripts (schema definition)
├── DML.sql                  # Data insert/update/delete scripts
├── Queries.sql              # All analytical and reporting SQL queries
├── Fantasy_Manager_DB.txt   # Combined full database script (DDL + DML + Queries)
└── README.md                # Project documentation (this file)
```

---

## 🗃️ Database Schema

The database consists of **7 tables** with clearly defined relationships:

| Table | Description |
|---|---|
| `League` | Represents a fantasy league containing multiple teams |
| `User` | Platform users who own and manage fantasy teams |
| `Team` | Fantasy teams created and managed by users |
| `Real_World_Team` | Actual Premier League clubs (e.g., Arsenal, Chelsea) |
| `Player` | Real-world players that can be drafted into fantasy teams |
| `GameMatch` | Head-to-head matches between fantasy teams |
| `TransferMarket` | Tracks player draft and transfer activity |

### Entity Relationships

- A **League** has many **Users**
- A **User** owns one **Team**
- A **Team** has many **Players**
- A **Player** belongs to one **Real_World_Team** and optionally one **Team**
- **GameMatch** links two **Teams** in a weekly matchup
- **TransferMarket** links **Players** to **Users** for draft/transfer tracking

---

## 📊 SQL Queries Overview

The project includes **16 queries** covering a range of complexity:

| # | Description |
|---|---|
| 1 | List all players grouped by fantasy team and position |
| 2 | Show players with their team, injury status, and position |
| 3 | Highest market value player per position |
| 4 | Average market value of players per real-world team |
| 5 | Player availability status based on market value threshold |
| 6 | Match usernames to their fantasy team names |
| 7 | Real-world teams with their associated players |
| 8 | All undrafted (free agent) players with transfer info |
| 9 | Upcoming match schedule with participating teams |
| 10 | Transfer history — which users drafted which players |
| 11 | Count of drafted players |
| 12 | Count of undrafted players |
| 13 | Predict match winner based on total squad market value |
| 14 | Predicted win count per team across all fixtures |
| 15 | Full player roster including undrafted players with injury highlights |
| 16 | Full match schedule with scores and outcomes |

---

## 🚀 How to Set Up & Run

### Prerequisites

- [MySQL](https://dev.mysql.com/downloads/) (v8.0 or higher recommended) or [XAMPP](https://www.apachefriends.org/) / [MySQL Workbench](https://www.mysql.com/products/workbench/)

### Steps

1. Open your MySQL client (Workbench, CLI, or phpMyAdmin)
2. Create a new database:
   ```sql
   CREATE DATABASE fantasy_manager;
   USE fantasy_manager;
   ```
3. Run the DDL script to create tables:
   ```sql
   SOURCE DDL.sql;
   ```
4. Run the DML script to populate data:
   ```sql
   SOURCE DML.sql;
   ```
5. Run any query from `Queries.sql` to explore the data.

> Alternatively, run `Fantasy_Manager_DB.txt` as a single combined script to do all of the above at once.

---

## 📌 Notes

- Passwords in the `User` table are stored as plain text for academic demonstration purposes. In a production system, passwords should always be **hashed** (e.g., using bcrypt).
- The `TransferMarket` table uses a composite unique key on `(Player_ID, User_ID)` to prevent duplicate transfer entries.
- `GameMatch` uses a composite primary key `(Team1_ID, Team2_ID)` to uniquely identify each matchup.

---

## 📜 License

This project was created for academic purposes as part of a Database Systems course. Feel free to use or adapt it for learning.
