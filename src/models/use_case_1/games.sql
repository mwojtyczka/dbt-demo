{{ config(
  materialized='table',
  file_format='delta'
) }}
select
    game_id,
    game_date
from {{ ref('game_dates') }}  -- use seed data to populate the table