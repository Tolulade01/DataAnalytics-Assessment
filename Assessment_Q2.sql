-- Assessment_Q2.sql
-- Calculate average number of transactions per customer per month
-- Categorize customers into High, Medium, and Low frequency users
-- Output frequency category, number of customers in each category, and average transactions per month

WITH monthly_transactions AS (
    SELECT
        owner_id,                                 -- Customer ID
        DATE_FORMAT(transaction_date, '%Y-%m-01') AS month_start,  -- First day of the transaction month
        COUNT(*) AS transactions_in_month         -- Number of transactions in that month
    FROM
        savings_savingsaccount
    GROUP BY
        owner_id,
        month_start
),

avg_transactions_per_customer AS (
    SELECT
        owner_id,
        AVG(transactions_in_month) AS avg_transactions_per_month  -- Average transactions per month per customer
    FROM
        monthly_transactions
    GROUP BY
        owner_id
)

SELECT
    -- Categorize customers based on average transactions per month
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    
    COUNT(*) AS customer_count,                    -- Number of customers in each category
    
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month  -- Average transactions per month for the category
FROM
    avg_transactions_per_customer
GROUP BY
    frequency_category
ORDER BY
    -- Order categories from high to low frequency
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
