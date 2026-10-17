select 
       job_title_short as title,
       job_location as location,
       job_posted_date :: DATE as date 
from 
      job_postings_fact;
