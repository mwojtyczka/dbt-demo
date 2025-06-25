-- This sport allows no negative scores or tie games.
-- For this test to pass, this query must return no results.

SELECT
        'game_details' as model,
        'date' as column,
        'home_and_visitors_scores_less_than_0' as test,
        CAST(MAP() AS MAP<STRING, STRING>) AS params,
        home_score,
        visitor_score
from {{ ref('game_details') }}
where home_score < 0
or visitor_score < 0
or home_score = visitor_score