SELECT
    skills,
    count(*) as demand_count,
    round(avg(salary_year_avg),0) as avg_salary

FROM 
    job_postings_fact

inner join
    skills_job_dim

ON
    job_postings_fact.job_id = skills_job_dim.job_id

inner join
    skills_dim

ON
    skills_job_dim.skill_id = skills_dim.skill_id

where
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg is not NULL
    AND
    job_work_from_home = TRUE

group BY
    skills

HAVING
    count(*) > 10

order by
    avg_salary DESC

limit 25;

    