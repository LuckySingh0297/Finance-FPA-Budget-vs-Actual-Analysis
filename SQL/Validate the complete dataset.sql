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