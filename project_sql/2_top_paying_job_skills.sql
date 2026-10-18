with top_paying_jobs AS
(
     select  
            job_id,
            salary_year_avg
     From job_postings_fact as j
     WHERE job_title_short = 'Data Analyst' 
       and salary_year_avg is not NULL 
       and job_work_from_home = TRUE
    order by salary_year_avg desc
   
)
select 
      t.*,
      s.skills
FROM top_paying_jobs as t
inner JOIN skills_job_dim as sd
            ON t.job_id = sd.job_id 
INNER JOIN skills_dim as s
        on sd.skill_id = s.skill_id

 limit 10;

 -- top skills for the Data Analyst remote position ,which paying highest salary.