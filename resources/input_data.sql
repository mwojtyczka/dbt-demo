-- run this before running dbt models
CREATE CATALOG IF NOT EXISTS dbt_demo;

--DROP SCHEMA IF EXISTS dbt_demo.dbt_dev CASCADE;
CREATE SCHEMA IF NOT EXISTS dbt_demo.dbt_dev;

DROP TABLE hive_metastore.default.diamonds;
CREATE TABLE hive_metastore.default.diamonds USING CSV OPTIONS (path "/databricks-datasets/Rdatasets/data-001/csv/ggplot2/diamonds.csv", header "true");

USE dbt_demo.dbt_dev;

CREATE TABLE game_opponents (
    game_id INT,
    home_team_id INT,
    visitor_team_id INT
) USING DELTA;

INSERT INTO game_opponents VALUES (1, 1, 2);
INSERT INTO game_opponents VALUES (2, 1, 3);
INSERT INTO game_opponents VALUES (3, 2, 1);
INSERT INTO game_opponents VALUES (4, 2, 3);
INSERT INTO game_opponents VALUES (5, 3, 1);
INSERT INTO game_opponents VALUES (6, 3, 2);

CREATE TABLE game_scores (
    game_id INT,
    home_team_score INT,
    visitor_team_score INT
) USING DELTA;

INSERT INTO game_scores VALUES (1, 4, 2);
INSERT INTO game_scores VALUES (2, 0, 1);
INSERT INTO game_scores VALUES (3, 1, 2);
INSERT INTO game_scores VALUES (4, 3, 2);
INSERT INTO game_scores VALUES (5, 3, 0);
INSERT INTO game_scores VALUES (6, 3, 1);