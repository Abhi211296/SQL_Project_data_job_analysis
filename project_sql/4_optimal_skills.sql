
SELECT * from 
(
     select 
       

        s.skills,
        count(sj.job_id) 
          over (partition by s.skill_id)
               as total_jobs,
         round(j.salary_year_avg,0) AS max_salary,
         c.name as company_name,
          j.job_id
    from skills_dim as s
    JOIN skills_job_dim as sj On s.skill_id = sj.skill_id
    JOIN job_postings_fact as j on j.job_id = sj.job_id
    join company_dim as c on c.company_id = j.company_id
    where job_title_short = 'Data Analyst' and 
          j.salary_year_avg is not NULL
    order by s.skill_id, max_salary DESC 
) as result
order by max_salary desc;


/*
Top in-demand skills based on the number of job openings,
along with the maximum salary for each skill,
the corresponding job ID, and company name.
*/

