import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

from db.db_connection import create_connection

def skills_by_salary():
    conn = create_connection()
    if conn is None:
        return

    try:
        cursor = conn.cursor()

        cursor.execute("""
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salay
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY average_salay DESC
LIMIT 20
""")

        skills = cursor.fetchall()
        data = pd.DataFrame(skills, columns=['skills', 'av_salary'])
        
        plt.figure(figsize=(8, 5))
        sns.barplot(x='skills', y='av_salary', data=data)
        plt.title('Top 20 Skills by Average Yearly Salary', fontsize=20)
        plt.xlabel('')
        plt.ylabel('Average Salary')
        plt.xticks(rotation=45, fontsize=8)
        plt.tight_layout()

        image_path = 'images/skills_by_salary.png'
        plt.savefig(image_path)

        plt.close()

    except psycopg2.Error as e:
        print(f"Error executing query: {e}")
    finally:
        conn.close()
