-- Overwrite implementation of built-in generic unique data test
{% test unique(model, column_name) %}

    WITH duplicates AS (
        SELECT
            {{ column_name }}
        FROM {{ model }}
        GROUP BY {{ column_name }}
        HAVING COUNT(*) > 1
    )
    SELECT
        '{{ model }}' AS model,
        '{{ column_name }}' AS column,
        MAP('column', '{{ column_name }}') as params,
        'unique' AS test,
        m.*
    FROM {{ model }} AS m
    LEFT JOIN duplicates AS d
        ON m.{{ column_name }} = d.{{ column_name }}
    WHERE d.{{ column_name }} IS NOT NULL

{% endtest %}