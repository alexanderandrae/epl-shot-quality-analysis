# Data Dictionary

This document defines the planned tables, fields, and metrics for the EPL Shot Quality Analysis project.

## Planned Tables

### matches

One row per Premier League match.

Source file:

`data/raw/epl_2024_25_matches.csv`

Planned SQL table name:

`raw_matches`

| Column | Description | Initial Data Type |
|---|---|---|
| `Div` | League division | Text |
| `Date` | Match date | Date |
| `Time` | Match kickoff time | Text |
| `HomeTeam` | Home team name | Text |
| `AwayTeam` | Away team name | Text |
| `FTHG` | Full-time home goals | Integer |
| `FTAG` | Full-time away goals | Integer |
| `FTR` | Full-time result: H = home win, D = draw, A = away win | Text |
| `HTHG` | Half-time home goals | Integer |
| `HTAG` | Half-time away goals | Integer |
| `HTR` | Half-time result: H = home lead, D = draw, A = away lead | Text |
| `Referee` | Match referee | Text |
| `HS` | Home team shots | Integer |
| `AS` | Away team shots | Integer |
| `HST` | Home shots on target | Integer |
| `AST` | Away shots on target | Integer |
| `HF` | Home fouls committed | Integer |
| `AF` | Away fouls committed | Integer |
| `HC` | Home corners | Integer |
| `AC` | Away corners | Integer |
| `HY` | Home yellow cards | Integer |
| `AY` | Away yellow cards | Integer |
| `HR` | Home red cards | Integer |
| `AR` | Away red cards | Integer |

Notes:

- Betting odds columns are excluded from the first version of the SQL workflow.
- This table will later be reshaped into a team-match table with one row per team per match.

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
