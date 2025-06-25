-- create a view
select
    account_id,
    workspace_id,
    usage_date,
    sum(usage_quantity) as quantity,
    sum(ROUND({{ cents_to_dollars('usage_quantity') }}, 2)) as amount_usd
from system.billing.usage
group by account_id, workspace_id, usage_date
