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
