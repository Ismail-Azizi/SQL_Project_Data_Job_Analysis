/* 
Question: what are the top-paying data analyst job?
- identify the top 10 highest-paying data analyst roles that are avaliable remotely.
- focuses on job postings with specified salaries (remove nulls)
*/

SELECT
    company_dim.name,
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact

left JOIN
    company_dim

ON
    job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst'
    AND
    job_work_from_home = TRUE
    AND
    salary_year_avg is not NULL

order by
    salary_year_avg DESC

limit
    10;