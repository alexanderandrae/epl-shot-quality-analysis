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
