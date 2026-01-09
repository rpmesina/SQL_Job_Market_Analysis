# Data Analyst Skills That Pay: A Demand vs. Salary Analysis of 2023 Job Postings
## Introduction
<p style="text-align: justify;">
Everyone wants a high-paying job in data, but few can pinpoint exactly which skills the market is willing to pay a premium for. Is it Python? SQL? Or a niche combination of both? This analysis moves beyond job titles to look at the "market price" of expertise. Using a SQL-driven framework, we analyzed salary variances across locations and industries to solve a critical problem for the modern professional: How do you strategically choose what to learn next? The results offer a transparent look at the ROI of technical skills, revealing which paths lead to stagnation and which lead to the highest financial returns.
</p>

## Objectives
The objective of this project is to move beyond anecdotal career advice and establish a data-driven framework for navigating the 2023 data analyst job market. By applying statistical aggregation and filtering to real-world job postings and compensation data, this project aims to provide a clear roadmap for career progression and skill acquisition. More importantly, it seeks to answer the following questions:
#### 1. Which data roles offer the highest-paying job opportunities?
This identifies where the strongest compensation exists across data-related roles at both global and local levels.
#### 2. How does Data Analyst compensation differ between global and local markets?
This examines salary distribution, including minimum, average, and maximum earnings, to understand how career progression and earning potential vary by geography.
#### 3. What skills are most frequently required for Data Analyst roles?
This measures job market demand to identify the core technical skills employers consistently expect from Data Analysts in both global and Philippine markets.
#### 4. Which skills are associated with higher average salaries for Data Analysts?
This evaluates salary premiums to determine which technical skills provide stronger compensation leverage beyond basic employability.
#### 5. Which skills should Data Analysts prioritize to maximize both job demand and salary potential?
By combining market demand and average salary, this question identifies high-value skills that offer the best return on investment, distinguishing strategic, specialized, commodity, and low-priority skills.

## Methodology 
This project uses SQL as the primary tool to analyze a large dataset of job postings from 2023 and convert it into clear insights about the data analyst job market. The dataset includes information on job titles, companies, locations, salary data, and required skills.
The analysis was conducted by building structured SQL queries that progressively narrow the data to match the goals of the project. Job postings were first filtered by role and location to allow fair comparisons between global and local markets. Salary data was then aggregated to measure average, minimum, and maximum compensation, providing a clear view of earning potential and career progression.
To understand skill requirements, job postings were linked to their associated skills using relational joins. This made it possible to measure how often specific skills appear in data analyst roles (market demand) and how those skills relate to average salary outcomes (skill value). By combining these two measures, the project evaluates not just which skills are popular, but which ones are most strongly rewarded by the market.
## Tools 
<p style="text-align: justify;">
The primary aim of this project is to create a data-driven framework that connects roles, skills, and salary into a single, coherent view of the data analyst labor market. To do so, we also used the following tools: 
SQL: Served as the primary analytical language. Used extensively for data filtering, aggregation, joins, window functions, CTEs, and derived metrics to uncover salary trends, skill demand, and valuation patterns.
PostgreSQL: Used as the relational database management system to store and manage large-scale job posting data, used for efficient querying, indexing, and schema-based data modeling.
Visual Studio Code: Used as the primary working environment for developing, testing, and organizing SQL queries in a clear and maintainable environment.
Microsoft Excel : Used extensively for data visualization and creation of performance dashboards.
Git & GitHub: Used for version control and documentation to track query iterations. Used as a platform to share output and as an avenue for future collaborations.
</p>

