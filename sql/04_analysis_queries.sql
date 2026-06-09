-- 04_analysis_queries.sql
-- Project: EPL Shot Quality Analysis
-- Purpose: First team-level analysis queries using the team_season_summary table.
--
-- Main questions:
-- 1. Which teams performed best overall?
-- 2. Which teams generated the most attacking volume?
-- 3. Which teams were most efficient with their shots?
-- 4. Which teams suppressed opposition shots best?
-- 5. Which teams showed strong shot dominance?

USE epl_shot_quality_analysis;

-- ------------------------------------------------------------
-- Query 1: League table style summary
-- ------------------------------------------------------------
-- Purpose:
-- Check overall team performance using familiar football outcomes.
--
-- Why:
-- This validates that points, wins, draws, losses, and goal difference
-- have been calculated correctly.

SELECT
    team,
    matches_played,
    wins,
    draws,
    losses,
    points,
    goals_for,
    goals_against,
    goal_difference
FROM team_season_summary
ORDER BY points DESC, goal_difference DESC, goals_for DESC;


-- ------------------------------------------------------------
-- Query 2: Attacking volume profile
-- ------------------------------------------------------------
-- Purpose:
-- Identify which teams produced the highest shooting volume.
--
-- Why:
-- Shot volume is an early proxy for attacking pressure.
-- It does not tell us chance quality yet, but it helps identify
-- which teams consistently generated attempts.

SELECT
    team,
    shots_for,
    shots_for_per_match,
    shots_on_target_for,
    shots_on_target_for_per_match,
    shot_on_target_rate_for,
    goals_for,
    goals_for_per_match
FROM team_season_summary
ORDER BY shots_for_per_match DESC;


-- ------------------------------------------------------------
-- Query 3: Attacking efficiency profile
-- ------------------------------------------------------------
-- Purpose:
-- Compare how efficiently teams converted shots into goals.
--
-- Why:
-- Goal conversion rate can indicate finishing efficiency, but it
-- should be interpreted carefully because it does not yet account
-- for expected goals or shot quality.

SELECT
    team,
    goals_for,
    shots_for,
    shots_for_per_match,
    shot_on_target_rate_for,
    goal_conversion_rate,
    goals_for_per_match
FROM team_season_summary
ORDER BY goal_conversion_rate DESC;


-- ------------------------------------------------------------
-- Query 4: Defensive shot suppression profile
-- ------------------------------------------------------------
-- Purpose:
-- Identify which teams allowed the fewest opposition shots.
--
-- Why:
-- Shots against per match is an early measure of defensive control.
-- A team that concedes fewer shots may be better at suppressing
-- opposition attacks.

SELECT
    team,
    shots_against,
    shots_against_per_match,
    shots_on_target_against,
    shots_on_target_against_per_match,
    shot_on_target_rate_against,
    goals_against,
    goals_against_per_match
FROM team_season_summary
ORDER BY shots_against_per_match ASC;


-- ------------------------------------------------------------
-- Query 5: Defensive vulnerability profile
-- ------------------------------------------------------------
-- Purpose:
-- Compare how efficiently opponents converted shots against each team.
--
-- Why:
-- Opponent goal conversion rate can highlight defensive vulnerability,
-- goalkeeper impact, or chance-quality issues. This needs xG later
-- before making strong claims.

SELECT
    team,
    goals_against,
    shots_against,
    shots_against_per_match,
    shot_on_target_rate_against,
    opponent_goal_conversion_rate,
    goals_against_per_match
FROM team_season_summary
ORDER BY opponent_goal_conversion_rate DESC;


-- ------------------------------------------------------------
-- Query 6: Shot dominance profile
-- ------------------------------------------------------------
-- Purpose:
-- Compare teams by shot difference and shots-on-target difference.
--
-- Why:
-- Shot difference shows whether a team generally creates more attempts
-- than it allows. This is a useful early performance-balance metric.

