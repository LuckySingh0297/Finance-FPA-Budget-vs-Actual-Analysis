# Finance, FP&A & Budget vs Actual Analysis

## 1. Project Overview

This project focuses on Financial Planning and Analysis (FP&A), examining budgeted versus actual expenditure for a fictional retail company, **Northstar Retail Ltd.**, over a three-year period (2021–2023).

The objective was to identify budget deviations, understand spending patterns across departments, expense categories and regions, and provide actionable insights to support financial planning, cost control and management decision-making.

This end-to-end project demonstrates the use of **Microsoft Excel, MySQL and Power BI** to transform raw financial data into meaningful business insights through data cleaning, SQL analysis, financial KPI calculations, dashboard development and data validation.

## 2. Business Problem

Northstar Retail Ltd. needs better visibility into its financial spending performance.

Management wants to understand:

- How does actual spending compare with the approved budget?
- Which departments and expense categories exceed their budgets?
- Which regions have the highest budget deviations?
- How does spending change over time?
- What percentage of transactions exceed their allocated budgets?
- Where should management focus its cost-control efforts?

The project addresses these questions through financial analysis, SQL queries, Excel reporting and an interactive Power BI dashboard.

## 3. Project Objectives

1. Clean and prepare financial transaction data.
2. Calculate budget variance and budget utilization.
3. Analyze spending across departments, categories and regions.
4. Identify monthly, quarterly and yearly spending trends.
5. Measure over-budget and under-budget transactions.
6. Validate financial calculations and reconcile results.
7. Build interactive Excel and Power BI dashboards.
8. Provide business recommendations based on analytical findings.

## 4. Dataset Information

**Dataset Name:** Budget vs Actual Financial Dataset  
**Dataset Author:** Kennath Alexander Roy  
**Source:** Kaggle

### Dataset Link

https://www.kaggle.com/datasets/kennathalexanderroy/budget-vs-actual-financial-dataset

| Attribute | Details |
|---|---|
| Company | Northstar Retail Ltd. (Fictional) |
| Dataset | Budget vs Actual Financial Dataset |
| Original Records | 10,010 |
| Final Records | 10,000 |
| Original Columns | 8 |
| Final Columns | 10 |
| Period | January 2021 – December 2023 |
| Data Granularity | Financial transactions |

### Dataset Columns

**Original Columns**
- Date
- Department
- Category
- Region
- Budget Amount
- Actual Amount
- Payment Method
- Transaction ID

**Additional Calculated Columns**
- Budget Variance
- Budget Status

## 5. Tools & Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Data cleaning, PivotTables, financial reporting and dashboard creation |
| Power Query | Data transformation and preparation |
| MySQL Workbench | SQL querying, financial analysis and validation |
| Power BI | Data modelling, DAX measures and interactive dashboard development |
| DAX | Financial KPIs and year-over-year calculations |

## 6. Data Cleaning & Preparation

The original dataset contained 10,010 records and 8 columns.

The following data preparation steps were performed:

- Identified and removed 10 complete duplicate records.
- Retained 10,000 records in the cleaned dataset.
- Handled missing categorical values using the label `Unknown`.
- Handled missing transaction identifiers using `Unknown`.
- Created a calculated column called `Budget Variance`.
- Created a classification column called `Budget Status`.
- Verified column data types.
- Checked for missing values and data inconsistencies.
- Validated financial amounts and date coverage.

### Calculated Fields

**Budget Variance**

Actual Amount − Budget Amount

**Budget Status**

- Over Budget: Actual Amount is greater than Budget Amount.
- Under Budget: Actual Amount is less than Budget Amount.

## 7. SQL Analysis

MySQL Workbench was used to perform **40 financial analysis queries**.

The analysis covered:

- Overall budget and actual spending performance.
- Department-wise financial analysis.
- Expense category analysis.
- Regional spending analysis.
- Monthly, quarterly and yearly financial trends.
- Budget utilization analysis.
- Over-budget and under-budget transaction analysis.
- Top overspending and underspending transactions.
- Year-over-year spending growth.
- Year-over-year budget variance changes.
- Financial data validation and reconciliation.

### SQL Concepts Demonstrated

- SELECT, WHERE and ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- CASE statements
- JOINs
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- Date functions
- Financial calculations
- Data validation queries

## 8. Key Financial KPIs

| KPI | Result |
|---|---:|
| Total Transactions | 10,000 |
| Total Budget | ₹795,469,256 |
| Actual Spending | ₹890,267,029 |
| Net Budget Variance | ₹94,797,773 |
| Budget Utilization | 111.92% |
| Over-Budget Transactions | 5,590 |
| Under-Budget Transactions | 4,410 |
| Over-Budget Transaction % | 55.90% |

**Key Observation:** Actual spending exceeded the approved budget by ₹94,797,773, resulting in overall budget utilization of 111.92%.

## 9. Key Business Findings

### 9.1 Department Analysis

- Marketing recorded the highest budget variance percentage at 15.06%.
- HR recorded the highest actual spending at ₹155,439,763.
- Finance had the lowest budget variance percentage among the identified departments at 8.38%.

### 9.2 Expense Category Analysis

- Salaries recorded the highest budget variance percentage at 16.21%.
- Utilities had the highest actual spending at ₹155,260,320.
- Training recorded the lowest budget variance percentage among the identified categories at 9.53%.

