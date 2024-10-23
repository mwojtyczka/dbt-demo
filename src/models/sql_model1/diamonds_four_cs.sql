-- create a table
-- https://docs.getdbt.com/reference/resource-configs/databricks-configs
{{ config(
  materialized='table',
  file_format='delta'
) }}
select
    carat,
    cut,
    color,
    clarity
-- get table specification from schema.yml
from {{ source('raw', 'diamonds') }} -- equivalent of: from hive_metastore.default.diamonds
