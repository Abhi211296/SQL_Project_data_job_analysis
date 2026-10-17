/* Find the companies that have the most job openings.
- get the total number of job postings per company id 
- return the total number of jobs with the company name
*/

select 
      c.name,
      count(j.job_id) as number_of_jobs 

from company_dim as c
left join job_postings_fact as j on c.company_id = j.company_id
group by name
order by number_of_jobs DESC;
          