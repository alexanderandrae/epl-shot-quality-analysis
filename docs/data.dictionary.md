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

---

### matches_clean

One row per Premier League match.

Source file:

`data/clean/epl_2024_25_matches_clean.csv`

Purpose:

Cleaned match-level dataset prepared for MySQL import.

| Column | Description | Initial Data Type |
|---|---|---|
| `division` | League division | Text |
| `match_date` | Match date | Date |
| `kickoff_time` | Match kickoff time | Text |
| `home_team` | Home team name | Text |
| `away_team` | Away team name | Text |
| `full_time_home_goals` | Full-time home goals | Integer |
| `full_time_away_goals` | Full-time away goals | Integer |
| `full_time_result` | Full-time result: H = home win, D = draw, A = away win | Text |
| `half_time_home_goals` | Half-time home goals | Integer |
| `half_time_away_goals` | Half-time away goals | Integer |
| `half_time_result` | Half-time result: H = home lead, D = draw, A = away lead | Text |
| `referee` | Match referee | Text |
| `home_shots` | Home team shots | Integer |
| `away_shots` | Away team shots | Integer |
| `home_shots_on_target` | Home shots on target | Integer |
| `away_shots_on_target` | Away shots on target | Integer |
| `home_fouls` | Home fouls committed | Integer |
| `away_fouls` | Away fouls committed | Integer |
| `home_corners` | Home corners | Integer |
| `away_corners` | Away corners | Integer |
| `home_yellow_cards` | Home yellow cards | Integer |
| `away_yellow_cards` | Away yellow cards | Integer |
| `home_red_cards` | Home red cards | Integer |
| `away_red_cards` | Away red cards | Integer |

Notes:

- This file excludes betting odds columns.
- This file uses SQL-friendly column names.
- This file will be used to create the first MySQL table.

---

### clean_matches

One row per Premier League match.

Source table:

`raw_matches`

Created by:

`sql/02_clean_tables.sql`

Purpose:

Cleaned match-level SQL table prepared for analysis and later reshaping.

| Column | Description | Data Type |
|---|---|---|
| `match_id` | Unique match identifier created during raw import | Integer |
| `division` | League division | Text |
| `match_date` | Match date converted to SQL date format | Date |
| `kickoff_time` | Match kickoff time | Text |
| `home_team` | Home team name | Text |
| `away_team` | Away team name | Text |
| `full_time_home_goals` | Full-time home goals | Integer |
| `full_time_away_goals` | Full-time away goals | Integer |
| `full_time_result` | Source result code: H, D, A | Text |
| `full_time_result_label` | Readable full-time result label | Text |
| `half_time_home_goals` | Half-time home goals | Integer |
| `half_time_away_goals` | Half-time away goals | Integer |
| `half_time_result` | Source half-time result code: H, D, A | Text |
| `half_time_result_label` | Readable half-time result label | Text |
| `referee` | Match referee | Text |
| `home_shots` | Home team shots | Integer |
| `away_shots` | Away team shots | Integer |
| `home_shots_on_target` | Home shots on target | Integer |
| `away_shots_on_target` | Away shots on target | Integer |
| `home_fouls` | Home fouls committed | Integer |
| `away_fouls` | Away fouls committed | Integer |
| `home_corners` | Home corners | Integer |
| `away_corners` | Away corners | Integer |
| `home_yellow_cards` | Home yellow cards | Integer |
| `away_yellow_cards` | Away yellow cards | Integer |
| `home_red_cards` | Home red cards | Integer |
| `away_red_cards` | Away red cards | Integer |
| `total_goals` | Combined full-time goals for both teams | Integer |
| `total_shots` | Combined shots for both teams | Integer |
| `total_shots_on_target` | Combined shots on target for both teams | Integer |
| `total_corners` | Combined corners for both teams | Integer |
| `total_yellow_cards` | Combined yellow cards for both teams | Integer |
| `total_red_cards` | Combined red cards for both teams | Integer |

Notes:

- This table is still match-level.
- Team-level analysis will require reshaping into one row per team per match.

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

---

### team_match_stats

One row per team per Premier League match.

Source table:

`clean_matches`

Created by:

`sql/03_derived_tables.sql`

Purpose:

Reshaped team-level match table used for team performance analysis.

| Column | Description | Data Type |
|---|---|---|
| `match_id` | Match identifier from clean match table | Integer |
| `division` | League division | Text |
| `match_date` | Match date | Date |
| `kickoff_time` | Match kickoff time | Text |
| `team` | Team being analysed | Text |
| `opponent` | Opposing team | Text |
| `venue` | Home or Away | Text |
| `goals_for` | Goals scored by the team | Integer |
| `goals_against` | Goals conceded by the team | Integer |
| `goal_difference` | Goals for minus goals against | Integer |
| `result` | Team result: W, D, or L | Text |
| `points` | League points earned by the team | Integer |
| `half_time_goals_for` | Team goals at half-time | Integer |
| `half_time_goals_against` | Opponent goals at half-time | Integer |
| `half_time_goal_difference` | Half-time goals for minus half-time goals against | Integer |
| `shots_for` | Shots taken by the team | Integer |
| `shots_against` | Shots conceded by the team | Integer |
| `shots_on_target_for` | Team shots on target | Integer |
| `shots_on_target_against` | Opponent shots on target | Integer |
| `shot_on_target_rate_for` | Team shots on target divided by team shots | Decimal |
| `shot_on_target_rate_against` | Opponent shots on target divided by opponent shots | Decimal |
| `fouls_committed` | Fouls committed by the team | Integer |
| `fouls_won` | Fouls committed by the opponent | Integer |
| `corners_for` | Corners won by the team | Integer |
| `corners_against` | Corners won by the opponent | Integer |
| `yellow_cards` | Yellow cards received by the team | Integer |
| `opponent_yellow_cards` | Yellow cards received by the opponent | Integer |
| `red_cards` | Red cards received by the team | Integer |
| `opponent_red_cards` | Red cards received by the opponent | Integer |

Notes:

- This table converts home/away match data into team-perspective data.
- This is the main table for team-level analysis.
- Each team should have 38 rows.
- The full table should contain 760 rows.
