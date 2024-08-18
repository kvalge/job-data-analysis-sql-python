
--Number of job postings in Estonia
SELECT 
    COUNT(job_id)
FROM job_postings_fact
WHERE 
    job_country = 'Estonia'
-------------


--Number of job postings by job type in Estonia
SELECT 
    job_title_short, COUNT(job_id) AS count
FROM job_postings_fact
WHERE
    job_country = 'Estonia'
GROUP BY
    job_title_short
ORDER BY
    count DESC
-------------


--Number of job postings by jobs including analyst role in Estonia
SELECT 
    job_title_short, COUNT(job_id) AS count
FROM job_postings_fact
WHERE
    job_country = 'Estonia' AND job_title LIKE '%Analyst%'
GROUP BY
    job_title_short
ORDER BY
    count DESC
-------------


--All job postings in Estonia
SELECT 
    job_title, COUNT(job_id) AS count
FROM job_postings_fact
WHERE
    job_country = 'Estonia'
GROUP BY
    job_title
ORDER BY
    count DESC
-------------


--Jobs wiht average yearly salary by company in Estonia
SELECT 
    CONCAT(UPPER(name), ' - ', job_title_short) AS company_job, salary_year_avg
FROM job_postings_fact AS jpf
JOIN company_dim AS cd ON jpf.company_id = cd.company_id
WHERE 
    salary_year_avg IS NOT NULL AND job_country = 'Estonia'
ORDER BY 
    name, job_title_short, salary_year_avg
-------------

