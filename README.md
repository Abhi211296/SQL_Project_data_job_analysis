# Introduction
## Project Introduction

This project provides valuable insights into the data job market by analyzing and combining data from multiple tables. It explores the highest-paying data analyst jobs, top-paying skills, most in-demand skills, and the relationship between skill demand and salary.

By identifying skills that are both highly demanded and well-compensated, this project helps uncover valuable career opportunities and provides a clearer understanding of which technical skills can improve career prospects in the data analytics field.

The analysis uses SQL to explore job postings, salary information, companies, and associated skills, transforming raw data into meaningful insights to support informed career decisions.

Check SQL queries here [project_sql folder](/project_sql/ )

# Background
### The questions I wanted to answer through my sql queries were:

1. What are the top paying Data Analyst jobs salaries and associated companies?
2. What skills are required for this top paying jobs?
3. What skills are most in demand for data Analysts?
4. what are the most optimal skills to learn, which has more demand and higher salaries?

# Tools & Technologies Used

- **SQL** – Used to query, analyze, and extract insights from the database.
- **PostgreSQL** – Database management system used to store and manage the data.
- **Visual Studio Code (VS Code)** – Used for database management and executing SQL queries.
- **Git & GitHub** – Used for version control, tracking changes, and sharing SQL scripts and project analysis.

# The Analysis

This section outlines the approach, SQL queries, and analytical methods used to answer each business question and uncover meaningful insights from the data.

### 1. Top-Paying Companies for Data Analyst Roles

To identify the top-paying companies, I first filtered the job postings for remote Data Analyst positions with non-null salary information. I then joined the job postings table with the company dimension table to retrieve the associated company names and identify the companies offering the highest salaries.
```sql
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
```
![Top Paying Roles](assets/Top_10_Highest-Paying_Companies.png)
*Bar graph visualizing the top 10 highest-paying Data Analyst jobs by company. This graph was generated using ChatGPT.*

Key insights:
- Mantys offers the highest listed average salary at $650,000.
- Meta ranks second at $336,500.
- SmartAsset appears twice with different salary records.
- All salaries are annual averages in USD.


### 2. Top-Paying Skills for Data Analysts

To identify the highest-paying skills for Data Analysts, we first filter remote Data Analyst job postings with available salary information and sort them by annual salary in descending order to identify the top highest-paying jobs. 

Next, we use CTEs to organize the query and connect the selected job postings with their associated skills through the `skills_job_dim` and `skills_dim` tables. We also connect the company table to retrieve company names.

Since each skill can be associated with multiple job postings and salaries, we use `DISTINCT ON` combined with `ORDER BY` to select the highest-paying job for each skill. Finally, we sort the results by maximum salary in descending order and return the top 20 highest-paying skills.

```sql
WITH top_salaries AS
(
    SELECT
        job_id,
        company_id,
        ROUND(salary_year_avg, 0) AS salary_year_avg
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
),
skill_salaries AS
(
    SELECT DISTINCT ON (s.skill_id)
        s.skill_id,
        s.skills,
        ts.salary_year_avg AS max_salary,
        ts.job_id,
        c.name AS company_name
    FROM skills_dim AS s
    JOIN skills_job_dim AS sj
        ON sj.skill_id = s.skill_id
    JOIN top_salaries AS ts
        ON ts.job_id = sj.job_id
    JOIN company_dim AS c
        ON c.company_id = ts.company_id
    ORDER BY s.skill_id, ts.salary_year_avg DESC
)
SELECT *
FROM skill_salaries
ORDER BY max_salary DESC
limit 20;
```
![Top Paying skills](assets/Top%2020%20Highest-Paying%20Data%20Analyst%20Skills.png)
*These are maximum salaries associated with skills, not average salaries or typical market salaries.*

Key insight: The highest salary is $255,830, associated with 13 skills from an AT&T job posting.

### 3. Most Demanded Skills for Data Analysts

This query identifies the top 10 most demanded skills for Data Analyst positions by counting how many job postings mention each skill. It joins the skills, job skills, and job postings tables, filters for Data Analyst roles, groups the results by skill, and sorts them in descending order of job count.



```sql
   select distinct(s.skills),
         count(sj.job_id) as total_jobs
    from skills_dim as s
    inner JOIN skills_job_dim as sj On s.skill_id = sj.skill_id
    inner JOIN job_postings_fact as j on j.job_id = sj.job_id
    where job_title_short = 'Data Analyst'
    group by s.skills , sj.skill_id
    order by  total_jobs DESC 
    limit 10;  
```

