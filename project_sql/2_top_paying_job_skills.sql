with top_salaries AS
( 
     select  
           job_id,
           company_id,
           round(salary_year_avg, 0) as salary_year_avg
     From job_postings_fact as j
     WHERE job_title_short = 'Data Analyst' 
       and salary_year_avg is not NULL 
       and job_work_from_home = TRUE
     order by salary_year_avg desc
     limit 10
)
select distinct on (s.skill_id)
      s.skills,
     Max(ts.salary_year_avg) over (PARTITION BY s.skill_id) as max_salary,
     ts.job_id,
     c.name
      
FROM skills_dim as s 
JOIN skills_job_dim as sj
            ON sj.skill_id = s.skill_id 
JOIN top_salaries as ts
            on ts.job_id  = sj.job_id
join company_dim as c
            on c.company_id = ts.company_id

ORDER BY s.skill_id,  max_salary DESC;
 
 /*  top salaries by skills for Data Analyst,
 remote position and their job id and company_name */
    