{{ config(
  materialized='table',
  file_format='delta'
) }}
select * from {{ ref('country_snapshot') }}