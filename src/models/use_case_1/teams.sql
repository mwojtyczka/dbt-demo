{{ config(
  materialized='table',
  file_format='delta'
) }}
select
    team_id,
    team_city
from {{ ref('team_cities') }}  -- use seed data to populate the table