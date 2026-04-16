# CRM Sales Opportunities Project by Matthew Pernes

Technical Tools Used: MySQL, Gemini AI

_Note: All the SQL queries can be found in the crm_sql.sql file within the repository._

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

Clause/s Used: CASE WHEN, LEFT JOIN, ROUND, etc.,

Snapshot of Result Grid:

<img width="756" height="93" alt="image" src="https://github.com/user-attachments/assets/bd59b13c-886e-4d45-9bb7-0878c971191e" />

Insight: Based on the data, the West office is the most efficient performer, boasting the highest win rate at 63.9% despite being in the middle of the pack when it comes to volume of opportunities. While the Central office generated the highest total revenue (3,346,293), its win rate is nearly 1.3% lower than the West, suggesting its success is driven by sheer lead volume rather than conversion efficiency. To maximize growth, the company should investigate the West's closing strategies to see if they can be replicated in the higher-volume Central and East regions.

--- 

2. Are any sales agents lagging behind their regional averages?

Clause/s Used: COUNT, CASE WHEN, LEFT JOIN, etc.,

Snapshot of Result Grid: 

<img width="731" height="276" alt="image" src="https://github.com/user-attachments/assets/7f2bfa0b-d8a2-4d95-85ec-89689c009613" />

Insight: While Lajuana Vencill appears to be lagging with the lowest win rate in the group (55.0%), the data also highlights Markita Hansen and Donn Cantrell as underperformers with win rates below 58%. In contrast, high-efficiency agents like Maureen Marcano and Hayden Neloms are closing over 70% of their deals, creating a significant 15-point performance gap across the team. These trailing agents may require targeted coaching, as they are currently losing nearly half of their opportunities compared to the top-tier "closers."

---

3. Are there any significant quarter-over-quarter (QoQ) trends in revenue or deal volume?

Clause/s Used: YEAR, QUARTER, GROUP BY, etc.,

Snapshot of Result Grid: 

<img width="585" height="117" alt="image" src="https://github.com/user-attachments/assets/22acc6b2-20da-4409-a849-a7348a27d0f6" />

Insight: The data reveals a significant spike in sales activity during Q2 2017, where revenue nearly tripled to 3.09 million alongside a massive surge in total opportunities. However, this volume growth came at the cost of efficiency, as the win rate dropped from a high of 82.1% in Q1 to a stabilized low of approximately 60% by year-end. This suggests that while the company successfully scaled its reach after the first quarter, the quality of leads or the capacity of the sales team may have reached a threshold that lowered overall conversion rates.

---

4. Do any products have better win rates?

Clause/s Used: AVG, SUM, INNER JOIN, etc.,

Snapshot of Result Grid:

<img width="420" height="160" alt="image" src="https://github.com/user-attachments/assets/00fef307-6bf2-437b-9e93-597a74d4952d" />

Insight: The GTX Plus Pro is clearly the top-tier product, accounting for over 40% of grand total sales while maintaining a high win rate of 64.3%. Interestingly, the MG Special has the highest overall win rate (64.8%), yet it represents less than 1% of total revenue, indicating it is a highly successful but significantly under-utilized niche product. Across the board, the GTX line consistently outperforms the MG and GTK lines in both conversion efficiency and total market share.

---

5. How long does it take, on average, for each sales agent to move a deal from the day it was created to the day it was closed?

Clause/s Used: ROUND, AVG, DATEDIFF, etc.,

Snapshot of Result Grid:

<img width="302" height="240" alt="image" src="https://github.com/user-attachments/assets/42b137e3-3dd3-4b8f-ae00-abf2411efffd" />

Insight: The average sales cycle across the team is approximately 48 days, with Cecily Lampkin leading in efficiency at only 39 days per deal. While the majority of the team clusters around the 45-50 day mark, Moses Frase is a notable outlier with a much slower cycle of 57 days. Reducing the gap between the fastest and slowest agents could significantly increase the team's total deal capacity over the course of the fiscal year.

---

6. Which products are being sold through which sectors?

Clause/s Used: LEFT JOIN, WHERE, ORDER BY

Snapshot of Result Grid: 

<img width="334" height="246" alt="image" src="https://github.com/user-attachments/assets/fa8a06b4-a6f3-45ce-a180-5883d17ac8aa" />

Insight: The Retail and Technology sectors are the primary drivers of volume, with the GTX Basic serving as the most widely sold product across almost every major industry. While high-tech sectors like Software and Medical show healthy diversification across the GTX and MG lines, specialized products like the GTK 500 remain extremely niche with negligible sales across all categories. Overall, the data suggests a strong reliance on the Retail sector for core product volume, while the Medical and Technology sectors offer the most balanced adoption of the premium MG Advanced and Special lines.
