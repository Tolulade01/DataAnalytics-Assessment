-- Assessment_Q4.sql
-- Calculate Customer Lifetime Value (CLV) based on account tenure and transaction volume
--   - profit_per_transaction = 0.1% (0.001) of transaction value (confirmed_amount)
--   - tenure in months = months between signup_date and current date (2025-05-18)
--   - CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction

WITH customer_transactions AS (
    SELECT
        u.id AS customer_id,
        u.name,
        u.created_on,
        COUNT(sa.id) AS total_transactions,                       -- Total number of transactions per customer
        COALESCE(SUM(sa.confirmed_amount), 0) / 100.00 AS total_amount -- Total transaction amount in main currency
    FROM
        users_customuser u
        LEFT JOIN savings_savingsaccount sa ON sa.owner_id = u.id
    GROUP BY
        u.id,
        u.name,
        u.created_on
),

customer_tenure AS (
    SELECT
        customer_id,
        name,
        created_on,
        total_transactions,
        total_amount,
        -- Calculate tenure in months (rounded down)
        PERIOD_DIFF(
            DATE_FORMAT('2025-05-18', '%Y%m'),
            DATE_FORMAT(created_on, '%Y%m')
        ) AS tenure_months
    FROM
        customer_transactions
)

SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    -- Calculate average profit per transaction (0.1% of average transaction value)
    (total_amount / NULLIF(total_transactions, 0)) * 0.001 AS avg_profit_per_transaction,
    -- Calculate estimated CLV using the formula
    CASE
        WHEN tenure_months > 0 THEN ROUND((total_transactions / tenure_months) * 12 * ((total_amount / NULLIF(total_transactions, 0)) * 0.001), 2)
        ELSE 0
    END AS estimated_clv
FROM
    customer_tenure
ORDER BY
    estimated_clv DESC;
