-- Assessment_Q1.sql
-- Query to find customers with at least one funded savings plan AND one funded investment plan, along with counts and total deposits.

-- Get the count of funded savings plans per customer
WITH savings_plans AS (
    SELECT owner_id, COUNT(*) AS savings_count
    FROM plans_plan
    WHERE is_regular_savings = 1
    GROUP BY owner_id
),
-- Get the count of funded investment plans per customer
investment_plans AS (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
),
-- Calculate total deposits per customer from savings transactions
total_deposits AS (
    SELECT owner_id, COALESCE(SUM(confirmed_amount), 0) / 100.00 AS total_deposits
    FROM savings_savingsaccount
    GROUP BY owner_id
)
--  Final selection combining customers with both savings and investment plans
SELECT
    u.id AS owner_id,           -- Customer ID
    u.name,                     -- Customer name
    sp.savings_count,           -- Number of savings plans
    ip.investment_count,        -- Number of investment plans
    COALESCE(td.total_deposits, 0) AS total_deposits  -- Total deposits, defaulting to 0 if none
FROM
    users_customuser u
    -- Join only customers who have savings plans
    JOIN savings_plans sp ON sp.owner_id = u.id
    -- Join only customers who have investment plans
    JOIN investment_plans ip ON ip.owner_id = u.id
    -- Left join deposits to get total deposits (some customers might have zero deposits)
    LEFT JOIN total_deposits td ON td.owner_id = u.id
ORDER BY
    total_deposits DESC;