SELECT DISTINCT job_country, COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_country
ORDER BY job_count DESC
LIMIT 25