{% snapshot country_snapshot %}

{% set unique_key = 'country_code' %}
{% set strategy = 'check' %}
{% set check_cols = ['country_code'] %}
{% set target_database = 'dbt_demo' %}
{% set target_schema = 'dbt_dev' %}

{{
    config(
        target_database=target_database,
        target_schema=target_schema,
        unique_key=unique_key,
        strategy=strategy,
        check_cols=check_cols
    )
}}

-- SQL query for the snapshot
SELECT *
FROM {{ ref('country') }}

{% endsnapshot %}
