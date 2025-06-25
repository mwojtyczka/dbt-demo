select game_id, MAX(game_date) AS latest_game
from {{ ref('games') }}
group by game_id
