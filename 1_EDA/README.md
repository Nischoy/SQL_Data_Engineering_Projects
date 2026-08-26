# Exploratory Data Analysis w/ SQL: Data Engineering Job Market Analysis (India vs USA)  
![Project 1 Overview](../Images/1_1_Project1_EDA.png)

## Overview
- **Project Scope** : Built 3 analytical queries that answer key questions 
  about the Data Engineering job market across India and the USA.
- **Purpose** : Built as a SQL practice project to strengthen query writing 
  skills and to understand how Data Analysts consume and interpret data, 
  providing insight into what effective Data Engineering deliverables should 
  look like for downstream analytical use.
- **Data Modeling** : Used multi-table joins across fact and dimension tables 
  to extract meaningful insights from raw job posting data.
- **Analytics** : Applied aggregations, filtering, and sorting to identify 
  top skills by demand, salary, and overall value.
- **Outcomes** : Delivered actionable insights on SQL and Python dominance, 
  cloud platform trends, and salary patterns across two major job markets.

If you only have a minute, review these:

1. [`01_top_demanded_skills.sql`](01_top_demanded_skills.sql): Multi-table join query to find the top 10 most in-demand skills across India and the USA.
2. [`02_top_paying_skills.sql`](02_top_paying_skills.sql): Aggregation query to identify the top 10 highest paying skills with salary and demand metrics.
3. [`03_optimal_skills.sql`](03_optimal_skills.sql): Optimization query combining median 
salary and log-scaled demand into a single optimal score.

## Problem and Context
Job market analysts need to answer questions like:

- **Most In-Demand** : Which skills are most in-demand for Data Engineers?
- **Highest Paid** : Which skills command the highest salaries?
- **Best Trade-off** : What is the optimal skill set balancing demand and 
  compensation?

This project analyzes a data warehouse built using a star schema design. 
The warehouse structure consists of:

![Data Warehouse Structure](../Images/1_2_Data_Warehouse.png)

- **Fact Table** : `job_postings_fact` - central table containing job posting 
  details such as job titles, locations, salaries, and dates.
- **Dimension Tables** :
  - `company_dim` - company information linked to job postings
  - `skills_dim` - skills catalog with skill names and types
- **Bridge Table** : `skills_job_dim` - resolves the many-to-many relationship 
  between job postings and skills

By querying across these interconnected tables, I extracted insights about 
skill demand, salary patterns, and optimal skill combinations for Data 
Engineering roles in India and the USA.

## Tools Used

- **Query Engine** : DuckDB for fast OLAP-style analytical queries
- **Cloud Storage** : MotherDuck as cloud companion to DuckDB for dataset 
  storage and sharing
- **Language** : SQL with analytical functions including aggregations, and logarithmic scaling
- **Data Model** : Star schema with fact, dimension, and bridge tables
- **Development** : VSCode for SQL editing and Git Bash for DuckDB CLI 
  and terminal operations
- **Version Control** : Git and GitHub for versioned SQL scripts

## Dataset
Data sourced from Luke Barousse's Data Jobs Dataset, introduced in his 
SQL for Data Engineers video series. The dataset contains real-world job 
postings with information on job titles, locations, salaries, and required 
skills.

Source: https://lukebarousse.com/sql

## Project Structure
1_EDA/  
├── 01_top_demanded_skills.sql  
├── 02_top_paying_skills.sql  
├── 03_optimal_skills.sql  
└── README.md


## Analysis Overview
### Query Structure

1. **[Top Demanded Skills](01_top_demanded_skills.sql) :** Identifies the top 10 most 
   in-demand skills for Data Engineering roles across India and the USA, 
   comparing market specific differences in skill requirements.
2. **[Top Paying Skills](02_top_paying_skills.sql) :** Analyzes the top 10 highest 
   paying skills with salary and demand metrics, filtered to skills with 
   more than 100 postings for statistical reliability.
3. **[Optimal Skills](03_optimal_skills.sql) :** Calculates an optimal score using 
   the natural log of demand combined with median salary to identify the 
   most valuable skills to learn for maximum career ROI.

### Key Findings

- **Core Languages** : SQL and Python dominate both markets, with SQL 
  appearing in nearly 30,000 Indian job postings and over 56,000 US postings.
- **Cloud Platforms** : AWS and Azure are critical for modern Data Engineering 
  roles, consistently appearing in the top 5 across both markets.
- **Market Differences** : Scala and Kafka differentiate the US market, while 
  PySpark and Databricks see stronger adoption in India.
- **Premium Salaries** : DevOps adjacent skills like MongoDB, Golang, Ansible, 
  and Rust are associated with the highest salaries in the US market.
- **Most Optimal Skill** : Python offers the best balance of salary and demand 
  in both markets, making it the single safest skill investment for aspiring 
  Data Engineers.
- **Data Limitation** : India's salary data contains a clustering artifact at 
  $147,500 across multiple skills, and should be interpreted with caution.

## Data Limitations
- India's remote job listings had insufficient salary data and were excluded 
  from salary analysis.
- India's salary data contains a clustering artifact at $147,500 across 
  multiple skills, suggesting a salary cap or default value in the dataset.
- India's optimal skill analysis is based on a limited salary-reported subset 
  and should be interpreted with caution.

## Skills Demonstrated
- **SQL** : Writing complex queries involving joins, aggregations, filtering, 
  and subqueries across multiple related tables
- **DuckDB** : Running in-process analytical queries on large datasets 
  efficiently using modern SQL syntax
- **MotherDuck** : Managing and sharing datasets via cloud-based DuckDB 
  storage
- **Data Analysis** : Identifying patterns, drawing comparisons across 
  markets, and interpreting results in a meaningful context
- **Data Limitations Awareness** : Recognizing and documenting dataset 
  artifacts and reliability issues rather than presenting results blindly
- **Documentation** : Writing clear, structured findings and key takeaways 
  alongside SQL code for reproducibility and readability
- **Version Control** : Managing project files and commits using Git and 
  Git Bash