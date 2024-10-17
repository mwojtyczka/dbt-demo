-- create a view
select account_id, workspace_id, usage_date, sum(usage_quantity) as quantity, sum({{ cents_to_dollars('usage_quantity') }}) as amount_usd
from system.billing.usage
group by account_id, workspace_id, usage_date
