select game_id, MAX(game_date) AS latest_game
from {{ target.catalog }}.{{ target.schema }}.{{ target.name }}_zzz_games
group by game_id
