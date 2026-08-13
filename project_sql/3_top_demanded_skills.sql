SELECT
    skills_dim.skills,
    count(*) as demand_count

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

group BY
    skills_dim.skills

order by
    demand_count DESC

limit 5;

    