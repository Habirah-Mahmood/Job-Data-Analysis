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
