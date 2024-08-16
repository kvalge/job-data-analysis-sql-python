import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

from db.db_connection import create_connection

def job_count_by_skill():
    conn = create_connection()
    if conn is None:
        return

    try:
        cursor = conn.cursor()

        cursor.execute("""
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 7
""")

        skills = cursor.fetchall()
        data = pd.DataFrame(skills, columns=['Skill', 'Job Postings Count'])
        
        plt.figure(figsize=(8, 5))
        sns.barplot(x='Skill', y='Job Postings Count', data=data)
        plt.title('Top 7 Skills by Number of Job Postings', fontsize=20)
        plt.xlabel('')
        plt.ylabel('Count')
        plt.xticks(rotation=0, fontsize=8)
        plt.tight_layout()

        image_path = 'images/job_postings_by_skill.png'
        plt.savefig(image_path)

        plt.close()

    except psycopg2.Error as e:
        print(f"Error executing query: {e}")
    finally:
        conn.close()
