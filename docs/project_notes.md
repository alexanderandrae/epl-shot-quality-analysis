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