SELECT
    team,
    shots_for,
    shots_against,
    shot_difference,
    shots_on_target_for,
    shots_on_target_against,
    shots_on_target_difference,
    goal_difference,
    points
FROM team_season_summary
ORDER BY shot_difference DESC;


-- ------------------------------------------------------------
-- Query 7: Team attacking style segmentation
-- ------------------------------------------------------------
-- Purpose:
-- Segment teams by attacking volume and shooting accuracy.
--
-- Why:
-- This turns raw metrics into interpretable categories.
-- It helps move the project beyond rankings and toward analysis.

WITH league_averages AS (
    SELECT
        AVG(shots_for_per_match) AS avg_shots_for_per_match,
        AVG(shot_on_target_rate_for) AS avg_shot_on_target_rate_for
    FROM team_season_summary
)

SELECT
    t.team,
    t.shots_for_per_match,
    t.shot_on_target_rate_for,
    t.goals_for_per_match,
    CASE
        WHEN t.shots_for_per_match >= l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for >= l.avg_shot_on_target_rate_for
            THEN 'High volume / high accuracy'
        WHEN t.shots_for_per_match >= l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for < l.avg_shot_on_target_rate_for
            THEN 'High volume / low accuracy'
        WHEN t.shots_for_per_match < l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for >= l.avg_shot_on_target_rate_for
            THEN 'Low volume / high accuracy'
        ELSE 'Low volume / low accuracy'
    END AS attacking_profile
FROM team_season_summary t
CROSS JOIN league_averages l
ORDER BY t.shots_for_per_match DESC;


-- ------------------------------------------------------------
-- Query 8: Defensive profile segmentation
-- ------------------------------------------------------------
-- Purpose:
-- Segment teams by shots conceded and opponent conversion rate.
--
-- Why:
-- This helps identify different defensive profiles:
-- teams that suppress shots, teams that concede many shots,
-- and teams whose opponents convert chances efficiently.

WITH league_averages AS (
    SELECT
        AVG(shots_against_per_match) AS avg_shots_against_per_match,
        AVG(opponent_goal_conversion_rate) AS avg_opponent_goal_conversion_rate
    FROM team_season_summary
)

SELECT
    t.team,
    t.shots_against_per_match,
    t.opponent_goal_conversion_rate,
    t.goals_against_per_match,
    CASE
        WHEN t.shots_against_per_match < l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate < l.avg_opponent_goal_conversion_rate
            THEN 'Low volume conceded / low conversion conceded'
        WHEN t.shots_against_per_match < l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate >= l.avg_opponent_goal_conversion_rate
            THEN 'Low volume conceded / high conversion conceded'
        WHEN t.shots_against_per_match >= l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate < l.avg_opponent_goal_conversion_rate
            THEN 'High volume conceded / low conversion conceded'
        ELSE 'High volume conceded / high conversion conceded'
    END AS defensive_profile
FROM team_season_summary t
CROSS JOIN league_averages l
ORDER BY t.shots_against_per_match ASC;


-- ------------------------------------------------------------
-- Query 9: Relationship between shot dominance and points
-- ------------------------------------------------------------
-- Purpose:
-- Compare points with shot difference and goal difference.
--
-- Why:
-- This prepares for later visual analysis, especially scatter plots
-- comparing performance process metrics with outcomes.

SELECT
    team,
    points,
    goal_difference,
    shot_difference,
    shots_on_target_difference,
    goals_for,
    goals_against
FROM team_season_summary
ORDER BY points DESC;


-- ------------------------------------------------------------
-- Query 10: Export-ready team summary
-- ------------------------------------------------------------
-- Purpose:
-- Create a compact table suitable for exporting to CSV or building charts.
--
-- Why:
-- This gives a clean output for Excel, Tableau, Power BI, or later portfolio visuals.

