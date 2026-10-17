select 
     count(job_id),
     case 
         when job_location = 'Anywhere' then 'Remote'
         when job_location = 'New York, NY' then 'Local'
         else 'Onsite'
     end as location_category 

from job_postings_fact
where job_title_short = 'Data Analyst'
group by location_category;

/* This SQL query counts the number of job 
postings for the title 'Data Analyst' and 
categorizes them based on their job location. 
The locations are grouped into three categories: 
'Remote' for jobs that can be done from anywhere,
 'Local' for jobs located in New York, NY, and 
 'Onsite' for all other locations. 
 The results are grouped by these location 
 categories, providing a count of job postings
 