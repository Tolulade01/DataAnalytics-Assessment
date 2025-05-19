-- Assessment_Q3.sql
-- Find active plans (savings or investment) with no inflow transactions in the last 365 days
-- Show plan ID, owner ID, plan type, last transaction date, and days of inactivity

SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS plan_type,
    last_tx.last_transaction_date,
    -- Calculate inactivity days; if no transaction, result will be NULL
    DATEDIFF('2025-05-18', last_tx.last_transaction_date) AS inactivity_days
FROM
    plans_plan p
    LEFT JOIN (
        -- Pre-aggregate last transaction date per customer
        SELECT 
            owner_id, 
            MAX(transaction_date) AS last_transaction_date
        FROM 
            savings_savingsaccount
        GROUP BY 
            owner_id
    ) last_tx ON last_tx.owner_id = p.owner_id
WHERE
    p.is_regular_savings = 1 OR p.is_a_fund = 1  -- Only consider active savings or investment plans
HAVING
    -- Include plans with no transactions or last transaction older than 365 days
    last_tx.last_transaction_date IS NULL OR DATEDIFF('2025-05-18', last_tx.last_transaction_date) > 365
ORDER BY
    inactivity_days DESC
LIMIT 1000;
_days DESC
LIMIT 1000;
