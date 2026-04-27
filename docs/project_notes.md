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

## Next Steps

1. Download the 2024/25 Premier League match CSV from Football-Data.
2. Save it in `data/raw`.
3. Inspect the columns in Excel.
4. Record the row grain, useful fields, and possible issues.
5. Begin updating the data dictionary.
