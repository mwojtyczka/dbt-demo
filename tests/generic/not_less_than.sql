-- Generic data quality test
{% test not_less_than(model, column_name, min_value) %}

    SELECT
        '{{ model }}' as model,
        '{{ column_name }}' as column,
        'not_less_than' as test,
        MAP('min_value', '{{ min_value }}') as params,
        *
    FROM {{ model }}
    WHERE {{ column_name }} < {{ min_value }}

{% endtest %}