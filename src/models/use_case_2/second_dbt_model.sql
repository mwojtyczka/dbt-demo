-- Use the `ref` function to select from other models

select
    *, {{ cents_to_dollars('id') }} as amount_usd
from {{ ref('first_dbt_model') }}
