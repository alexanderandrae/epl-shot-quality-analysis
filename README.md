# EPL Shot Quality Analysis

## Project Overview
This project analyses the 2024/25 English Premier League season to understand how teams create attacking value, how efficiently they convert chances, and which teams are most vulnerable defensively.

The project is designed as a portfolio piece to demonstrate data analytics skills using football data, with a focus on SQL, data cleaning, metric design, and analytical interpretation.

## Objectives
- Analyse team attacking output using shot volume, expected goals, and shot quality.
- Compare finishing efficiency using goals versus expected goals.
- Identify teams that concede high-quality chances.
- Build player-level shooting and finishing profiles.
- Communicate findings clearly through summary tables and visual outputs.

## Key Questions
1. Which EPL teams create the highest shot volume?
2. Which teams create the highest-quality chances?
3. Which teams outperform or underperform their expected goals?
4. Which teams are most defensively vulnerable?
5. Which players contribute most to shooting output and finishing efficiency?

## Tools
- SQL
- Excel
- GitHub

## Repository Structure
```text
data/
  raw/        original downloaded datasets
  clean/      cleaned datasets used for analysis

docs/
  project_notes.md
  data_dictionary.md

outputs/
  charts/     visual outputs
  tables/     exported summary tables

sql/
  01_raw_tables.sql
  02_clean_tables.sql
  03_derived_tables.sql
  04_analysis_queries.sql
```

## Initial Visuals

### Attacking Volume vs Scoring Output

![Attacking Volume vs Scoring Output](outputs/charts/attacking_volume_vs_scoring.png)

This chart compares team shot volume with scoring output across the 2024/25 Premier League season.

Each point represents one team. The dashed reference lines show the league averages for shots per match and goals per match.

The chart provides an early view of which teams generated high attacking volume, which teams converted that volume into goals, and which teams may require deeper expected goals analysis to separate finishing efficiency from chance quality.

## Preliminary Findings

Initial analysis of the 2024/25 Premier League season identified several differences between shooting volume and team outcomes.

**Key observations:**

- Liverpool combined high attacking volume with high scoring output, averaging 17.05 shots and 2.26 goals per match.
- Brentford averaged fewer shots than Bournemouth (11.61 vs 15.26) but scored more goals per match (1.74 vs 1.53).
- Nottingham Forest earned 65 points despite a negative shot difference, while Manchester United earned 42 points with a positive shot difference.

These results suggest that shooting volume alone is insufficient to explain team performance.

The next stage will investigate expected goals (xG) and expected goals against (xGA) to better understand differences in chance quality and outcomes.

[Read the full preliminary findings](docs/preliminary_findings.md)

## Project Status

**Current stage: Preliminary analysis completed**

- EPL 2024/25 match data imported and cleaned in MySQL
- Team-match and team-season summary tables created
- Attacking and defensive metrics calculated
- SQL analysis views and CSV exports created
- Initial attacking visual completed
- Preliminary findings documented

**Next:** Integrate expected goals (xG) data to assess chance quality and finishing performance.
