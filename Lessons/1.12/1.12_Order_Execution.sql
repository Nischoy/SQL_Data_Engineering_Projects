SELECT *
FROM job_postings_fact
LIMIT 10;

EXPLAIN ANALYZE
SELECT
    cd.name as company_name,
    COUNT(jpf.*) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim as CD
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC
LIMIT 10; 