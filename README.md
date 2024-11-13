# Job-Data-Analysis
The goal is to analyze the data and identify the most perfect job to apply for and the skills needed.

# Introduction
This project dives into the data job market, focusing on data analyst roles. It explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

# The Questions I Used
The following are the questions I had to find answers for:
- 1_High_jobs_on_demand
- 2_op Paying Data Analyst Jobs
- 3_The_months_when_the_most_data_analysis_jobs_are_posted
- 4_Top_paying_companies_for_the_highly-demanded_job_for_remote_work._and_require_no_degree
- 5_high_demand_and__high-paying_jobs

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** A database management system that is ideal for handling the job posting data.
- **Visual Studio Code:** My go-t for database management and executing SQL queries.  

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Jobs on Demand
To identify the top roles on demand, I counted the number of jobs posted.

``` sql
SELECT 
    job_title_short,
    COUNT (job_title_short) AS Number_of_jobs
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY Number_of_jobs DESC
LIMIT 10;
```
I then exported the data to MS excel, which I used to plot the graph. The following is the graph and the table we developed.

Table:

![Screenshot of the high jobs on demand](https://github.com/user-attachments/assets/7aada320-b7cf-4927-86ff-79cc2e45eec1)

Graph:

![Screenshot of graph showing highest paying jobs](https://github.com/user-attachments/assets/e677611f-0a7e-4ff6-b136-bb574d1fe521)


According the table and graph, the data analyst role is the highest on demand.

### 2. Top Paying Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.
``` sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.
    company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

When I exported this result to MS Excel, I obtained these results.


These results show that the data analyst role is the highest paying remote job.

### 3. The Months With the Most Postings of the Data Analysis Jobs
To solve this, I extracted job posting months, mapped numbers to month names, counted postings per month, and ranked by count.

``` sql
WITH Date_Months AS
(
    SELECT 
        EXTRACT(MONTH FROM job_posted_date) AS Month_Number
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
)

SELECT 
    CASE 
        WHEN Month_Number = 1 THEN 'January'
        WHEN Month_Number = 2 THEN 'February'
        WHEN Month_Number = 3 THEN 'March'
        WHEN Month_Number = 4 THEN 'April'
        WHEN Month_Number = 5 THEN 'May'
        WHEN Month_Number = 6 THEN 'June'
        WHEN Month_Number = 7 THEN 'July'
        WHEN Month_Number = 8 THEN 'August'
        WHEN Month_Number = 9 THEN 'September'
        WHEN Month_Number = 10 THEN 'October'
        WHEN Month_Number = 11 THEN 'November'
        WHEN Month_Number = 12 THEN 'December'
    END AS Month_Name,
    COUNT(Month_Number) AS Number_of_postings,
    RANK() OVER (ORDER BY COUNT(Month_Number) DESC) AS Rank
FROM Date_Months
GROUP BY Month_Number
ORDER BY Month_Number;
```
The following are the results I obtained.


Basing on the fact that the data analyst role is the highest on demand and highest paying, the results above show the months in which this role is posted the most. This means that the best moth to apply is January and the least is May.

### 4. High Demand and High-Paying Data Analyst Jobs
To solve this query, I identified key columns to retrieve skill demand and average salary for remote Data Analyst roles. I used inner joins across tables, applied filters, grouped by skill ID, and ordered results for top-demand skills.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
These are the results I obtained.


This table shows the highest paying and most needed skills for the data analyst job. These are the skills you need to put much emphasis on while learning.

### 5. Top Paying Companies for Data Analyst Role (Top Paying and Highest on Demand)
To solve this query, I joined job postings with company details, filtered for remote Data Analyst roles with specific conditions (salary provided, no degree required, "Anywhere" location), and ordered results by salary in descending order, limiting to ten entries.

```sql
SELECT 
    cd.name AS company_name,
    jp.salary_year_avg,
    jp.job_location,
    jp.job_work_from_home,
    jp.job_no_degree_mention
FROM job_postings_fact AS jp
LEFT JOIN company_dim AS cd
    ON cd.company_id = jp.company_id

WHERE jp.salary_year_avg IS NOT NULL 
    AND jp.job_work_from_home IS NOT FALSE 
    AND jp.job_title_short = 'Data Analyst'
    AND jp.job_location = 'Anywhere'
    AND jp.job_no_degree_mention IS TRUE
ORDER BY jp.salary_year_avg DESC
LIMIT 10;
```
The following are the results I obtained.


Lastly, the companies shown above are those that pay the highest. They are the ones you should look out for.


# What I Learned


# Conclusions
