import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

from db.db_connection import create_connection

def optimal_skills():
    conn = create_connection()
    if conn is None:
        return

    try:
        cursor = conn.cursor()

        cursor.execute("""
WITH skills_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT DISTINCT
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 100
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 20
""")

        skills = cursor.fetchall()
        data = pd.DataFrame(skills, columns=['skills', 'nr_of_skills', 'av_salary'])

        fig, ax1 = plt.subplots(figsize=(8, 5))

        sns.barplot(data=data, x='skills', y='av_salary', alpha=0.5, ax=ax1)

        ax2 = ax1.twinx()

        sns.lineplot(data=data, x='skills', y='nr_of_skills', marker='o', sort=False, ax=ax2)

        ax1.set_xlabel('Skills')
        ax1.set_ylabel('Average Salary')
        ax2.set_ylabel('Number of Skills')
        ax1.set_title('Top Demanded Skills by Average Yearly Salary')

        for label in ax1.get_xticklabels():
            label.set_rotation(35)
            label.set_fontsize(8)

        image_path = 'images/optimal_skills.png'
        plt.savefig(image_path)

        plt.close()

    except psycopg2.Error as e:
        print(f"Error executing query: {e}")
    finally:
        conn.close()