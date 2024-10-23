-- Create a table that provides full details for each game, including
-- the game ID, the home and visiting teams' city names and scores,
-- the game winner's city name, and the game date.
{{ config(
  materialized='table',
  file_format='delta'
) }}
-- Step 4 of 4: Replace the visitor team IDs with their city names.
select
    game_id,
    home,
    t.team_city as visitor,
    home_score,
    visitor_score,
    -- Step 3 of 4: Display the city name for each game's winner.
    game_date as date,
    case
        when
            home_score > visitor_score
            then
                home
        when
            visitor_score > home_score
            then
                t.team_city
    end as winner
from (
    -- Step 2 of 4: Replace the home team IDs with their actual city names.
    select
        game_id,
        t.team_city as home,
        home_score,
        visitor_team_id,
        visitor_score,
        game_date
    from (
    -- Step 1 of 4: Combine data from various tables (for example, game and team IDs, scores, dates).
        select
            g.game_id,
            go.home_team_id,
            gs.home_team_score as home_score,
            go.visitor_team_id,
            gs.visitor_team_score as visitor_score,
            g.game_date
        from
            marcin_demo.dbt.{{ target.name }}_zzz_games as g,
            marcin_demo.dbt.zzz_game_opponents as go,
            marcin_demo.dbt.zzz_game_scores as gs
        where
            g.game_id = go.game_id
            and g.game_id = gs.game_id
    ) as all_ids,
        marcin_demo.dbt.zzz_teams as t
    where
        all_ids.home_team_id = t.team_id
) as visitor_ids,
    marcin_demo.dbt.zzz_teams as t
where
    visitor_ids.visitor_team_id = t.team_id
order by game_date desc
