# CRM Sales Opportunities Project by Matthew Pernes

Technical Tools Used: MySQL, Gemini AI

## Project Overview

This project focuses on a deep-dive exploratory data analysis of a CRM (Customer Relationship Management) sales pipeline. The goal is to identify performance bottlenecks, track regional success, and uncover product-market fit across various industry sectors.

I used the following questions to guide my analysis and surface actionable insights:

1. Regional Performance: How is each sales team performing compared to the rest?
2. Agent Benchmarking: Are any sales agents lagging behind their regional averages?
3. Time Series Trends: Are there any significant quarter-over-quarter (QoQ) trends in revenue or deal volume?
4. Product Success: Which products demonstrate the highest win rates and conversion efficiency?
5. Sales Velocity: How long does it take, on average, for each sales agent to move a deal from engagement to close?
6. Market Segmentation: Which products are being sold most effectively through which industry sectors?

## The Dataset

Dataset Used In This Project: [https://mavenanalytics.io/data-playground/crm-sales-opportunities](https://mavenanalytics.io/data-playground/crm-sales-opportunities)

Description of the dataset:
B2B sales pipeline data from a fictitious company that sells computer hardware, including information on accounts, products, sales teams, and sales opportunities.

## Data Exploratory Analysis

1. How is each sales team performing compared to the rest?

Query:

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

Snapshot of Result Grid:
<img width="756" height="93" alt="image" src="https://github.com/user-attachments/assets/bd59b13c-886e-4d45-9bb7-0878c971191e" />

Insight: Based on the data, the West office is the most efficient performer, boasting the highest win rate at 63.9% despite being in the middle of the pack when it comes to volume of opportunities. While the Central office generated the highest total revenue (3,346,293), its win rate is nearly 1.3% lower than the West, suggesting its success is driven by sheer lead volume rather than conversion efficiency. To maximize growth, the company should investigate the West's closing strategies to see if they can be replicated in the higher-volume Central and East regions.

--- 

2. Are any sales agents lagging behind their regional averages?
