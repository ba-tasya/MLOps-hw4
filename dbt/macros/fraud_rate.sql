{% macro fraud_rate(fraud_count, tx_count) %}
    round(100 * {{ fraud_count }} / {{ tx_count }}, 2)
{% endmacro %}
