-- Now our 2nd step is too use SQL for the project Finance, FP&A & Management Analytics


-- create a database first
CREATE DATABASE project_4_fpa;

-- check the data is fully and correctly uploaded or not 
select * from financial_data;

-- let's verify the actual record count

USE project_4_fpa;

SELECT COUNT(*) AS total_records
FROM financial_data;


-- Check table structure
DESCRIBE financial_data;

-- we see the data and we come to know that we have 2 proplems 
-- Problem 1 — Date column name , date column has ï»¿Date instead of Date. so we have to chnage that first
-- problem 2 is Date data type it shows text instead of date 

-- 
SELECT `ï»¿Date`
FROM financial_data
LIMIT 10;

ALTER TABLE financial_data
CHANGE COLUMN `ï»¿Date` Date_Text TEXT;

ALTER TABLE financial_data
ADD COLUMN `Date` DATE;

UPDATE financial_data
SET `Date` = STR_TO_DATE(Date_Text, '%d-%m-%Y');

SELECT Date_Text, `Date`
FROM financial_data
LIMIT 10;

ALTER TABLE financial_data
DROP COLUMN Date_Text;


DESCRIBE financial_data;


-- SQL Analysis 1 — Overall Financial Performance
SELECT
    COUNT(*) AS total_transactions,

    SUM(`Budget Amount`) AS total_budget,

    SUM(`Actual Amount`) AS total_actual_spending,

    SUM(`Budget Variance`) AS total_budget_variance,

    ROUND(
        SUM(`Actual Amount`) / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage

FROM financial_data;


-- after anaysis ths we come to know that 
-- Overall budget performance is 111.92% while on the other hand 
-- Total budget is 795,469,256 , Actual spending is 890,267,029 and Overspending is 94,797,773

-- on the point of business presective :
-- The company spent approximately 11.92% more than its allocated budget. which meansFor every 100 units of budget, it spent approximately 
-- 111.92 units.



-- SQL Analysis 2 — Over Budget vs Under Budget
SELECT
    `Budget Status`,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance

FROM financial_data

GROUP BY `Budget Status`;

-- after executing this query we gwt to know that 
-- Finding 1 — Over-budget transactions 5,590 transactions (55.9%) exceeded their allocated budgets.
-- Finding 2 — Under-budget transactions 4,410 transactions (44.1%) spent less than their allocated budgets.
-- Finding 3 — Financial impact Over-budget transactions generated 302,351,747 in overspending, while under-budget 
-- transactions were 207,553,974 below budget.
-- The net overspending is: 302,351,747 − 207,553,974 = 94,797,773

-- The company has a significant budget-control problem. Although 44.1% of transactions stayed within budget, overspending transactions 
-- created a larger financial impact than the savings from under-budget transactions.

-- Management should investigate which departments and expense categories are driving the overspending.





-- SQL Analysis 3 — Department-wise Financial Performance

SELECT
    Department,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage

FROM financial_data

GROUP BY Department

ORDER BY total_variance DESC;

-- what we got after the query Marketing: Highest overspending, both in absolute amount and percentage.
-- HR: Second-highest overspending, at 13.15%.
-- Finance: Lowest overspending among the six identified departments, at 8.38%.
-- Unknown: One transaction is 1,136 below budget. Its department remains unidentified.


--            Business interpretation
-- Marketing deserves the first investigation because its spending exceeds its budget by 15.06%.
-- HR and Sales also need attention. Finance has the smallest budget variance percentage among the six named departments, 
--         but it is still overspending.
-- One important distinction: the department with the highest actual spending is HR, not Marketing. The department with the highest budget 
--          overrun is Marketing.






-- SQL Analysis 4 — Category-wise Financial Performance

SELECT
    Category,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage

FROM financial_data

GROUP BY Category

ORDER BY total_variance DESC;

-- Key findings:
-- 1. Salaries has the highest budget overrun: 20.61 million, or 16.21% above budget. This is the largest variance in both absolute and percentage terms.
-- 2. Utilities has the highest actual spending: 155.26 million. However, it does not have the highest budget overrun.
-- 3. Marketing is also above budget: 16.30 million, or 12.52%.
-- 4. Training has the lowest overspending among the six known categories: 12.61 million, or 9.53%.
-- 5. Unknown: One record is under budget by 25,060. It is a data-quality category, not a genuine business expense category.


-- Business insight: All six identified expense categories exceeded their allocated budgets. Salaries recorded the highest overspending 
-- at 16.21%, while Training had the lowest at 9.53%. Utilities had the highest actual spending, indicating that management should review 
-- both spending volume and budget control separately.




-- SQL Analysis 5 — Regional Financial Performance

SELECT
    Region,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY Region
ORDER BY total_variance DESC;


-- Key business insights
-- 1. East has the highest budget overrun among identified regions: 21.39 million, or 13.40%.
-- 2. Central has the highest actual spending: 182.08 million. But East has the highest budget variance.
-- 3. North performs best in budget control: its overspending is 10.47%, the lowest among the five identified regions.
-- 4. All five identified regions exceed their budgets. This suggests the overspending is not limited to one geographic area.
-- 5. Unknown region: Three records have missing region information. Their combined variance is 183,025, so they should be investigated 
-- separately rather than treated as a real region.




-- SQL Analysis 6 — Payment Method Analysis

SELECT
    `Payment Method`,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY `Payment Method`
ORDER BY total_actual DESC;

-- business insights
-- 1. UPI has the highest actual spending: 228.70 million.
-- 2. Bank Transfer has the highest budget overrun: 25.01 million.
-- 3. Bank Transfer also has the highest variance percentage: 12.74%.
-- 4. Cash has the lowest budget variance percentage: 10.89%.
-- 5. All four payment methods have spending above their allocated budgets.

-- what this tell us about business is that UPI accounted for the highest actual spending among payment methods, while Bank Transfer recorded 
-- the highest budget overrun at 25.01 million (12.74%). Cash showed the lowest budget variance percentage at 10.89%. Management should 
-- investigate the reasons for higher spending associated with Bank Transfers and review payment-related expense controls.



-- SQL Analysis 7 — Monthly Financial Trends


SELECT
    YEAR(`Date`) AS financial_year,
    MONTH(`Date`) AS month_number,
    MONTHNAME(`Date`) AS month_name,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY
    YEAR(`Date`),
    MONTH(`Date`),
    MONTHNAME(`Date`)
ORDER BY
    financial_year,
    month_number;



--      Insight 1 — Overspending happened in every month.
-- All 36 months show positive budget variance. This means actual spending exceeded budget in every month of the three-year period.

--      Insight 2 — April 2021 was particularly concerning.
-- Actual spending exceeded the budget by 23.61%. March 2021 was also high at 23.03%.

--      Insight 3 — December 2022 had the largest financial overrun.
-- The business exceeded its monthly budget by 5.24 million. This is the highest absolute variance in your monthly results.

--      Insight 4 — April 2023 had the highest spending.
-- Actual spending was 29.23 million. However, its variance percentage was 12.09%, showing why high spending does not necessarily mean the worst budget performance.

--      Insight 5 — January 2023 had relatively strong budget control.
-- Its variance was only 2.37%, considerably lower than most other months.

-- Management should investigate:
--  Why spending was unusually high in March and April 2021.
--  What caused the December 2022 budget overrun.
--  Whether the January 2023 budget performance can be replicated.
--  Why overspending continued across every month.



-- SQL Analysis 8 — Year-wise Financial Performance

SELECT
    YEAR(`Date`) AS financial_year,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY YEAR(`Date`)
ORDER BY financial_year;

--       Insight 1 — 2022 was the weakest year for budget control.
-- Highest annual overspending: 36.43 million.
-- Highest annual variance percentage: 13.67%.
-- Actual spending was higher than budget by 13.67%.

--       Insight 2 — 2023 showed improvement.
-- Budget variance decreased from 36.43 million to 27.53 million.
-- Variance percentage improved from 13.67% to 10.11%.
-- This is a reduction of 3.56 percentage points.

--      Insight 3 — Actual spending was highest in 2022.
-- Actual spending increased from 287.51 million in 2021 to 302.87 million in 2022, then decreased slightly to 299.89 million in 2023.

--      Insight 4 — Budget control improved, but overspending continued.
-- 2023 performed better than the previous two years, but actual spending still exceeded the approved budget.


-- Annual financial analysis showed that 2022 had the highest budget overrun, with actual spending exceeding the budget by 36.43 million 
-- (13.67%). In 2023, the variance percentage improved to 10.11%, representing a 3.56 percentage-point improvement. Although actual spending 
-- remained above budget, the reduction in variance suggests improved budget control during 2023.



-- Analysis 9 — Department-wise Annual Trends


SELECT
    YEAR(`Date`) AS financial_year,
    Department,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY
    YEAR(`Date`),
    Department
ORDER BY
    financial_year,
    total_variance DESC;

-- insight

-- Department-wise annual analysis identified changing patterns in budget overruns. Operations recorded the highest variance in 2021, 
-- while HR had the highest overrun in 2022 and 2023. Finance demonstrated substantial improvement, reducing its variance percentage from 
-- 12.57% in 2021 to 3.98% in 2023. Marketing remained consistently above budget throughout the three-year period.



-- SQL Analysis 10 — Category-wise Annual Trends
SELECT
    YEAR(`Date`) AS financial_year,
    Category,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY
    YEAR(`Date`),
    Category
ORDER BY
    financial_year,
    total_variance DESC;

-- insight


-- Category-wise annual analysis revealed that Salaries recorded the highest variance percentage in 2021 and 2023, reaching 19.90% and 19.37%, 
-- respectively. Utilities recorded the highest variance in 2022 at 17.72%. Marketing, Infrastructure and Training showed improved budget 
-- control in 2023. These findings identify recurring expense categories that require closer budget monitoring.


-- SQL Analysis 11 — Regional Annual Trends

SELECT
    YEAR(`Date`) AS financial_year,
    Region,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY
    YEAR(`Date`),
    Region
ORDER BY
    financial_year,
    total_variance DESC;

-- insight

-- Regional annual analysis showed that East recorded the highest variance percentage in 2021 and 2023, while South recorded the highest in 
-- 2022. North demonstrated the strongest improvement in 2023, reducing its variance percentage to 7.37%. Overall, regional budget performance 
-- improved in 2023, although all five identified regions continued to exceed their budgets.


-- SQL Analysis 12 — Quarterly Financial Performance
SELECT
    YEAR(`Date`) AS financial_year,
    QUARTER(`Date`) AS financial_quarter,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,
    ROUND(
        SUM(`Budget Variance`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS variance_percentage
FROM financial_data
GROUP BY
    YEAR(`Date`),
    QUARTER(`Date`)
ORDER BY
    financial_year,
    financial_quarter;
    
-- insight

-- Quarterly analysis showed that Q1 2021 recorded the highest budget variance percentage at 17.42%. In 2022, overspending remained 
-- consistently high across all four quarters. In 2023, budget control improved significantly during Q1 and Q2 but deteriorated in Q3 and Q4. 
-- Q3 showed a recurring increase in variance percentage across all three years, indicating an area for further investigation.


-- SQL Analysis 13 — Monthly Year-over-Year Comparison

SELECT
    MONTH(`Date`) AS month_number,
    MONTHNAME(`Date`) AS month_name,
    SUM(CASE WHEN YEAR(`Date`) = 2021
        THEN `Budget Amount` ELSE 0 END) AS budget_2021,
    SUM(CASE WHEN YEAR(`Date`) = 2021
        THEN `Actual Amount` ELSE 0 END) AS actual_2021,
    SUM(CASE WHEN YEAR(`Date`) = 2022
        THEN `Budget Amount` ELSE 0 END) AS budget_2022,
    SUM(CASE WHEN YEAR(`Date`) = 2022
        THEN `Actual Amount` ELSE 0 END) AS actual_2022,
    SUM(CASE WHEN YEAR(`Date`) = 2023
        THEN `Budget Amount` ELSE 0 END) AS budget_2023,
    SUM(CASE WHEN YEAR(`Date`) = 2023
        THEN `Actual Amount` ELSE 0 END) AS actual_2023
FROM financial_data
GROUP BY
    MONTH(`Date`),
    MONTHNAME(`Date`)
ORDER BY month_number;

-- insight

-- Monthly year-over-year analysis revealed changing spending patterns across the three financial years. April 2023 recorded the highest actual
-- monthly spending at 29.23 million, while December 2022 recorded the highest monthly budget overrun at 5.24 million. All 36 month-year 
-- combinations showed actual spending above budget, indicating persistent budget overruns throughout the analysis period.




-- SQL Analysis 14 — Identify the Top 10 Highest Overspending Transactions

SELECT
    `Transaction ID`,
    `Date`,
    Department,
    Category,
    Region,
    `Budget Amount`,
    `Actual Amount`,
    `Budget Variance`,
    `Budget Status`
FROM financial_data
WHERE `Budget Variance` > 0
ORDER BY `Budget Variance` DESC
LIMIT 10;


-- Operations and Travel appears most frequently while The largest overrun is substantial.
-- A large variance could have several explanations, such as an incorrect budget allocation, 
-- an unusual expense, or an unplanned purchase. We need supporting records to establish the cause.



-- SQL Analysis 15 — Top 10 Transactions by Underspending
SELECT
    `Transaction ID`,
    `Date`,
    Department,
    Category,
    Region,
    `Budget Amount`,
    `Actual Amount`,
    `Budget Variance`,
    `Budget Status`
FROM financial_data
WHERE `Budget Variance` < 0
ORDER BY `Budget Variance` ASC
LIMIT 10;

-- The top ten underspending transactions were identified using SQL sorting on negative budget variances. IT, Finance and Sales appeared 
-- frequently among these transactions. The largest underspending transaction was TXN108906, with an unused budget amount of 138,773. 
-- These exceptions may indicate opportunities to review budget allocation and investigate delayed or unutilized spending.



-- SQL Analysis 16 — Department-wise Overspending vs Underspending
SELECT
    Department,

    COUNT(*) AS total_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0 THEN 1
        ELSE 0
    END) AS over_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` < 0 THEN 1
        ELSE 0
    END) AS under_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0
        THEN `Budget Variance`
        ELSE 0
    END) AS total_overspending,

    SUM(CASE
        WHEN `Budget Variance` < 0
        THEN ABS(`Budget Variance`)
        ELSE 0
    END) AS total_underspending,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Department
ORDER BY net_variance DESC;


-- Department-wise analysis showed that Marketing had the highest net overspending at 19.88 million, while Finance recorded the highest gross underspending at 36.08 million. 
-- HR had the greatest number of over-budget transactions, with 979 records. All identified departments experienced both overspending and underspending, indicating opportunities 
-- for more detailed budget allocation and monitoring.



-- SQL Analysis 17 — Category-wise Overspending vs Underspending
SELECT
    Category,

    COUNT(*) AS total_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0 THEN 1
        ELSE 0
    END) AS over_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` < 0 THEN 1
        ELSE 0
    END) AS under_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0
        THEN `Budget Variance`
        ELSE 0
    END) AS total_overspending,

    SUM(CASE
        WHEN `Budget Variance` < 0
        THEN ABS(`Budget Variance`)
        ELSE 0
    END) AS total_underspending,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Category
