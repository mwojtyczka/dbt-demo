-- This season's games happened between 2020-12-12 and 2021-02-06.
-- For this test to pass, this query must return no results.

select date
from {{ ref('my_python_model') }}
where carat < 0.2
