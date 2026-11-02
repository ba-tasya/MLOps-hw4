"""Stubs of dbt_date macros for sqlfluff linting."""


def day_of_week(date, isoweek=True):
    return f"toDayOfWeek({date})"


def day_name(date, short=True, language="default"):
    return f"dateName('weekday', {date})"