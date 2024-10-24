SELECT color, COUNT(*)
FROM {{ ref('diamonds_list_colors') }}
GROUP BY color
HAVING COUNT(*) > 1
