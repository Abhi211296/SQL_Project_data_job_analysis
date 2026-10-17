 
select 
       sd.skills,
       count(j.job_id) as number_of_jobs
FROM skills_dim as sd
JOIN skills_job_dim as sjd on sd.skill_id = sjd.skill_id
join job_postings_fact as j on sjd.job_id = j.job_id
group by sd.skills, sd.skill_id
order by number_of_jobs desc;

-- identifying top skills based on number of job postings.