# Data Dictionary

This document defines the planned tables, fields, and metrics for the EPL Shot Quality Analysis project.

## Planned Tables

### matches

One row per Premier League match.

Planned source file:

`data/raw/epl_2024_25_matches.csv`

Expected key fields:

| Column | Description |
|---|---|
| `Date` | Match date |
| `HomeTeam` | Home team name |
| `AwayTeam` | Away team name |
| `FTHG` | Full-time home goals |
| `FTAG` | Full-time away goals |
| `FTR` | Full-time result |
| `HS` | Home team shots |
| `AS` | Away team shots |
| `HST` | Home shots on target |
| `AST` | Away shots on target |
| `HC` | Home corners |
| `AC` | Away corners |
| `HY` | Home yellow cards |
| `AY` | Away yellow cards |
| `HR` | Home red cards |
| `AR` | Away red cards |

### shots
One row per shot.

### teams
One row per team.

### players
One row per player.

### team_match_stats
One row per team per match.

## Planned Metrics

| Metric | Formula | Level | Purpose |
|---|---|---|---|
| shots_per_match | total shots / matches played | Team | Measures attacking volume |
| xg_per_match | total xG / matches played | Team | Measures attacking threat |
| xg_per_shot | total xG / total shots | Team | Measures chance quality |
| goals_minus_xg | goals - xG | Team/Player | Estimates finishing over/under-performance |
| shots_conceded_per_match | shots conceded / matches played | Team | Measures defensive shot suppression |
| xg_conceded_per_match | xG conceded / matches played | Team | Measures defensive vulnerability |
| xg_conceded_per_shot | xG conceded / shots conceded | Team | Measures quality of chances conceded |
