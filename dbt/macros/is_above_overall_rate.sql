{% macro is_above_overall_rate(rate_column, fraud_count_column, tx_count_column, multiplier=2) %}
{{ rate_column }} > {{ multiplier }} * 100 * sum({{ fraud_count_column }}) over () / sum({{ tx_count_column }}) over ()
{% endmacro %}
