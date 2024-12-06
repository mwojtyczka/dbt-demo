select count(1)
from {{ ref('country_codes') }}
