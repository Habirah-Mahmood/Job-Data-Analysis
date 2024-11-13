SELECT 
    job_title_short,
    COUNT (job_title_short) AS Number_of_jobs
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY Number_of_jobs DESC
LIMIT 10;