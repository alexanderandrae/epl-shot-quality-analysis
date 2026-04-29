-- 01_raw_tables.sql
-- Project: EPL Shot Quality Analysis
-- Purpose: Create the initial MySQL database and raw match import table.
--
-- Source file:
-- data/clean/epl_2024_25_matches_clean.csv
--
-- Table grain:
-- One row represents one Premier League match.

CREATE DATABASE IF NOT EXISTS epl_shot_quality_analysis;

USE epl_shot_quality_analysis;

DROP TABLE IF EXISTS raw_matches;

CREATE TABLE raw_matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,

    division VARCHAR(10),
    match_date VARCHAR(20),
    kickoff_time VARCHAR(10),

    home_team VARCHAR(100),
    away_team VARCHAR(100),

    full_time_home_goals INT,
    full_time_away_goals INT,
    full_time_result CHAR(1),

    half_time_home_goals INT,
    half_time_away_goals INT,
    half_time_result CHAR(1),

    referee VARCHAR(100),

    home_shots INT,
    away_shots INT,
    home_shots_on_target INT,
    away_shots_on_target INT,

    home_fouls INT,
    away_fouls INT,

    home_corners INT,
    away_corners INT,

    home_yellow_cards INT,
    away_yellow_cards INT,

    home_red_cards INT,
    away_red_cards INT
);

-- Basic structure check after import:
-- SELECT COUNT(*) AS total_matches FROM raw_matches;
-- SELECT * FROM raw_matches LIMIT 10;
