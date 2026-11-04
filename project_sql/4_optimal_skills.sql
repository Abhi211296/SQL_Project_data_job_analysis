
     select  

     s.skills,
     count(distinct sj.job_id) as total_jobs,
     ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    from skills_dim as s
    JOIN skills_job_dim as sj On s.skill_id = sj.skill_id
    JOIN job_postings_fact as j on j.job_id = sj.job_id

    where 
          job_title_short = 'Data Analyst' and 
          j.salary_year_avg is not NULL  
     Group BY s.skills
     HAVING   
         count(sj.job_id) >= 100

    
     ORDER BY avg_salary DESC;


/*
Top in-demand skills based on the number of job openings(above 200) along with the maximum average salary for each skill.
*/

