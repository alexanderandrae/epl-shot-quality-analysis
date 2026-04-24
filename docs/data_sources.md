# Data Sources

This project uses public football data to analyse the 2024/25 English Premier League season.

The project combines match-level data with expected goals data to evaluate team attacking output, shot quality, finishing efficiency, and defensive vulnerability.

---

## Source 1: Football-Data

### Website

https://www.football-data.co.uk/englandm.php

### Dataset Used

2024/25 Premier League CSV

### Planned File

`data/raw/epl_2024_25_matches.csv`

### Data Level

One row per match.

### Main Fields Expected

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

### Intended Use

This source will be used for match-level analysis, including:

- match results
- goals scored and conceded
- team shots
- team shots on target
- home and away performance
- basic attacking and defensive match summaries

### Notes

Football-Data provides structured CSV files for football results, match statistics, and betting odds.

For this project, the main focus will be match results and match statistics rather than betting markets.

---

## Source 2: Understat

### Website

https://understat.com/league/EPL

### Dataset Used

2024/25 English Premier League expected goals data

### Planned Files

- `data/raw/epl_2024_25_understat_team_xg.csv`
- `data/raw/epl_2024_25_understat_player_xg.csv`

### Data Level

Expected to include team-level and player-level expected goals data.

### Main Fields Expected

Team-level fields may include:

- `team`
- `matches`
- `goals`
- `xG`
- `NPxG`
- `xGA`
- `NPxGA`
- `xPTS`

Player-level fields may include:

- `player`
- `team`
- `goals`
- `shots`
- `xG`
- `assists`
- `xA`
- `key_passes`
- `minutes`

### Intended Use

This source will be used for expected goals and shot quality analysis, including:

- team attacking quality
- team defensive chance quality
- finishing overperformance or underperformance
- player shooting contribution
- player chance creation contribution

### Notes

Understat provides expected goals data for major European leagues.

The project will begin with team-level xG analysis before expanding into player-level analysis.

---

## Source Strategy

The project uses two complementary data sources:

| Source | Main Purpose | Data Level |
|---|---|---|
| Football-Data | Match results and match statistics | Match |
| Understat | Expected goals and shot quality | Team / Player |
| Combined dataset | Efficiency and vulnerability analysis | Team / Match / Player |

Football-Data gives the match structure and basic match statistics.

Understat adds the quality layer through expected goals.

Together, these sources allow the project to compare both volume and quality of attacking and defensive performance.

---

## Data Limitations

Potential limitations include:

- Team names may differ between sources and may need standardisation.
- Football-Data match statistics do not include expected goals.
- Understat expected goals data may need manual export or extraction.
- Player-level data may require additional processing.
- Different sources may define statistics differently.
- Match-level and xG-level data may not join perfectly without cleaning.

These limitations will be reviewed during the data inspection stage.

---

## Initial Data Plan

The first stage of analysis will focus on team-level metrics.

Initial planned outputs include:

- team attacking volume
- team shot quality
- goals versus expected goals
- defensive chance quality conceded
- finishing efficiency
- team-level attacking and defensive profiles

Player-level analysis will be added after the team-level structure is working correctly.
