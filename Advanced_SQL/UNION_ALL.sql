SELECT
    quarter_1_job_postings.job_title_short,
    quarter_1_job_postings.job_location,
    quarter_1_job_postings.job_via,
    quarter_1_job_postings.job_posted_date::DATE,
    quarter_1_job_postings.salary_year_avg
FROM (
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs
) AS quarter_1_job_postings
WHERE
    quarter_1_job_postings.salary_year_avg > 70000 AND
    quarter_1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter_1_job_postings.salary_year_avg DESC