## Analysis
### 1. Highest-Paying Data Roles
We identified the top 10 highest-paying data roles at both global and local levels. We  then filter the results specifically for data analyst positions wherein location and average annual salary are the important key factors for being in the list. 
```
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN  company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
![Alt text](Graphs\1_local.png)

#### Key Insights
- Advanced roles such as Data Scientist and Analytics Engineer dominate the local salary landscape.
- Data analyst compensation increases noticeably with seniority and role scope.
- Contract-based analyst roles show a significant pay trade-off compared to full-time positions.
- Roles combining analytics with engineering or research depth consistently command higher salaries.
<p style="text-align: justify;">
Local market results show a clear salary gap between advanced data roles and traditional analyst positions. Data Scientist ($164,000) and Analytics Engineer ($139,216) roles command the highest average salaries, reflecting strong demand for modeling, engineering, and system-level skills. Among analyst roles, Data Analyst ($111,175) and mid-level Data Analyst ($98,500) positions remain competitive, while contract-based roles average significantly lower pay ($69,900), indicating a trade-off between stability and compensation. Research-focused roles fall in the mid-to-high range, suggesting domain expertise adds value, but the highest salary outcomes consistently align with roles that combine analytics with engineering or specialized technical responsibility.
</p>

![Alt text](1_global.png)

- Global compensation for advanced data roles is an order of magnitude higher than local benchmarks.
- Senior and staff-level Data Scientist roles dominate the top salary tier.
- Executive and research-intensive roles command sustained salary premiums.
- The global market strongly rewards scale, specialization, and leadership.
<p style="text-align: justify;">
Global market results show extreme salary concentration at the senior and executive levels, led by Data Scientist ($960,000) and Senior Data Scientist ($890,000) roles, far exceeding local compensation ceilings. Unlike the local market, where analytics and engineering roles are more evenly distributed, global top-paying positions are heavily skewed toward senior, staff, and leadership roles, including VP Data Science & Research ($463,500) and staff-level research positions. Even general Data Analyst roles reach significantly higher compensation globally ($650,000), highlighting the impact of market scale, company size, and regional pay structures. Overall, the global market places substantially greater monetary value on advanced specialization, organizational influence, and high-impact decision-making compared to the more role-balanced local landscape.
</p>

### 2. Local vs. Global Salary Compensation 
We analyzed salary distribution by computing minimum, maximum, and average earnings to understand market progression from entry-level roles to senior, high-compensation positions.
```
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
```

- The global market offers a higher average salary and wider earning range than the local market.
- Local salaries show a narrower ceiling, limiting upside at senior levels.
- Entry-level compensation is comparable, but career progression diverges sharply.
- Global roles provide significantly greater long-term earning potential.
<p style="text-align: justify;">
Salary aggregation shows a clear divergence in earning trajectories between local and global markets. While entry-level salaries are relatively similar (Global min: $25,000; Local min: $25,920), the average global salary ($93,876) exceeds the local average ($76,374), indicating stronger mid-career compensation abroad. The most pronounced difference appears at the upper end of the market, where the global maximum salary reaches $650,000, compared to a local ceiling of $111,175. This gap suggests that while local markets can support early to mid-level data roles, high-compensation senior and leadership opportunities are disproportionately concentrated in the global market, reinforcing the importance of role scope, market scale, and organizational impact in long-term salary growth.
</p>

### 3. Skills Demand
We constructed a relational data model linking job titles, companies, and required skills. Roles were then ranked in terms of skills demand (demand_count) to reveal which industries and organizations place the highest monetary value on advanced analytical skill sets.
```
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
#### Key Insights
- SQL and Excel form the foundational skill set across both global and local markets.
- The global market shows stronger demand for programming and visualization tools.
- The local market places relatively higher emphasis on spreadsheet and BI tools.
- Skill demand patterns are consistent, but depth and scale differ by market.
<p style="text-align: justify;">
The market penetration analysis highlights a stable core skill set for data analyst roles across regions. Globally, SQL (92,628) and Excel (67,031) dominate demand, followed by Python (57,326) and visualization tools such as Tableau (46,554) and Power BI (39,468), reflecting the need for scalable querying, automation, and data storytelling. In the local market, Excel (325) and SQL (275) remain the most frequently required skills, but demand is more evenly distributed among Tableau, Power BI, and Python, indicating a stronger focus on reporting and dashboard-driven analysis. Overall, while both markets agree on foundational skills, the global market demonstrates greater emphasis on programmatic and scalable analytics, whereas the local market prioritizes accessible, business-facing tools.
</p>

### 4. Skills Compensation 
 Using the same relational data model, we now rank the skills in terms of Skills Compensation (average_yearly_salary) to reveal which industries and organizations place the highest monetary value on advanced analytical skill sets.
```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10; 
```

