  select  
       q1_job_posted.salary_year_avg,  
       q1_job_posted.job_location,
       q1_job_posted.job_via,
       q1_job_posted.job_posted_date:: Date

  from 
        ( select *
         from job_posted_january
         UNION 
         select *
         from job_posted_february
         UNION 
         SELECT *
         from job_posted_march 
         )
         as q1_job_posted
         WHERE salary_year_avg > 70000 and salary_year_avg IS NOT NULL and job_title_short = 'Data Analyst'
         order by salary_year_avg desc;