--Jobs by posting date at EETDST time zone
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EETDST' AS Date_time
FROM job_postings_fact
LIMIT 5;
-------------


--Jobs by posting year and month at EETDST time zone
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EETDST' AS Date_time,
    EXTRACT(YEAR FROM job_posted_date) AS date_month,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 5;
-------------


--Jobs count by posting month
SELECT 
    COUNT(job_id) AS count,
    EXTRACT (MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY 
    month
ORDER BY 
    count DESC
-------------


--Jobs by after certain posting date by month
SELECT 
    EXTRACT (MONTH FROM job_posted_date) AS month,
    job_title_short,
    ROUND(AVG(salary_year_avg))
FROM job_postings_fact
WHERE 
    job_posted_date > '06/01/2023' AND 
    salary_year_avg is NOT NULL
GROUP BY 
    month, job_title_short
LIMIT 100;
-------------


--Jobs posting by comany and period range
SELECT cd.name, jpf.job_id, jpf.job_posted_date
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
WHERE job_posted_date BETWEEN '01-01-2023' AND '09-30-2023'
LIMIT 20;
-------------


