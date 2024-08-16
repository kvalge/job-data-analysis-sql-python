from analysis.by_country import job_count_by_country
from analysis.by_skill import job_count_by_skill
from analysis.by_salary import skills_by_salary
from analysis.optimal_skill import optimal_skills

if __name__ == "__main__":
    job_count_by_country()
    job_count_by_skill()
    skills_by_salary()
    optimal_skills()
    