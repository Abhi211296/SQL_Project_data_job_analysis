SELECT
      COUNT(job_id) as number_of_job,
      EXTRACT(month from job_posted_date at time zone 'UTC') as month
    from job_postings_fact
    where EXTRACT(year from job_posted_date) = 2023
         
    group by month;
