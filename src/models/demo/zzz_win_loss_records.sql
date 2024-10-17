-- Create a view that summarizes the season's win and loss records by team.
-- https://docs.getdbt.com/docs/build/materializations
{{
    config(
        materialized='materialized_view'
    )
}}
-- to refresh materialized view on schedule
--post_hook = 'ALTER MATERIALIZED VIEW {{this}} ADD SCHEDULE CRON "0 0 0 * * ? *" AT TIME ZONE "America/Los_Angeles";'
-- Step 2 of 2: Calculate the number of wins and losses for each team.
select
  winner as team,
  count(winner) as wins,
  -- Each team played in 4 games.
  (4 - count(winner)) as losses
from (
  -- Step 1 of 2: Determine the winner and loser for each game.
  select
    game_id,
    winner,
    case
      when
        home = winner
          then
            visitor
      else
        home
    end as loser
  from {{ ref('zzz_game_details') }}
)
group by winner
order by wins desc