### 9.3 Regional Analysis

- East recorded the highest budget variance percentage at 13.40%.
- Central recorded the highest actual spending at ₹182,078,152.
- North recorded the lowest budget variance percentage at 10.47%.

### 9.4 Monthly and Yearly Trends

- All 36 months recorded actual spending above budget.
- April 2021 recorded the highest monthly budget variance percentage at 23.61%.
- June 2021 recorded the lowest monthly budget variance percentage at 0.59%.
- December 2022 recorded the highest absolute monthly variance at ₹5,240,553.
- April 2023 recorded the highest monthly actual spending at ₹29,230,433.

### 9.5 Year-over-Year Performance

| Year | Actual Spending Growth |
|---|---:|
| 2022 | +5.34% |
| 2023 | -0.98% |

The annual budget variance percentage improved from 13.67% in 2022 to 10.11% in 2023, indicating an improvement in budget performance.

## 10. Excel Dashboard

An Excel financial dashboard was developed using PivotTables, PivotCharts and financial KPI calculations.

### Dashboard Components

- Executive Summary
- Department Analysis
- Category Analysis
- Regional Analysis
- Monthly Financial Trends
- Business Insights and Management Recommendations

The Excel dashboard provides a consolidated view of budget performance and helps identify spending deviations across different business segments.

## 11. Power BI Dashboard

An interactive Power BI dashboard was developed to provide a consolidated view of financial performance.

### Financial KPI Cards

- Total Budget
- Actual Spending
- Budget Variance
- Budget Utilization

### Financial Analysis Visuals

- Department-wise Budget vs Actual Spending
- Category-wise Budget vs Actual Spending
- Regional Budget vs Actual Spending
- Monthly Budget vs Actual Spending
- Budget Compliance Transaction Split

### Interactive Slicers

- Year
- Department
- Category
- Region

### Power BI Technical Implementation

- Created DAX measures for financial KPIs.
- Created a separate Date Table.
- Established a relationship between the Date Table and financial transaction table.
- Developed previous-year spending and year-over-year spending growth measures.
- Added interactive slicers to filter dashboard visuals.
- Validated KPI results against SQL analysis.

## 12. Data Validation & Quality Checks

Several SQL validation checks were performed to ensure the reliability of the analysis.

- Confirmed the final record count of 10,000.
- Reconciled total budget, actual spending and budget variance.
- Verified transaction-level budget variance calculations.
- Checked budget status classification for all transactions.
- Checked for missing values across all 10 columns.
- Investigated repeated `Unknown` transaction identifiers and confirmed that the corresponding records represented separate transactions.
- Checked for zero or negative budget and actual amounts.
- Verified monthly and yearly date coverage.
- Compared financial KPI results between SQL, Excel and Power BI.

The overall financial KPI results were successfully reconciled across the three tools.

## 13. Business Recommendations

Based on the findings, the following recommendations can support management decision-making:

1. **Strengthen Budget Monitoring:** Introduce regular budget-versus-actual reviews to identify overspending early.
2. **Review Department Spending:** Investigate Marketing's higher budget variance percentage and identify the reasons behind deviations.
3. **Monitor Expense Categories:** Review salary and utility expenditure to understand the drivers of higher spending.
4. **Improve Regional Cost Control:** Examine the East region's budget deviations and identify opportunities for better expense management.
5. **Introduce Monthly Variance Reporting:** Monitor monthly spending patterns and investigate significant deviations.
6. **Improve Financial Planning:** Use historical spending patterns and year-over-year trends to support future budget preparation.

## 14. Project Deliverables

- Cleaned financial dataset.
- Excel financial analysis workbook and dashboard.
- MySQL SQL analysis script containing 40 queries.
- Power BI interactive dashboard.
- Project documentation and business recommendations.

## 15. Conclusion

This project demonstrates how financial data can be transformed into meaningful business insights through data cleaning, SQL analysis, financial KPI calculations, dashboard development and data validation.

The analysis identified an overall budget overrun of ₹94,797,773, highlighted departments, categories and regions with higher budget deviations, and revealed improvements in annual budget variance performance.

The final Excel and Power BI dashboards provide management with a consolidated view of financial performance and support more informed budgeting, spending monitoring and cost-control decisions.

## 16. Skills Demonstrated

- Financial Data Analysis
- Financial Planning & Analysis (FP&A)
- Budget vs Actual Analysis
- Budget Variance Analysis
- Data Cleaning and Transformation
- Advanced SQL
- MySQL Workbench
- Microsoft Excel
- Power Query
- Power BI
- DAX Measures
- Data Modelling
- KPI Development
- Dashboard Development
- Business Insights and Recommendations

---

**Project Category:** Finance Analytics | FP&A | Business Intelligence | Data Analytics

**Tools:** Excel | Power Query | MySQL | Power BI | DAX

**Dataset Period:** 2021–2023

**Dataset Source:** [Kaggle – Budget vs Actual Financial Dataset](https://www.kaggle.com/datasets/kennathalexanderroy/budget-vs-actual-financial-dataset)

**Disclaimer:** Northstar Retail Ltd. is a fictional company used for educational and portfolio purposes. The analysis is based on the provided dataset and does not represent the financial performance of a real company.
