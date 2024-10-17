-- create a table
-- https://docs.getdbt.com/reference/resource-configs/databricks-configs
{{ config(
  materialized='table',
  file_format='delta'
) }}
select carat, cut, color, clarity
from hive_metastore.default.diamonds