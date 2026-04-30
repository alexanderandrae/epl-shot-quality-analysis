-- 02_clean_tables.sql
-- Project: EPL Shot Quality Analysis
-- Purpose: Create cleaned match-level tables from the raw imported match data.
--
-- Source table:
-- raw_matches
--
-- Output table:
-- clean_matches
--
-- Table grain:
-- One row represents one Premier League match.

USE epl_shot_quality_analysis;

DROP TABLE IF EXISTS clean_matches;

CREATE TABLE clean_matches AS
SELECT
    match_id,

    division,

    -- Convert text date into a proper SQL date.
    STR_TO_DATE(match_date, '%d/%m/%Y') AS match_date,

    kickoff_time,

    home_team,
    away_team,

    full_time_home_goals,
    full_time_away_goals,
    full_time_result,

    CASE
        WHEN full_time_result = 'H' THEN 'Home Win'
        WHEN full_time_result = 'A' THEN 'Away Win'
        WHEN full_time_result = 'D' THEN 'Draw'
        ELSE 'Unknown'
    END AS full_time_result_label,

    half_time_home_goals,
    half_time_away_goals,
    half_time_result,

    CASE
        WHEN half_time_result = 'H' THEN 'Home Lead'
        WHEN half_time_result = 'A' THEN 'Away Lead'
        WHEN half_time_result = 'D' THEN 'Draw'
        ELSE 'Unknown'
    END AS half_time_result_label,

    referee,

    home_shots,
    away_shots,
    home_shots_on_target,
    away_shots_on_target,

    home_fouls,
    away_fouls,

    home_corners,
    away_corners,

    home_yellow_cards,
    away_yellow_cards,

    home_red_cards,
    away_red_cards,

    -- Basic derived match-level fields.
    full_time_home_goals + full_time_away_goals AS total_goals,
    home_shots + away_shots AS total_shots,
    home_shots_on_target + away_shots_on_target AS total_shots_on_target,
    home_corners + away_corners AS total_corners,
    home_yellow_cards + away_yellow_cards AS total_yellow_cards,
    home_red_cards + away_red_cards AS total_red_cards

FROM raw_matches;

-- Add a primary key to the cleaned table.
ALTER TABLE clean_matches
ADD PRIMARY KEY (match_id);

-- Basic checks:
-- SELECT COUNT(*) AS total_matches FROM clean_matches;
-- SELECT * FROM clean_matches LIMIT 10;
