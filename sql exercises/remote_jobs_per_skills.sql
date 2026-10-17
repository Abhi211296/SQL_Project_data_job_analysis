 with remote_job_skills as (
   select 
      sjd.skill_id,
      count(*) as skills_count
    from skills_job_dim as sjd
    INNER JOIN job_postings_fact as j
            on sjd.job_id = j.job_id
     where job_work_from_home = TRUE and job_title_short = 'Data Analyst'
    group by sjd.skill_id
 )
 select 
      s.skills,
      skills_count
 from skills_dim as s INNER JOIN remote_job_skills as rj
      on s.skill_id = rj.skill_id

order by skills_count desc
limit 5;

-- this is top 5 skills based on job postings for Data Analyst.