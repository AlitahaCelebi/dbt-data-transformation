# dbt Data Transformation Project

![dbt](https://img.shields.io/badge/dbt-1.6+-orange.svg)
![SQL](https://img.shields.io/badge/SQL-Advanced-blue.svg)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-blue.svg)
![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

Modern data transformation pipeline using dbt (data build tool) for analytics engineering and enterprise data warehouse modeling.

## 🎯 Overview

This project demonstrates modern analytics engineering practices using dbt. It showcases the transformation layer of a modern data stack, turning raw data into analytics-ready models using SQL and best practices from software engineering.

**Key Highlights:**
- 📊 Dimensional modeling (Facts & Dimensions)
- 🔄 Layered transformation approach (Staging → Marts)
- ✅ Data quality testing built-in
- 📝 Auto-generated documentation
- 🔗 Data lineage tracking
- ♻️ Modular and reusable SQL

## 🏗️ Architecture

```
┌──────────────┐         ┌───────────────┐         ┌──────────────┐         ┌────────────┐
│  Raw Data    │────────▶│   Staging     │────────▶│ Intermediate │────────▶│   Marts    │
│  (Sources)   │         │   (Clean)     │         │  (Transform) │         │ (Analytics)│
└──────────────┘         └───────────────┘         └──────────────┘         └────────────┘
                                                                                    │
                                                                                    ▼
                                                                            ┌────────────────┐
                                                                            │  BI Tools      │
                                                                            │  (Reporting)   │
                                                                            └────────────────┘
```

## 🚀 Features

### Core Capabilities
- **SQL-based Transformations**: Pure SQL with Jinja templating
- **Modular Models**: Staging → Intermediate → Marts layers
- **Data Testing**: Built-in schema, uniqueness, and relationship tests
- **Documentation**: Auto-generated data catalog with lineage
- **Version Control**: All transformations in Git
- **Incremental Models**: Efficient processing of large datasets
- **Macros**: Reusable SQL functions
- **Seeds**: Reference data management

### Model Layers
1. **Staging**: Clean raw data, standardize naming
2. **Intermediate**: Business logic, joins, aggregations
3. **Marts**: Analytics-ready dimensional models

## 🛠️ Technologies

| Category | Technology |
|----------|-----------|
| Transformation | dbt Core 1.6+ |
| Query Language | SQL |
| Database | PostgreSQL / Snowflake / BigQuery |
| Language | Python 3.9+ |
| Version Control | Git |

## 📁 Project Structure

```
dbt-data-transformation/
├── models/
│   ├── staging/                    # Layer 1: Source data cleaning
│   │   ├── stg_customers.sql       # Customer staging model
│   │   ├── stg_orders.sql          # Orders staging model
│   │   └── sources.yml             # Source definitions
│   ├── intermediate/               # Layer 2: Business logic
│   │   └── int_order_items.sql     # Order items enrichment
│   └── marts/                      # Layer 3: Analytics models
│       ├── fct_orders.sql          # Orders fact table
│       ├── dim_customers.sql       # Customers dimension
│       └── schema.yml              # Tests & documentation
├── tests/                          # Custom data tests
│   └── assert_positive_revenue.sql
├── macros/                         # Reusable SQL functions
│   └── cents_to_dollars.sql
├── seeds/                          # CSV reference data
│   └── country_codes.csv
├── snapshots/                      # SCD Type 2 tracking
│   └── customers_snapshot.sql
├── dbt_project.yml                # Project configuration
├── profiles.yml                   # Connection profiles
├── packages.yml                   # dbt packages
└── README.md
```

## 🏃 Quick Start

### Prerequisites
- Python 3.9+
- PostgreSQL / Snowflake / BigQuery database
- dbt installed

### 1. Install dbt
```bash
pip install dbt-core dbt-postgres
# Or for Snowflake: pip install dbt-core dbt-snowflake
# Or for BigQuery: pip install dbt-core dbt-bigquery
```

### 2. Clone Repository
```bash
git clone https://github.com/AlitahaCelebi/dbt-data-transformation.git
cd dbt-data-transformation
```

### 3. Configure Connection
Create `profiles.yml` in `~/.dbt/`:
```yaml
data_warehouse:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: your_user
      password: your_password
      port: 5432
      dbname: analytics
      schema: dbt_dev
      threads: 4
```

### 4. Run dbt Models
```bash
# Run all models
dbt run

# Run specific model
dbt run --select stg_customers

# Run models in specific folder
dbt run --select staging

# Run models and dependencies
dbt run --select +fct_orders
```

### 5. Test Data Quality
```bash
# Run all tests
dbt test

# Test specific model
dbt test --select stg_customers
```

### 6. Generate Documentation
```bash
# Generate docs
dbt docs generate

# Serve docs locally
dbt docs serve
```

Access documentation at: `http://localhost:8080`

## 📊 Models Overview

### Staging Layer (`models/staging/`)

#### `stg_customers.sql`
**Purpose**: Clean and standardize raw customer data

**Transformations:**
- Trim and lowercase names
- Standardize email format
- Remove null IDs
- Rename columns to standard convention

**Tests:**
- ✅ customer_id is unique
- ✅ customer_id is not null
- ✅ email is not null

#### `stg_orders.sql`
**Purpose**: Clean and standardize raw order data

**Transformations:**
- Parse date fields
- Standardize status values
- Remove test orders
- Calculate order totals

### Marts Layer (`models/marts/`)

#### `fct_orders.sql` (Fact Table)
**Purpose**: Analytics-ready order transactions

**Columns:**
- order_id (PK)
- customer_id (FK)
- order_date
- order_amount
- total_revenue (calculated)
- customer details (denormalized)

**Tests:**
- ✅ order_id is unique
- ✅ Relationships to dim_customers
- ✅ total_revenue is not null
- ✅ Custom: revenue > 0

#### `dim_customers.sql` (Dimension Table)
**Purpose**: Customer master data

**Features:**
- Customer demographics
- Lifetime value calculations
- Customer segmentation
- SCD Type 1 (slowly changing)

## 💡 Use Cases

This dbt project architecture is suitable for:

1. **Data Warehousing**: Building analytics-ready dimensional models
2. **BI & Reporting**: Feeding Tableau, PowerBI, Looker
3. **Data Quality**: Automated testing and validation
4. **Analytics Engineering**: Modern data transformation workflows
5. **ELT Pipelines**: Transform layer in ELT architectures

## 📈 dbt Commands Reference

### Build & Run
```bash
dbt run                          # Run all models
dbt run --select model_name      # Run specific model
dbt run --select staging.*       # Run folder
dbt run --full-refresh           # Rebuild incremental models
dbt build                        # Run + Test in DAG order
```

### Testing
```bash
dbt test                         # Run all tests
dbt test --select model_name     # Test specific model
dbt test --select test_type:unique  # Run specific test type
```

### Documentation
```bash
dbt docs generate                # Generate documentation
dbt docs serve                   # Serve docs locally
```

### Compilation & Debugging
```bash
dbt compile                      # Compile SQL
dbt compile --select model_name  # Compile specific model
dbt show --select model_name     # Preview model results
```

## 🧪 Data Testing

### Built-in Tests
```yaml
# In schema.yml
models:
  - name: stg_customers
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
      - name: email
        tests:
          - not_null
```

### Custom Tests
```sql
-- tests/assert_positive_revenue.sql
SELECT *
FROM {{ ref('fct_orders') }}
WHERE total_revenue <= 0
```

### Relationship Tests
```yaml
- name: fct_orders
  columns:
    - name: customer_id
      tests:
        - relationships:
            to: ref('dim_customers')
            field: customer_id
```

## 📚 Best Practices Implemented

- ✅ **Layered Architecture**: Staging → Intermediate → Marts
- ✅ **Naming Conventions**: stg_, int_, fct_, dim_ prefixes
- ✅ **One Model Per File**: Modular and maintainable
- ✅ **Comprehensive Testing**: Schema and data tests
- ✅ **Documentation**: YAML descriptions for all models
- ✅ **DRY Principle**: Macros for reusable logic
- ✅ **Version Control**: All code in Git
- ✅ **Incremental Models**: For large fact tables

## 🔧 Configuration

### `dbt_project.yml`
```yaml
name: 'data_warehouse'
version: '1.0.0'
config-version: 2

models:
  data_warehouse:
    staging:
      +materialized: view
      +schema: staging
    intermediate:
      +materialized: view
      +schema: intermediate
    marts:
      +materialized: table
      +schema: marts
```

### Materialization Strategies
- **View**: Fast development, query-time computation
- **Table**: Pre-computed, faster queries
- **Incremental**: Efficient for large datasets
- **Ephemeral**: CTE-only, no persistence

## 🎯 Data Modeling Approach

### Dimensional Modeling
- **Fact Tables**: Measures/metrics (fct_orders, fct_sales)
- **Dimension Tables**: Descriptive attributes (dim_customers, dim_products)
- **Star Schema**: Optimized for analytics queries

### Kimball Methodology
- Conformed dimensions
- Slowly changing dimensions (SCD)
- Grain definition
- Additivity of facts

## 📝 License

MIT License - Free to use for learning and portfolio purposes

## 👨‍💻 Author

**Alitaha Celebi**
- Analytics Engineer / Data Engineer
- Specializing in dbt, Data Modeling, and Modern Data Stack

---

*Built with dbt for reliable, testable data transformations*
