# DataAnalytics-Assessment

## Overview

This repository contains SQL solutions for the Data Analyst SQL Proficiency Assessment. The assessment evaluates skills in data retrieval, aggregation, joins, subqueries, and data manipulation across multiple tables to solve business problems.

Each SQL file contains a single query answering one of the four assessment questions. Queries are optimized for accuracy, efficiency, and readability, with comments explaining the logic.

## Repository Structure
DataAnalytics-Assessment/
│
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
│
└── README.md 

## Per-Question Explanations

### Question 1: High-Value Customers with Multiple Products

- **Goal:** Identify customers who have at least one funded savings plan and one funded investment plan.
- **Approach:**  
  - Used Common Table Expressions to separately count savings and investment plans per customer.  
  - Calculated total deposits by summing confirmed deposit amounts.  
  - Joined aggregated results to filter customers with both plan types.  
  - Sorted customers by total deposits descending.
  - Used `COALESCE` to handle customers with no deposits.

---

### Question 2: Transaction Frequency Analysis

- **Goal:** Categorize customers based on average monthly transaction frequency.
- **Approach:**  
  - Grouped transactions by customer and month using `DATE_FORMAT` (MySQL-compatible).  
  - Calculated average transactions per month per customer.  
  - Categorized customers into High, Medium, and Low frequency using CASE statements.  
  - Aggregated counts and averages per category.
  - Used clear categorization thresholds as per instructions.

---

### Question 3: Account Inactivity Alert

- **Goal:** Find active plans with no inflow transactions in the last 365 days.
- **Approach:**  
  - Pre-aggregated last transaction dates per customer to reduce join size.  
  - Joined with plans to identify inactive accounts.  
  - Calculated inactivity days using `DATEDIFF`.  
  - Filtered accounts with inactivity over 365 days or no transactions.
  - Used `HAVING` clause to filter after aggregation.

---

### Question 4: Customer Lifetime Value (CLV) Estimation

- **Goal:** Estimate customer lifetime value based on tenure and transaction volume.
- **Approach:**  
  - Calculated total transactions and total transaction amount per customer.  
  - Computed account tenure in months using `PERIOD_DIFF`.  
  - Calculated average profit per transaction as 0.1% of average transaction value.  
  - Estimated CLV using the provided formula and handled division by zero cases.  
  - Ordered customers by estimated CLV descending.
  - Ensured inclusion of customers with zero transactions.  
  - Used fixed current date for tenure calculation.

---

## Challenges and Resolutions

- **Handling Large Data Joins:**  
  Initial queries joining large tables caused timeouts. Resolved by pre-aggregating data in subqueries to reduce join sizes.

- **Database Compatibility:**  
  Functions like `DATE_TRUNC` are not supported in MySQL. Adapted queries using `DATE_FORMAT` and `PERIOD_DIFF` for date manipulations.

- **NULL Handling:**  
  Used `COALESCE` and `NULLIF` to handle null values and avoid division by zero errors.

- **Performance Optimization:**  
  Added filtering in `HAVING` clauses post-aggregation and limited result sets to improve query speed.

---

## How to Run

1. Load the provided `.sql` files into your MySQL database environment.
2. Execute each SQL file individually to get answers to the respective questions.
3. Ensure your database has the required tables and data loaded.
4. Adjust the current date in queries if running on a different date.

---

Thank you for reviewing my assessment. Please feel free to reach out if you have any questions.


