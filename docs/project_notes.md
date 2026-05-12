# Project Notes

## Project
EPL Shot Quality Analysis

## Season
2024/25 English Premier League

## Main Objective
Analyse team attacking value, shot quality, defensive vulnerability, and player shooting contribution.

## Current Stage
Data source planning

---

## Project Direction

The project will combine match-level data and expected goals data.

The first version will focus on team-level analysis. Player-level and shot-level analysis will be added after the team-level structure is working correctly.

---

## Planned Sources

### Football-Data
Used for match-level results and statistics.

Expected use:
- match results
- home and away teams
- goals
- shots
- shots on target
- corners
- cards

### Understat
Used for expected goals and shot quality.

Expected use:
- xG
- xGA
- NPxG
- NPxGA
- player xG
- player xA

---

## Key Early Decisions

- Use one completed Premier League season: 2024/25.
- Start with team-level analysis before player-level analysis.
- Use Football-Data for match-level structure.
- Use Understat for expected goals and shot quality.
- Keep raw data separate from cleaned data.
- Document source limitations before building SQL tables.

---

## Raw Data Inspection: Football-Data Match CSV

### File

`data/raw/epl_2024_25_matches.csv`

### Source

Football-Data 2024/25 Premier League CSV

### Row Grain

One row represents one Premier League match.

### Key Fields Identified

- `Date`
- `HomeTeam`
- `AwayTeam`
- `FTHG`
- `FTAG`
- `FTR`
- `HS`
- `AS`
- `HST`
- `AST`
- `HC`
- `AC`
- `HY`
- `AY`
- `HR`
- `AR`

### Initial Use

This dataset will be used to create match-level and team-match-level tables.

### Notes

- The file contains both match statistics and betting odds.
- The first stage of the project will focus on match statistics only.
- Betting odds columns will be ignored for the initial analysis.
- The data will later be reshaped from one row per match into one row per team per match.

---

## Football-Data Column Selection

### File Reviewed

`data/raw/epl_2024_25_matches.csv`

### Row Grain

One row represents one Premier League match.

### Columns Selected for Initial SQL Table

| Column | Planned Use |
|---|---|
| `Div` | League identifier |
| `Date` | Match date |
| `Time` | Match kickoff time |
| `HomeTeam` | Home team |
| `AwayTeam` | Away team |
| `FTHG` | Full-time home goals |
| `FTAG` | Full-time away goals |
| `FTR` | Full-time result |
| `HTHG` | Half-time home goals |
| `HTAG` | Half-time away goals |
| `HTR` | Half-time result |
| `Referee` | Match context |
| `HS` | Home shots |
| `AS` | Away shots |
| `HST` | Home shots on target |
| `AST` | Away shots on target |
| `HF` | Home fouls |
| `AF` | Away fouls |
| `HC` | Home corners |
| `AC` | Away corners |
| `HY` | Home yellow cards |
| `AY` | Away yellow cards |
| `HR` | Home red cards |
| `AR` | Away red cards |

### Columns Ignored for Initial Analysis

Betting odds columns will be ignored in the first version of the project.

Examples include bookmaker odds and market average odds such as:

- `B365H`
- `B365D`
- `B365A`
- `MaxH`
- `MaxD`
- `MaxA`
- `AvgH`
- `AvgD`
- `AvgA`

### Reason for Excluding Betting Odds

The initial project focus is team performance, shot volume, attacking efficiency, and defensive vulnerability.

Betting odds may be useful for a future market-expectation analysis, but they are outside the scope of the first version.

---

## Clean Match Dataset Created

### Clean File

`data/clean/epl_2024_25_matches_clean.csv`

### Source File

`data/raw/epl_2024_25_matches.csv`

### Cleaning Actions Completed

- Selected match-performance columns only.
- Removed betting odds columns from the working dataset.
- Renamed source columns into SQL-friendly snake_case names.
- Preserved the original raw file unchanged.

### Row Grain

One row represents one Premier League match.

### Expected Row Count

380 match rows.

### Purpose

This cleaned file will be used as the import file for the first MySQL table.

### Notes

The cleaned file focuses on match results and match statistics only. Betting odds may be revisited in a future version of the project but are outside the scope of the initial performance analysis.

---

## MySQL Clean Match Table Created

### SQL Script

`sql/02_clean_tables.sql`

### Source Table

`raw_matches`

### Clean Table Created

`clean_matches`

### Table Grain

One row represents one Premier League match.

### Cleaning Actions Completed

- Converted `match_date` from text to SQL date format.
- Added readable result labels for full-time result.
- Added readable result labels for half-time result.
- Created match-level derived fields:
  - `total_goals`
  - `total_shots`
  - `total_shots_on_target`
  - `total_corners`
  - `total_yellow_cards`
  - `total_red_cards`

### Validation Checks

- Expected row count: 380
- Confirmed no null match dates after date conversion.
- Confirmed full-time result labels match source result codes.
- Checked sample derived totals.

### Notes

The `clean_matches` table is still match-level. The next stage will reshape the data into a team-match table with one row per team per match.

---

## Team Match Stats Table Created

### SQL Script

`sql/03_derived_tables.sql`

### Source Table

`clean_matches`

### Derived Table Created

`team_match_stats`

### Table Grain

One row represents one team in one Premier League match.

### Transformation Completed

The match-level table was reshaped from one row per match into one row per team per match.

Each match now appears as two rows:

- one row for the home team
- one row for the away team

### New Team-Perspective Fields

- `team`
- `opponent`
- `venue`
- `goals_for`
- `goals_against`
- `goal_difference`
- `result`
- `points`
- `shots_for`
- `shots_against`
- `shots_on_target_for`
- `shots_on_target_against`
- `corners_for`
- `corners_against`
- `yellow_cards`
- `red_cards`

### Validation Checks

- Expected row count: 760
- Expected teams: 20
- Expected matches per team: 38
- Expected venue rows: 380 home and 380 away
- Expected result categories: `W`, `D`, `L`

### Notes

This table is the foundation for team-level analysis. It allows performance metrics to be calculated consistently regardless of whether a team played at home or away.
