import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

from db.db_connection import create_connection

def job_count_by_country():
    conn = create_connection()
    if conn is None:
        return

    try:
        cursor = conn.cursor()

        cursor.execute("""
SELECT DISTINCT job_country, COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_country
ORDER BY job_count DESC
LIMIT 25
""")

        countries = cursor.fetchall()
        df = pd.DataFrame(countries, columns=['Country', 'Job Postings Count'])
        data = df.sort_values(by='Job Postings Count', ascending=False)
        
        plt.figure(figsize=(8, 5))
        sns.barplot(x='Country', y='Job Postings Count', data=data)
        plt.title('Top 25 Countries by Number of Job Postings', fontsize=20)
        plt.xlabel('')
        plt.ylabel('Count')
        plt.xticks(rotation=60, fontsize=8)
        plt.tight_layout()

        image_path = 'images/job_postings_by_country.png'
        plt.savefig(image_path)

        plt.close()

    except psycopg2.Error as e:
        print(f"Error executing query: {e}")
    finally:
        conn.close()
