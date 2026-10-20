# Preliminary Findings — EPL 2024/25

## Purpose

This document records the initial findings from the 2024/25 Premier League match-statistics analysis.

The initial analysis focuses on attacking volume, scoring output, defensive shot suppression and team performance. Expected goals data has not yet been incorporated.

## Finding 1: Attacking volume does not fully explain scoring output

Liverpool produced 17.05 shots and 2.26 goals per match, representing strong output on both measures.

However, Brentford averaged 11.61 shots and 1.74 goals per match, while Bournemouth averaged 15.26 shots and 1.53 goals per match.

Brentford therefore achieved a higher scoring output despite substantially lower shot volume.

**Interpretation:** Total shot volume alone does not explain scoring performance. Differences in chance quality, finishing or both may contribute.

**Further investigation:** Compare expected goals per shot and goals minus expected goals.

## Finding 2: Defensive shot suppression varies substantially

Arsenal conceded an average of 9.53 shots and 0.89 goals per match.

Southampton conceded 17.95 shots and 2.26 goals per match.

These results illustrate a substantial difference in both opposition shooting volume and goals conceded.

**Interpretation:** Lower shot volume conceded was accompanied by lower scoring output against in these examples. However, shots conceded do not account for the quality of opportunities allowed.

**Further investigation:** Compare xG conceded per match and xG conceded per shot.

## Finding 3: Shot difference does not completely explain league performance

Nottingham Forest recorded 65 points despite a season shot difference of -68.

Manchester United recorded 42 points despite a positive shot difference of +112.

This demonstrates that shot dominance alone is insufficient to explain the difference in league outcomes between these two teams.

**Interpretation:** The relationship between shots and results is more complex than volume alone.

**Further investigation:** Compare shot quality, expected goal difference, finishing performance and goals conceded relative to xG against.

## Analytical Limitations

- The dataset currently contains match-level shooting statistics rather than individual shot locations or shot-level xG.
- Goals per shot is a descriptive conversion metric, not a direct measurement of finishing skill.
- Defensive shots conceded do not measure the danger of those opportunities.
- The comparisons are observational and do not establish causation.
- Further analysis with xG and xGA is required before drawing stronger conclusions.

## Next Stage

Integrate expected goals data to investigate whether differences in team outcomes can be explained by the quality of chances created and conceded.

## Data Source

[Team Summary Metrics](../outputs/tables/team_summary_metrics.csv)
