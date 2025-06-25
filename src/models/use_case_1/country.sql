-- create a table
-- https://docs.getdbt.com/reference/resource-configs/databricks-configs
{{ config(
  materialized='table',
  file_format='delta'
) }}
select
    country_code,
    country_name
from {{ ref('country_codes') }}  -- use seed data to populate the table
