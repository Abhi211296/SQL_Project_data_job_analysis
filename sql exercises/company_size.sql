select 
      c.name,
      CASE
          when count(j.job_id) < 10 then 'Small'
          when count(j.job_id) between 10 and 50 then 'Medium'
          when count(j.job_id) > 50 then 'Large'
      end as company_grade
from company_dim as c
LEFT JOIN job_postings_fact as j
       on c.company_id = j.company_id
group by c.company_id, c.name
order by company_grade;

-- identify company size based on grade which assigned on number of job postings