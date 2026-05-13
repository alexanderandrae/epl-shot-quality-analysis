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

-- ------------------------------------------------------------
-- Create team season summary table
-- ------------------------------------------------------------
-- Source table:
-- team_match_stats
--
-- Output table:
-- team_season_summary
--
-- Table grain:
-- One row represents one team across the full Premier League season.

DROP TABLE IF EXISTS team_season_summary;

CREATE TABLE team_season_summary AS
SELECT
    team,

    COUNT(*) AS matches_played,

    SUM(CASE WHEN venue = 'Home' THEN 1 ELSE 0 END) AS home_matches,
    SUM(CASE WHEN venue = 'Away' THEN 1 ELSE 0 END) AS away_matches,

    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END) AS losses,

    SUM(points) AS points,

    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goal_difference) AS goal_difference,

    ROUND(AVG(goals_for), 2) AS goals_for_per_match,
    ROUND(AVG(goals_against), 2) AS goals_against_per_match,

    SUM(shots_for) AS shots_for,
    SUM(shots_against) AS shots_against,

    ROUND(AVG(shots_for), 2) AS shots_for_per_match,
    ROUND(AVG(shots_against), 2) AS shots_against_per_match,

    SUM(shots_on_target_for) AS shots_on_target_for,
    SUM(shots_on_target_against) AS shots_on_target_against,

    ROUND(AVG(shots_on_target_for), 2) AS shots_on_target_for_per_match,
    ROUND(AVG(shots_on_target_against), 2) AS shots_on_target_against_per_match,

    ROUND(SUM(shots_on_target_for) / NULLIF(SUM(shots_for), 0), 3) AS shot_on_target_rate_for,
    ROUND(SUM(shots_on_target_against) / NULLIF(SUM(shots_against), 0), 3) AS shot_on_target_rate_against,

    ROUND(SUM(goals_for) / NULLIF(SUM(shots_for), 0), 3) AS goal_conversion_rate,
    ROUND(SUM(goals_against) / NULLIF(SUM(shots_against), 0), 3) AS opponent_goal_conversion_rate,

    SUM(shots_for) - SUM(shots_against) AS shot_difference,
    SUM(shots_on_target_for) - SUM(shots_on_target_against) AS shots_on_target_difference,

    SUM(corners_for) AS corners_for,
    SUM(corners_against) AS corners_against,

    ROUND(AVG(corners_for), 2) AS corners_for_per_match,
    ROUND(AVG(corners_against), 2) AS corners_against_per_match,

    SUM(fouls_committed) AS fouls_committed,
    SUM(fouls_won) AS fouls_won,

    SUM(yellow_cards) AS yellow_cards,
    SUM(red_cards) AS red_cards

FROM team_match_stats
GROUP BY team;

ALTER TABLE team_season_summary
ADD PRIMARY KEY (team);

CREATE INDEX idx_team_season_summary_points
ON team_season_summary (points);

CREATE INDEX idx_team_season_summary_goal_difference
ON team_season_summary (goal_difference);

-- Basic checks:
-- SELECT COUNT(*) AS total_teams FROM team_season_summary;
-- SELECT * FROM team_season_summary ORDER BY points DESC;
