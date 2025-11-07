# dbt Data Transformation Project

Modern data transformation pipeline using dbt (data build tool) for analytics engineering and data warehouse modeling.

## Features

- SQL-based transformations with dbt
- Modular data models (staging, intermediate, mart)
- Data testing and validation
- Documentation generation
- Version control for transformations
- Incremental models
- Macros and packages
- Lineage tracking

## Technologies

- dbt Core 1.6+
- PostgreSQL / Snowflake / BigQuery
- Python 3.9+
- SQL

## Project Structure

```
dbt-data-transformation/
├── models/
│   ├── staging/              # Staging models
│   │   ├── stg_customers.sql
│   │   └── stg_orders.sql
│   ├── intermediate/         # Intermediate transformations
│   │   └── int_order_items.sql
│   └── marts/               # Business-ready models
│       ├── fct_orders.sql   # Fact tables
│       └── dim_customers.sql # Dimension tables
├── tests/                   # Custom data tests
├── macros/                  # Reusable SQL macros
├── seeds/                   # CSV reference data
├── snapshots/               # SCD Type 2
├── dbt_project.yml         # dbt configuration
├── profiles.yml            # Connection profiles
└── README.md
```

## Quick Start

1. Install dbt:
```bash
pip install dbt-core dbt-postgres
```

2. Configure connection in profiles.yml

3. Run dbt models:
```bash
dbt run
```

4. Test data quality:
```bash
dbt test
```

5. Generate documentation:
```bash
dbt docs generate
dbt docs serve
```

## Model Organization

- **Staging**: Raw data cleaned and renamed
- **Intermediate**: Business logic transformations
- **Marts**: Analytics-ready dimensional models

## Best Practices

- One model per file
- Modular and reusable code
- Comprehensive testing
- Clear naming conventions
- Documentation in YAML

## Author

Alitaha Celebi - Analytics Engineer / Data Engineer
