{% macro amount_bucket(amount_column) %}
    case
        when {{ amount_column }} < 10 then 'micro'
        when {{ amount_column }} < 100 then 'small'
        when {{ amount_column }} < 500 then 'medium'
        when {{ amount_column }} < 1000 then 'large'
        else 'xlarge'
    end
{% endmacro %}
