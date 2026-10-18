
   select 
         s.skills,
         count(sj.job_id) as total_jobs
    from skills_dim as s
    inner JOIN skills_job_dim as sj On s.skill_id = sj.skill_id
    inner JOIN job_postings_fact as j on j.job_id = sj.job_id
    where job_title_short = 'Data Analyst'
    group by s.skills , sj.skill_id
    order by  total_jobs DESC
    limit 5;  