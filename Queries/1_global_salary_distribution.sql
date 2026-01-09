WITH global_data_analyst_jobs AS (
    SELECT
        job_id,
        salary_year_avg
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
)
SELECT
    COUNT(*) AS total_DA_jobs,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary
FROM global_data_analyst_jobs;