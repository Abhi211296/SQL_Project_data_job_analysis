

     select 
            c.name as company_name,
            j.salary_year_avg
     from job_postings_fact as j 
     LEFT JOIN company_dim as c
               ON c.company_id = j.company_id

     WHERE j.job_title_short = 'Data Analyst' 
       and j.salary_year_avg is not NULL 
       and j.job_work_from_home = TRUE
    
     order by j.salary_year_avg desc
     limit 10;
 

 /* top paying Data Analyst jobs by the 
 company names    */