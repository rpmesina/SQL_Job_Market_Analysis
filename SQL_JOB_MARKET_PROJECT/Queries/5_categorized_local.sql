WITH skill_base AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        job_postings_fact.salary_year_avg
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
      AND job_postings_fact.job_location = 'Philippines'
      OR job_postings_fact.salary_year_avg IS NOT NULL
),
skill_stats AS (
    SELECT
        skill_id,
        skills,
        COUNT(*) AS demand_count,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM skill_base
    GROUP BY skill_id, skills
),
thresholds AS (
    SELECT
        AVG(demand_count) AS avg_demand,
        AVG(avg_salary) AS avg_salary
    FROM skill_stats
)
SELECT
    skill_stats.skills,
    skill_stats.demand_count,
    skill_stats.avg_salary,
    CASE
        WHEN skill_stats.demand_count >= thresholds.avg_demand
         AND skill_stats.avg_salary >= thresholds.avg_salary
            THEN 'Strategic'
        WHEN skill_stats.demand_count >= thresholds.avg_demand
         AND skill_stats.avg_salary < thresholds.avg_salary
            THEN 'Commodity'
        WHEN skill_stats.demand_count < thresholds.avg_demand
         AND skill_stats.avg_salary >= thresholds.avg_salary
            THEN 'Specialized'
        ELSE 'Low Priority'
    END AS skill_category
FROM skill_stats
CROSS JOIN thresholds
WHERE skill_stats.demand_count > 5
ORDER BY
        skill_stats.avg_salary DESC,
     skill_stats.demand_count DESC;
