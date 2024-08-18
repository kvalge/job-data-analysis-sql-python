
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



