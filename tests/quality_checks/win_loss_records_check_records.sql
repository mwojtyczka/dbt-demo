-- Each team participated in 4 games this season.
-- For this test to pass, this query must return no results.
select
    'win_loss_records' as model,
    'date' as column,
    'wins_and_losses_value' as test,
    CAST(MAP() AS MAP<STRING, STRING>) AS params,
    wins,
    losses
from {{ ref('win_loss_records') }}
where wins < 0 or wins > 4
or losses < 0 or losses > 4
or (wins + losses) > 4