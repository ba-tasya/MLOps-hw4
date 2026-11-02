all: deps seed run test

deps:
	dbt deps

seed:
	dbt seed

run:
	dbt run

test:
	dbt test

docs:
	dbt docs generate && dbt docs serve

lint:
	sqlfluff lint models tests macros

.PHONY: all deps seed run test docs lint