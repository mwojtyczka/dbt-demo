-- This season's games happened between 2020-12-12 and 2021-02-06.
-- For this test to pass, this query must return no results.

SELECT
        'game_details' as model,
        'date' as column,
        'game_details_incorrect_dates' as test,
        CAST(MAP() AS MAP<STRING, STRING>) AS params,
        date
from {{ ref('game_details') }}
where date < '2020-12-12'
or date > '2021-02-06'