SELECT
    team,
    points,
    goal_difference,
    goals_for_per_match,
    goals_against_per_match,
    shots_for_per_match,
    shots_against_per_match,
    shot_difference,
    shot_on_target_rate_for,
    shot_on_target_rate_against,
    goal_conversion_rate,
    opponent_goal_conversion_rate
FROM team_season_summary
ORDER BY points DESC;

-- ------------------------------------------------------------
-- Export-ready SQL views
-- ------------------------------------------------------------
-- Purpose:
-- Create repeatable outputs that can be exported for Excel charts
-- and saved in outputs/tables.
--
-- These views are based on the team_season_summary table.

USE epl_shot_quality_analysis;


-- ------------------------------------------------------------
-- View 1: Export-ready team summary
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_team_summary_export AS
SELECT
    team,
    points,
    goal_difference,
    goals_for,
    goals_against,
    goals_for_per_match,
    goals_against_per_match,
    shots_for_per_match,
    shots_against_per_match,
    shot_difference,
    shots_on_target_difference,
    shot_on_target_rate_for,
    shot_on_target_rate_against,
    goal_conversion_rate,
    opponent_goal_conversion_rate
FROM team_season_summary;


-- ------------------------------------------------------------
-- View 2: Attacking profile segmentation
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_attacking_profiles AS
SELECT
    t.team,
    t.points,
    t.goals_for_per_match,
    t.shots_for_per_match,
    t.shot_on_target_rate_for,
    t.goal_conversion_rate,
    CASE
        WHEN t.shots_for_per_match >= l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for >= l.avg_shot_on_target_rate_for
            THEN 'High volume / high accuracy'
        WHEN t.shots_for_per_match >= l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for < l.avg_shot_on_target_rate_for
            THEN 'High volume / low accuracy'
        WHEN t.shots_for_per_match < l.avg_shots_for_per_match
             AND t.shot_on_target_rate_for >= l.avg_shot_on_target_rate_for
            THEN 'Low volume / high accuracy'
        ELSE 'Low volume / low accuracy'
    END AS attacking_profile
FROM team_season_summary t
CROSS JOIN (
    SELECT
        AVG(shots_for_per_match) AS avg_shots_for_per_match,
        AVG(shot_on_target_rate_for) AS avg_shot_on_target_rate_for
    FROM team_season_summary
) l;


-- ------------------------------------------------------------
-- View 3: Defensive profile segmentation
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_defensive_profiles AS
SELECT
    t.team,
    t.points,
    t.goals_against_per_match,
    t.shots_against_per_match,
    t.shot_on_target_rate_against,
    t.opponent_goal_conversion_rate,
    CASE
        WHEN t.shots_against_per_match < l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate < l.avg_opponent_goal_conversion_rate
            THEN 'Low volume conceded / low conversion conceded'
        WHEN t.shots_against_per_match < l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate >= l.avg_opponent_goal_conversion_rate
            THEN 'Low volume conceded / high conversion conceded'
        WHEN t.shots_against_per_match >= l.avg_shots_against_per_match
             AND t.opponent_goal_conversion_rate < l.avg_opponent_goal_conversion_rate
            THEN 'High volume conceded / low conversion conceded'
        ELSE 'High volume conceded / high conversion conceded'
    END AS defensive_profile
FROM team_season_summary t
CROSS JOIN (
    SELECT
        AVG(shots_against_per_match) AS avg_shots_against_per_match,
        AVG(opponent_goal_conversion_rate) AS avg_opponent_goal_conversion_rate
    FROM team_season_summary
) l;


-- ------------------------------------------------------------
-- View 4: Shot dominance export
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_shot_dominance_export AS
SELECT
    team,
    points,
    goal_difference,
    shots_for,
    shots_against,
    shot_difference,
    shots_on_target_for,
    shots_on_target_against,
    shots_on_target_difference,
    shots_for_per_match,
    shots_against_per_match
FROM team_season_summary;
