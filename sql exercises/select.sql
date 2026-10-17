select 
     job_schedule_type,
      avg(salary_hour_avg) as salary_hour_avg,
      avg(salary_year_avg) as salary_year_avg,
      job_posted_date :: Date
    
from job_postings_fact
where job_posted_date > '2023-06-02'
group by job_schedule_type, job_posted_date
order by job_posted_date
;
