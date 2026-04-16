SELECT * FROM accounts;
SELECT * FROM data_dictionary;
SELECT * FROM products;
SELECT * FROM sales_pipeline;
SELECT * FROM sales_teams;

-- 1. How is each sales team performing compared to the rest?

SELECT regional_office, 
	   COUNT(deal_stage) AS opportunities,
	   SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE NULL END) AS deals_won,
       ROUND(AVG(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100, 1) AS deals_won_pct,
       SUM(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE NULL END) AS deals_lost,
       ROUND(AVG(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END) * 100, 1) AS deals_lost_pct,
       SUM(close_value) AS total_close_value
FROM sales_pipeline AS sp
	LEFT JOIN sales_teams AS st
		ON sp.sales_agent = st.sales_agent
GROUP BY regional_office
;

-- 2. Are any sales agents lagging behind?

SELECT sp.sales_agent, 
	   COUNT(deal_stage) AS opportunities,
	   SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS deals_won,
       ROUND(AVG(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100, 1) AS deals_won_pct,
       SUM(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END) AS deals_lost,
       ROUND(AVG(CASE WHEN deal_stage = 'Lost' THEN 1 ELSE 0 END) * 100, 1) AS deals_lost_pct,
       SUM(close_value) AS total_sales
FROM sales_pipeline AS sp
	LEFT JOIN sales_teams AS st
		ON sp.sales_agent = st.sales_agent
GROUP BY sales_agent
ORDER BY total_sales DESC
;

-- 3. Are there any quarter-over-quarter trends?

SELECT YEAR(close_date) AS fiscal_year,
	   QUARTER(close_date) AS fiscal_quarter,
       COUNT(*) AS total_opportunities,
       ROUND(SUM(close_value) / 1000000, 2) AS revenue_millions,
       ROUND(AVG(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100, 1) AS win_rate_pct
FROM sales_pipeline
GROUP BY fiscal_year, fiscal_quarter
;

-- 4. Do any products have better win rates?

SELECT sp.product,
	   AVG(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100 AS win_pct,
       SUM(close_value) AS total_sales,
       ROUND(SUM(close_value) / SUM(SUM(close_value)) OVER() * 100, 2) AS pct_grand_total
FROM products AS p
	INNER JOIN sales_pipeline AS sp
		ON p.product = sp.product
GROUP BY sp.product
ORDER BY total_sales DESC
;

-- 5. How long does it take, on average, for each sales agent to move a deal from the day it was created to the day it was closed?

SELECT sales_agent, 
	   ROUND(AVG(DATEDIFF(close_date, engage_date))) AS avg_days_per_deal
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY avg_days_per_deal DESC
;

-- 6. Which products are being sold through which sectors?

SELECT 
    sector, product, COUNT(*) AS products_sold
FROM accounts AS a
	LEFT JOIN sales_pipeline AS sp 
		ON a.account = sp.account
WHERE deal_stage = 'Won'
GROUP BY sector , product
ORDER BY products_sold DESC
;
