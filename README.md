# DAT 400 Final Project: NCAA Tournament Champion Analytics

## Scenario

You are building a data analytics project focused on NCAA Men’s Basketball Tournament performance. The project combines historical tournament data, champion data, team performance metrics, resume rankings, shooting splits, and Final Four location data.

The goal is to create a complete analytics pipeline that moves from raw data collection and cleaning into PostgreSQL, then into SQL-based analysis and Metabase dashboard visualizations.

This project is designed so someone else can understand the data sources, database structure, workflow, and dashboard purpose without needing to rebuild the project from the beginning.

---

## What You Will Build

```text
Scraped/CSV Data  →  Python Cleaning  →  PostgreSQL  →  SQL Queries  →  Metabase Dashboard
```

**Main project tables:**

| Table | Description |
|------|-------------|
| `champions` | NCAA national champions by year, including school location coordinates |
| `final_four_locations` | Final Four host city, state, arena, and arena coordinates by year |
| `shooting_splits` | Team shooting statistics by season |
| `resumes` | Resume-based team rankings and quality-win metrics |
| `bartt_away_neutral` | Advanced team metrics, seeds, rounds, and efficiency data |

**Main dashboard topics:**

- Champions by year
- Champion seed trends
- Adjusted efficiency and tournament success
- Resume strength and tournament round reached
- Shooting performance of champions
- Final Four arena locations
- Champion university locations

---

## Data Quality Issues to Check

Before loading the data into PostgreSQL, the cleaned files should be checked for common issues.

| Issue | Why It Matters |
|------|----------------|
| Inconsistent team names | Joins may fail if the same school is spelled differently across tables |
| Different year column names | Some tables use `Year`, while others use `YEAR` |
| Missing latitude or longitude | Map visualizations will not work correctly |
| Text stored as numbers | Metabase may not recognize fields as numeric |
| Duplicate rows | Aggregations and charts may become inaccurate |
| Missing values | SQL joins and dashboard results may exclude important records |
| Case-sensitive column names | PostgreSQL requires quoted names when columns contain capitals or spaces |

---

## Prerequisites

You need these tools installed before running the project.

| Tool | Purpose |
|------|---------|
| **Docker Desktop** | Runs PostgreSQL and Metabase locally |
| **PostgreSQL** | Stores cleaned project tables |
| **Metabase** | Creates charts, maps, questions, and dashboards |
| **DataGrip or DBeaver** | Tests SQL queries and inspects database tables |
| **Python 3.10+** | Runs scraping, cleaning, and upload scripts |
| **pandas** | Cleans and prepares datasets |
| **SQLAlchemy / psycopg2** | Connects Python to PostgreSQL |

---

## Setup

### 1. Start the Docker Stack

Start the Docker containers for PostgreSQL and Metabase from the folder that contains the Docker configuration.

The stack should include:

| Container | Purpose |
|----------|---------|
| `capstone_postgres` | PostgreSQL database |
| `capstone_metabase` | Metabase dashboard application |

After the containers start, PostgreSQL should be available through the local database port, and Metabase should be available in the browser.

Metabase usually opens at:

```text
http://localhost:3000
```

---

### 2. Prepare the Python Environment

Create and activate a Python virtual environment before running scraping or cleaning scripts.

The Python environment should include the packages needed to:

- Read CSV files
- Scrape or collect data
- Clean DataFrames
- Convert data types
- Add latitude and longitude fields
- Upload cleaned tables into PostgreSQL

---

### 3. Load the Cleaned Data into PostgreSQL

Each cleaned dataset should be written into PostgreSQL as its own table.

The main tables needed for the project are:

- `champions`
- `final_four_locations`
- `shooting_splits`
- `resumes`
- `bartt_away_neutral`

After loading the tables, confirm that each table appears in the PostgreSQL database and that the expected columns are present.

---

## Step-by-Step Workflow

### Step 1 — Collect the Data

The project uses data from scraped tables, CSV files, and manually updated location information.

The key data categories are:

| Data Category | Description |
|--------------|-------------|
| Champion data | Identifies the national champion for each year |
| Final Four location data | Identifies the host city, state, and arena |
| Team performance data | Includes efficiency, seed, round, and strength metrics |
| Resume data | Includes resume rank and quality-win information |
| Shooting data | Includes shooting percentages and shot-type performance |
| Geographic data | Includes latitude and longitude for universities and arenas |

---

### Step 2 — Clean the Data

The data should be cleaned before it is uploaded into PostgreSQL.

Important cleaning tasks include:

| Task | Purpose |
|------|---------|
| Standardize team names | Allows tables to join correctly |
| Standardize year fields | Makes year-based joins possible |
| Convert numeric fields | Allows charts, averages, and maps to work correctly |
| Remove unnecessary columns | Keeps the database easier to understand |
| Handle missing values | Prevents incomplete or misleading results |
| Add coordinates | Enables geographic visualizations in Metabase |

---

### Step 3 — Create the PostgreSQL Tables

After cleaning, the data should be loaded into PostgreSQL.

Each dataset should become a separate table. The table names should be simple and consistent so they are easy to use in SQL and Metabase.

Recommended table names:

| Table | Main Use |
|------|----------|
| `champions` | Connects each year to the national champion |
| `final_four_locations` | Connects each year to the Final Four site |
| `shooting_splits` | Compares shooting performance |
| `resumes` | Compares resume strength |
| `bartt_away_neutral` | Compares advanced team metrics |

---

