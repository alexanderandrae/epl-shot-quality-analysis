-- 03_derived_tables.sql
-- Project: EPL Shot Quality Analysis
-- Purpose: Create derived analytical tables from cleaned match-level data.
--
-- Source table:
-- clean_matches
--
-- Output table:
-- team_match_stats
--
-- Table grain:
-- One row represents one team in one Premier League match.

USE epl_shot_quality_analysis;

DROP TABLE IF EXISTS team_match_stats;

CREATE TABLE team_match_stats AS

-- Home team rows
SELECT
    match_id,
    division,
    match_date,
    kickoff_time,

    home_team AS team,
    away_team AS opponent,
    'Home' AS venue,

    full_time_home_goals AS goals_for,
    full_time_away_goals AS goals_against,
    full_time_home_goals - full_time_away_goals AS goal_difference,

    CASE
        WHEN full_time_result = 'H' THEN 'W'
        WHEN full_time_result = 'D' THEN 'D'
        WHEN full_time_result = 'A' THEN 'L'
        ELSE 'Unknown'
    END AS result,

    CASE
        WHEN full_time_result = 'H' THEN 3
        WHEN full_time_result = 'D' THEN 1
        WHEN full_time_result = 'A' THEN 0
        ELSE NULL
    END AS points,

    half_time_home_goals AS half_time_goals_for,
    half_time_away_goals AS half_time_goals_against,
    half_time_home_goals - half_time_away_goals AS half_time_goal_difference,

    home_shots AS shots_for,
    away_shots AS shots_against,

    home_shots_on_target AS shots_on_target_for,
    away_shots_on_target AS shots_on_target_against,

    ROUND(home_shots_on_target / NULLIF(home_shots, 0), 3) AS shot_on_target_rate_for,
    ROUND(away_shots_on_target / NULLIF(away_shots, 0), 3) AS shot_on_target_rate_against,

    home_fouls AS fouls_committed,
    away_fouls AS fouls_won,

    home_corners AS corners_for,
    away_corners AS corners_against,

    home_yellow_cards AS yellow_cards,
    away_yellow_cards AS opponent_yellow_cards,

    home_red_cards AS red_cards,
    away_red_cards AS opponent_red_cards

FROM clean_matches

UNION ALL

-- Away team rows
SELECT
    match_id,
    division,
    match_date,
    kickoff_time,

    away_team AS team,
    home_team AS opponent,
    'Away' AS venue,

    full_time_away_goals AS goals_for,
    full_time_home_goals AS goals_against,
    full_time_away_goals - full_time_home_goals AS goal_difference,

    CASE
        WHEN full_time_result = 'A' THEN 'W'
        WHEN full_time_result = 'D' THEN 'D'
        WHEN full_time_result = 'H' THEN 'L'
        ELSE 'Unknown'
    END AS result,

    CASE
        WHEN full_time_result = 'A' THEN 3
        WHEN full_time_result = 'D' THEN 1
        WHEN full_time_result = 'H' THEN 0
        ELSE NULL
    END AS points,

    half_time_away_goals AS half_time_goals_for,
    half_time_home_goals AS half_time_goals_against,
    half_time_away_goals - half_time_home_goals AS half_time_goal_difference,

    away_shots AS shots_for,
    home_shots AS shots_against,

    away_shots_on_target AS shots_on_target_for,
    home_shots_on_target AS shots_on_target_against,

    ROUND(away_shots_on_target / NULLIF(away_shots, 0), 3) AS shot_on_target_rate_for,
    ROUND(home_shots_on_target / NULLIF(home_shots, 0), 3) AS shot_on_target_rate_against,

    away_fouls AS fouls_committed,
    home_fouls AS fouls_won,

    away_corners AS corners_for,
    home_corners AS corners_against,

    away_yellow_cards AS yellow_cards,
    home_yellow_cards AS opponent_yellow_cards,

    away_red_cards AS red_cards,
    home_red_cards AS opponent_red_cards

FROM clean_matches;

-- Add a composite primary key.
-- Each team should appear once per match.
ALTER TABLE team_match_stats
ADD PRIMARY KEY (match_id, team);

-- Add indexes for common analysis filters.
CREATE INDEX idx_team_match_stats_team
ON team_match_stats (team);

CREATE INDEX idx_team_match_stats_match_date
ON team_match_stats (match_date);

CREATE INDEX idx_team_match_stats_venue
ON team_match_stats (venue);

-- Basic checks:
-- SELECT COUNT(*) AS total_team_match_rows FROM team_match_stats;
-- SELECT * FROM team_match_stats LIMIT 10;
