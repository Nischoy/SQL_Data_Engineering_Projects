/*
Question: What skills offer the best combination of high salary and high demand
          for Data Engineering (DE) roles?
• Identify the top 10 skills that balance both median salary and demand count
  for DE roles in India and the USA.
• An optimal score is calculated by combining median salary and the natural log
  of demand count, rewarding skills that are both well-paying and consistently
  sought after.
• Why? Ranking skills by salary or demand alone can be misleading. A skill
  with a very high salary but minimal demand, or high demand but low pay, may
  not be the best investment of learning time. The optimal score helps identify
  skills worth prioritizing.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*))) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND jpf.job_country = 'India'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 50
ORDER BY
    optimal_score DESC
LIMIT 10;

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*))) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 50
ORDER BY
    optimal_score DESC
LIMIT 10;

/*
Findings:
The analysis ranks Data Engineering skills by an optimal score combining median
salary and logarithmic demand across India and the USA. Python emerges as the
top skill in both markets, offering the best balance of strong pay and high
demand. The USA shows significantly higher optimal scores overall, driven by
larger job volumes and more complete salary data. India's results are based on
a smaller salary-reported subset of the dataset, which may limit statistical
reliability but still reveals meaningful patterns. Kafka appears in both
markets' top 10, suggesting it is a consistently valuable skill regardless
of location.

Key Takeaways:
• Python is the single most optimal skill in both India and the USA,
  high salary and high demand make it the safest learning investment.
• SQL ranks #2 in the USA by optimal score despite a lower median salary
  than some competitors, driven entirely by its massive demand volume.
• Kafka appears in both markets' top 10, confirming its value as a
  real-time streaming skill worth prioritizing globally.
• MongoDB stands out in the USA with the highest median salary ($207,000)
  but a relatively low demand count, high reward but higher risk as a
  primary skill focus.
• Java and Azure appear in both markets, reinforcing their cross market
  relevance for Data Engineers.
• India's optimal scores are significantly lower than the USA's, reflecting
  smaller job volumes and scarcer salary data rather than lower skill value.
• Note: India's results are based on a limited salary reported subset of
  the dataset and should be interpreted with caution.
• For India, Python, Spark, Java, and Kafka offer the best balance of
  salary and demand.
• For the USA, Python, SQL, AWS, Spark, and Kafka offer the strongest
  overall value as a skill stack.

India:
┌───────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│  skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar  │    double     │    int64     │     double      │    double     │
├───────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python    │      145025.0 │          242 │             5.0 │           0.8 │
│ spark     │      131580.0 │          133 │             5.0 │          0.64 │
│ java      │      134621.0 │           90 │             4.0 │          0.61 │
│ sql       │      110000.0 │          236 │             5.0 │           0.6 │
│ r         │      145025.0 │           62 │             4.0 │           0.6 │
│ nosql     │      132911.0 │           68 │             4.0 │          0.56 │
│ kafka     │      135000.0 │           65 │             4.0 │          0.56 │
│ hadoop    │      120705.0 │           99 │             5.0 │          0.55 │
│ azure     │      110000.0 │          137 │             5.0 │          0.54 │
│ snowflake │      131040.0 │           54 │             4.0 │          0.52 │
├───────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 10 rows                                                          5 columns │
└────────────────────────────────────────────────────────────────────────────┘

USA:
┌───────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│  skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar  │    double     │    int64     │     double      │    double     │
├───────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python    │      135000.0 │         5238 │             9.0 │          1.16 │
│ sql       │      130000.0 │         5324 │             9.0 │          1.12 │
│ aws       │      137500.0 │         3292 │             8.0 │          1.11 │
│ spark     │      140000.0 │         2544 │             8.0 │           1.1 │
│ mongo     │      207000.0 │          203 │             5.0 │           1.1 │
│ kafka     │      150000.0 │         1492 │             7.0 │           1.1 │
│ airflow   │      147500.0 │         1159 │             7.0 │          1.04 │
│ java      │      138100.0 │         1789 │             7.0 │          1.03 │
│ azure     │      130000.0 │         2738 │             8.0 │          1.03 │
│ snowflake │      136000.0 │         1943 │             8.0 │          1.03 │
├───────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 10 rows                                                          5 columns │
└────────────────────────────────────────────────────────────────────────────┘
*/