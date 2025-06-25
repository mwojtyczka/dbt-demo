-- Overwrite implementation of built-in generic non_null data test
{% test not_null(model, column_name) %}

    SELECT
        '{{ model }}' AS model,
        '{{ column_name }}' AS column,
        CAST(MAP() AS MAP<STRING, STRING>) AS params,
        'not_null' AS test,
        *
    FROM {{ model }}
    WHERE {{ column_name }} IS NULL

{% endtest %}