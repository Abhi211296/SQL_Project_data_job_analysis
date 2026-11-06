WITH top_salaries AS
(
    SELECT
        job_id,
        company_id,
        ROUND(salary_year_avg, 0) AS salary_year_avg
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
),
skill_salaries AS
(
    SELECT DISTINCT ON (s.skill_id)
        s.skill_id,
        s.skills,
        ts.salary_year_avg AS max_salary,
        ts.job_id,
        c.name AS company_name
    FROM skills_dim AS s
    JOIN skills_job_dim AS sj
        ON sj.skill_id = s.skill_id
    JOIN top_salaries AS ts
        ON ts.job_id = sj.job_id
    JOIN company_dim AS c
        ON c.company_id = ts.company_id
    ORDER BY s.skill_id, ts.salary_year_avg DESC
)
SELECT *
FROM skill_salaries
ORDER BY max_salary DESC
limit 20;
 
 /*  top salaries by skills for Data Analyst,
 remote position and their job id and company_name */
    