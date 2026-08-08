# Olist E-Commerce Analytics

End-to-end e-commerce analytics portfolio project using Python, PostgreSQL, SQL, and Power BI to analyze sales, customers, products, sellers, delivery, and customer satisfaction.

## Business Problem

Transform raw Olist marketplace data into reliable business information and use it to answer management questions about revenue, product performance, customer behavior, seller performance, geography, delivery, and reviews.

## Project Workflow

1. Store original Olist CSV files unchanged in `data/raw/`.
2. Profile every source table in `notebooks/01_data_discovery.ipynb`.
3. Explore distributions, relationships, anomalies, and business metrics in `notebooks/02_eda.ipynb`.
4. Clean and validate data reproducibly with scripts in `src/`.
5. Save processed outputs in `data/processed/`.
6. Load validated data into PostgreSQL.
7. Create schema, quality checks, views, and business analysis queries in `sql/`.
8. Build a Power BI semantic model and three-page dashboard.
9. Reconcile core KPIs across Python, SQL, and Power BI.
10. Document findings, recommendations, assumptions, and limitations.

## Repository Structure

```text
olist-ecommerce-analytics/
├── README.md
├── data/
│   ├── raw/
│   ├── processed/
│   └── reference/
├── notebooks/
│   ├── 01_data_discovery.ipynb
│   ├── 02_eda.ipynb
│   └── 03_validation.ipynb
├── src/
│   ├── load_data.py
│   ├── clean_data.py
│   └── validate_data.py
├── sql/
│   ├── 01_schema.sql
│   ├── 02_quality_checks.sql
│   ├── 03_views.sql
│   └── 04_business_analysis.sql
├── powerbi/
│   └── olist_analytics.pbix
├── screenshots/
├── docs/
└── requirements.txt
```

## Core Business Questions

- How is revenue changing over time?
- Which product categories and products drive revenue and order volume?
- Which customers or segments show repeat purchasing or high value?
- Which sellers contribute most to performance?
- How does delivery performance relate to review score?
- Which states or cities show strong performance or opportunity?

## Data

Dataset: Brazilian E-Commerce Public Dataset by Olist.

Place the original CSV files in `data/raw/`. Do not modify raw files directly. Put cleaned exports in `data/processed/` and reference tables or dictionaries in `data/reference/`.

## Validation

The final project should reconcile core metrics across three layers:

- Python processed data
- PostgreSQL SQL totals
- Power BI DAX measures

## Power BI Deliverable

The report should contain three focused pages:

- Executive Overview
- Product & Seller Performance
- Customer, Delivery & Satisfaction

