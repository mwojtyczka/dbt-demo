-- Overwrite implementation of built-in generic relationship data test
{% test relationships(model, column_name, to, field) %}

    SELECT
        '{{ model }}' AS model,
        '{{ column_name }}' AS column,
        MAP(
            'to', '{{ to }}',
            'field', '{{ field }}'
        ) AS params,
        'relationship' AS test,
        m.*
    FROM {{ model }} AS m
    LEFT JOIN {{ to }} AS r
        ON m.{{ column_name }} = r.{{ field }}
    WHERE r.{{ field }} IS NULL

{% endtest %}