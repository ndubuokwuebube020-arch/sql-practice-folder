select DISTINCT 
  jobs.job_title_short as job_roles,
  skills.skills as required_skills,
  count(skills.skills) as count_skills
from 
  job_postings_fact as jobs
left join 
  skills_job_dim as skills_id
  on skills_id.job_id = jobs.job_id
left join 
  skills_dim as skills
  on skills.skill_id = skills_id.skill_id
where 
  jobs.job_title_short = 'Data Analyst' 
group by 
  job_roles,required_skills
order by  
  count_skills desc
limit 10;



/*
## Project overview

I analyzed job posting data to find the skills most frequently listed
for Data Analyst roles.

## Method

I joined the job postings table to the job skills and skills tables.
I filtered the results for Data Analyst roles, grouped the postings
by skill, and sorted the skills from most to least frequent.

## Top 10 skills

| Rank | Skill      | Count  |
|-----:|------------|-------:|
| 1    | SQL        | 92,628 |
| 2    | Excel      | 67,031 |
| 3    | Python     | 57,326 |
| 4    | Tableau    | 46,554 |
| 5    | Power BI   | 39,468 |
| 6    | R          | 30,075 |
| 7    | SAS        | 28,068 |
| 8    | PowerPoint | 13,848 |
| 9    | Word       | 13,591 |
| 10   | SAP        | 11,297 |

## Key findings

- SQL appears most frequently, followed by Excel and Python.
- Tableau and Power BI are also common, showing the importance of
  data visualization and reporting.
- R and SAS appear often, while PowerPoint and Word suggest that
  presenting findings is part of the work.

## Conclusion

The results suggest that people preparing for Data Analyst roles
should prioritize SQL and Excel, then build skills in Python and a
visualization tool such as Tableau or Power BI.

These counts reflect skill mentions in this dataset. They do not
measure skill proficiency or mean that every Data Analyst role
requires every skill.
```

[
  {
    "job_roles": "Data Analyst",
    "required_skills": "sql",
    "count_skills": "92628"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "excel",
    "count_skills": "67031"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "python",
    "count_skills": "57326"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "tableau",
    "count_skills": "46554"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "power bi",
    "count_skills": "39468"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "r",
    "count_skills": "30075"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sas",
    "count_skills": "28068"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "powerpoint",
    "count_skills": "13848"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "word",
    "count_skills": "13591"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sap",
    "count_skills": "11297"
  }
]