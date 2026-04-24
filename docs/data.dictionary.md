# Data Dictionary

This document defines the planned tables, fields, and metrics for the EPL Shot Quality Analysis project.

## Planned Tables

### matches
One row per match.

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