ORDER BY net_variance DESC;

-- Category-wise analysis identified Salaries as having the highest net overspending at 20.61 million, while Utilities recorded the highest gross overspending at 52.94 million 
-- and the greatest number of over-budget transactions. Travel had the highest gross underspending at 37.60 million. These findings indicate that management should review both 
-- expense allocation and individual spending patterns.



-- SQL Analysis 18 — Regional Overspending vs Underspending
SELECT
    Region,

    COUNT(*) AS total_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0 THEN 1
        ELSE 0
    END) AS over_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` < 0 THEN 1
        ELSE 0
    END) AS under_budget_transactions,

    SUM(CASE
        WHEN `Budget Variance` > 0
        THEN `Budget Variance`
        ELSE 0
    END) AS total_overspending,

    SUM(CASE
        WHEN `Budget Variance` < 0
        THEN ABS(`Budget Variance`)
        ELSE 0
    END) AS total_underspending,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Region
ORDER BY net_variance DESC;

-- Regional overspending analysis identified East as having the highest net budget overrun at 21.39 million and the highest number of over-budget transactions. 
-- Central recorded the highest gross underspending at 43.12 million. All five identified regions exceeded their allocated budgets, highlighting the need for 
-- stronger regional budget monitoring and allocation reviews.



-- SQL Analysis 19 — Budget Utilization by Department

SELECT
    Department,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,

    ROUND(
        SUM(`Actual Amount`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Department
ORDER BY budget_utilization_percentage DESC;


-- Department-wise budget utilization analysis showed that Marketing had the highest utilization at 115.06%, followed by HR at 113.15%. 
-- Finance had the lowest utilization among identified departments at 108.38%. All six identified departments exceeded 100% utilization, 
-- indicating a consistent pattern of budget overruns.



-- SQL Analysis 20 — Budget Utilization by Category
SELECT
    Category,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,

    ROUND(
        SUM(`Actual Amount`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Category
ORDER BY budget_utilization_percentage DESC;


-- Category-wise budget utilization analysis identified Salaries as having the highest utilization at 116.21%, followed by Utilities 
-- at 112.60% and Marketing at 112.52%. Training had the lowest utilization among identified categories at 109.53%. All six identified 
-- categories exceeded their approved budgets, indicating a need for closer expense monitoring.




-- SQL Analysis 21 — Budget Utilization by Region
SELECT
    Region,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,

    ROUND(
        SUM(`Actual Amount`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY Region
ORDER BY budget_utilization_percentage DESC;



-- Regional budget utilization analysis identified East as having the highest utilization at 113.40%, followed by Central at 111.94%. 
-- North recorded the lowest utilization at 110.47%. All five identified regions exceeded their allocated budgets, highlighting the 
-- need for stronger regional budget monitoring.


-- SQL Analysis 22 — Monthly Budget Utilization Trends

SELECT
    YEAR(`Date`) AS financial_year,
    MONTH(`Date`) AS month_number,
    MONTHNAME(`Date`) AS month_name,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,

    ROUND(
        SUM(`Actual Amount`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage

FROM financial_data
GROUP BY
    YEAR(`Date`),
    MONTH(`Date`),
    MONTHNAME(`Date`)
ORDER BY
    financial_year,
    month_number;

-- Monthly budget utilization analysis showed that April 2021 recorded the highest utilization at 123.61%, while June 2021 had the lowest at 100.59%. 
-- All 36 month-year combinations exceeded 100% utilization. Annual utilization improved from 113.67% in 2022 to 110.11% in 2023, indicating better
-- overall budget control in 2023.




-- SQL Analysis 23 — Quarterly Budget Utilization
SELECT
    YEAR(`Date`) AS financial_year,
    QUARTER(`Date`) AS financial_quarter,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,

    ROUND(
        SUM(`Actual Amount`) /
        SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage,

    SUM(`Budget Variance`) AS net_variance

FROM financial_data
GROUP BY
    YEAR(`Date`),
    QUARTER(`Date`)
ORDER BY
    financial_year,
    financial_quarter;

-- Quarterly budget utilization analysis identified Q1 2021 as having the highest utilization at 117.42%, while Q1 2023 had the lowest at 107.63%. 
-- Q2 and Q4 showed improved budget control in 2023 compared with 2022. Q3 utilization increased slightly across all three years, indicating a 
-- recurring pattern that management should investigate.



-- SQL Analysis 24 — Year-over-Year Financial Growth
WITH yearly_financials AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        SUM(`Budget Amount`) AS total_budget,
        SUM(`Actual Amount`) AS total_actual
    FROM financial_data
    GROUP BY YEAR(`Date`)
),

yearly_comparison AS (
    SELECT
        financial_year,
        total_budget,
        total_actual,

        LAG(total_actual) OVER (
            ORDER BY financial_year
        ) AS previous_year_actual

    FROM yearly_financials
)

SELECT
    financial_year,
    total_budget,
    total_actual,
    previous_year_actual,

    ROUND(
        (total_actual - previous_year_actual)
        / previous_year_actual * 100,
        2
    ) AS actual_spending_growth_percentage

FROM yearly_comparison
ORDER BY financial_year;

-- Year-over-year financial analysis showed that actual spending increased by 5.34% in 2022 compared with 2021. In 2023, actual spending decreased by 0.98%, 
-- despite a 2.22% increase in the allocated budget. This indicates improved spending control in 2023, although total spending remained above the approved budget.



-- SQL Analysis 25 — Year-over-Year Budget Variance Growth
WITH yearly_financials AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        SUM(`Budget Amount`) AS total_budget,
        SUM(`Actual Amount`) AS total_actual,
        SUM(`Budget Variance`) AS total_variance
    FROM financial_data
    GROUP BY YEAR(`Date`)
),

yearly_comparison AS (
    SELECT
        financial_year,
        total_budget,
        total_actual,
        total_variance,

        LAG(total_variance) OVER (
            ORDER BY financial_year
        ) AS previous_year_variance

    FROM yearly_financials
)

SELECT
    financial_year,
    total_variance,
    previous_year_variance,

    ROUND(
        (total_variance - previous_year_variance)
        / ABS(previous_year_variance) * 100,
        2
    ) AS variance_growth_percentage

FROM yearly_comparison
ORDER BY financial_year;

-- Year-over-year budget variance analysis showed that the company's net budget overrun increased by 18.18% in 2022. In 2023, 
-- the variance decreased by 24.43%, indicating improved budget control. However, actual spending continued to exceed the approved budget.


-- SQL Analysis 26 — Department-wise Year-over-Year Spending Growth

WITH department_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Department,
        SUM(`Budget Amount`) AS total_budget,
        SUM(`Actual Amount`) AS total_actual,
        SUM(`Budget Variance`) AS total_variance
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Department
),

department_comparison AS (
    SELECT
        financial_year,
        Department,
        total_budget,
        total_actual,
        total_variance,

        LAG(total_actual) OVER (
            PARTITION BY Department
            ORDER BY financial_year
        ) AS previous_year_actual

    FROM department_yearly
)

SELECT
    financial_year,
    Department,
    total_actual,
    previous_year_actual,

    ROUND(
        (total_actual - previous_year_actual)
        / previous_year_actual * 100,
        2
    ) AS spending_growth_percentage

FROM department_comparison
ORDER BY
    financial_year,
    Department;

-- Department-wise year-over-year analysis showed that HR recorded the highest spending growth in 2022 at 11.34%, 
-- while Operations had the highest growth in 2023 at 8.42%. Sales experienced the largest spending reduction in 2023 
-- at 10.33%. Marketing showed consistent spending growth across both years.


-- SQL Analysis 27 — Category-wise Year-over-Year Spending Growth
WITH category_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Category,
        SUM(`Budget Amount`) AS total_budget,
        SUM(`Actual Amount`) AS total_actual,
        SUM(`Budget Variance`) AS total_variance
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Category
),

category_comparison AS (
    SELECT
        financial_year,
        Category,
        total_budget,
        total_actual,
        total_variance,

        LAG(total_actual) OVER (
            PARTITION BY Category
            ORDER BY financial_year
        ) AS previous_year_actual

    FROM category_yearly
)

SELECT
    financial_year,
    Category,
    total_actual,
    previous_year_actual,

    ROUND(
        (total_actual - previous_year_actual)
        / previous_year_actual * 100,
        2
    ) AS spending_growth_percentage

FROM category_comparison
ORDER BY
    financial_year,
    Category;


-- Category-wise year-over-year analysis showed that Infrastructure had the highest spending growth in 2022 at 11.61%, while Utilities 
-- recorded the highest growth in 2023 at 4.98%. Five of the six identified categories reduced their spending in 2023, whereas Utilities continued to increase. 
-- This highlights the need to monitor Utilities spending while reviewing the reasons behind reductions in other categories.



-- SQL Analysis 28 — Regional Year-over-Year Spending Growth
WITH regional_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Region,
        SUM(`Budget Amount`) AS total_budget,
        SUM(`Actual Amount`) AS total_actual,
        SUM(`Budget Variance`) AS total_variance
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Region
),

regional_comparison AS (
    SELECT
        financial_year,
        Region,
        total_budget,
        total_actual,
        total_variance,

        LAG(total_actual) OVER (
            PARTITION BY Region
            ORDER BY financial_year
        ) AS previous_year_actual

    FROM regional_yearly
)

SELECT
    financial_year,
    Region,
    total_actual,
    previous_year_actual,

    ROUND(
        (total_actual - previous_year_actual)
        / previous_year_actual * 100,
        2
    ) AS spending_growth_percentage

FROM regional_comparison
ORDER BY
    financial_year,
    Region;




-- Regional year-over-year analysis showed that South experienced the highest spending growth in 2022 at 18.14%, followed by a 12.56% reduction in 2023. 
-- North also changed direction, moving from a 4.88% decline in 2022 to 6.40% growth in 2023. East showed consistent growth across both years, 
-- while Central remained relatively stable in 2023. These findings can help management identify regions that may require closer expenditure monitoring.



-- SQL Analysis 29 — Year-over-Year Budget Growth by Department
WITH department_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Department,
        SUM(`Budget Amount`) AS total_budget
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Department
),

department_comparison AS (
    SELECT
        financial_year,
        Department,
        total_budget,

        LAG(total_budget) OVER (
            PARTITION BY Department
            ORDER BY financial_year
        ) AS previous_year_budget

    FROM department_yearly
)

SELECT
    financial_year,
    Department,
    total_budget,
    previous_year_budget,

    ROUND(
        (total_budget - previous_year_budget)
        / previous_year_budget * 100,
        2
    ) AS budget_growth_percentage

FROM department_comparison
ORDER BY
    financial_year,
    Department;

-- Department-wise year-over-year budget analysis revealed that Operations received the highest budget increases in both 2022 (8.09%) and 2023 (12.53%). 
-- Marketing maintained consistent budget growth across the period. In contrast, Sales and HR experienced budget reductions in 2023 after receiving 
-- increases in 2022. These findings help identify changes in departmental budget allocation and areas requiring further financial review.



-- SQL Analysis 30 — Year-over-Year Budget Growth by Category
WITH category_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Category,
        SUM(`Budget Amount`) AS total_budget
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Category
),

category_comparison AS (
    SELECT
        financial_year,
        Category,
        total_budget,

        LAG(total_budget) OVER (
            PARTITION BY Category
            ORDER BY financial_year
        ) AS previous_year_budget

    FROM category_yearly
)

SELECT
    financial_year,
    Category,
    total_budget,
    previous_year_budget,

    ROUND(
        (total_budget - previous_year_budget)
        / previous_year_budget * 100,
        2
    ) AS budget_growth_percentage

FROM category_comparison
ORDER BY
    financial_year,
    Category;

-- Category-wise year-over-year budget analysis revealed that Salaries received the highest budget increase in 2022 at 19.38%, 
-- while Utilities received the highest increase in 2023 at 10.14%. Salaries experienced a reversal in 2023, with budget allocation declining by 8.82%. 
-- Training and Utilities also showed changing allocation patterns across the period, while Infrastructure received consistent increases. 
-- These findings highlight shifts in the company's expense planning priorities.



-- SQL Analysis 31 — Year-over-Year Budget Growth by Region
WITH regional_yearly AS (
    SELECT
        YEAR(`Date`) AS financial_year,
        Region,
        SUM(`Budget Amount`) AS total_budget
    FROM financial_data
    GROUP BY
        YEAR(`Date`),
        Region
),

regional_comparison AS (
    SELECT
        financial_year,
        Region,
        total_budget,

        LAG(total_budget) OVER (
            PARTITION BY Region
            ORDER BY financial_year
        ) AS previous_year_budget

    FROM regional_yearly
)

SELECT
    financial_year,
    Region,
    total_budget,
    previous_year_budget,

    ROUND(
        (total_budget - previous_year_budget)
        / previous_year_budget * 100,
        2
    ) AS budget_growth_percentage

FROM regional_comparison
ORDER BY
    financial_year,
    Region;

-- Regional year-over-year budget analysis revealed that South received the highest budget increase in 2022 at 12.63%, 
-- while North received the highest increase in 2023 at 12.39%. Both regions experienced reversals in their allocation trends
-- in the following year. East, Central and West maintained positive budget growth across both years. These findings highlight 
-- changes in regional budget allocation and provide areas for further financial review.



-- SQL Analysis 32 — Department-wise Budget Variance Percentage
SELECT
    Department,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data
GROUP BY Department
ORDER BY budget_variance_percentage DESC;



-- Department-wise budget variance analysis revealed that all six identified departments exceeded their allocated budgets. 
-- Marketing recorded the highest variance at 15.06%, followed by HR at 13.15%. Finance had the lowest variance at 8.38%. 
-- These findings suggest that management should prioritize reviewing spending patterns in Marketing and HR while examining 
-- the practices associated with Finance's comparatively lower variance.






SELECT
    Category,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data
GROUP BY Category
ORDER BY budget_variance_percentage DESC;





SELECT
    Region,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data
GROUP BY Region
ORDER BY budget_variance_percentage DESC;





SELECT
    YEAR(`Date`) AS financial_year,
    MONTH(`Date`) AS month_number,
    MONTHNAME(`Date`) AS month_name,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data
GROUP BY
    YEAR(`Date`),
    MONTH(`Date`),
    MONTHNAME(`Date`)

ORDER BY
    financial_year,
    month_number;
    
    
    
    
    
    
    SELECT
    YEAR(`Date`) AS financial_year,
    QUARTER(`Date`) AS financial_quarter,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data
GROUP BY
    YEAR(`Date`),
    QUARTER(`Date`)

ORDER BY
    financial_year,
    financial_quarter;
    
    
    
    SELECT
    Department,
    Region,

    COUNT(*) AS total_transactions,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data

GROUP BY
    Department,
    Region

ORDER BY
    budget_variance_percentage DESC;
    
    
    
    
    
    
    SELECT
    Category,
    Region,

    COUNT(*) AS total_transactions,

    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance,

    ROUND(
        SUM(`Budget Variance`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_variance_percentage

FROM financial_data

GROUP BY
    Category,
    Region

ORDER BY
    budget_variance_percentage DESC;
    
    
    
    
    
    
    SELECT
    `Transaction ID`,
    `Date`,
    Department,
    Category,
    Region,
    `Budget Amount`,
    `Actual Amount`,
    `Budget Variance`

FROM financial_data

WHERE `Budget Variance` > 0

ORDER BY `Budget Variance` DESC

LIMIT 10;








SELECT
    `Transaction ID`,
    `Date`,
    Department,
    Category,
    Region,
    `Budget Amount`,
    `Actual Amount`,
    `Budget Variance`

FROM financial_data

WHERE `Budget Variance` < 0

ORDER BY `Budget Variance` ASC

LIMIT 10;



SELECT
    COUNT(*) AS total_records,

    MIN(`Date`) AS first_transaction_date,
    MAX(`Date`) AS last_transaction_date,

    SUM(`Budget Amount`) AS total_budget,

    SUM(`Actual Amount`) AS total_actual_spending,

    SUM(`Budget Variance`) AS total_budget_variance,

    SUM(`Actual Amount`)
        - SUM(`Budget Amount`) AS calculated_variance,

    SUM(`Budget Variance`)
        - (
            SUM(`Actual Amount`)
            - SUM(`Budget Amount`)
        ) AS reconciliation_difference

FROM financial_data;



SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN `Budget Variance` =
                 (`Actual Amount` - `Budget Amount`)
            THEN 1
            ELSE 0
        END
    ) AS correct_variance_records,

    SUM(
        CASE
            WHEN `Budget Variance` <>
                 (`Actual Amount` - `Budget Amount`)
            THEN 1
            ELSE 0
        END
    ) AS incorrect_variance_records

FROM financial_data;



SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN `Budget Variance` > 0
                 AND `Budget Status` = 'Over Budget'
            THEN 1
            WHEN `Budget Variance` < 0
                 AND `Budget Status` = 'Under Budget'
            THEN 1
            WHEN `Budget Variance` = 0
                 AND `Budget Status` = 'On Budget'
            THEN 1
            ELSE 0
        END
    ) AS correctly_classified_records,

    SUM(
        CASE
            WHEN (`Budget Variance` > 0
                  AND `Budget Status` <> 'Over Budget')
              OR (`Budget Variance` < 0
                  AND `Budget Status` <> 'Under Budget')
              OR (`Budget Variance` = 0
                  AND `Budget Status` <> 'On Budget')
            THEN 1
            ELSE 0
        END
    ) AS incorrectly_classified_records

FROM financial_data;



SELECT
    COUNT(*) AS total_records,

    SUM(CASE WHEN `Date` IS NULL THEN 1 ELSE 0 END)
        AS missing_dates,

    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END)
        AS missing_departments,

    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END)
        AS missing_categories,

    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END)
        AS missing_regions,

    SUM(CASE WHEN `Budget Amount` IS NULL THEN 1 ELSE 0 END)
        AS missing_budgets,

    SUM(CASE WHEN `Actual Amount` IS NULL THEN 1 ELSE 0 END)
        AS missing_actuals,

    SUM(CASE WHEN `Payment Method` IS NULL THEN 1 ELSE 0 END)
        AS missing_payment_methods,

    SUM(CASE WHEN `Transaction ID` IS NULL THEN 1 ELSE 0 END)
        AS missing_transaction_ids,

    SUM(CASE WHEN `Budget Variance` IS NULL THEN 1 ELSE 0 END)
        AS missing_variances,

    SUM(CASE WHEN `Budget Status` IS NULL THEN 1 ELSE 0 END)
        AS missing_budget_status

FROM financial_data;






SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT `Transaction ID`) AS unique_transaction_ids,
    COUNT(*) - COUNT(DISTINCT `Transaction ID`)
        AS duplicate_transaction_id_count
FROM financial_data;




SELECT
    `Transaction ID`,
    COUNT(*) AS occurrence_count
FROM financial_data
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;





SELECT *
FROM financial_data
WHERE `Transaction ID` = 'Unknown';





SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE WHEN `Budget Amount` <= 0
        THEN 1 ELSE 0 END
    ) AS invalid_budget_records,

    SUM(
        CASE WHEN `Actual Amount` <= 0
        THEN 1 ELSE 0 END
    ) AS invalid_actual_records,

    MIN(`Budget Amount`) AS minimum_budget,
    MIN(`Actual Amount`) AS minimum_actual,

    MAX(`Budget Amount`) AS maximum_budget,
    MAX(`Actual Amount`) AS maximum_actual

FROM financial_data;





SELECT
    `Budget Status`,
    COUNT(*) AS total_transactions,
    SUM(`Budget Amount`) AS total_budget,
    SUM(`Actual Amount`) AS total_actual,
    SUM(`Budget Variance`) AS total_variance

FROM financial_data

GROUP BY `Budget Status`

ORDER BY `Budget Status`;



SELECT
    YEAR(`Date`) AS financial_year,
    COUNT(DISTINCT MONTH(`Date`)) AS months_available,
    COUNT(*) AS total_transactions,
    MIN(`Date`) AS first_transaction_date,
    MAX(`Date`) AS last_transaction_date

FROM financial_data

GROUP BY YEAR(`Date`)

ORDER BY financial_year;



SELECT
    COUNT(*) AS total_transactions,

    SUM(`Budget Amount`) AS total_budget,

    SUM(`Actual Amount`) AS total_actual_spending,

    SUM(`Budget Variance`) AS net_budget_variance,

    ROUND(
        SUM(`Actual Amount`)
        / SUM(`Budget Amount`) * 100,
        2
    ) AS budget_utilization_percentage,

    SUM(
        CASE
            WHEN `Budget Status` = 'Over Budget'
            THEN 1 ELSE 0
        END
    ) AS over_budget_transactions,

    SUM(
        CASE
            WHEN `Budget Status` = 'Under Budget'
            THEN 1 ELSE 0
        END
    ) AS under_budget_transactions,

    ROUND(
        SUM(
            CASE
                WHEN `Budget Status` = 'Over Budget'
                THEN 1 ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS over_budget_transaction_percentage

FROM financial_data;