| Rank | Skill      | Total Jobs |
| ---- | ---------- | ---------- |
| 1    | SQL        | 92,628     |
| 2    | Excel      | 67,031     |
| 3    | Python     | 57,326     |
| 4    | Tableau    | 46,554     |
| 5    | Power BI   | 39,468     |
| 6    | R          | 30,075     |
| 7    | SAS        | 14,034     |
| 8    | PowerPoint | 13,848     |
| 9    | Word       | 13,591     |
| 10   | SAP        | 11,297     |

The goal is to identify which skills are most frequently requested by employers in Data Analyst job postings.

### 4. The most optimal skills to learn, which has more demand and higher salaries
To identify the most optimal skills for Data Analysts, we consider both average salaries and job demand. First, we filter the job postings to include only Data Analyst roles with available salary information. Then, we join the relevant tables to get the associated skills, calculate the number of job postings and average salary for each skill, and filter out skills appearing in fewer than 100 job postings. Finally, we sort the results by average salary in descending order to identify skills that offer a good balance of higher salaries and job opportunities.


```sql
     select  

     s.skills,
     count(distinct sj.job_id) as total_jobs,
     ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    from skills_dim as s
    JOIN skills_job_dim as sj On s.skill_id = sj.skill_id
    JOIN job_postings_fact as j on j.job_id = sj.job_id

    where 
          job_title_short = 'Data Analyst' and 
          j.salary_year_avg is not NULL  
     Group BY s.skills
     HAVING   
         count(sj.job_id) >= 100

    
     ORDER BY avg_salary DESC;
```


| No. | Skill       | Total Jobs | Average Salary ($) |
| --- | ----------- | ---------- | ------------------ |
| 1   | Spark       | 187        | 113,002            |
| 2   | Databricks  | 102        | 112,881            |
| 3   | Snowflake   | 241        | 111,578            |
| 4   | Hadoop      | 140        | 110,888            |
| 5   | NoSQL       | 108        | 108,331            |
| 6   | Jira        | 145        | 107,931            |
| 7   | AWS         | 291        | 106,440            |
| 8   | Alteryx     | 124        | 105,580            |
| 9   | Azure       | 319        | 105,400            |
| 10  | Looker      | 260        | 103,855            |
| 11  | Python      | 1,840      | 101,512            |
| 12  | Oracle      | 332        | 100,964            |
| 13  | Qlik        | 100        | 100,933            |
| 14  | Java        | 135        | 100,214            |
| 15  | R           | 1,073      | 98,708             |
| 16  | Flow        | 271        | 98,020             |
| 17  | Tableau     | 1,659      | 97,978             |
| 18  | Go          | 288        | 97,267             |
| 19  | SSIS        | 102        | 97,235             |
| 20  | SQL         | 3,083      | 96,435             |
| 21  | SQL Server  | 336        | 96,191             |
| 22  | VBA         | 185        | 93,845             |
| 23  | SAS         | 500        | 93,707             |
| 24  | SAP         | 183        | 92,446             |
| 25  | Power BI    | 1,044      | 92,324             |
| 26  | JavaScript  | 153        | 91,805             |
| 27  | SSRS        | 129        | 91,537             |
| 28  | SharePoint  | 174        | 89,027             |
| 29  | PowerPoint  | 524        | 88,316             |
| 30  | Excel       | 2,143      | 86,419             |

By comparing both demand and salary, this analysis helps prioritize skills that offer a strong balance between job opportunities and earning potential, rather than focusing only on popularity or salary.


# Conclusion 

Through this SQL project, I analyzed Data Analyst job postings, salary information, companies, and associated skills to understand the current data job market. By answering the four key questions, I gained the following insights:

1. Top-Paying Companies for Data Analyst Roles
The analysis identified companies offering the highest salaries for remote Data Analyst positions. Mantys ranked first with an average annual salary of $650,000, followed by Meta at $336,500. This highlights the significant salary differences across companies and the earning potential available in remote Data Analyst roles.

2. Top-Paying Skills for Data Analysts
The analysis revealed that certain specialized technical skills are associated with significantly higher salaries. The highest salary identified was $255,830, associated with 13 skills in an AT&T job posting. This demonstrates the potential value of developing specialized technical skills to access higher-paying opportunities.

3. Most Demanded Skills for Data Analysts
SQL, Excel, Python, Tableau, and Power BI emerged as the most frequently requested skills in Data Analyst job postings. SQL ranked first with 92,628 job postings, followed by Excel with 67,031 and Python with 57,326. This highlights the importance of building a strong foundation in SQL, spreadsheets, programming, and data visualization tools.

4. Most Optimal Skills to Learn
By comparing average salaries and job demand, the analysis identified Spark, Databricks, Snowflake, AWS, and Azure among the higher-paying skills with at least 100 associated job postings. Python, SQL, Tableau, and Power BI also demonstrated strong demand alongside competitive average salaries. This provides a useful perspective on prioritizing skills based on both earning potential and employment opportunities.
