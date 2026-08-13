# SQL Data Job Analysis

## Table of Contents

- [Introduction](#introduction)
- [Background](#background)
- [Tools I Used](#tools-i-used)
- [The Analysis](#the-analysis)
  - [1. Top-Paying Data Analyst Jobs](#1-top-paying-data-analyst-jobs)
  - [2. Skills Required for Top-Paying Data Analyst Jobs](#2-skills-required-for-top-paying-data-analyst-jobs)
  - [3. Most In-Demand Skills for Data Analysts](#3-most-in-demand-skills-for-data-analysts)
  - [4. Top-Paying Skills for Data Analysts](#4-top-paying-skills-for-data-analysts)
  - [5. Most Optimal Skills to Learn](#5-most-optimal-skills-to-learn)
- [What I Learned](#what-i-learned)
- [Conclusion](#conclusion)

---

## Introduction

This project is my **first hands-on SQL data analysis project**.

After learning the fundamentals of SQL, I wanted to apply what I had learned to a real dataset and answer practical questions about the **Data Analyst job market**.

The project explores salary trends, skill demand, and the relationship between technical skills and compensation.

Rather than only practicing individual SQL commands, the goal was to understand how SQL can be used to:

- Work with a large dataset
- Connect information stored across multiple tables
- Filter and organize data
- Calculate meaningful statistics
- Answer real-world business and career questions
- Communicate findings clearly

The project is built around five questions:

1. What are the top-paying Data Analyst jobs?
2. What skills are required for the top-paying Data Analyst jobs?
3. What are the most in-demand skills for Data Analysts?
4. Which skills are associated with the highest salaries?
5. Which skills provide the best combination of demand and salary?

---

## Background

When I first started learning SQL, I learned concepts such as `SELECT`, `WHERE`, `GROUP BY`, aggregate functions, joins, subqueries, and Common Table Expressions separately.

Understanding those concepts individually was helpful, but this project showed me that the more important skill is knowing **when and why to use them together**.

The dataset stores information across several related tables.

For example, job posting information and company information are stored separately:

```text
job_postings_fact
        ↓
     company_id
        ↓
company_dim
```

Skills are also stored separately from the job postings:

```text
job_postings_fact
        ↓ job_id
skills_job_dim
        ↓ skill_id
skills_dim
```

The `skills_job_dim` table acts as a bridge between job postings and skills.

This project helped me better understand why relational databases separate information into multiple tables and how SQL joins allow that information to be connected again during analysis.

---

## Tools I Used

### SQL

**SQL** was the main language used throughout the project.

I used SQL to:

- Filter job postings with `WHERE`
- Sort results with `ORDER BY`
- Limit results with `LIMIT`
- Connect related tables with `JOIN`
- Count demand with `COUNT()`
- Calculate average salaries with `AVG()`
- Organize grouped data with `GROUP BY`
- Filter grouped results with `HAVING`
- Build reusable query logic with CTEs
- Work with subqueries

### PostgreSQL

**PostgreSQL** was used as the relational database management system.

It allowed me to store the dataset and run SQL queries against the job posting data.

### Visual Studio Code

**Visual Studio Code** was used to write, organize, and execute the SQL files.

Each analysis question was separated into its own SQL file so the project remained organized and easy to follow.

### Git

**Git** was used for version control.

This project gave me hands-on experience with:

- Tracking file changes
- Staging changes
- Creating commits
- Understanding local repositories
- Connecting a local repository to GitHub
- Pushing commits to a remote repository

### GitHub

**GitHub** was used to publish and document the project.

It allows the SQL queries, project structure, and analysis to be presented in one place.

---

# The Analysis

## 1. Top-Paying Data Analyst Jobs

📄 [View Query 1](/project_sql/1_top_paying_jobs.sql)

### Question

**What are the top-paying Data Analyst jobs?**

The first analysis identifies the **top 10 highest-paying remote Data Analyst roles** with available yearly salary information.

The query focuses on:

- `Data Analyst` roles
- Remote positions
- Jobs with known yearly salaries

The main filters include:

```sql
job_title_short = 'Data Analyst'
AND job_work_from_home = TRUE
AND salary_year_avg IS NOT NULL
```

The results are ranked from highest salary to lowest using:

```sql
ORDER BY salary_year_avg DESC
```

and limited to the top 10 positions using:

```sql
LIMIT 10
```

### Why This Analysis Matters

This analysis provides a starting point for understanding the upper end of the Data Analyst job market.

It helps identify the types of positions, companies, and salary levels associated with some of the highest-paying remote Data Analyst opportunities.

---

## 2. Skills Required for Top-Paying Data Analyst Jobs

📄 [View Query 2](/project_sql/2_top_paying_job_skills.sql)

### Question

**What skills are required for the top-paying Data Analyst jobs?**

The second analysis builds directly on Query 1.

A Common Table Expression is used to temporarily store the top 10 highest-paying remote Data Analyst jobs:

```sql
WITH top_paying_jobs AS (
    ...
)
```

Those jobs are then connected to their required skills.

The relationship between the tables is:

```text
top_paying_jobs
        ↓ job_id
skills_job_dim
        ↓ skill_id
skills_dim
```

The first join uses `job_id` to find the skills attached to each job.

The second join uses `skill_id` to translate those IDs into readable skill names.

### Why This Analysis Matters

A high salary alone does not explain what a candidate needs to know.

This analysis connects high-paying jobs to the technical skills required for those positions, making it easier to understand which skills may help someone qualify for higher-paying Data Analyst opportunities.

---

## 3. Most In-Demand Skills for Data Analysts

📄 [View Query 3](/project_sql/3_top_demanded_skills.sql)

### Question

**What are the most in-demand skills for Data Analysts?**

The third analysis focuses on market demand.

After connecting Data Analyst job postings to their required skills, the query counts how often each skill appears.

The main calculation is:

```sql
COUNT(*) AS skill_count
```

The results are then grouped by skill:

```sql
GROUP BY skills
```

and ranked from highest demand to lowest:

```sql
ORDER BY skill_count DESC
```

The analysis returns the **top five most frequently requested skills**.

### Understanding Demand

In this project, demand is measured by how frequently a skill appears across Data Analyst job postings.

For example, if `SQL` appears in more postings than `Python`, then SQL has a higher demand count within this dataset.

This query helps identify the skills that employers request most often.

---

## 4. Top-Paying Skills for Data Analysts

📄 [View Query 4](/project_sql/4_top_paying_skills.sql)

### Question

**What are the top skills based on salary?**

Question 4 looks at skills from a compensation perspective.

Instead of counting how often a skill appears, this query calculates the average yearly salary associated with each skill.

The main calculation is:

```sql
ROUND(AVG(salary_year_avg), 0) AS avg_salary
```

Jobs without salary information are excluded:

```sql
salary_year_avg IS NOT NULL
```

The results are grouped by skill and ranked from highest average salary to lowest.

### Why Average Salary Is Useful

A skill may not be the most frequently requested skill but could still be associated with higher-paying positions.

This analysis helps separate:

- **Skill popularity**
- **Skill earning potential**

That provides a different perspective from the demand analysis in Query 3.

---

## 5. Most Optimal Skills to Learn

📄 [View Query 5](/project_sql/5_optimal_skills.sql)

### Question

**What are the most optimal skills to learn?**

The final analysis combines the two major ideas from the previous queries:

- **Demand**
- **Average salary**

For each skill, the query calculates:

```sql
COUNT(*) AS demand_count
```

and:

```sql
ROUND(AVG(salary_year_avg), 0) AS avg_salary
```

The analysis focuses on:

- `Data Analyst` roles
- Remote jobs
- Jobs with known yearly salaries

A minimum demand threshold can also be applied using `HAVING`.

For example:

```sql
HAVING COUNT(*) > 10
```

This helps prevent a skill from appearing highly ranked simply because a very small number of jobs happen to offer unusually high salaries.

### Why This Analysis Matters

The highest-paying skill is not automatically the best skill to learn.

The most frequently requested skill is also not automatically the best skill to learn.

A more useful question is:

> **Which skills offer a strong balance between market demand and earning potential?**

This final analysis brings both factors together.

---

# What I Learned

This project was especially meaningful to me because it was my **first time applying the SQL concepts I had been learning to a complete data analysis project**.

At the beginning, I understood individual SQL commands, but I still had to think carefully about how different parts of a query connected.

One of the biggest improvements in my understanding came from working with joins.

Before this project, I understood the basic idea of a `JOIN`, but working with the dataset helped me understand **why joins are necessary**.

For example, when the company name was not stored inside `job_postings_fact`, I had to connect that table to `company_dim` using `company_id`.

When skill information was stored separately, I had to understand how `skills_job_dim` acted as a bridge between jobs and skills.

I also became much more comfortable with `GROUP BY`.

Instead of only thinking about the syntax, I started understanding it as:

> Put similar values together so I can calculate something about each group.

The difference between `WHERE` and `HAVING` also became much clearer.

I learned that:

- `WHERE` filters individual rows before grouping
- `HAVING` filters grouped results after aggregate calculations have been created

Another major lesson was learning how to break larger questions into smaller steps.

Instead of immediately trying to write one large query, I started asking:

- What am I trying to find?
- Which table contains that information?
- Do I need another table?
- Which IDs connect those tables?
- What rows should I filter?
- Do I need to group the data?
- Am I calculating a count, average, or another aggregate?
- How should the final result be ranked?

That thinking process made SQL much easier to understand.

I also gained practical experience using **Git and GitHub**.

I learned that writing the SQL is only one part of building a project. Organizing files, staging changes, creating commits, pushing work to GitHub, and documenting the project are also important parts of the development process.

Most importantly, this project helped SQL feel less like a list of commands I needed to memorize and more like a tool for answering questions with data.

---

# Conclusion

Completing this project gave me a much better understanding of what working with SQL actually looks like.

Before starting the project, most of my experience came from learning one concept at a time.

I practiced filtering, joins, aggregate functions, CTEs, subqueries, grouping, and other SQL concepts individually.

This project forced me to bring those concepts together.

There were several moments where I knew what I wanted SQL to do but was not immediately sure how to write it.

Working through those problems helped me understand that becoming better at SQL is not only about memorizing syntax.

It is about learning how to break a question down logically and understand how the data is structured.

I also became more comfortable making mistakes and debugging queries.

Errors involving joins, aliases, grouping, or query order became opportunities to better understand why SQL behaves the way it does.

By the end of the project, I felt much more comfortable approaching a question with this process:

```text
What data do I need?
        ↓
Where is it stored?
        ↓
How do I connect it?
        ↓
How should I analyze it?
        ↓
What does the result tell me?
```

This project represents my starting point with SQL and gave me a strong foundation that I can continue building on through more advanced data analysis projects.