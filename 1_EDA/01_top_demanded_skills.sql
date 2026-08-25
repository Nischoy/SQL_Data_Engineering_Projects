/*
Question: What are the most in-demand skills for Data Engineering (DE) roles?
• Identify the top 10 skills with the highest demand for DE roles.
• Compare skill requirements between job postings in India and the USA
  to identify market specific differences.
• Why? Understanding which skills dominate each market helps Data Engineers
  prioritize learning and tailor their profile for their target job market,
  whether local or international.
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'India'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Findings:
The analysis compares the top 10 in-demand skills for Data Engineering roles
across India and the USA. SQL and Python consistently dominate both markets,
establishing them as the non-negotiable foundation for any Data Engineer
regardless of location. Cloud platforms, particularly AWS and Azure, feature
prominently in both markets. The USA leads significantly in job volume compared
to India, though both markets share a broadly similar core skill set with a
few notable differences in secondary skills.

Key Takeaways:
• SQL and Python are universal — master these first regardless of which
  market you target.
• AWS and Azure are essential in both markets, appearing in the top 5
  consistently.
• India and the USA share a similar core skill profile — SQL, Python,
  AWS, Azure, and Spark make up the top 5 in both markets.
• Databricks ranks higher in India (#6) compared to the USA (#8),
  suggesting stronger adoption of the Databricks ecosystem in India.
• Scala and Kafka appear in the USA top 10 but are absent from India's
  list, indicating stronger demand for distributed computing and real-time
  streaming expertise in the US market.
• PySpark appears in India's top 10 but not the USA's, reflecting
  India's preference for Python-based Spark workflows.
• When targeting the Indian market, SQL, Python, AWS, Azure, and Spark
  should be the priority skill stack, with Databricks and PySpark as
  strong secondary skills.
• When targeting the US market, SQL, Python, AWS, Azure, and Spark
  should be the priority skill stack, with Scala and Kafka as valuable
  differentiators.

India:                                USA:
┌────────────┬──────────────┐         ┌────────────┬──────────────┐
│   skills   │ demand_count │         │   skills   │ demand_count │
├────────────┼──────────────┤         ├────────────┼──────────────┤
│ sql        │        29766 │         │ sql        │        56933 │
│ python     │        27049 │         │ python     │        55159 │
│ aws        │        17026 │         │ aws        │        35698 │
│ azure      │        16189 │         │ azure      │        29236 │
│ spark      │        15744 │         │ spark      │        26768 │
│ databricks │         9186 │         │ snowflake  │        19996 │
│ hadoop     │         8563 │         │ java       │        19405 │
│ java       │         8552 │         │ databricks │        15430 │
│ snowflake  │         8534 │         │ scala      │        14921 │
│ pyspark    │         8331 │         │ kafka      │        14688 │
└────────────┴──────────────┘         └────────────┴──────────────┘
*/