### Step 4 — Connect DataGrip to PostgreSQL

Use DataGrip or another SQL editor to connect to the local PostgreSQL database.

DataGrip is useful for:

- Viewing tables
- Checking column names
- Testing joins
- Writing SQL queries
- Confirming data types
- Troubleshooting database issues before using Metabase

After connecting, verify that each project table appears in the database.

---

### Step 5 — Build SQL Queries

SQL queries are used to connect the project tables and create dashboard-ready results.

Important joins include:

| Join | Purpose |
|-----|---------|
| `champions` joined to `final_four_locations` | Connects champions to Final Four host sites |
| `champions` joined to `shooting_splits` | Shows shooting data for national champions |
| `resumes` joined to `bartt_away_neutral` | Compares resume strength with tournament results |
| `champions` joined to advanced metrics | Compares champion quality across years |

When writing SQL in PostgreSQL, column names with capital letters, spaces, or symbols must be wrapped in double quotes.

---

### Step 6 — Build the Metabase Dashboard

Metabase turns the SQL results and database tables into visualizations.

The dashboard should help answer the main project question:

**What characteristics are common among NCAA Tournament champions and successful tournament teams?**

Recommended dashboard sections:

| Section | What It Shows |
|--------|---------------|
| Championship Overview | Champions by year and seed |
| Team Strength | Adjusted efficiency, BARTHAG, and WAB |
| Resume Analysis | Resume rank and quality wins |
| Shooting Analysis | Dunk field goal percentage and three-point field goal percentage |
| Location Analysis | Final Four locations and champion university locations |

---

## Metabase Dashboard Requirements

The Metabase dashboard should be clear enough for someone else to understand without needing to read every SQL query.

Each chart should have:

- A clear title
- A useful visualization type
- Correct fields on each axis
- Clean labels
- A clear connection to the project question

Recommended visualizations:

| Visualization | Best Use |
|--------------|----------|
| Table | Showing champions by year |
| Bar chart | Comparing seeds, rounds, or grouped metrics |
| Line chart | Showing changes over time |
| Scatterplot | Comparing two numeric variables |
| Map | Showing arena or university locations |

---

## Important SQL Notes

PostgreSQL is case-sensitive when column names are quoted. Many project columns use capital letters, spaces, or symbols.

Examples of columns that must be handled carefully include:

- `Year`
- `YEAR`
- `Winner`
- `TEAM`
- `TEAM NO`
- `BADJ EM`
- `BADJ O`
- `BADJ D`
- `DUNKS FG%`
- `THREES FG%`

This matters because a query may fail if the exact column name is not used.

---

## Project File Structure

The project folder should be organized so that someone else can quickly find the data, scripts, SQL files, and dashboard materials.

```text
DAT400FinalProject/
├── data/
│   ├── raw/                  ← Original scraped or downloaded data
│   ├── cleaned/              ← Cleaned CSV files ready for PostgreSQL
│   └── output/               ← Updated files with added fields
│
├── scripts/
│   ├── scraping/             ← Scripts used to collect data
│   ├── cleaning/             ← Scripts used to clean data
│   └── database/             ← Scripts used to upload data
│
├── sql/
│   └── project_queries.sql   ← SQL queries used for analysis
│
├── docker/
│   └── docker-compose.yml    ← PostgreSQL and Metabase setup
│
├── README.md                 ← Project guide
└── requirements.txt          ← Python dependencies
```

---

## Main Research Questions

This project is built around the following research questions:

1. What types of teams usually win the NCAA Tournament?
2. Do champions usually have stronger adjusted offensive or defensive metrics?
3. How does seed relate to tournament success?
4. Does resume strength help explain how far a team advances?
5. Do shooting splits reveal patterns among championship teams?
6. Where have Final Four games been played?
7. How do champion university locations compare with Final Four arena locations?

---

## Key Takeaways

This project demonstrates a full data analytics workflow.

The project shows how raw sports data can be collected, cleaned, stored, queried, and visualized. It also shows how different types of data can work together. Champion history, advanced metrics, resume rankings, shooting splits, and geographic data each explain a different part of tournament success.

The strongest part of the project is the connection between SQL and Metabase. SQL creates the analytical results, while Metabase makes those results easier to understand through dashboards.

---

## Limitations

This project has several limitations.

Team names may not always match perfectly across datasets. If names are inconsistent, some joins may leave out valid teams.

Some statistics may not be available for every season. This can make year-to-year comparisons uneven.

Tournament results are also affected by factors that are difficult to measure, such as injuries, matchups, coaching decisions, travel, and random variation.

Because the NCAA Tournament is single elimination, one poor game can remove a strong team. For that reason, the project is better at describing patterns than proving exact causes.

---

## Future Improvements

Future versions of the project could add:

- Predictive modeling for tournament advancement
- Champion probability by seed
- Comparison between champions, Final Four teams, and all tournament teams
- Conference-level analysis
- Distance from campus to Final Four location
- More detailed player-level data
- Automated data refreshes
- More interactive Metabase filters
- A cleaned data dictionary for every table

---

## Final Project Summary

This project analyzes NCAA Tournament champions and team performance using Python, PostgreSQL, SQL, Docker, and Metabase.

The final product is a database-backed dashboard that helps explain patterns in tournament success. A user can inspect champions by year, compare advanced metrics, analyze resume strength, review shooting performance, and visualize tournament locations.

The README is intended to serve as the main guide for understanding the project, rebuilding the workflow, and explaining the final dashboard.
