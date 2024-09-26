select account_id, workspace_id, usage_date, sum(usage_quantity) as quantity
from system.billing.usage
group by account_id, workspace_id, usage_date
