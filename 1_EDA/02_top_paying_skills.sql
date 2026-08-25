/*
Question: What are the highest paying skills for Data Engineering (DE) roles?
• Identify the top 10 skills with the highest median salary for DE roles
  in India and the USA.
• Only skills with more than 100 job postings are included to ensure
  statistical reliability and filter out outliers.
• Why? Identifying high paying skills helps Data Engineers make informed
  decisions about which skills to prioritize for maximum salary growth.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND jpf.job_country = 'India'
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 10;

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 10;

/*
Findings:
The analysis identifies the highest paying skills for Data Engineering roles
in India and the USA. The USA results reveal a clear salary hierarchy with
MongoDB leading at $207,000 median salary, followed by emerging and DevOps
adjacent skills like Rust, Golang, and Ansible commanding strong premiums.
India's results are heavily affected by a salary data artifact where multiple
skills cluster at exactly $147,500, suggesting a salary cap or default value
in the dataset. As a result, India's high salary rankings should be
interpreted with significant caution and may not reflect true market rates.

Key Takeaways:
• MongoDB commands the highest median salary in the USA at $207,000,
  with substantial demand of over 2,000 postings.
• DevOps and infrastructure skills like Ansible, Puppet, and Golang
  appear prominently in the USA high salary list, suggesting Data
  Engineers with these skills command a premium.
• Rust and Golang emerging in the high salary list signals growing
  demand for performance oriented languages in data infrastructure.
• TypeScript appearing in the USA top 10 suggests full stack data
  engineering skills are increasingly well compensated.
• India's salary data is heavily skewed by a $147,500 clustering
  artifact across most ranked skills, limiting the reliability of
  these results.
• Perl ranks highest in India at $151,750, the only skill clearly
  above the clustering artifact, but with only 301 postings.
• Note: India's high salary analysis should be treated with caution
  due to insufficient and potentially capped salary data in the dataset.
• For the USA, skills like MongoDB, Golang, Ansible, and TypeScript
  offer meaningful salary premiums beyond the core DE skill stack.

India:
┌────────────┬───────────────┬──────────────┐
│  skills    │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ perl       │      151750.0 │          301 │
│ mysql      │      147500.0 │         2626 │
│ docker     │      147500.0 │         2980 │
│ db2        │      147500.0 │          348 │
│ looker     │      147500.0 │          980 │
│ bitbucket  │      147500.0 │          625 │
│ neo4j      │      147500.0 │          356 │
│ redis      │      147500.0 │          470 │
│ php        │      147500.0 │          110 │
│ sheets     │      147500.0 │          112 │
├────────────┴───────────────┴──────────────┤
│ 10 rows                         3 columns │
└───────────────────────────────────────────┘

USA:
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│   varchar  │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ mongo      │      207000.0 │         2097 │
│ rust       │      175000.0 │          282 │
│ atlassian  │      165000.0 │          506 │
│ golang     │      158500.0 │          537 │
│ ansible    │      157500.0 │         1169 │
│ puppet     │      157500.0 │          260 │
│ groovy     │      157500.0 │          173 │
│ zoom       │      155000.0 │          215 │
│ plotly     │      155000.0 │          149 │
│ typescript │      155000.0 │          565 │
├────────────┴───────────────┴──────────────┤
│ 10 rows                         3 columns │
└───────────────────────────────────────────┘
*/