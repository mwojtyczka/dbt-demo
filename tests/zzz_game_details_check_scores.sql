-- This sport allows no negative scores or tie games.
-- For this test to pass, this query must return no results.

select home_score, visitor_score
from {{ ref('zzz_game_details') }}
where home_score < 0
or visitor_score < 0
or home_score = visitor_score