--Jobs by average yearly salary
SELECT 
    job_title_short, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
GROUP BY
    job_title_short
ORDER BY 
    av_salary DESC
-------------


--Jobs by average yearyl salary in Estonia
SELECT 
    job_title_short, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    job_country = 'Estonia' AND salary_year_avg IS NOT NULL
GROUP BY
    job_title_short
ORDER BY 
    av_salary DESC
-------------


--Countries by average yearly salary
SELECT 
    job_country, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND job_country IS NOT NULL
GROUP BY
    job_country
ORDER BY 
    av_salary DESC
-------------


--Companies by average yearly salary
SELECT 
    name AS company_name, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    company_name
ORDER BY 
    av_salary DESC
-------------


--Companies in Estonia by average yearly salary
SELECT 
    name AS company_name, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL AND job_country = 'Estonia'
GROUP BY
    company_name
ORDER BY 
    av_salary DESC
-------------


--Comparing average yearly salary by onsite and remote jobs
SELECT 
    job_work_from_home, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    job_work_from_home
ORDER BY 
    av_salary DESC
-------------


--Comparing average yearly salary by onsite and remote jobs in Estonia
SELECT 
    job_work_from_home, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND job_country = 'Estonia'
GROUP BY
    job_work_from_home
ORDER BY 
    av_salary DESC
-------------


--Comparing average yearly salary by degree mention
SELECT 
    job_no_degree_mention, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    job_no_degree_mention
ORDER BY 
    av_salary DESC
-------------


--Comparing average yearly salary by degree mention in Estonia
SELECT 
    job_no_degree_mention, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND job_country = 'Estonia'
GROUP BY
    job_no_degree_mention
ORDER BY 
    av_salary DESC
-------------


--Minimum paid average yearly salary by country
SELECT 
    job_country, ROUND(MIN(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL AND job_country IS NOT NULL
GROUP BY 
    job_country
ORDER BY 
    av_salary
-------------


--Average yearly salary in selected countries
SELECT 
    job_country AS country, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact
WHERE 
    job_country IN ('Estonia', 'Latvia', 'Lithuania', 'Finland', 'Sweden') AND
    salary_year_avg IS NOT NULL AND
    job_country IS NOT NULL
GROUP BY 
    country
ORDER BY 
    av_salary DESC
-------------


--Skills by average salary
SELECT 
    skills, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    av_salary DESC
-------------


--Skills by average salary in Estonia
SELECT 
    skills, ROUND(AVG(salary_year_avg)) AS av_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    salary_year_avg IS NOT NULL AND job_country = 'Estonia'
GROUP BY 
    skills
ORDER BY
    av_salary DESC






