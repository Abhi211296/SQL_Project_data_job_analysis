select 
      c.name,
      salary_year_avg,
      case
          when salary_year_avg  >= 100000 then 'High'
          when salary_year_avg < 100000 and salary_year_avg >= 60000 then 'Standard'
          else 'low'
     end as salary_grade
from job_postings_fact as j
join company_dim as c on c.company_id = j.company_id
where job_title_short = 'Data Analyst' and 
       salary_year_avg is not null
order by salary_grade asc;

/* see the list of companies with highest salary
along with salary grade */ 