Here’s the top five skills that provide the strongest salary leverage.
- Globally, specialized and infrastructure-oriented skills command the highest salary premiums.
- High-paying global skills are often low-frequency but high-impact.
- Locally, salary premiums favor analytics platforms and core data tools.
- High demand does not always align with high salary leverage.
<p style="text-align: justify;">
Ranking skills in terms of salary reveals a sharp contrast between global and local skill markets. Globally, the highest salary leverage is associated with highly specialized or infrastructure-adjacent skills, such as SVN ($400,000), Solidity ($179,000), and Couchbase ($160,515), which appear infrequently but are tied to niche, high-impact roles. This indicates that global compensation strongly rewards scarcity and technical specialization. In contrast, the local market’s top-valued skills, including Looker and BigQuery ($111,175) and PostgreSQL, Tableau, GitHub, and Snowflake ($98,500), are more closely aligned with core analytics workflows and enterprise reporting environments. Notably, foundational skills like SQL ($93,192) and Python ($84,200) remain valuable locally but do not command the same premium as specialized tools. Overall, the results show that while global markets reward rare, high-complexity skills, local markets place greater salary value on widely applicable analytics platforms that support business intelligence and decision-making.
</p>

### 5. Skills Priority
To determine the skills that offer the best balance of pay and demand, we integrated market demand (demand_count) and salary impact (average_yearly_salary) into a unified evaluation model. This approach categorizes skills into four distinct groups:
- Strategic (High demand and high pay): skills that are widely required and consistently rewarded, making them the strongest targets for career growth.
- Specialized ( Low demand but high pay ): niche skills that command premium salaries due to scarcity and specialized use cases.
- Commodity (High demand but lower pay): commonly required skills that are essential but offer limited salary differentiation.
- Low Priority (Low demand and low pay): skills with minimal market traction and lower return on investment.
This synthesis removes the bias of high-demand but low-value skills and showcases the technical competencies that deliver the highest objective return on investment.
```
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
```
#### Key Insights
- High-paying skills in both markets are dominated by specialized, low-demand technologies.
- Salary premiums are driven more by scarcity than popularity.
- Local and global markets show strong overlap in specialized skill valuation.
- High demand alone does not guarantee high return on investment.
<p style="text-align: justify;">
The holistic skills framework shows that the highest salary outcomes are consistently driven by specialized skills with low market penetration in both local and global markets. Locally, technologies such as MongoDB, Node.js, Cassandra, and Solidity command average salaries exceeding $150,000 despite relatively limited demand, indicating strong compensation premiums for niche expertise. A similar pattern appears globally, where skills like Debian, Lua, Haskell, and ASP.NET Core achieve comparable salary levels while remaining scarce. Notably, several skills, including MongoDB, dplyr, Node.js, Cassandra, and Solidity, appear in both markets, suggesting globally transferable specialization. Overall, these results confirm that skills positioned in the Specialized quadrant deliver the highest return on investment, reinforcing that salary growth is more strongly influenced by technical scarcity and complexity than by widespread adoption.
</p>


## What I learned
<p style="text-align: justify;">
Through this project, I learned how to build a complete SQL-based data analysis workflow from scratch, starting with creating a local PostgreSQL database, designing structured tables, and importing raw job market data. Using Visual Studio Code, I developed and refined SQL queries for data cleaning, aggregation, multi-table joins, and salary analysis, while applying CTEs and window functions to extract meaningful insights. I also gained hands-on experience troubleshooting data import issues, schema conflicts, and query errors, strengthening my problem-solving and debugging skills. I also learned to showcase my professional project through GitHub and control its version through Git. I also enhanced my data visualization skills using Microsoft Excel. 

This project also strengthened my analytical forecasting abilities by training me to identify patterns, trends, and salary drivers across large job market datasets. I learned how to translate technical findings into practical, industry-relevant insights that support smarter career and business decisions. Through hands-on analysis, I ultimately developed a data-driven problem-solving mindset that makes me capable of approaching real-world challenges with structured reasoning and evidence-based solutions. Overall, this project strengthened my technical foundation in databases, SQL analytics, and data-driven decision-making.
</p>

## Conclusion
<p style="text-align: justify;">
The highest-paying data roles go beyond traditional analyst positions, with Data Scientist, Analytics Engineer, and senior or leadership roles consistently topping compensation tables. Locally, mid-level analyst roles are competitive, but the largest salary gains come from combining analytics with engineering, research, or decision-making responsibilities. Globally, senior and executive roles offer dramatically higher ceilings due to market scale and organizational impact.

Foundational skills like SQL, Excel, Python, and BI tools remain essential for employability, but high salaries are driven by specialized, niche skills with scarcity and technical complexity. The global market especially rewards expertise in advanced or infrastructure-focused tools.

To maximize both employability and salary leverage, analysts should build a strong analytical foundation and layer on specialized, high-value skills. This combination consistently delivers the best return on investment and positions professionals for high-impact, high-compensation roles.

</p>
