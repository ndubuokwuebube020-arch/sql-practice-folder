-- First, get the top 10 highest-paying jobs
WITH top_paying_jobs AS (
    SELECT DISTINCT
        job_post.salary_year_avg AS AVG_SAL,
        job_post.job_title AS jobs,
        job_post.JOB_LOCATION AS LOCATION,
        job_post.job_id,
        job_post.job_posted_date,
        job_post.job_schedule_type,
        company.name AS company_name

    FROM job_postings_fact AS job_post

    LEFT JOIN company_dim AS company
        ON company.company_id = job_post.company_id

    WHERE
        job_post.job_title_short = 'Data Analyst'
        AND job_post.job_location = 'Anywhere'
        AND job_post.salary_year_avg IS NOT NULL

    ORDER BY AVG_SAL DESC
)

-- Now attach the skills to those top 10 jobs
SELECT
    jobs_post.AVG_SAL,
    jobs_post.jobs,
    jobs_post.LOCATION,
    jobs_post.job_id,
    jobs_post.job_posted_date,
    jobs_post.job_schedule_type,
    jobs_post.company_name,
    STRING_AGG(DISTINCT skill.skills, ', ') AS skills_required

FROM top_paying_jobs AS jobs_post

LEFT JOIN skills_job_dim AS skill_id
    ON skill_id.job_id = jobs_post.job_id

LEFT JOIN skills_dim AS skill
    ON skill.skill_id = skill_id.skill_id

GROUP BY
    jobs_post.AVG_SAL,
    jobs_post.jobs,
    jobs_post.LOCATION,
    jobs_post.job_id,
    jobs_post.job_posted_date,
    jobs_post.job_schedule_type,
    jobs_post.company_name

ORDER BY jobs_post.AVG_SAL DESC;


/*Skills analysis
The dataset lists skills for 546 of 604 postings; the other 58 (9.6%) have no skills recorded. Counts below are postings that mention each skill, so a job can count toward several skills.
Skill	Postings	Share of all postings
SQL	398	65.9%
Excel	256	42.4%
Python	236	39.1%
Tableau	230	38.1%
R	148	24.5%
Power BI	110	18.2%
SAS	63	10.4%
PowerPoint	58	9.6%
Looker	49	8.1%
Word	48	7.9%


What stands out
- SQL is the clearest core requirement, appearing in about two out of every three postings.
- Excel remains highly relevant despite the emphasis on programming and BI tools.
- Python and Tableau form a strong technical pairing: Python supports data cleaning and analysis, while Tableau supports visualization. Power BI is another useful visualization option, though it appears less often here.
- R is also a meaningful skill, appearing in about one quarter of postings, but less often than Python.
- SAS, Looker, and database or cloud tools such as Snowflake, Oracle, Azure, and AWS appear in fewer postings. They can help differentiate you, especially for roles that use those platforms, but they are less universal in this sample.
- Communication tools show up too: PowerPoint and Word appear in some postings, suggesting that presenting findings and preparing reports can be part of the job.

[
  {
    "avg_sal": "650000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 226942,
    "job_posted_date": "2023-02-20 15:13:33",
    "job_schedule_type": "Full-time",
    "company_name": "Mantys",
    "skills_required": null
  },
  {
    "avg_sal": "336500.0",
    "jobs": "Director of Analytics",
    "location": "Anywhere",
    "job_id": 547382,
    "job_posted_date": "2023-08-23 12:04:42",
    "job_schedule_type": "Full-time",
    "company_name": "Meta",
    "skills_required": null
  },
  {
    "avg_sal": "255829.5",
    "jobs": "Associate Director- Data Insights",
    "location": "Anywhere",
    "job_id": 552322,
    "job_posted_date": "2023-06-18 16:03:12",
    "job_schedule_type": "Full-time",
    "company_name": "AT&T",
    "skills_required": "aws, azure, databricks, excel, jupyter, pandas, power bi, powerpoint, pyspark, python, r, sql, tableau"
  },
  {
    "avg_sal": "232423.0",
    "jobs": "Data Analyst, Marketing",
    "location": "Anywhere",
    "job_id": 99305,
    "job_posted_date": "2023-12-05 20:00:40",
    "job_schedule_type": "Full-time",
    "company_name": "Pinterest Job Advertisements",
    "skills_required": "hadoop, python, r, sql, tableau"
  },
  {
    "avg_sal": "217000.0",
    "jobs": "Data Analyst (Hybrid/Remote)",
    "location": "Anywhere",
    "job_id": 1021647,
    "job_posted_date": "2023-01-17 00:17:23",
    "job_schedule_type": "Full-time",
    "company_name": "Uclahealthcareers",
    "skills_required": "crystal, flow, oracle, sql, tableau"
  },
  {
    "avg_sal": "205000.0",
    "jobs": "Principal Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 168310,
    "job_posted_date": "2023-08-09 11:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "SmartAsset",
    "skills_required": "excel, gitlab, go, numpy, pandas, python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "189309.0",
    "jobs": "Director, Data Analyst - HYBRID",
    "location": "Anywhere",
    "job_id": 731368,
    "job_posted_date": "2023-12-07 15:00:13",
    "job_schedule_type": "Full-time",
    "company_name": "Inclusively",
    "skills_required": "atlassian, aws, azure, bitbucket, confluence, jenkins, jira, oracle, power bi, python, sap, snowflake, sql, tableau"
  },
  {
    "avg_sal": "189000.0",
    "jobs": "Principal Data Analyst, AV Performance Analysis",
    "location": "Anywhere",
    "job_id": 310660,
    "job_posted_date": "2023-01-05 00:00:25",
    "job_schedule_type": "Full-time",
    "company_name": "Motional",
    "skills_required": "atlassian, bitbucket, confluence, git, jira, python, r, sql"
  },
  {
    "avg_sal": "186000.0",
    "jobs": "Principal Data Analyst",
    "location": "Anywhere",
    "job_id": 1749593,
    "job_posted_date": "2023-07-11 16:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "SmartAsset",
    "skills_required": "excel, gitlab, go, numpy, pandas, python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "184000.0",
    "jobs": "ERM Data Analyst",
    "location": "Anywhere",
    "job_id": 387860,
    "job_posted_date": "2023-06-09 08:01:04",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "170000.0",
    "jobs": "Azure Data Python Consultant - contract to HIRE - Citizen or Perm...",
    "location": "Anywhere",
    "job_id": 987523,
    "job_posted_date": "2023-01-23 22:28:01",
    "job_schedule_type": "Contractor",
    "company_name": "Kelly Science, Engineering, Technology & Telecom",
    "skills_required": "azure, databricks, power bi, python, sql"
  },
  {
    "avg_sal": "170000.0",
    "jobs": "DTCC Data Analyst",
    "location": "Anywhere",
    "job_id": 1781684,
    "job_posted_date": "2023-10-06 00:01:41",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "excel, go, java"
  },
  {
    "avg_sal": "170000.0",
    "jobs": "REMOTE Director of Data Analytics",
    "location": "Anywhere",
    "job_id": 1352513,
    "job_posted_date": "2023-08-09 14:02:45",
    "job_schedule_type": "Full-time",
    "company_name": "A-Line Staffing Solutions",
    "skills_required": "azure, python, sql"
  },
  {
    "avg_sal": "167000.0",
    "jobs": "Manager, Data Analyst",
    "location": "Anywhere",
    "job_id": 1525451,
    "job_posted_date": "2023-04-18 07:01:17",
    "job_schedule_type": "Full-time",
    "company_name": "Uber",
    "skills_required": "excel, looker, python, r, sql, swift, tableau"
  },
  {
    "avg_sal": "165000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 712473,
    "job_posted_date": "2023-08-14 16:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, matlab, pandas, python, r, sas, sql, tableau"
  },
  {
    "avg_sal": "165000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1246069,
    "job_posted_date": "2023-12-08 09:16:37",
    "job_schedule_type": "Full-time",
    "company_name": "Plexus Resource Solutions",
    "skills_required": "aws, mysql, python"
  },
  {
    "avg_sal": "164746.0",
    "jobs": "Principal Data Science Analyst- Remote",
    "location": "Anywhere",
    "job_id": 1423236,
    "job_posted_date": "2023-01-13 13:04:39",
    "job_schedule_type": "Full-time",
    "company_name": "Mayo Clinic",
    "skills_required": null
  },
  {
    "avg_sal": "164746.0",
    "jobs": "Principal Data Science Analyst- Remote",
    "location": "Anywhere",
    "job_id": 1799883,
    "job_posted_date": "2023-04-14 12:05:19",
    "job_schedule_type": "Full-time",
    "company_name": "Mayo Clinic",
    "skills_required": null
  },
  {
    "avg_sal": "163500.0",
    "jobs": "Principal Data Intelligence Analyst - Cardiac - Remote",
    "location": "Anywhere",
    "job_id": 618890,
    "job_posted_date": "2023-09-20 13:00:44",
    "job_schedule_type": "Full-time",
    "company_name": "CEDARS-SINAI",
    "skills_required": "crystal, go, sas, tableau"
  },
  {
    "avg_sal": "160515.0",
    "jobs": "Senior - Data Analyst",
    "location": "Anywhere",
    "job_id": 918213,
    "job_posted_date": "2023-06-14 21:01:17",
    "job_schedule_type": "Full-time",
    "company_name": "DIRECTV",
    "skills_required": "airflow, aws, azure, cognos, couchbase, databricks, linux, mysql, oracle, postgresql, pyspark, python, r, redshift, scala, snowflake, sql, ssis, tableau, visio, watson"
  },
  {
    "avg_sal": "160000.0",
    "jobs": "Principal Data Analyst",
    "location": "Anywhere",
    "job_id": 182813,
    "job_posted_date": "2023-10-13 09:00:52",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "azure, power bi, python, r, sas, sql, sql server, ssrs"
  },
  {
    "avg_sal": "160000.0",
    "jobs": "Principal Data Analyst",
    "location": "Anywhere",
    "job_id": 475626,
    "job_posted_date": "2023-02-02 14:16:03",
    "job_schedule_type": "Full-time",
    "company_name": "Realtime Recruitment",
    "skills_required": "looker, power bi, snowflake"
  },
  {
    "avg_sal": "160000.0",
    "jobs": "SQL DEVELOPER / DATA ANALYST (Insurance industry Experience) ...",
    "location": "Anywhere",
    "job_id": 783771,
    "job_posted_date": "2023-01-30 02:02:22",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "java, sql"
  },
  {
    "avg_sal": "157500.0",
    "jobs": "Applied Scientist - Maps",
    "location": "Anywhere",
    "job_id": 266799,
    "job_posted_date": "2023-10-13 07:03:27",
    "job_schedule_type": "Full-time",
    "company_name": "Uber",
    "skills_required": "python, r, spark, sql"
  },
  {
    "avg_sal": "157500.0",
    "jobs": "System Data Analyst",
    "location": "Anywhere",
    "job_id": 485388,
    "job_posted_date": "2023-07-17 18:00:47",
    "job_schedule_type": null,
    "company_name": "Edgewater Federal Solutions, Inc.",
    "skills_required": "go, oracle, sql"
  },
  {
    "avg_sal": "155485.5",
    "jobs": "Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 25761,
    "job_posted_date": "2023-09-01 16:41:57",
    "job_schedule_type": "Full-time",
    "company_name": "CaptivateIQ",
    "skills_required": "datarobot, looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "155000.0",
    "jobs": "Lead Data Analyst",
    "location": "Anywhere",
    "job_id": 105157,
    "job_posted_date": "2023-01-05 08:00:45",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "airflow, c++, hadoop, java, python, redshift, scala, snowflake, spark, sql, tableau"
  },
  {
    "avg_sal": "152625.0",
    "jobs": "Staff Business Data Analyst (Remote U.S. OK)",
    "location": "Anywhere",
    "job_id": 565646,
    "job_posted_date": "2023-03-07 07:01:47",
    "job_schedule_type": "Full-time",
    "company_name": "Zscaler",
    "skills_required": "excel, hadoop, looker, sql, tableau"
  },
  {
    "avg_sal": "152625.0",
    "jobs": "Staff Business Data Analyst (Remote U.S. OK)",
    "location": "Anywhere",
    "job_id": 795614,
    "job_posted_date": "2023-03-11 07:01:56",
    "job_schedule_type": "Full-time",
    "company_name": "Zscaler",
    "skills_required": "excel, hadoop, looker, sql, tableau"
  },
  {
    "avg_sal": "152500.0",
    "jobs": "Lead Data Analyst, Growth (Remote)",
    "location": "Anywhere",
    "job_id": 540057,
    "job_posted_date": "2023-03-24 07:00:42",
    "job_schedule_type": "Full-time",
    "company_name": "Rocket Money",
    "skills_required": "looker, sql"
  },
  {
    "avg_sal": "152221.5",
    "jobs": "Management & Program Analyst (Data Analytics)",
    "location": "Anywhere",
    "job_id": 72957,
    "job_posted_date": "2023-09-11 16:00:30",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills_required": "alteryx, databricks, go, r, sql, tableau"
  },
  {
    "avg_sal": "151500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 456042,
    "job_posted_date": "2023-09-25 10:59:56",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "150000.0",
    "jobs": "Mid-Level Data Analyst",
    "location": "Anywhere",
    "job_id": 73304,
    "job_posted_date": "2023-07-05 07:01:08",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql, tableau"
  },
  {
    "avg_sal": "150000.0",
    "jobs": "Mid-Level Data BI Analyst",
    "location": "Anywhere",
    "job_id": 591850,
    "job_posted_date": "2023-07-17 07:03:43",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "148238.5",
    "jobs": "Lead Data Analyst - Retirement Product Management",
    "location": "Anywhere",
    "job_id": 1402149,
    "job_posted_date": "2023-05-09 10:04:46",
    "job_schedule_type": "Full-time",
    "company_name": "Edward Jones",
    "skills_required": "db2, excel, hadoop, microstrategy, nosql, oracle, python, r, sas, spss, sql, tableau, vba"
  },
  {
    "avg_sal": "147285.0",
    "jobs": "Manager - Data Analyst",
    "location": "Anywhere",
    "job_id": 1694004,
    "job_posted_date": "2023-10-23 07:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "EXL Service",
    "skills_required": "excel, hadoop, python, sas, snowflake, sql, ssis, t-sql"
  },
  {
    "avg_sal": "145000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 405581,
    "job_posted_date": "2023-05-01 13:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "c++, java, javascript, power bi, python, qlik, r, tableau"
  },
  {
    "avg_sal": "145000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 479485,
    "job_posted_date": "2023-03-15 16:59:55",
    "job_schedule_type": "Full-time",
    "company_name": "Level",
    "skills_required": "aws, bigquery, elasticsearch, gcp, golang, kubernetes, looker, pandas, python, r, scikit-learn, sql"
  },
  {
    "avg_sal": "145000.0",
    "jobs": "Data Analyst - up to 160K+",
    "location": "Anywhere",
    "job_id": 1329162,
    "job_posted_date": "2023-04-18 17:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "Hire With Jarvis",
    "skills_required": "excel, power bi, sql, tableau"
  },
  {
    "avg_sal": "145000.0",
    "jobs": "Data Scientist Analyst",
    "location": "Anywhere",
    "job_id": 712558,
    "job_posted_date": "2023-02-13 17:13:26",
    "job_schedule_type": "Full-time",
    "company_name": "ALTA IT Services",
    "skills_required": "excel, power bi, python, r, sas, sql, tableau"
  },
  {
    "avg_sal": "144481.5",
    "jobs": "Lead Data Analyst",
    "location": "Anywhere",
    "job_id": 1275642,
    "job_posted_date": "2023-01-28 11:00:40",
    "job_schedule_type": "Full-time",
    "company_name": "Edward Jones",
    "skills_required": null
  },
  {
    "avg_sal": "140500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1090975,
    "job_posted_date": "2023-03-24 07:06:43",
    "job_schedule_type": "Full-time",
    "company_name": "Uber",
    "skills_required": "excel, looker, python, r, sql, swift, tableau"
  },
  {
    "avg_sal": "140500.0",
    "jobs": "People Data Analyst",
    "location": "Anywhere",
    "job_id": 149006,
    "job_posted_date": "2023-07-31 15:05:01",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "oracle, python, sql"
  },
  {
    "avg_sal": "140000.0",
    "jobs": "Data Manager",
    "location": "Anywhere",
    "job_id": 208403,
    "job_posted_date": "2023-01-26 16:01:53",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "nosql"
  },
  {
    "avg_sal": "140000.0",
    "jobs": "Product Data Analyst",
    "location": "Anywhere",
    "job_id": 1392859,
    "job_posted_date": "2023-02-14 08:00:35",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": null
  },
  {
    "avg_sal": "140000.0",
    "jobs": "Qlik/Power BI Data Analyst | $130K-$150K + ESOP |100% USA-Remote",
    "location": "Anywhere",
    "job_id": 762220,
    "job_posted_date": "2023-01-03 04:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "IT Pros",
    "skills_required": "bigquery, power bi, qlik"
  },
  {
    "avg_sal": "140000.0",
    "jobs": "Sr. Data Analyst",
    "location": "Anywhere",
    "job_id": 1049000,
    "job_posted_date": "2023-07-17 22:00:04",
    "job_schedule_type": "Full-time",
    "company_name": "Sisense",
    "skills_required": "python, r, snowflake, sql"
  },
  {
    "avg_sal": "139000.0",
    "jobs": "Data Analyst (Product Data Analyst)",
    "location": "Anywhere",
    "job_id": 1300702,
    "job_posted_date": "2023-08-04 21:57:48",
    "job_schedule_type": "Full-time",
    "company_name": "Revolut",
    "skills_required": "c++, java, python, scala, sql"
  },
  {
    "avg_sal": "138640.0",
    "jobs": "Digital Marketing Data Analyst (Hybrid)",
    "location": "Anywhere",
    "job_id": 388392,
    "job_posted_date": "2023-08-13 07:01:06",
    "job_schedule_type": "Full-time",
    "company_name": "United Services Automobile Association",
    "skills_required": "hadoop, javascript, nosql, phoenix, snowflake, sql, tableau"
  },
  {
    "avg_sal": "138500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1482852,
    "job_posted_date": "2023-11-23 12:38:59",
    "job_schedule_type": "Full-time",
    "company_name": "Overmind",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "138000.0",
    "jobs": "Lead I - Power BI Data Analyst",
    "location": "Anywhere",
    "job_id": 350382,
    "job_posted_date": "2023-10-13 10:01:14",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "azure, dax, nosql, power bi, sql, sql server"
  },
  {
    "avg_sal": "137500.0",
    "jobs": "Secret Data Analyst Remote / Telecommute Jobs",
    "location": "Anywhere",
    "job_id": 835092,
    "job_posted_date": "2023-10-20 23:00:12",
    "job_schedule_type": "Contractor",
    "company_name": "Insight Global, Inc.",
    "skills_required": "sharepoint"
  },
  {
    "avg_sal": "137000.0",
    "jobs": "Data Analytics Manager",
    "location": "Anywhere",
    "job_id": 740073,
    "job_posted_date": "2023-07-28 09:39:55",
    "job_schedule_type": "Full-time",
    "company_name": "WhiteCrow",
    "skills_required": "excel, powerpoint"
  },
  {
    "avg_sal": "135000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 479965,
    "job_posted_date": "2023-02-26 01:04:44",
    "job_schedule_type": "Full-time",
    "company_name": "InvestM Technology LLC",
    "skills_required": "excel, power bi, sql"
  },
  {
    "avg_sal": "135000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1326467,
    "job_posted_date": "2023-06-26 17:00:18",
    "job_schedule_type": "Full-time",
    "company_name": "EPIC Brokers",
    "skills_required": "excel"
  },
  {
    "avg_sal": "135000.0",
    "jobs": "Data Analyst - Advanced Analytics",
    "location": "Anywhere",
    "job_id": 513988,
    "job_posted_date": "2023-08-27 10:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Hospitality",
    "skills_required": "python, r, sas, sql"
  },
  {
    "avg_sal": "135000.0",
    "jobs": "Lead Data Analyst / SQL Developer",
    "location": "Anywhere",
    "job_id": 777802,
    "job_posted_date": "2023-10-13 00:02:19",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "c, go, python, sql, sql server"
  },
  {
    "avg_sal": "132500.0",
    "jobs": "Data Analyst III",
    "location": "Anywhere",
    "job_id": 311931,
    "job_posted_date": "2023-09-16 13:02:26",
    "job_schedule_type": "Full-time",
    "company_name": "SoftDev Incorporated",
    "skills_required": "python, r, sheets, sql"
  },
  {
    "avg_sal": "132500.0",
    "jobs": "Data Insights Analyst III",
    "location": "Anywhere",
    "job_id": 990420,
    "job_posted_date": "2023-12-12 08:17:27",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sql, tableau"
  },
  {
    "avg_sal": "132500.0",
    "jobs": "Quantitative Scientist (Remote)",
    "location": "Anywhere",
    "job_id": 262837,
    "job_posted_date": "2023-01-28 08:04:56",
    "job_schedule_type": "Full-time",
    "company_name": "Osmind",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1209798,
    "job_posted_date": "2023-05-08 19:02:19",
    "job_schedule_type": "Full-time",
    "company_name": "Doximity",
    "skills_required": "git, github, numpy, pandas, python, spark, sql, unix"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "Data Analyst must have telecom domain experince",
    "location": "Anywhere",
    "job_id": 21451,
    "job_posted_date": "2023-04-28 13:56:12",
    "job_schedule_type": "Contractor",
    "company_name": "ApTask",
    "skills_required": "flow, python, sheets, sql"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "Data Insights Manager",
    "location": "Anywhere",
    "job_id": 1686779,
    "job_posted_date": "2023-12-09 09:00:33",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, power bi, python, r, sql, sql server, tableau"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "Lead Data Analyst",
    "location": "Anywhere",
    "job_id": 447569,
    "job_posted_date": "2023-05-03 23:00:16",
    "job_schedule_type": "Full-time",
    "company_name": "Kforce Technology Staffing",
    "skills_required": "aws, databricks, python, r, redshift, snowflake, sql, tableau"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "Sr. Data Analyst",
    "location": "Anywhere",
    "job_id": 92703,
    "job_posted_date": "2023-09-19 13:01:02",
    "job_schedule_type": "Full-time",
    "company_name": "Launch Consulting Group",
    "skills_required": "aws, azure, dax, excel, flow, jira, power bi, snowflake, sql, tableau, visio"
  },
  {
    "avg_sal": "130000.0",
    "jobs": "System Data Analyst",
    "location": "Anywhere",
    "job_id": 1531276,
    "job_posted_date": "2023-04-11 20:00:42",
    "job_schedule_type": "Full-time",
    "company_name": "Alpha Silicon",
    "skills_required": "flow, python, sheets, sql"
  },
  {
    "avg_sal": "129000.0",
    "jobs": "Manager, Data Analytics (Bioscience) - Remote",
    "location": "Anywhere",
    "job_id": 1566076,
    "job_posted_date": "2023-09-19 14:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Lonza",
    "skills_required": "power bi, python"
  },
  {
    "avg_sal": "127000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1148444,
    "job_posted_date": "2023-06-22 21:00:56",
    "job_schedule_type": "Full-time",
    "company_name": "Acorns",
    "skills_required": "outlook"
  },
  {
    "avg_sal": "127000.0",
    "jobs": "Marketing Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1791785,
    "job_posted_date": "2023-03-09 07:01:13",
    "job_schedule_type": "Full-time",
    "company_name": "Cash App",
    "skills_required": "c, go, sql, twilio"
  },
  {
    "avg_sal": "126452.0",
    "jobs": "Behavioral Health Data Analyst- REMOTE",
    "location": "Anywhere",
    "job_id": 592669,
    "job_posted_date": "2023-07-25 17:41:14",
    "job_schedule_type": "Full-time",
    "company_name": "ICF",
    "skills_required": "python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "126000.0",
    "jobs": "Sr Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 116211,
    "job_posted_date": "2023-08-31 20:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "UnitedHealthcare",
    "skills_required": "sql, sql server, ssis, ssrs"
  },
  {
    "avg_sal": "126000.0",
    "jobs": "Sr Data Analyst, Consultant - Client Facing - Remote",
    "location": "Anywhere",
    "job_id": 502626,
    "job_posted_date": "2023-02-25 14:00:24",
    "job_schedule_type": "Full-time",
    "company_name": "UnitedHealth Group",
    "skills_required": "aws, python, r, sas, sql"
  },
  {
    "avg_sal": "125930.0",
    "jobs": "Mid-Level Decision Science Analyst",
    "location": "Anywhere",
    "job_id": 1735665,
    "job_posted_date": "2023-10-01 08:01:11",
    "job_schedule_type": "Full-time",
    "company_name": "USAA",
    "skills_required": "phoenix, sas, sql"
  },
  {
    "avg_sal": "125500.0",
    "jobs": "Strategy and Data Analyst, Sustainability",
    "location": "Anywhere",
    "job_id": 748965,
    "job_posted_date": "2023-12-14 08:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "Uber",
    "skills_required": "go, python, r, sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 285447,
    "job_posted_date": "2023-05-26 14:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "flow"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 900945,
    "job_posted_date": "2023-12-27 13:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "The Walt Disney Company",
    "skills_required": "databricks, python, r, sas, snowflake, spss, sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Data Analyst, Operations (Remote)",
    "location": "Anywhere",
    "job_id": 1216840,
    "job_posted_date": "2023-02-01 07:01:02",
    "job_schedule_type": "Full-time",
    "company_name": "hims & hers",
    "skills_required": "airflow, bash, bigquery, looker, postgresql, python, r, sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Data Science Analyst 2 (Pop Health)",
    "location": "Anywhere",
    "job_id": 595967,
    "job_posted_date": "2023-01-11 21:06:26",
    "job_schedule_type": "Full-time",
    "company_name": "Starbridge Partners",
    "skills_required": "python, r, sas, sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 300502,
    "job_posted_date": "2023-08-18 17:00:58",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "airflow, bigquery, jupyter, python, redshift, shell, spark, sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Healthcare Data Analyst (Manager)- $120,000-130,000/yr | Remote in PST",
    "location": "Anywhere",
    "job_id": 400967,
    "job_posted_date": "2023-08-21 22:01:23",
    "job_schedule_type": "Full-time",
    "company_name": "PWR Staffing & Recruiting",
    "skills_required": "sql"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Investment Data and Analytics Manager",
    "location": "Anywhere",
    "job_id": 1551308,
    "job_posted_date": "2023-12-12 08:17:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "alteryx, excel, flow, python, r, sql, tableau, vba"
  },
  {
    "avg_sal": "125000.0",
    "jobs": "Manager, Data Analytics & Reporting - Remote",
    "location": "Anywhere",
    "job_id": 1229773,
    "job_posted_date": "2023-03-14 04:02:08",
    "job_schedule_type": "Full-time",
    "company_name": "Infinity Consulting Solutions, Inc.",
    "skills_required": "excel, go, notion, sql"
  },
  {
    "avg_sal": "124500.0",
    "jobs": "Data Analyst: regional physical security",
    "location": "Anywhere",
    "job_id": 1682817,
    "job_posted_date": "2023-05-27 01:00:43",
    "job_schedule_type": "Full-time",
    "company_name": "Blackstone Consulting, Inc.",
    "skills_required": "excel, microsoft teams, power bi, powerpoint, sharepoint, word"
  },
  {
    "avg_sal": "124000.0",
    "jobs": "Data Analyst, Support Operations",
    "location": "Anywhere",
    "job_id": 821092,
    "job_posted_date": "2023-02-17 19:02:22",
    "job_schedule_type": "Full-time",
    "company_name": "Cloudflare",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "123249.5",
    "jobs": "Senior Clinical Data Manager/Analyst II",
    "location": "Anywhere",
    "job_id": 970857,
    "job_posted_date": "2023-06-19 22:01:45",
    "job_schedule_type": "Full-time",
    "company_name": "Exact Sciences Corporation",
    "skills_required": null
  },
  {
    "avg_sal": "123000.0",
    "jobs": "Data Analytics Manager",
    "location": "Anywhere",
    "job_id": 631753,
    "job_posted_date": "2023-07-30 11:00:50",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, power bi, sql, tableau"
  },
  {
    "avg_sal": "122769.0",
    "jobs": "Lead Analyst - Data Analytics - Remote",
    "location": "Anywhere",
    "job_id": 596565,
    "job_posted_date": "2023-08-31 20:30:00",
    "job_schedule_type": "Full-time",
    "company_name": "ICF",
    "skills_required": "power bi, python, sql, tableau"
  },
  {
    "avg_sal": "122500.0",
    "jobs": "Business Data Analyst with SQL (Strong)",
    "location": "Anywhere",
    "job_id": 238020,
    "job_posted_date": "2023-06-19 17:01:37",
    "job_schedule_type": "Full-time",
    "company_name": "Innova Solutions",
    "skills_required": "aws, confluence, jira, sql"
  },
  {
    "avg_sal": "122500.0",
    "jobs": "Decision Science Analyst - Consumer Lending",
    "location": "Anywhere",
    "job_id": 1015777,
    "job_posted_date": "2023-01-20 19:22:47",
    "job_schedule_type": "Full-time",
    "company_name": "Analytic Recruiting Inc.",
    "skills_required": "python, sas, snowflake, sql, tableau"
  },
  {
    "avg_sal": "122500.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 841943,
    "job_posted_date": "2023-07-01 19:00:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": null
  },
  {
    "avg_sal": "122000.0",
    "jobs": "Sales Ops Data Analyst (Austin, TX or Remote)",
    "location": "Anywhere",
    "job_id": 298860,
    "job_posted_date": "2023-08-01 23:01:46",
    "job_schedule_type": "Full-time",
    "company_name": "Cloudflare",
    "skills_required": "bigquery, sheets, sql, tableau"
  },
  {
    "avg_sal": "122000.0",
    "jobs": "Sales Ops Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 426033,
    "job_posted_date": "2023-08-01 23:00:59",
    "job_schedule_type": "Full-time",
    "company_name": "CloudFlare",
    "skills_required": "bigquery, sheets, sql, tableau"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 1191992,
    "job_posted_date": "2023-04-04 15:56:17",
    "job_schedule_type": "Contractor",
    "company_name": "Robert Half",
    "skills_required": "power bi, sql, tableau"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Business Intelligence Data Analyst",
    "location": "Anywhere",
    "job_id": 999820,
    "job_posted_date": "2023-11-29 16:00:03",
    "job_schedule_type": "Full-time",
    "company_name": "LAI",
    "skills_required": "confluence, excel, go, jira, kubernetes, sql, tableau, word"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Data Analytics Analyst",
    "location": "Anywhere",
    "job_id": 236172,
    "job_posted_date": "2023-11-04 09:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, outlook, power bi, powerpoint, sharepoint, tableau, visio"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Data Architect",
    "location": "Anywhere",
    "job_id": 587198,
    "job_posted_date": "2023-07-18 06:35:18",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "aws, azure, bigquery, gcp, redshift, snowflake, sql, tableau"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Lifeforce: Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1611348,
    "job_posted_date": "2023-04-17 22:59:57",
    "job_schedule_type": "Full-time",
    "company_name": "M13",
    "skills_required": "r, sas, spss, sql"
  },
  {
    "avg_sal": "120000.0",
    "jobs": "Senior Financial and Data Analyst | Hybrid Schedule",
    "location": "Anywhere",
    "job_id": 946582,
    "job_posted_date": "2023-09-18 23:40:38",
    "job_schedule_type": "Full-time",
    "company_name": "Jobot",
    "skills_required": null
  },
  {
    "avg_sal": "119908.0",
    "jobs": "Risk Data Analyst",
    "location": "Anywhere",
    "job_id": 1132443,
    "job_posted_date": "2023-06-20 16:00:30",
    "job_schedule_type": "Full-time",
    "company_name": "US Development Finance Corporation (formerly Overseas Private Investment Corporation)",
    "skills_required": "power bi, python, tableau, vba"
  },
  {
    "avg_sal": "119200.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 876656,
    "job_posted_date": "2023-03-25 07:59:55",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "hadoop, python, sql, tableau"
  },
  {
    "avg_sal": "119200.0",
    "jobs": "Data Analyst - Predictive Modeling",
    "location": "Anywhere",
    "job_id": 446029,
    "job_posted_date": "2023-06-09 08:00:23",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "hadoop, python, sql, tableau"
  },
  {
    "avg_sal": "117713.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 945180,
    "job_posted_date": "2023-11-13 10:59:58",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "excel, ms access, powerpoint, tableau, word"
  },
  {
    "avg_sal": "117500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 685438,
    "job_posted_date": "2023-09-12 23:00:51",
    "job_schedule_type": "Full-time",
    "company_name": "Jobot",
    "skills_required": "python, sql, tableau"
  },
  {
    "avg_sal": "117500.0",
    "jobs": "Lead Data Analyst",
    "location": "Anywhere",
    "job_id": 1124418,
    "job_posted_date": "2023-12-28 10:22:27",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql, sql server"
  },
  {
    "avg_sal": "117500.0",
    "jobs": "Lead Data Analyst / SQL Developer",
    "location": "Anywhere",
    "job_id": 436153,
    "job_posted_date": "2023-12-27 20:01:58",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "c, go, python, sql, sql server"
  },
  {
    "avg_sal": "117000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 131427,
    "job_posted_date": "2023-11-12 09:00:25",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, python, sql, tableau"
  },
  {
    "avg_sal": "115791.5",
    "jobs": "BI Data Analyst IV",
    "location": "Anywhere",
    "job_id": 16358,
    "job_posted_date": "2023-01-06 16:01:23",
    "job_schedule_type": "Full-time",
    "company_name": "Kern Health Systems",
    "skills_required": "excel, sas, sql"
  },
  {
    "avg_sal": "115791.5",
    "jobs": "BI Data Analyst IV",
    "location": "Anywhere",
    "job_id": 1574716,
    "job_posted_date": "2023-01-05 04:01:12",
    "job_schedule_type": "Full-time",
    "company_name": "Kern Health Systems",
    "skills_required": "excel, sas, sql"
  },
  {
    "avg_sal": "115791.5",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1788827,
    "job_posted_date": "2023-04-14 20:01:05",
    "job_schedule_type": "Full-time",
    "company_name": "Kern Health Systems",
    "skills_required": "excel, sas, sql"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 198747,
    "job_posted_date": "2023-02-07 19:44:58",
    "job_schedule_type": "Contractor",
    "company_name": "Robert Half",
    "skills_required": "power bi, sql, tableau"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 24351,
    "job_posted_date": "2023-04-21 14:55:10",
    "job_schedule_type": "Full-time",
    "company_name": "ManyPets",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 357990,
    "job_posted_date": "2023-01-19 17:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "azure, databricks, oracle, power bi, sql, sql server, tableau"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1139755,
    "job_posted_date": "2023-06-01 19:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Lighthouse Professional Services",
    "skills_required": "alteryx, dax, power bi, powerpoint, python, r, snowflake, sql, tableau, vba"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1403108,
    "job_posted_date": "2023-12-24 09:00:30",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data Analyst- REMOTE",
    "location": "Anywhere",
    "job_id": 728112,
    "job_posted_date": "2023-05-08 20:03:17",
    "job_schedule_type": "Full-time",
    "company_name": "General Dynamics Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "115000.0",
    "jobs": "Data/Information Architect",
    "location": "Anywhere",
    "job_id": 156483,
    "job_posted_date": "2023-07-06 19:33:59",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "postgresql, python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "115000.0",
    "jobs": "QNXT/TriZetto Data Analyst",
    "location": "Anywhere",
    "job_id": 1772547,
    "job_posted_date": "2023-01-11 16:02:49",
    "job_schedule_type": "Full-time",
    "company_name": "Medasource",
    "skills_required": "azure, excel, sql, sql server"
  },
  {
    "avg_sal": "114956.5",
    "jobs": "Behavioral Health Data Analyst",
    "location": "Anywhere",
    "job_id": 945577,
    "job_posted_date": "2023-10-24 23:09:53",
    "job_schedule_type": "Full-time",
    "company_name": "ICF",
    "skills_required": "python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "114948.0",
    "jobs": "Healthcare Analytics Expert",
    "location": "Anywhere",
    "job_id": 467403,
    "job_posted_date": "2023-08-13 19:01:28",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "power bi, python, r, sas, tableau"
  },
  {
    "avg_sal": "114805.0",
    "jobs": "Behavioral Health Data Analyst",
    "location": "Anywhere",
    "job_id": 857003,
    "job_posted_date": "2023-09-22 16:57:25",
    "job_schedule_type": "Full-time",
    "company_name": "ICF",
    "skills_required": "python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "114000.0",
    "jobs": "Data Analyst, Global Business Development",
    "location": "Anywhere",
    "job_id": 1566879,
    "job_posted_date": "2023-11-01 07:01:10",
    "job_schedule_type": "Full-time",
    "company_name": "Uber",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "113500.0",
    "jobs": "Technical Business/Data Analyst (REMOTE)",
    "location": "Anywhere",
    "job_id": 1354909,
    "job_posted_date": "2023-03-21 17:16:32",
    "job_schedule_type": "Full-time",
    "company_name": "GEICO",
    "skills_required": "azure, db2, hadoop, oracle, power bi, python, snowflake, sql"
  },
  {
    "avg_sal": "112850.0",
    "jobs": "Data Analyst, Customer Success (Chicago, IL or Remote)",
    "location": "Anywhere",
    "job_id": 248219,
    "job_posted_date": "2023-09-16 23:01:25",
    "job_schedule_type": "Full-time",
    "company_name": "Square",
    "skills_required": "c, flow, go, looker, python, sql, tableau"
  },
  {
    "avg_sal": "112661.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 236397,
    "job_posted_date": "2023-07-29 20:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "python, sql, tableau"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 185960,
    "job_posted_date": "2023-12-03 09:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1006256,
    "job_posted_date": "2023-01-08 01:03:25",
    "job_schedule_type": "Full-time",
    "company_name": "InvestM Technology LLC",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Data Analyst Remote / Telecommute Jobs",
    "location": "Anywhere",
    "job_id": 71065,
    "job_posted_date": "2023-11-21 21:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Paratus Solutions LLC",
    "skills_required": "excel, javascript, python, r, sas, spss, sql, sqlite, tableau"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Data Engineer/Data Analyst",
    "location": "Anywhere",
    "job_id": 1728,
    "job_posted_date": "2023-05-24 19:08:14",
    "job_schedule_type": "Full-time",
    "company_name": "Segue Technologies Inc",
    "skills_required": "aws, excel, nosql, sql, sql server, tableau"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Experian Data Analyst Remote / Telecommute Jobs",
    "location": "Anywhere",
    "job_id": 84928,
    "job_posted_date": "2023-01-03 21:27:28",
    "job_schedule_type": "Full-time",
    "company_name": "Seneca Resources, LLC",
    "skills_required": "aws, linux"
  },
  {
    "avg_sal": "112500.0",
    "jobs": "Remote Lead Business Data Analyst (Chicago, IL or Remote)",
    "location": "Anywhere",
    "job_id": 576410,
    "job_posted_date": "2023-05-03 02:02:40",
    "job_schedule_type": "Full-time",
    "company_name": "UL Solutions",
    "skills_required": "dax, excel"
  },
  {
    "avg_sal": "112050.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 147455,
    "job_posted_date": "2023-02-02 07:00:30",
    "job_schedule_type": "Full-time",
    "company_name": "Cisco Meraki",
    "skills_required": "excel, looker, oracle, sap, sql, tableau"
  },
  {
    "avg_sal": "111500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 958872,
    "job_posted_date": "2023-10-20 16:00:12",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills_required": "azure, ibm cloud, jira, python, sql, tableau"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 409831,
    "job_posted_date": "2023-12-21 08:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "Trinity Solar Careers",
    "skills_required": "dax, excel, power bi, sql, sql server, ssis, t-sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 446319,
    "job_posted_date": "2023-09-10 10:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "javascript, looker"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 894317,
    "job_posted_date": "2023-12-24 10:00:33",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 991817,
    "job_posted_date": "2023-10-23 16:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1047698,
    "job_posted_date": "2023-03-14 16:45:26",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "aws, sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1210470,
    "job_posted_date": "2023-09-20 16:03:42",
    "job_schedule_type": "Contractor",
    "company_name": "Convergenz",
    "skills_required": "power bi, r, sas, sql, tableau"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1574686,
    "job_posted_date": "2023-04-13 20:38:26",
    "job_schedule_type": "Contractor",
    "company_name": "Insight Global",
    "skills_required": "aws, azure, power bi, sql, sql server, ssis, ssrs, t-sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1814437,
    "job_posted_date": "2023-08-18 17:00:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 480243,
    "job_posted_date": "2023-01-06 20:01:36",
    "job_schedule_type": "Full-time",
    "company_name": "Cava Connect",
    "skills_required": "dax, excel, power bi, python, sql, ssis, ssrs, vba"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst III",
    "location": "Anywhere",
    "job_id": 321727,
    "job_posted_date": "2023-10-30 21:00:33",
    "job_schedule_type": "Full-time",
    "company_name": "CREDITSERVE INC",
    "skills_required": "excel, powerpoint, python, sql, tableau, word"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Data Analyst III",
    "location": "Anywhere",
    "job_id": 1434170,
    "job_posted_date": "2023-11-09 00:21:53",
    "job_schedule_type": "Full-time",
    "company_name": "CREDITSERVE INC",
    "skills_required": "excel, powerpoint, python, sql, tableau, word"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Energy Data Analyst",
    "location": "Anywhere",
    "job_id": 382334,
    "job_posted_date": "2023-08-30 21:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "DNV",
    "skills_required": "azure, databricks, excel, javascript, jira, power bi, powerpoint, python, r, sas, sql, word"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Master Data Analyst",
    "location": "Anywhere",
    "job_id": 885463,
    "job_posted_date": "2023-07-30 14:01:53",
    "job_schedule_type": "Full-time",
    "company_name": "Executive Search Partners LLC",
    "skills_required": null
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Master Data Analyst",
    "location": "Anywhere",
    "job_id": 1348516,
    "job_posted_date": "2023-10-02 21:23:46",
    "job_schedule_type": "Full-time",
    "company_name": "Executive Search Partners LLC",
    "skills_required": null
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Medicaid Data Analyst",
    "location": "Anywhere",
    "job_id": 412163,
    "job_posted_date": "2023-06-26 16:04:19",
    "job_schedule_type": "Contractor",
    "company_name": "Apex Systems",
    "skills_required": "sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "Retail Systems Data Analyst",
    "location": "Anywhere",
    "job_id": 1490432,
    "job_posted_date": "2023-06-09 09:01:47",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "alteryx, excel, flow, power bi, sql"
  },
  {
    "avg_sal": "110000.0",
    "jobs": "SQL DEVELOPER / DATA ANALYST (Insurance industry Experience) ...",
    "location": "Anywhere",
    "job_id": 1592165,
    "job_posted_date": "2023-01-26 13:03:57",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "sql, ssis"
  },
  {
    "avg_sal": "109600.0",
    "jobs": "EDI Data Analyst/Business Systems Analyst III  (Great Place to...",
    "location": "Anywhere",
    "job_id": 991303,
    "job_posted_date": "2023-06-05 14:02:08",
    "job_schedule_type": "Full-time",
    "company_name": "Paradigm",
    "skills_required": "bash, db2, flow, java, javascript, oracle, powershell, python, shell, sql, sql server"
  },
  {
    "avg_sal": "108500.0",
    "jobs": "Portfolio Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 480984,
    "job_posted_date": "2023-03-25 02:59:58",
    "job_schedule_type": "Full-time",
    "company_name": "Addepar",
    "skills_required": null
  },
  {
    "avg_sal": "107500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1119269,
    "job_posted_date": "2023-08-28 02:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "CODING DOJO INC.",
    "skills_required": "excel, hadoop, outlook, power bi, powerpoint, python, r, sas, sql, tableau, word"
  },
  {
    "avg_sal": "107500.0",
    "jobs": "Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 1795029,
    "job_posted_date": "2023-09-20 09:01:27",
    "job_schedule_type": "Full-time",
    "company_name": "Dice",
    "skills_required": "power bi, python, sap, sql"
  },
  {
    "avg_sal": "107500.0",
    "jobs": "Data Analyst, Finance and Accounting (Remote)",
    "location": "Anywhere",
    "job_id": 1026200,
    "job_posted_date": "2023-03-24 03:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "Rhino",
    "skills_required": "bigquery, excel, sql"
  },
  {
    "avg_sal": "107500.0",
    "jobs": "Data and Process Modeling Analyst",
    "location": "Anywhere",
    "job_id": 65900,
    "job_posted_date": "2023-12-30 13:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Hospitality",
    "skills_required": "excel, powerpoint"
  },
  {
    "avg_sal": "107500.0",
    "jobs": "IT Data Analyst - Remote | WFH",
    "location": "Anywhere",
    "job_id": 255533,
    "job_posted_date": "2023-10-06 14:59:57",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, azure, excel, html, power bi, python, r, sql, sql server, tableau"
  },
  {
    "avg_sal": "107500.0",
    "jobs": "REMOTE PowerBI Data Analyst",
    "location": "Anywhere",
    "job_id": 600392,
    "job_posted_date": "2023-04-04 17:05:54",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "sql"
  },
  {
    "avg_sal": "106562.5",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 107274,
    "job_posted_date": "2023-09-05 17:00:45",
    "job_schedule_type": "Full-time",
    "company_name": "Cherry Bekaert Advisory, LLC",
    "skills_required": "alteryx, numpy, pandas, power bi, python, r, scikit-learn, sql, tableau"
  },
  {
    "avg_sal": "106479.0",
    "jobs": "Data Analyst II - Firm Analytics",
    "location": "Anywhere",
    "job_id": 228239,
    "job_posted_date": "2023-11-15 08:02:28",
    "job_schedule_type": "Full-time",
    "company_name": "Edward Jones",
    "skills_required": "oracle, python, r, sas, snowflake, spss, sql, tableau"
  },
  {
    "avg_sal": "106479.0",
    "jobs": "Data Analyst II - Firm Analytics",
    "location": "Anywhere",
    "job_id": 617583,
    "job_posted_date": "2023-09-04 14:01:59",
    "job_schedule_type": "Full-time",
    "company_name": "Edward Jones",
    "skills_required": "oracle, python, r, sas, snowflake, spss, sql, tableau"
  },
  {
    "avg_sal": "106479.0",
    "jobs": "Data Governance Analyst II - Frameworks, Standards, & Policies",
    "location": "Anywhere",
    "job_id": 55833,
    "job_posted_date": "2023-08-03 11:02:09",
    "job_schedule_type": "Full-time",
    "company_name": "Edward Jones",
    "skills_required": "excel, powerpoint, vba, word"
  },
  {
    "avg_sal": "106000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 800017,
    "job_posted_date": "2023-08-12 09:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, git, python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "106000.0",
    "jobs": "Market Research & Data Analyst",
    "location": "Anywhere",
    "job_id": 1454946,
    "job_posted_date": "2023-08-12 10:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, looker, sql, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Associate Director, Data Analysis",
    "location": "Anywhere",
    "job_id": 909000,
    "job_posted_date": "2023-01-27 16:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "EL Education (Formerly Expeditionary Learning)",
    "skills_required": "r, tableau, word"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Building Management System Data Analyst",
    "location": "Anywhere",
    "job_id": 1352378,
    "job_posted_date": "2023-08-16 10:00:34",
    "job_schedule_type": "Full-time",
    "company_name": "Vantage Consulting",
    "skills_required": null
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Clinical Data Analyst",
    "location": "Anywhere",
    "job_id": 371104,
    "job_posted_date": "2023-01-23 22:01:31",
    "job_schedule_type": "Full-time",
    "company_name": "Modis",
    "skills_required": "azure, sql"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1069248,
    "job_posted_date": "2023-02-09 15:26:09",
    "job_schedule_type": "Full-time",
    "company_name": "Starr And Associates LLC",
    "skills_required": "excel, python, qlik, r, sql, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1344229,
    "job_posted_date": "2023-10-23 13:52:28",
    "job_schedule_type": "Full-time",
    "company_name": "Vista Global Solutions, LLC",
    "skills_required": "aws, excel, python, qlik, r, redshift, sql, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Data Visualization Analyst",
    "location": "Anywhere",
    "job_id": 601788,
    "job_posted_date": "2023-10-15 08:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, html, power bi, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 1091932,
    "job_posted_date": "2023-11-24 09:00:39",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "power bi, python, sql, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 936268,
    "job_posted_date": "2023-06-29 19:01:21",
    "job_schedule_type": "Full-time",
    "company_name": "Syndicatebleu",
    "skills_required": "excel, html, javascript, looker, sql"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Product Data Analyst",
    "location": "Anywhere",
    "job_id": 426601,
    "job_posted_date": "2023-06-12 21:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Syrup",
    "skills_required": "hadoop, power bi, python, r, spark, sql, tableau"
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Senior Analyst, Government Reporting",
    "location": "Anywhere",
    "job_id": 1640497,
    "job_posted_date": "2023-09-24 17:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Cnam - Auditeurs - Accueil",
    "skills_required": null
  },
  {
    "avg_sal": "105000.0",
    "jobs": "Sr Data Analyst",
    "location": "Anywhere",
    "job_id": 1309967,
    "job_posted_date": "2023-04-23 13:00:14",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "excel, oracle, sql, tableau"
  },
  {
    "avg_sal": "104300.0",
    "jobs": "Sales Comp Data Analyst (Remote, U.S.)",
    "location": "Anywhere",
    "job_id": 748403,
    "job_posted_date": "2023-07-14 06:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Pitney Bowes",
    "skills_required": "excel, go, power bi, tableau"
  },
  {
    "avg_sal": "104106.5",
    "jobs": "Health Information Management Data Analyst III",
    "location": "Anywhere",
    "job_id": 380744,
    "job_posted_date": "2023-06-06 20:00:52",
    "job_schedule_type": "Full-time",
    "company_name": "Health Plan of San Mateo",
    "skills_required": "excel, outlook, powerpoint, sas, spreadsheet, word"
  },
  {
    "avg_sal": "104000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 909351,
    "job_posted_date": "2023-12-04 09:01:13",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "c++, excel, javascript, looker, powerpoint, python, qlik, r, snowflake, sql, tableau"
  },
  {
    "avg_sal": "103500.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 1559111,
    "job_posted_date": "2023-12-15 09:01:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql"
  },
  {
    "avg_sal": "103049.5",
    "jobs": "Data and Analytics Analyst",
    "location": "Anywhere",
    "job_id": 1061483,
    "job_posted_date": "2023-08-08 10:52:20",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": null
  },
  {
    "avg_sal": "103000.0",
    "jobs": "Data Integration Analyst",
    "location": "Anywhere",
    "job_id": 1667594,
    "job_posted_date": "2023-04-17 20:00:52",
    "job_schedule_type": "Full-time",
    "company_name": "AIDS Healthcare Foundation",
    "skills_required": "oracle, python, r, sql, sql server, ssis, ssrs, t-sql, tableau, unix, windows"
  },
  {
    "avg_sal": "103000.0",
    "jobs": "Data Wrangling and Visualization Manager",
    "location": "Anywhere",
    "job_id": 1679633,
    "job_posted_date": "2023-12-27 13:39:49",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, azure, databricks, python, spark, sql"
  },
  {
    "avg_sal": "103000.0",
    "jobs": "Epic Chronicles Database Analyst",
    "location": "Anywhere",
    "job_id": 707689,
    "job_posted_date": "2023-11-23 09:01:46",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql"
  },
  {
    "avg_sal": "102500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 61021,
    "job_posted_date": "2023-10-10 16:04:08",
    "job_schedule_type": "Full-time and Contractor",
    "company_name": "The Phoenix Group",
    "skills_required": null
  },
  {
    "avg_sal": "102500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 523374,
    "job_posted_date": "2023-06-06 15:01:10",
    "job_schedule_type": "Contractor",
    "company_name": "Insight Global",
    "skills_required": "javascript, sql, tableau"
  },
  {
    "avg_sal": "102500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 535535,
    "job_posted_date": "2023-04-05 15:01:31",
    "job_schedule_type": "Full-time",
    "company_name": "Orion Groups",
    "skills_required": "bash, confluence, flow, gcp, github, hadoop, jenkins, jira, python, spark"
  },
  {
    "avg_sal": "102500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 949643,
    "job_posted_date": "2023-06-25 08:23:34",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "power bi, sql, tableau"
  },
  {
    "avg_sal": "102250.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1277458,
    "job_posted_date": "2023-09-20 22:00:41",
    "job_schedule_type": "Full-time",
    "company_name": "ZipRecruiter",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "102000.0",
    "jobs": "Data Analyst - Healthcare Industry (Remote)",
    "location": "Anywhere",
    "job_id": 1526567,
    "job_posted_date": "2023-04-21 08:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "102000.0",
    "jobs": "Remote Data Analyst III",
    "location": "Anywhere",
    "job_id": 1378977,
    "job_posted_date": "2023-04-15 08:46:46",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "102000.0",
    "jobs": "Senior System/Data Analyst",
    "location": "Anywhere",
    "job_id": 4420,
    "job_posted_date": "2023-11-04 09:00:13",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, oracle, python, redshift, sql, tableau"
  },
  {
    "avg_sal": "101500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 686507,
    "job_posted_date": "2023-07-06 09:02:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "azure, python, r, sql"
  },
  {
    "avg_sal": "101500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1234973,
    "job_posted_date": "2023-07-09 10:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "confluence, hadoop, jira, sql, tableau"
  },
  {
    "avg_sal": "101500.0",
    "jobs": "Data Analyst - Empowering Insights for a Healthier Future",
    "location": "Anywhere",
    "job_id": 1440,
    "job_posted_date": "2023-07-15 09:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "100400.0",
    "jobs": "Data Analyst 2 - Remote",
    "location": "Anywhere",
    "job_id": 838504,
    "job_posted_date": "2023-02-26 01:01:04",
    "job_schedule_type": "Full-time",
    "company_name": "Optum",
    "skills_required": "c#, github, sql, sql server, ssis, ssrs"
  },
  {
    "avg_sal": "100400.0",
    "jobs": "Data analyst remote",
    "location": "Anywhere",
    "job_id": 1514995,
    "job_posted_date": "2023-12-23 23:40:47",
    "job_schedule_type": "Full-time",
    "company_name": "UnitedHealth Group",
    "skills_required": "alteryx, excel, power bi, python, snowflake, tableau"
  },
  {
    "avg_sal": "100400.0",
    "jobs": "Healthcare Data Analyst- Hybrid",
    "location": "Anywhere",
    "job_id": 136192,
    "job_posted_date": "2023-11-27 07:01:02",
    "job_schedule_type": "Full-time",
    "company_name": "UnitedHealth Group",
    "skills_required": "go, sas"
  },
  {
    "avg_sal": "100400.0",
    "jobs": "Sr Supplemental Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 1519017,
    "job_posted_date": "2023-02-27 12:01:00",
    "job_schedule_type": "Full-time",
    "company_name": "UnitedHealth Group",
    "skills_required": "excel, ms access, outlook, powerpoint, sql, visio, word"
  },
  {
    "avg_sal": "100000.5",
    "jobs": "Tableau Data Analyst",
    "location": "Anywhere",
    "job_id": 262921,
    "job_posted_date": "2023-05-05 20:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "SAIC",
    "skills_required": "c, c#, c++, excel, java, oracle, qlik, sql, sql server, tableau, visio"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 309300,
    "job_posted_date": "2023-05-15 16:00:39",
    "job_schedule_type": "Full-time",
    "company_name": "Scaleai",
    "skills_required": "python, sql, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 524146,
    "job_posted_date": "2023-02-23 18:01:48",
    "job_schedule_type": "Full-time",
    "company_name": "Hearth",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 734020,
    "job_posted_date": "2023-12-22 22:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Govcio LLC",
    "skills_required": "atlassian, oracle, sql"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 736533,
    "job_posted_date": "2023-05-11 20:00:22",
    "job_schedule_type": "Full-time",
    "company_name": "LHH",
    "skills_required": "excel, oracle, sap, sql, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analyst - Healthcare",
    "location": "Anywhere",
    "job_id": 43545,
    "job_posted_date": "2023-01-22 14:05:22",
    "job_schedule_type": "Full-time",
    "company_name": "InvestM Technology LLC",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analyst - Investment Management",
    "location": "Anywhere",
    "job_id": 1331634,
    "job_posted_date": "2023-04-08 16:02:36",
    "job_schedule_type": "Contractor",
    "company_name": "InvestM Technology LLC",
    "skills_required": "java, power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Analytics Manager",
    "location": "Anywhere",
    "job_id": 1217891,
    "job_posted_date": "2023-12-19 08:01:16",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Data Conversion Analyst",
    "location": "Anywhere",
    "job_id": 420972,
    "job_posted_date": "2023-06-23 14:22:13",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "power bi"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Healthcare Quality Data Analyst",
    "location": "Anywhere",
    "job_id": 1785328,
    "job_posted_date": "2023-04-25 16:02:04",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global Healthcare",
    "skills_required": "excel, powerpoint, qlik, tableau"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Lead Data Analyst / SQL Developer",
    "location": "Anywhere",
    "job_id": 327502,
    "job_posted_date": "2023-09-08 00:02:13",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "c, go, python, sql, sql server"
  },
  {
    "avg_sal": "100000.0",
    "jobs": "Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 882690,
    "job_posted_date": "2023-06-19 23:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "LHH",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "99746.90625",
    "jobs": "Research Data Analyst",
    "location": "Anywhere",
    "job_id": 670899,
    "job_posted_date": "2023-10-12 04:00:55",
    "job_schedule_type": "Full-time",
    "company_name": "Calbright College",
    "skills_required": "excel, oracle, python, r, sas, sheets, spreadsheet, spss, sql, windows, word"
  },
  {
    "avg_sal": "99500.0",
    "jobs": "Legal Project Management Data Analyst",
    "location": "Anywhere",
    "job_id": 1064019,
    "job_posted_date": "2023-07-24 17:02:21",
    "job_schedule_type": "Full-time",
    "company_name": "Ogletree Deakins",
    "skills_required": "excel, python, r, sql, tableau"
  },
  {
    "avg_sal": "99500.0",
    "jobs": "Senior Earth Observation Data Analyst",
    "location": "Anywhere",
    "job_id": 1733276,
    "job_posted_date": "2023-07-06 09:00:14",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, bash, c#, c++, java, powershell, python, r, sql, tableau"
  },
  {
    "avg_sal": "99000.0",
    "jobs": "Data Analyst III - SQL Analytics - Remote | WFH",
    "location": "Anywhere",
    "job_id": 867791,
    "job_posted_date": "2023-03-04 10:01:39",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Technology",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "98800.0",
    "jobs": "Research Data Analyst (remote)",
    "location": "Anywhere",
    "job_id": 1332763,
    "job_posted_date": "2023-05-04 01:00:43",
    "job_schedule_type": "Full-time",
    "company_name": "Ad Hoc Team",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "98750.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 284410,
    "job_posted_date": "2023-09-16 09:02:30",
    "job_schedule_type": "Full-time",
    "company_name": "Goldbelt, Inc.",
    "skills_required": "flow, sas"
  },
  {
    "avg_sal": "98500.0",
    "jobs": "Data Analyst IV (Healthcare Analytics) - Remote | WFH",
    "location": "Anywhere",
    "job_id": 1149238,
    "job_posted_date": "2023-02-27 08:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Technology",
    "skills_required": "excel, python, r, sql"
  },
  {
    "avg_sal": "98000.0",
    "jobs": "Remote Epic Bridges Analyst with Data Conversion Expertise",
    "location": "Anywhere",
    "job_id": 1044426,
    "job_posted_date": "2023-11-30 08:02:18",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "97500.0",
    "jobs": "Data Analyst - Healthcare",
    "location": "Anywhere",
    "job_id": 1691565,
    "job_posted_date": "2023-01-26 22:06:18",
    "job_schedule_type": "Full-time",
    "company_name": "InvestM Technology LLC",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "97500.0",
    "jobs": "Mid-Level Data Analyst - Python/SQL/PowerBI/Tableau",
    "location": "Anywhere",
    "job_id": 498516,
    "job_posted_date": "2023-05-30 07:01:57",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "azure, databricks, power bi, python, snowflake, spark, sql, tableau"
  },
  {
    "avg_sal": "97500.0",
    "jobs": "Privacy Data Analyst- (remote)",
    "location": "Anywhere",
    "job_id": 1714018,
    "job_posted_date": "2023-01-09 20:01:32",
    "job_schedule_type": "Full-time",
    "company_name": "Cognizant Technology Solutions",
    "skills_required": "excel, flow"
  },
  {
    "avg_sal": "97500.0",
    "jobs": "Quantitative Data Analyst (CRE / CMBS)",
    "location": "Anywhere",
    "job_id": 630777,
    "job_posted_date": "2023-10-20 14:00:09",
    "job_schedule_type": "Full-time",
    "company_name": "CRED iQ",
    "skills_required": "excel, go, powerpoint, python, rust, sql, word"
  },
  {
    "avg_sal": "97070.5",
    "jobs": "Provider Data Configuration Analyst IV",
    "location": "Anywhere",
    "job_id": 35406,
    "job_posted_date": "2023-12-20 22:00:34",
    "job_schedule_type": "Full-time",
    "company_name": "Central California Alliance for Health (Remote)",
    "skills_required": "sql"
  },
  {
    "avg_sal": "97000.0",
    "jobs": "Lead Master Data Analyst (Remote or Onsite)",
    "location": "Anywhere",
    "job_id": 339556,
    "job_posted_date": "2023-05-09 07:01:26",
    "job_schedule_type": "Full-time",
    "company_name": "Driscoll's",
    "skills_required": "flow, sql"
  },
  {
    "avg_sal": "96400.0",
    "jobs": "Data Analyst (Apex Legends)",
    "location": "Anywhere",
    "job_id": 1299756,
    "job_posted_date": "2023-06-22 19:01:06",
    "job_schedule_type": "Full-time",
    "company_name": "Respawn Entertainment",
    "skills_required": "power bi, sql"
  },
  {
    "avg_sal": "95700.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1791218,
    "job_posted_date": "2023-01-20 03:00:21",
    "job_schedule_type": "Full-time",
    "company_name": "Booz Allen Hamilton",
    "skills_required": "power bi, powerpoint, python, qlik, r, sql, tableau"
  },
  {
    "avg_sal": "95680.0",
    "jobs": "Data Analyst (QA)",
    "location": "Anywhere",
    "job_id": 703426,
    "job_posted_date": "2023-01-05 16:00:49",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel"
  },
  {
    "avg_sal": "95680.0",
    "jobs": "Data Analyst (QA)",
    "location": "Anywhere",
    "job_id": 1601917,
    "job_posted_date": "2023-01-05 04:01:14",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel"
  },
  {
    "avg_sal": "95650.0",
    "jobs": "Data Analyst, Mid",
    "location": "Anywhere",
    "job_id": 1519639,
    "job_posted_date": "2023-08-30 20:01:43",
    "job_schedule_type": "Full-time",
    "company_name": "Booz Allen Hamilton",
    "skills_required": "power bi, powerpoint, python, r"
  },
  {
    "avg_sal": "95500.0",
    "jobs": "Data Analyst Lead - Remote",
    "location": "Anywhere",
    "job_id": 735880,
    "job_posted_date": "2023-05-18 01:00:30",
    "job_schedule_type": "Full-time",
    "company_name": "Olympus Corporation of the Americas",
    "skills_required": "excel, python, sql, tableau, unity, vba"
  },
  {
    "avg_sal": "95329.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 354407,
    "job_posted_date": "2023-08-11 14:00:49",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "oracle, power bi, sql, tableau"
  },
  {
    "avg_sal": "95150.0",
    "jobs": "Risk Adjustment Data Analytics Lead",
    "location": "Anywhere",
    "job_id": 690438,
    "job_posted_date": "2023-07-26 09:00:37",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "excel, sas, sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "(Remote) Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 1359967,
    "job_posted_date": "2023-05-26 14:00:22",
    "job_schedule_type": "Full-time",
    "company_name": "Clark Associates",
    "skills_required": "looker, power bi, python, sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 78069,
    "job_posted_date": "2023-10-31 00:03:00",
    "job_schedule_type": "Full-time",
    "company_name": "Polygence",
    "skills_required": "excel, looker, python, r, sheets, sql, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 204667,
    "job_posted_date": "2023-10-10 20:00:44",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "oracle, power bi, sql, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 542425,
    "job_posted_date": "2023-01-04 17:05:22",
    "job_schedule_type": "Full-time",
    "company_name": "Jobot",
    "skills_required": "dax, microstrategy, power bi"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 796604,
    "job_posted_date": "2023-11-03 18:52:30",
    "job_schedule_type": "Full-time",
    "company_name": "Polygence",
    "skills_required": "excel, looker, python, r, sheets, sql, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1240374,
    "job_posted_date": "2023-04-18 14:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "crystal, excel, qlik, sas, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1467775,
    "job_posted_date": "2023-07-12 18:04:03",
    "job_schedule_type": "Contractor",
    "company_name": "Insight Global",
    "skills_required": "tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst - Looker",
    "location": "Anywhere",
    "job_id": 369634,
    "job_posted_date": "2023-02-23 14:22:02",
    "job_schedule_type": "Full-time",
    "company_name": "Hays",
    "skills_required": "looker, mongodb, postgresql, sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst (Greater LA Area, CA or Remote)",
    "location": "Anywhere",
    "job_id": 328827,
    "job_posted_date": "2023-01-06 19:01:21",
    "job_schedule_type": "Full-time",
    "company_name": "HopSkipDrive",
    "skills_required": "excel, go, sheets, sql, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst * Work from home",
    "location": "Anywhere",
    "job_id": 334078,
    "job_posted_date": "2023-10-12 00:00:16",
    "job_schedule_type": "Full-time",
    "company_name": "American Red Cross",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst III (REMOTE)",
    "location": "Anywhere",
    "job_id": 430230,
    "job_posted_date": "2023-06-14 12:25:49",
    "job_schedule_type": "Full-time",
    "company_name": "Ryder System",
    "skills_required": "alteryx, azure, express, power bi, python, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst Role",
    "location": "Anywhere",
    "job_id": 1156421,
    "job_posted_date": "2023-02-25 00:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "mariadb, mysql, php, powershell, python, sql, ssrs, t-sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Analyst, Financial Services",
    "location": "Anywhere",
    "job_id": 1230135,
    "job_posted_date": "2023-01-23 19:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Earnest Analytics",
    "skills_required": "excel, tableau"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Data Integration Analyst",
    "location": "Anywhere",
    "job_id": 1355313,
    "job_posted_date": "2023-07-20 09:00:43",
    "job_schedule_type": "Full-time",
    "company_name": "United Site Services",
    "skills_required": "flow"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Informatics Data Analyst II",
    "location": "Anywhere",
    "job_id": 1491918,
    "job_posted_date": "2023-03-29 18:17:06",
    "job_schedule_type": "Full-time",
    "company_name": "IDR, Inc.",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "95000.0",
    "jobs": "Program/Data Analyst (Health Services) Remote!",
    "location": "Anywhere",
    "job_id": 945198,
    "job_posted_date": "2023-07-03 08:01:42",
    "job_schedule_type": "Full-time",
    "company_name": "General Dynamics Information Technology",
    "skills_required": "jira"
  },
  {
    "avg_sal": "94871.5",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1127339,
    "job_posted_date": "2023-08-25 15:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Protect Democracy",
    "skills_required": "python, r"
  },
  {
    "avg_sal": "94400.0",
    "jobs": "Sustainability Oversight Data Lead Analyst - Remote",
    "location": "Anywhere",
    "job_id": 961597,
    "job_posted_date": "2023-09-05 18:00:22",
    "job_schedule_type": "Full-time",
    "company_name": "The Cigna Group",
    "skills_required": "flow, tableau"
  },
  {
    "avg_sal": "94000.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 1243771,
    "job_posted_date": "2023-06-16 08:00:21",
    "job_schedule_type": "Full-time",
    "company_name": "Tactis LLC",
    "skills_required": "excel, jira, tableau"
  },
  {
    "avg_sal": "93000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 75704,
    "job_posted_date": "2023-09-13 09:03:50",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "93000.0",
    "jobs": "Statistical Data Analyst",
    "location": "Anywhere",
    "job_id": 133125,
    "job_posted_date": "2023-11-21 15:00:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sas, word"
  },
  {
    "avg_sal": "92750.0",
    "jobs": "Sr. People Data Analyst",
    "location": "Anywhere",
    "job_id": 960363,
    "job_posted_date": "2023-04-12 14:59:52",
    "job_schedule_type": "Full-time",
    "company_name": "Medidata Solutions",
    "skills_required": "excel, powerpoint, python, r, sql, tableau"
  },
  {
    "avg_sal": "92500.0",
    "jobs": "Data Analyst (US REMOTE)",
    "location": "Anywhere",
    "job_id": 758193,
    "job_posted_date": "2023-02-15 00:50:02",
    "job_schedule_type": "Full-time",
    "company_name": "LeanTaaS",
    "skills_required": "excel, python, sql, tableau"
  },
  {
    "avg_sal": "92500.0",
    "jobs": "Data Analyst [70649]",
    "location": "Anywhere",
    "job_id": 1098113,
    "job_posted_date": "2023-02-24 21:00:39",
    "job_schedule_type": "Full-time",
    "company_name": "0nward Select",
    "skills_required": "atlassian, confluence, excel, html, javascript, jira, sharepoint, sql"
  },
  {
    "avg_sal": "92500.0",
    "jobs": "Operations Data Analyst (Greater LA Area, CA or Remote)",
    "location": "Anywhere",
    "job_id": 1190547,
    "job_posted_date": "2023-02-02 07:00:32",
    "job_schedule_type": "Full-time",
    "company_name": "HopSkipDrive",
    "skills_required": "excel, go, sheets, sql, tableau"
  },
  {
    "avg_sal": "92000.0",
    "jobs": "Data Insights Analyst (all genders) - Remote",
    "location": "Anywhere",
    "job_id": 738823,
    "job_posted_date": "2023-09-04 09:18:09",
    "job_schedule_type": "Full-time",
    "company_name": "OUTFITTERY",
    "skills_required": "pascal, python, sql, tableau"
  },
  {
    "avg_sal": "91000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1178655,
    "job_posted_date": "2023-12-05 12:00:38",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "powerpoint, python, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "100% REMOTE Data Analyst",
    "location": "Anywhere",
    "job_id": 1560173,
    "job_posted_date": "2023-01-20 17:00:34",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "aws, numpy, pandas, plotly, python, seaborn, sql, word"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Clinical Data Analyst",
    "location": "Anywhere",
    "job_id": 581546,
    "job_posted_date": "2023-08-10 15:11:23",
    "job_schedule_type": "Full-time",
    "company_name": "Engage Partners Inc.",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Credit Data Analyst",
    "location": "Anywhere",
    "job_id": 613034,
    "job_posted_date": "2023-09-09 18:00:51",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "looker, python, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analysis Manager",
    "location": "Anywhere",
    "job_id": 321007,
    "job_posted_date": "2023-02-23 08:00:38",
    "job_schedule_type": "Full-time",
    "company_name": "Maximus",
    "skills_required": null
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 116825,
    "job_posted_date": "2023-04-12 17:00:09",
    "job_schedule_type": "Full-time",
    "company_name": "hackajob",
    "skills_required": "c#, c++, java, matlab, python, r, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 196796,
    "job_posted_date": "2023-08-19 10:21:49",
    "job_schedule_type": "Full-time",
    "company_name": "Angi",
    "skills_required": "excel, python, r, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 258262,
    "job_posted_date": "2023-09-11 10:00:24",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "bigquery, sql, ssrs, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 293077,
    "job_posted_date": "2023-12-13 10:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel, microsoft teams, powerpoint"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 354417,
    "job_posted_date": "2023-03-09 01:00:37",
    "job_schedule_type": "Full-time",
    "company_name": "EcoCart",
    "skills_required": "aws, clickup, power bi, python, redshift, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 419649,
    "job_posted_date": "2023-10-10 20:01:18",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 680315,
    "job_posted_date": "2023-05-28 19:14:00",
    "job_schedule_type": "Full-time",
    "company_name": "Gotely",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 714930,
    "job_posted_date": "2023-01-10 08:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "looker, python, r, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1228142,
    "job_posted_date": "2023-09-22 01:00:12",
    "job_schedule_type": "Full-time",
    "company_name": "Grant Leading Technology, LLC",
    "skills_required": "excel, html, java, javascript, oracle, power bi, python, shell, sql, t-sql, tableau, unix, visio"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1244897,
    "job_posted_date": "2023-09-11 10:00:24",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "bigquery, sql, ssrs, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1647550,
    "job_posted_date": "2023-04-28 10:57:37",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "oracle, sas, sql, vb.net"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1729407,
    "job_posted_date": "2023-06-14 14:02:19",
    "job_schedule_type": "Full-time",
    "company_name": "General Dynamics Information Technology",
    "skills_required": "confluence, excel, javascript, jira, powerpoint, python, sharepoint, tableau, word"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1810744,
    "job_posted_date": "2023-03-13 11:58:05",
    "job_schedule_type": "Full-time",
    "company_name": "Venteon",
    "skills_required": null
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst or Data Scientist",
    "location": "Anywhere",
    "job_id": 382064,
    "job_posted_date": "2023-12-29 12:00:51",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Analyst, Supply Chain (Remote)",
    "location": "Anywhere",
    "job_id": 914174,
    "job_posted_date": "2023-01-04 03:34:13",
    "job_schedule_type": "Full-time",
    "company_name": "Home Depot / THD",
    "skills_required": "oracle, sql, sql server"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Data Science Analyst",
    "location": "Anywhere",
    "job_id": 391159,
    "job_posted_date": "2023-01-11 08:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Fraud Data Analyst",
    "location": "Anywhere",
    "job_id": 25749,
    "job_posted_date": "2023-10-19 19:01:08",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": null
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Health Data Lead Analyst - Fully Remote",
    "location": "Anywhere",
    "job_id": 514485,
    "job_posted_date": "2023-07-15 10:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "Constant Associates",
    "skills_required": "excel, python, r, sas, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 326110,
    "job_posted_date": "2023-03-06 00:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Preveta",
    "skills_required": "excel, power bi, qlik, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 648986,
    "job_posted_date": "2023-10-01 15:00:46",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 1186631,
    "job_posted_date": "2023-03-22 20:07:09",
    "job_schedule_type": "Full-time",
    "company_name": "Adaptive Solutions Group",
    "skills_required": "alteryx, excel, sql, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Real Estate Data Analyst",
    "location": "Anywhere",
    "job_id": 846860,
    "job_posted_date": "2023-09-12 10:01:41",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "bigquery, ssrs, tableau"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Real Estate Transaction Data Analyst",
    "location": "Anywhere",
    "job_id": 1152523,
    "job_posted_date": "2023-09-21 22:00:08",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Real Estate",
    "skills_required": "excel, outlook, powerpoint, word"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Strategic Data Analyst",
    "location": "Anywhere",
    "job_id": 811436,
    "job_posted_date": "2023-12-25 12:00:51",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel, planner, powerpoint, word"
  },
  {
    "avg_sal": "90000.0",
    "jobs": "Telecom Data Analyst",
    "location": "Anywhere",
    "job_id": 468153,
    "job_posted_date": "2023-07-16 00:03:10",
    "job_schedule_type": "Full-time",
    "company_name": "Axelerate",
    "skills_required": "excel"
  },
  {
    "avg_sal": "89833.5",
    "jobs": "Data Analyst 2 - Albany - Research and Statistics",
    "location": "Anywhere",
    "job_id": 663590,
    "job_posted_date": "2023-02-16 00:00:26",
    "job_schedule_type": "Full-time",
    "company_name": "Labor, Department of",
    "skills_required": null
  },
  {
    "avg_sal": "89796.0",
    "jobs": "Data Analyst (Modeling) (Remote)",
    "location": "Anywhere",
    "job_id": 122927,
    "job_posted_date": "2023-05-01 18:01:05",
    "job_schedule_type": "Full-time",
    "company_name": "Heluna Health",
    "skills_required": "julia, r, sas"
  },
  {
    "avg_sal": "89500.0",
    "jobs": "Mobile Data Analyst",
    "location": "Anywhere",
    "job_id": 1618146,
    "job_posted_date": "2023-06-28 17:00:29",
    "job_schedule_type": "Full-time",
    "company_name": "Verizon",
    "skills_required": "power bi"
  },
  {
    "avg_sal": "89000.0",
    "jobs": "Marketing Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 833662,
    "job_posted_date": "2023-07-31 17:00:15",
    "job_schedule_type": "Full-time",
    "company_name": "World Education Services",
    "skills_required": "confluence, java, javascript, jira, python, r, scala, snowflake, sql, tableau"
  },
  {
    "avg_sal": "89000.0",
    "jobs": "Senior Supply Chain Analytics Analyst",
    "location": "Anywhere",
    "job_id": 660036,
    "job_posted_date": "2023-10-12 13:02:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "alteryx, python, r, tableau"
  },
  {
    "avg_sal": "88000.0",
    "jobs": "Health Data Systems Analyst",
    "location": "Anywhere",
    "job_id": 1209792,
    "job_posted_date": "2023-08-23 09:02:26",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "88000.0",
    "jobs": "Supply Chain Data Analyst",
    "location": "Anywhere",
    "job_id": 1657752,
    "job_posted_date": "2023-07-01 07:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "excel, outlook, powerpoint, word"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 30317,
    "job_posted_date": "2023-04-28 20:56:12",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "c#, excel, flow, sql, sql server"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 826590,
    "job_posted_date": "2023-01-07 12:01:31",
    "job_schedule_type": "Contractor",
    "company_name": "Beacon Hill Staffing Group",
    "skills_required": null
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 915649,
    "job_posted_date": "2023-06-01 09:01:06",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, power bi, sql"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1489901,
    "job_posted_date": "2023-03-10 17:08:02",
    "job_schedule_type": "Full-time",
    "company_name": "Predictive Data Lab",
    "skills_required": "azure, sql"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Data Analyst - New Grad - Remote",
    "location": "Anywhere",
    "job_id": 1433360,
    "job_posted_date": "2023-09-04 15:01:59",
    "job_schedule_type": "Full-time",
    "company_name": "SeatGeek",
    "skills_required": "looker, redshift, spring, sql"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 66566,
    "job_posted_date": "2023-06-26 16:56:05",
    "job_schedule_type": "Full-time",
    "company_name": "Vatica Health",
    "skills_required": "excel, go, powerpoint, sql, tableau"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Media Data Analyst/Media Coordinator",
    "location": "Anywhere",
    "job_id": 352252,
    "job_posted_date": "2023-09-10 11:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel, sharepoint, word"
  },
  {
    "avg_sal": "87500.0",
    "jobs": "Senior Financial and Data Analyst",
    "location": "Anywhere",
    "job_id": 748524,
    "job_posted_date": "2023-06-30 21:00:14",
    "job_schedule_type": "Full-time",
    "company_name": "Oxfam America",
    "skills_required": "excel, oracle, planner, power bi, powerpoint, python, sql, tableau"
  },
  {
    "avg_sal": "87000.0",
    "jobs": "Treasury Data Analyst II",
    "location": "Anywhere",
    "job_id": 916210,
    "job_posted_date": "2023-11-22 09:01:38",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "flow, power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "87000.0",
    "jobs": "Treasury Data Analyst II",
    "location": "Anywhere",
    "job_id": 961041,
    "job_posted_date": "2023-12-08 09:01:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "86500.0",
    "jobs": "Remote Data Analyst",
    "location": "Anywhere",
    "job_id": 401243,
    "job_posted_date": "2023-04-16 09:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "oracle, sql"
  },
  {
    "avg_sal": "86500.0",
    "jobs": "Remote Data Analyst",
    "location": "Anywhere",
    "job_id": 1704094,
    "job_posted_date": "2023-04-16 10:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "oracle, sql"
  },
  {
    "avg_sal": "86000.0",
    "jobs": "Telecom Data Analyst",
    "location": "Anywhere",
    "job_id": 456839,
    "job_posted_date": "2023-04-21 08:01:49",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sheets, sql"
  },
  {
    "avg_sal": "85500.0",
    "jobs": "Data Governance Analyst",
    "location": "Anywhere",
    "job_id": 1638633,
    "job_posted_date": "2023-06-10 10:01:36",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 384007,
    "job_posted_date": "2023-07-24 07:01:42",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "azure, jira, mysql, sql, sql server"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1640252,
    "job_posted_date": "2023-11-16 08:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "r, tableau"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst - DHS Clearance Required Remote / Telecommute Jobs",
    "location": "Anywhere",
    "job_id": 27772,
    "job_posted_date": "2023-10-04 16:00:22",
    "job_schedule_type": "Full-time",
    "company_name": "Redwood Strategy Group",
    "skills_required": "excel, outlook, powerpoint, python, r, sql, tableau, visio, word"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst & Dashboard Developer",
    "location": "Anywhere",
    "job_id": 50602,
    "job_posted_date": "2023-05-17 08:59:58",
    "job_schedule_type": "Full-time",
    "company_name": "Impact Genome",
    "skills_required": "tableau, terminal"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst & Dashboard Developer",
    "location": "Anywhere",
    "job_id": 1215316,
    "job_posted_date": "2023-04-04 20:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Impact Genome",
    "skills_required": "tableau, terminal"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst & Dashboard Developer",
    "location": "Anywhere",
    "job_id": 1762396,
    "job_posted_date": "2023-03-11 20:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "Impact Genome",
    "skills_required": "tableau, terminal"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst (Hybrid - Remote/1-2 days office)/DC Metro",
    "location": "Anywhere",
    "job_id": 1201469,
    "job_posted_date": "2023-06-20 14:00:23",
    "job_schedule_type": "Full-time",
    "company_name": "Peopletek",
    "skills_required": null
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1085007,
    "job_posted_date": "2023-09-18 22:59:58",
    "job_schedule_type": "Full-time",
    "company_name": "DeepIntent",
    "skills_required": "excel, powerpoint, r, sql"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Analyst / Software Developer",
    "location": "Anywhere",
    "job_id": 1458260,
    "job_posted_date": "2023-12-19 14:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "QSE7, LLC",
    "skills_required": "excel, power bi, sharepoint, tableau, vba"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Data Mining Analyst",
    "location": "Anywhere",
    "job_id": 710614,
    "job_posted_date": "2023-03-28 18:02:56",
    "job_schedule_type": "Full-time",
    "company_name": "Envision Staffing Solutions",
    "skills_required": "excel, powerpoint, spreadsheet, word"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Growth Data Analyst",
    "location": "Anywhere",
    "job_id": 314738,
    "job_posted_date": "2023-11-16 08:01:44",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, looker, sheets, sql, tableau"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 382000,
    "job_posted_date": "2023-09-26 15:19:19",
    "job_schedule_type": "Full-time",
    "company_name": "Prime Team Partners",
    "skills_required": "excel, powerpoint, sql, tableau, word"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 1782272,
    "job_posted_date": "2023-01-14 04:03:04",
    "job_schedule_type": "Full-time",
    "company_name": "FocusKPI Inc.",
    "skills_required": "excel, powerpoint, python, sql"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "PPM Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 52176,
    "job_posted_date": "2023-02-03 21:01:33",
    "job_schedule_type": "Full-time",
    "company_name": "Mint Mobile",
    "skills_required": "atlassian, chef, excel, express, flow"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Predictive Data Analyst",
    "location": "Anywhere",
    "job_id": 196337,
    "job_posted_date": "2023-03-14 18:53:49",
    "job_schedule_type": "Full-time",
    "company_name": "SimioCloud",
    "skills_required": "alteryx, python, r, sql"
  },
  {
    "avg_sal": "85000.0",
    "jobs": "Senior Data Analyst II",
    "location": "Anywhere",
    "job_id": 1112585,
    "job_posted_date": "2023-08-28 17:00:25",
    "job_schedule_type": "Full-time",
    "company_name": "BlueLabs Analytics, Inc.",
    "skills_required": "python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "84950.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 1766497,
    "job_posted_date": "2023-12-08 15:45:33",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "alteryx, db2, sql, tableau"
  },
  {
    "avg_sal": "84800.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 1811540,
    "job_posted_date": "2023-04-10 07:00:36",
    "job_schedule_type": "Full-time",
    "company_name": "Ronin Staffing",
    "skills_required": null
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Asset Verification Data Analyst",
    "location": "Anywhere",
    "job_id": 1736157,
    "job_posted_date": "2023-11-06 09:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 367476,
    "job_posted_date": "2023-10-30 08:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, javascript, looker, python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 444259,
    "job_posted_date": "2023-11-29 10:03:49",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, javascript, looker, python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 496663,
    "job_posted_date": "2023-11-06 08:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sharepoint, webex, windows"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 547661,
    "job_posted_date": "2023-11-06 08:01:33",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "jenkins, sql"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Data Platform Analyst",
    "location": "Anywhere",
    "job_id": 1813745,
    "job_posted_date": "2023-11-28 08:01:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Experienced Data Analyst",
    "location": "Anywhere",
    "job_id": 398669,
    "job_posted_date": "2023-10-29 09:01:47",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, azure, looker, redshift, snowflake, sql, sql server, ssis, tableau"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Finance Data Analyst",
    "location": "Anywhere",
    "job_id": 1163106,
    "job_posted_date": "2023-11-20 08:00:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 104800,
    "job_posted_date": "2023-11-28 08:02:06",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 1540216,
    "job_posted_date": "2023-10-12 08:02:47",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, looker, power bi, python, r, sheets, sql, sql server, tableau"
  },
  {
    "avg_sal": "84500.0",
    "jobs": "Pricing Data Analyst",
    "location": "Anywhere",
    "job_id": 133854,
    "job_posted_date": "2023-11-18 20:00:27",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel, sap"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 1761702,
    "job_posted_date": "2023-12-24 09:59:52",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 23358,
    "job_posted_date": "2023-10-09 09:01:53",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "azure, dax, power bi, sql"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 894665,
    "job_posted_date": "2023-12-24 09:59:54",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, flow, sql, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1551217,
    "job_posted_date": "2023-12-29 11:59:56",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, javascript, looker, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1558833,
    "job_posted_date": "2023-12-10 07:54:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1683817,
    "job_posted_date": "2023-12-14 09:01:24",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "arch, word"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst- Early Career Quality Engineer",
    "location": "Anywhere",
    "job_id": 1155449,
    "job_posted_date": "2023-12-19 08:01:56",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "c#, html, java, javascript, python, sql, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst - Remote US",
    "location": "Anywhere",
    "job_id": 998283,
    "job_posted_date": "2023-12-13 09:01:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Data Analyst Intern",
    "location": "Anywhere",
    "job_id": 858421,
    "job_posted_date": "2023-12-25 09:01:14",
    "job_schedule_type": "Full-time and Internship",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sas, sql, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Early Career Data Analyst",
    "location": "Anywhere",
    "job_id": 1544793,
    "job_posted_date": "2023-12-19 08:01:56",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "nosql, python, r, sql, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 918810,
    "job_posted_date": "2023-10-03 06:01:16",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, powerpoint"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Marketing Data Analyst",
    "location": "Anywhere",
    "job_id": 122796,
    "job_posted_date": "2023-09-22 09:03:34",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "bigquery, excel, looker, power bi, python, r, sheets, sql, sql server, tableau"
  },
  {
    "avg_sal": "84000.0",
    "jobs": "Remote Data Analyst",
    "location": "Anywhere",
    "job_id": 1156181,
    "job_posted_date": "2023-11-11 09:01:30",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql, sql server, ssrs, tableau"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Accountant/Data Analyst",
    "location": "Anywhere",
    "job_id": 197120,
    "job_posted_date": "2023-05-25 19:00:40",
    "job_schedule_type": "Full-time",
    "company_name": "Robert Half",
    "skills_required": "excel, go"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 309335,
    "job_posted_date": "2023-09-10 10:00:14",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1153109,
    "job_posted_date": "2023-09-14 14:02:20",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "javascript, node.js"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1366794,
    "job_posted_date": "2023-08-18 09:00:16",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "r, tableau"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1632454,
    "job_posted_date": "2023-05-09 17:13:06",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Analyst with PowerBI expertise",
    "location": "Anywhere",
    "job_id": 1128758,
    "job_posted_date": "2023-08-23 09:01:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, python, sql"
  },
  {
    "avg_sal": "83500.0",
    "jobs": "Data Quality Analyst",
    "location": "Anywhere",
    "job_id": 1618469,
    "job_posted_date": "2023-09-17 09:00:12",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, python, sql"
  },
  {
    "avg_sal": "83200.0",
    "jobs": "Data Analyst - Part Time (Greater NYC Area, NY or Remote)",
    "location": "Anywhere",
    "job_id": 457003,
    "job_posted_date": "2023-09-22 02:59:54",
    "job_schedule_type": "Part-time",
    "company_name": "Memorial Sloan Kettering Cancer Center",
    "skills_required": "go, sql"
  },
  {
    "avg_sal": "83000.0",
    "jobs": "Budget Data Analyst (Power BI/Excel/VBA expert)",
    "location": "Anywhere",
    "job_id": 1005824,
    "job_posted_date": "2023-06-20 20:01:45",
    "job_schedule_type": "Full-time",
    "company_name": "General Dynamics Information Technology",
    "skills_required": "excel, flow, power bi, sql, vba, word"
  },
  {
    "avg_sal": "83000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 604141,
    "job_posted_date": "2023-03-24 13:01:53",
    "job_schedule_type": "Full-time",
    "company_name": "Alameda Health Consortium/Community Health Center Network",
    "skills_required": "excel, sas, sql, tableau"
  },
  {
    "avg_sal": "83000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1656466,
    "job_posted_date": "2023-08-13 11:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "matplotlib, pandas, python, qlik, redshift, snowflake, sql"
  },
  {
    "avg_sal": "83000.0",
    "jobs": "Data Governance Project Data Analyst",
    "location": "Anywhere",
    "job_id": 373211,
    "job_posted_date": "2023-08-06 10:00:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "82750.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 984993,
    "job_posted_date": "2023-12-18 23:11:07",
    "job_schedule_type": "Full-time",
    "company_name": "Luxury Presence",
    "skills_required": null
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Accounting / Data Analyst",
    "location": "Anywhere",
    "job_id": 863059,
    "job_posted_date": "2023-01-13 19:06:49",
    "job_schedule_type": "Full-time",
    "company_name": "Confidential",
    "skills_required": "oracle, sap"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Clinical Research Data Programmer Analyst",
    "location": "Anywhere",
    "job_id": 1795056,
    "job_posted_date": "2023-10-06 15:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Vitalief Inc.",
    "skills_required": "excel, ms access, r, sas"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 95123,
    "job_posted_date": "2023-07-24 10:01:08",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 103900,
    "job_posted_date": "2023-07-05 09:01:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, power bi, sql, tableau"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 672574,
    "job_posted_date": "2023-06-22 22:00:56",
    "job_schedule_type": "Full-time",
    "company_name": "Emotive",
    "skills_required": "looker, python, sql, tableau"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1715658,
    "job_posted_date": "2023-07-18 14:01:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sas, spss"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst (Tableau)",
    "location": "Anywhere",
    "job_id": 1621876,
    "job_posted_date": "2023-09-08 14:00:41",
    "job_schedule_type": "Full-time",
    "company_name": "Customer Value Partners",
    "skills_required": "excel, plotly, power bi, python, tableau"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst with PowerBI Dashboards Experience",
    "location": "Anywhere",
    "job_id": 1269187,
    "job_posted_date": "2023-07-24 10:02:16",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, python, sql"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analyst/Report Writer",
    "location": "Anywhere",
    "job_id": 908469,
    "job_posted_date": "2023-07-19 08:01:30",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Analysts- Capital Markets Team",
    "location": "Anywhere",
    "job_id": 934891,
    "job_posted_date": "2023-01-30 17:02:30",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "excel, sql, word"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Delivery Analyst",
    "location": "Anywhere",
    "job_id": 427343,
    "job_posted_date": "2023-11-18 09:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Data Insight Analyst",
    "location": "Anywhere",
    "job_id": 838391,
    "job_posted_date": "2023-07-15 09:01:46",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Healthcare Data Analyst - Remote in RI",
    "location": "Anywhere",
    "job_id": 1758551,
    "job_posted_date": "2023-09-09 08:00:21",
    "job_schedule_type": "Full-time",
    "company_name": "Complete HR Solutions",
    "skills_required": "sql"
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Part-time Data Analyst",
    "location": "Anywhere",
    "job_id": 337179,
    "job_posted_date": "2023-07-25 16:00:27",
    "job_schedule_type": "Part-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "82500.0",
    "jobs": "Technical/Data Analyst",
    "location": "Anywhere",
    "job_id": 1727059,
    "job_posted_date": "2023-07-28 09:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "c#, excel, python, sql, vba"
  },
  {
    "avg_sal": "82350.5",
    "jobs": "SQL Data Analyst - Healthcare",
    "location": "Anywhere",
    "job_id": 879043,
    "job_posted_date": "2023-07-22 06:59:58",
    "job_schedule_type": "Full-time",
    "company_name": "Village Care",
    "skills_required": "excel, python, r, sql, tableau"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Business Data Analyst II",
    "location": "Anywhere",
    "job_id": 318830,
    "job_posted_date": "2023-06-26 11:56:08",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql, tableau"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1115037,
    "job_posted_date": "2023-06-18 12:00:16",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, power bi, sql"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1296038,
    "job_posted_date": "2023-07-23 09:59:52",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, python, r, sql, tableau"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Data Analyst - Ad Tech and Google Ad Manager Experience (Remote)",
    "location": "Anywhere",
    "job_id": 5174,
    "job_posted_date": "2023-06-21 09:52:38",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "go, looker, python, r, redshift, snowflake, sql, tableau"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Data Analyst (Junior/Mid/Senior) - Remote - Defense Manpower Data...",
    "location": "Anywhere",
    "job_id": 463381,
    "job_posted_date": "2023-06-25 09:00:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "oracle, sql, t-sql"
  },
  {
    "avg_sal": "82000.0",
    "jobs": "Research Data Analyst I",
    "location": "Anywhere",
    "job_id": 288466,
    "job_posted_date": "2023-06-18 12:01:45",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "81500.0",
    "jobs": "Lead Data Analyst - Looker Studio Expert",
    "location": "Anywhere",
    "job_id": 1638787,
    "job_posted_date": "2023-06-14 09:00:32",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, sql"
  },
  {
    "avg_sal": "81500.0",
    "jobs": "Pharmacy Data Analyst",
    "location": "Anywhere",
    "job_id": 223644,
    "job_posted_date": "2023-06-14 09:02:06",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "arch, excel, outlook, power bi, sql, sql server, ssrs, tableau, word"
  },
  {
    "avg_sal": "81047.0",
    "jobs": "Data Analyst, Mortgage Enforcement Unit, Remote Opportunity",
    "location": "Anywhere",
    "job_id": 1436603,
    "job_posted_date": "2023-02-03 17:00:00",
    "job_schedule_type": "Full-time",
    "company_name": "New York State Office of the Attorney General",
    "skills_required": "excel, r"
  },
  {
    "avg_sal": "81000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 143947,
    "job_posted_date": "2023-05-11 14:00:09",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, matlab, python, r, scala, sql"
  },
  {
    "avg_sal": "81000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 413083,
    "job_posted_date": "2023-06-06 10:01:41",
    "job_schedule_type": "Contractor",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql, tableau"
  },
  {
    "avg_sal": "81000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 980665,
    "job_posted_date": "2023-05-16 10:01:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql, tableau"
  },
  {
    "avg_sal": "81000.0",
    "jobs": "Data Analytics and Reporting Analyst",
    "location": "Anywhere",
    "job_id": 606788,
    "job_posted_date": "2023-09-09 09:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "snowflake, sql, sql server, ssrs, tableau"
  },
  {
    "avg_sal": "80740.0",
    "jobs": "Research Data Analyst-",
    "location": "Anywhere",
    "job_id": 1025744,
    "job_posted_date": "2023-11-25 02:00:36",
    "job_schedule_type": "Full-time and Temp work",
    "company_name": "InsideHigherEd",
    "skills_required": "python, r, sas, zoom"
  },
  {
    "avg_sal": "80500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 670376,
    "job_posted_date": "2023-09-01 10:00:32",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "80500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1049953,
    "job_posted_date": "2023-08-15 21:00:29",
    "job_schedule_type": "Full-time",
    "company_name": "California State University",
    "skills_required": null
  },
  {
    "avg_sal": "80500.0",
    "jobs": "Lead Data Analyst for Big Data Projects",
    "location": "Anywhere",
    "job_id": 1472332,
    "job_posted_date": "2023-04-23 08:01:44",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "80250.0",
    "jobs": "Data Analyst - Underwriting",
    "location": "Anywhere",
    "job_id": 711091,
    "job_posted_date": "2023-04-01 11:01:29",
    "job_schedule_type": "Full-time",
    "company_name": "Automobile Club of Southern California",
    "skills_required": "bash, java, python, sql, tableau, vba"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "AI-focused Data Analyst/Tableau Developer",
    "location": "Anywhere",
    "job_id": 1075985,
    "job_posted_date": "2023-11-04 09:01:25",
    "job_schedule_type": "Full-time and Contractor",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, java, power bi, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Claims Data Analyst - 208554",
    "location": "Anywhere",
    "job_id": 566131,
    "job_posted_date": "2023-07-28 16:03:55",
    "job_schedule_type": "Full-time",
    "company_name": "Medix Technology",
    "skills_required": "alteryx, power bi, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 6083,
    "job_posted_date": "2023-02-27 21:37:51",
    "job_schedule_type": "Full-time",
    "company_name": "EUCON AMERICAS LLC",
    "skills_required": "excel, powerpoint, sas, spss, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 319413,
    "job_posted_date": "2023-08-07 21:00:38",
    "job_schedule_type": "Full-time",
    "company_name": "Coders Data",
    "skills_required": "excel, ms access, outlook, powerpoint, word"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 483152,
    "job_posted_date": "2023-01-06 20:02:41",
    "job_schedule_type": "Full-time",
    "company_name": "New World Now LLC",
    "skills_required": "sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 690454,
    "job_posted_date": "2023-04-03 21:00:08",
    "job_schedule_type": "Full-time",
    "company_name": "Gravy Analytics",
    "skills_required": "aws, excel, javascript, python, r, snowflake, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 940759,
    "job_posted_date": "2023-07-30 10:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1236616,
    "job_posted_date": "2023-02-28 08:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "Peraton",
    "skills_required": "aws, python, qlik, sas, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1333002,
    "job_posted_date": "2023-07-20 10:01:51",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "power bi, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1354750,
    "job_posted_date": "2023-08-03 20:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "Coders Data",
    "skills_required": "confluence, excel, jira, power bi, python, r, sharepoint, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst- Power BI (Remote)",
    "location": "Anywhere",
    "job_id": 276098,
    "job_posted_date": "2023-06-19 23:43:42",
    "job_schedule_type": "Full-time",
    "company_name": "HighGround",
    "skills_required": "azure, excel, spreadsheet, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 664113,
    "job_posted_date": "2023-09-15 23:01:19",
    "job_schedule_type": "Full-time",
    "company_name": "CrowdStrike",
    "skills_required": "python, snowflake, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analytics Consultant",
    "location": "Anywhere",
    "job_id": 1434052,
    "job_posted_date": "2023-08-03 18:00:27",
    "job_schedule_type": "Full-time",
    "company_name": "FutureNET",
    "skills_required": "cognos, powerpoint, r, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Data Analytics Manager",
    "location": "Anywhere",
    "job_id": 519106,
    "job_posted_date": "2023-10-11 23:31:55",
    "job_schedule_type": "Full-time",
    "company_name": "Itemize Corp.",
    "skills_required": "aws, mysql, sql"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 550113,
    "job_posted_date": "2023-06-20 07:01:39",
    "job_schedule_type": "Full-time",
    "company_name": "Motion Recruitment",
    "skills_required": "python"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 564679,
    "job_posted_date": "2023-10-09 20:01:53",
    "job_schedule_type": "Full-time",
    "company_name": "Coders Data",
    "skills_required": "confluence, excel, jira, python, r, sharepoint, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Manufacturing Data Analyst",
    "location": "Anywhere",
    "job_id": 794255,
    "job_posted_date": "2023-09-27 17:17:33",
    "job_schedule_type": "Full-time",
    "company_name": "ATR International",
    "skills_required": "excel, matplotlib, python, r, sql, tableau"
  },
  {
    "avg_sal": "80000.0",
    "jobs": "Sr. Business Analyst/Data Analyst",
    "location": "Anywhere",
    "job_id": 911869,
    "job_posted_date": "2023-06-21 16:02:08",
    "job_schedule_type": "Full-time",
    "company_name": "CBRE",
    "skills_required": "alteryx, excel, power bi"
  },
  {
    "avg_sal": "79968.0",
    "jobs": "Data Analyst - Remote | WFH",
    "location": "Anywhere",
    "job_id": 430789,
    "job_posted_date": "2023-02-21 16:21:59",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Technology",
    "skills_required": "looker, python, r, redshift, snowflake, sql, tableau"
  },
  {
    "avg_sal": "79500.0",
    "jobs": "Remote Geospatial Data Analyst",
    "location": "Anywhere",
    "job_id": 1801810,
    "job_posted_date": "2023-08-12 10:01:50",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "79415.5",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 36488,
    "job_posted_date": "2023-11-17 17:01:39",
    "job_schedule_type": "Full-time",
    "company_name": "Texas Workforce Commission",
    "skills_required": "go, microsoft teams, power bi, python, r, sas, spss, sql, tableau"
  },
  {
    "avg_sal": "79060.5",
    "jobs": "Health Data Analyst - Hybrid",
    "location": "Anywhere",
    "job_id": 401772,
    "job_posted_date": "2023-11-09 07:01:18",
    "job_schedule_type": "Full-time",
    "company_name": "Teacher Retirement System of Texas",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "79000.0",
    "jobs": "Remote - Data Analyst - Permanent - W2",
    "location": "Anywhere",
    "job_id": 189043,
    "job_posted_date": "2023-02-21 12:32:53",
    "job_schedule_type": "Full-time",
    "company_name": "Apex Systems",
    "skills_required": "c#, c++, python, sql"
  },
  {
    "avg_sal": "78040.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 59423,
    "job_posted_date": "2023-11-24 16:01:21",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": null
  },
  {
    "avg_sal": "78000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1723219,
    "job_posted_date": "2023-03-13 11:00:54",
    "job_schedule_type": "Full-time",
    "company_name": "Visual Connections, LLC",
    "skills_required": "cognos, excel, powerpoint, python, r, sas, sql, webex, word"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analysis and Production Support Analyst",
    "location": "Anywhere",
    "job_id": 704236,
    "job_posted_date": "2023-10-05 10:00:13",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "jupyter, python"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 397963,
    "job_posted_date": "2023-07-31 19:00:25",
    "job_schedule_type": "Full-time",
    "company_name": "Coders Data",
    "skills_required": "excel, mysql, python, sql, tableau"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 435726,
    "job_posted_date": "2023-12-15 06:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "JDC",
    "skills_required": "excel"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 502625,
    "job_posted_date": "2023-10-09 13:40:58",
    "job_schedule_type": "Full-time",
    "company_name": "Simplex.",
    "skills_required": "azure, python, snowflake, sql, sqlite"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1236681,
    "job_posted_date": "2023-11-08 18:21:53",
    "job_schedule_type": "Full-time",
    "company_name": "Simplex",
    "skills_required": "azure, python, snowflake, sql, sqlite"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1745486,
    "job_posted_date": "2023-11-09 08:01:11",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, sql"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 1600670,
    "job_posted_date": "2023-11-02 12:00:14",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": null
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Northeast Territory Data Analyst",
    "location": "Anywhere",
    "job_id": 1311958,
    "job_posted_date": "2023-08-18 10:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel, power bi, smartsheet"
  },
  {
    "avg_sal": "77500.0",
    "jobs": "Product Specialist (Data Analytics) (Remote)",
    "location": "Anywhere",
    "job_id": 1101994,
    "job_posted_date": "2023-02-02 07:00:37",
    "job_schedule_type": "Full-time",
    "company_name": "NBCUniversal",
    "skills_required": "dax, excel, jira, power bi, sql"
  },
  {
    "avg_sal": "77350.0",
    "jobs": "Data Analyst - CropSights, a Precision Ag Platform (Remote - Must...",
    "location": "Anywhere",
    "job_id": 1379514,
    "job_posted_date": "2023-07-03 00:00:50",
    "job_schedule_type": "Full-time",
    "company_name": "Wilbur-Ellis Company",
    "skills_required": "excel, python, r, sql"
  },
  {
    "avg_sal": "77000.0",
    "jobs": "Information Protection Data Analyst - Remote | WFH",
    "location": "Anywhere",
    "job_id": 974504,
    "job_posted_date": "2023-03-17 10:04:52",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "azure, excel, outlook, powerpoint, powershell, python, sql, sql server"
  },
  {
    "avg_sal": "76842.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 411881,
    "job_posted_date": "2023-12-05 14:01:22",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "alteryx, excel, sas, sql, tableau"
  },
  {
    "avg_sal": "76783.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1500082,
    "job_posted_date": "2023-09-15 15:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "sql"
  },
  {
    "avg_sal": "76559.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 487133,
    "job_posted_date": "2023-09-20 10:00:05",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "excel, sas, sql, vba"
  },
  {
    "avg_sal": "76500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 558598,
    "job_posted_date": "2023-04-14 01:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "Invitae",
    "skills_required": "excel, looker, sheets, spring, sql, tableau"
  },
  {
    "avg_sal": "76364.5",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1219618,
    "job_posted_date": "2023-06-09 22:00:04",
    "job_schedule_type": "Full-time",
    "company_name": "Stride inc",
    "skills_required": "c, excel, powerpoint, sharepoint, sql, vba, word"
  },
  {
    "avg_sal": "76007.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 164596,
    "job_posted_date": "2023-08-03 13:02:41",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "matplotlib, power bi, python, r, sas, sql, tableau"
  },
  {
    "avg_sal": "76007.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 959874,
    "job_posted_date": "2023-08-05 14:17:09",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "excel"
  },
  {
    "avg_sal": "76000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1259256,
    "job_posted_date": "2023-08-05 07:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "76000.0",
    "jobs": "GTM Revenue Operations Data Analyst",
    "location": "Anywhere",
    "job_id": 757196,
    "job_posted_date": "2023-01-25 01:01:52",
    "job_schedule_type": "Full-time",
    "company_name": "UiPath",
    "skills_required": "excel, go, powerpoint, tableau"
  },
  {
    "avg_sal": "75566.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 371461,
    "job_posted_date": "2023-09-21 20:01:29",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Marketing",
    "skills_required": "looker, power bi, sql, tableau"
  },
  {
    "avg_sal": "75500.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1068141,
    "job_posted_date": "2023-02-04 07:00:30",
    "job_schedule_type": "Full-time",
    "company_name": "ServiceTitan",
    "skills_required": "aws, azure, flow, snowflake, sql, tableau"
  },
  {
    "avg_sal": "75296.0",
    "jobs": "Health Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 1365513,
    "job_posted_date": "2023-07-29 07:01:16",
    "job_schedule_type": "Full-time",
    "company_name": "Teacher Retirement System of Texas",
    "skills_required": "python, r, sql"
  },
  {
    "avg_sal": "75250.0",
    "jobs": "Data Analyst - Department of Surgery/JRSC (Greater NYC Area, NY or...",
    "location": "Anywhere",
    "job_id": 368638,
    "job_posted_date": "2023-09-29 22:59:52",
    "job_schedule_type": "Full-time",
    "company_name": "Memorial Sloan Kettering Cancer Center",
    "skills_required": "excel, go, r, sql, tableau"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Associate Data Analyst",
    "location": "Anywhere",
    "job_id": 1406540,
    "job_posted_date": "2023-07-10 19:01:00",
    "job_schedule_type": "Full-time",
    "company_name": "Beyond 12",
    "skills_required": "excel, looker, python, sql"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 240037,
    "job_posted_date": "2023-11-24 19:20:27",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Hospitality",
    "skills_required": "excel, powerpoint"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 257140,
    "job_posted_date": "2023-10-31 08:12:19",
    "job_schedule_type": "Full-time",
    "company_name": "Veeva Systems",
    "skills_required": null
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 341807,
    "job_posted_date": "2023-11-24 09:20:25",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, powerpoint"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 479282,
    "job_posted_date": "2023-04-05 18:00:19",
    "job_schedule_type": "Full-time",
    "company_name": "hackajob",
    "skills_required": "c#, c++, java, matlab, python, r, sql"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1513802,
    "job_posted_date": "2023-01-13 17:06:49",
    "job_schedule_type": "Full-time",
    "company_name": "In Technology Group Inc (US)",
    "skills_required": "excel, power bi, python, snowflake, sql, tableau"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst - ggplot2, R, SQL, Python- Remote",
    "location": "Anywhere",
    "job_id": 210881,
    "job_posted_date": "2023-03-07 23:02:19",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "ggplot2, python, r, sql, word"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst - SaaS - EdTech",
    "location": "Anywhere",
    "job_id": 1517483,
    "job_posted_date": "2023-07-17 07:50:34",
    "job_schedule_type": "Full-time",
    "company_name": "KodeKloud",
    "skills_required": "hadoop, power bi, sql, tableau"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "DATA ANALYST - We offer career advancement, a work-life balance...",
    "location": "Anywhere",
    "job_id": 1461191,
    "job_posted_date": "2023-02-08 20:00:52",
    "job_schedule_type": "Full-time",
    "company_name": "Zunch Staffing",
    "skills_required": "sas, spss, sql"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst, Category Management & Demand Planning",
    "location": "Anywhere",
    "job_id": 221984,
    "job_posted_date": "2023-11-23 09:00:57",
    "job_schedule_type": "Full-time",
    "company_name": "MaryRuth's",
    "skills_required": "excel, flow, sap"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Data Analyst/Epic Cogito",
    "location": "Anywhere",
    "job_id": 555049,
    "job_posted_date": "2023-08-31 18:00:41",
    "job_schedule_type": "Full-time",
    "company_name": "Engage Partners Inc.",
    "skills_required": "sql, tableau"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "HR Data Analyst",
    "location": "Anywhere",
    "job_id": 1065749,
    "job_posted_date": "2023-01-26 19:01:47",
    "job_schedule_type": "Full-time",
    "company_name": "Chicken of the Sea",
    "skills_required": "excel, powerpoint, spark"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "HR Jr. Data Analyst",
    "location": "Anywhere",
    "job_id": 764861,
    "job_posted_date": "2023-03-30 21:01:08",
    "job_schedule_type": "Full-time",
    "company_name": "Chicken of the Sea",
    "skills_required": "excel, powerpoint, spark"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 156786,
    "job_posted_date": "2023-07-26 07:02:26",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Junior Data Analyst - US/Canada",
    "location": "Anywhere",
    "job_id": 1321085,
    "job_posted_date": "2023-07-20 07:00:27",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Junior Data BI Analyst",
    "location": "Anywhere",
    "job_id": 1170721,
    "job_posted_date": "2023-07-27 07:02:24",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Research Data Analyst",
    "location": "Anywhere",
    "job_id": 1210145,
    "job_posted_date": "2023-08-17 16:03:02",
    "job_schedule_type": "Full-time",
    "company_name": "Health Choice Network",
    "skills_required": "sql, sql server, word"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Research Data Analyst",
    "location": "Anywhere",
    "job_id": 1241014,
    "job_posted_date": "2023-08-22 19:02:59",
    "job_schedule_type": "Full-time",
    "company_name": "Health Choice Network",
    "skills_required": "sql, sql server, word"
  },
  {
    "avg_sal": "75000.0",
    "jobs": "Supply Chain Data Analyst",
    "location": "Anywhere",
    "job_id": 193923,
    "job_posted_date": "2023-08-19 18:00:54",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "excel, power bi"
  },
  {
    "avg_sal": "74500.0",
    "jobs": "Research Data Analyst",
    "location": "Anywhere",
    "job_id": 813827,
    "job_posted_date": "2023-08-16 12:01:01",
    "job_schedule_type": "Full-time",
    "company_name": "Southern California University",
    "skills_required": "excel, powerpoint, r, sas, spss, tableau, word"
  },
  {
    "avg_sal": "74224.5",
    "jobs": "Data Scientist/Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 47248,
    "job_posted_date": "2023-05-10 13:56:58",
    "job_schedule_type": "Full-time",
    "company_name": "NCUA",
    "skills_required": "c, python, r"
  },
  {
    "avg_sal": "74049.0",
    "jobs": "Healthcare Data Analyst",
    "location": "Anywhere",
    "job_id": 425984,
    "job_posted_date": "2023-12-05 18:00:59",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "jira, python, r, sas, sql"
  },
  {
    "avg_sal": "74000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1726747,
    "job_posted_date": "2023-07-13 10:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Applied Engineering Management Corporation",
    "skills_required": "excel, python, r, sas"
  },
  {
    "avg_sal": "74000.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1338279,
    "job_posted_date": "2023-03-16 22:00:13",
    "job_schedule_type": "Full-time",
    "company_name": "Retriever Medial Dental Payments LLC",
    "skills_required": "excel, python, r, sql, sql server, tableau, vba"
  },
  {
    "avg_sal": "73696.0",
    "jobs": "Data Insight Analyst",
    "location": "Anywhere",
    "job_id": 669824,
    "job_posted_date": "2023-10-31 13:01:51",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "73631.0",
    "jobs": "Medicare Compliance Data Analyst",
    "location": "Anywhere",
    "job_id": 1553132,
    "job_posted_date": "2023-12-02 16:00:09",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": "alteryx, excel, powerpoint, sql"
  },
  {
    "avg_sal": "73000.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 1395633,
    "job_posted_date": "2023-12-23 16:59:57",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "dax, excel, power bi, python, sql, tableau, vba"
  },
  {
    "avg_sal": "73000.0",
    "jobs": "Research Scientist (Remote)",
    "location": "Anywhere",
    "job_id": 769341,
    "job_posted_date": "2023-02-02 11:04:54",
    "job_schedule_type": "Full-time",
    "company_name": "Center for Open Science",
    "skills_required": "r"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Contact Center Data Analyst",
    "location": "Anywhere",
    "job_id": 1446024,
    "job_posted_date": "2023-10-06 23:37:00",
    "job_schedule_type": "Full-time",
    "company_name": "CharterUP",
    "skills_required": "erlang, excel, express, power bi, sheets, tableau"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 93604,
    "job_posted_date": "2023-08-08 20:49:34",
    "job_schedule_type": "Full-time",
    "company_name": "Bluesight",
    "skills_required": "excel, python, r, ruby, sheets, sql"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1262610,
    "job_posted_date": "2023-02-06 15:06:52",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1684855,
    "job_posted_date": "2023-03-28 17:02:52",
    "job_schedule_type": "Full-time",
    "company_name": "Every Body Texas",
    "skills_required": "azure, power bi, r, spss, sql"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Data Analyst III",
    "location": "Anywhere",
    "job_id": 621498,
    "job_posted_date": "2023-04-19 19:01:49",
    "job_schedule_type": "Full-time",
    "company_name": "Global Healthcare Exchange, Inc.",
    "skills_required": "excel, gitlab, python, r, sql"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Data Analyst Marketing",
    "location": "Anywhere",
    "job_id": 468876,
    "job_posted_date": "2023-01-30 19:02:17",
    "job_schedule_type": "Full-time",
    "company_name": "Coda Staffing",
    "skills_required": "matplotlib, plotly, python, r, sas, seaborn, spss, sql"
  },
  {
    "avg_sal": "72500.0",
    "jobs": "Pricing Data Analyst",
    "location": "Anywhere",
    "job_id": 1583314,
    "job_posted_date": "2023-12-18 09:00:33",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sap"
  },
  {
    "avg_sal": "72450.0",
    "jobs": "Data Analyst - Remote",
    "location": "Anywhere",
    "job_id": 360331,
    "job_posted_date": "2023-10-04 12:41:19",
    "job_schedule_type": "Full-time",
    "company_name": "CACI International Inc",
    "skills_required": null
  },
  {
    "avg_sal": "72000.0",
    "jobs": "Junior Business/Data Analyst",
    "location": "Anywhere",
    "job_id": 432310,
    "job_posted_date": "2023-07-28 09:00:20",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "nosql, sql"
  },
  {
    "avg_sal": "71850.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 361990,
    "job_posted_date": "2022-12-31 08:01:47",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "alteryx, excel, power bi, tableau"
  },
  {
    "avg_sal": "71850.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1698696,
    "job_posted_date": "2023-01-12 08:00:40",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "phoenix, python, r, sql, tableau"
  },
  {
    "avg_sal": "71850.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 897644,
    "job_posted_date": "2023-04-15 07:46:41",
    "job_schedule_type": "Full-time",
    "company_name": "CVS Health",
    "skills_required": "sql"
  },
  {
    "avg_sal": "71000.0",
    "jobs": "Data Analyst Intern",
    "location": "Anywhere",
    "job_id": 225308,
    "job_posted_date": "2023-12-04 09:00:41",
    "job_schedule_type": "Full-time and Internship",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, python, sql"
  },
  {
    "avg_sal": "70500.0",
    "jobs": "Investment Operations Data Analyst",
    "location": "Anywhere",
    "job_id": 1096460,
    "job_posted_date": "2023-05-03 13:52:22",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Asset Verification Data Analyst",
    "location": "Anywhere",
    "job_id": 1625061,
    "job_posted_date": "2023-05-17 09:01:09",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Community Data Analyst",
    "location": "Anywhere",
    "job_id": 1397514,
    "job_posted_date": "2023-12-26 09:01:09",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "planner, python"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 134039,
    "job_posted_date": "2023-11-03 00:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Class Action Capital Recovery LLC",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 330595,
    "job_posted_date": "2023-11-22 22:09:17",
    "job_schedule_type": "Full-time",
    "company_name": "Ohio Shared Information Services Inc",
    "skills_required": "azure, crystal, flow, git, power bi, sql, sql server, t-sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 442024,
    "job_posted_date": "2023-02-02 22:01:05",
    "job_schedule_type": "Full-time",
    "company_name": "Coda Search│Staffing",
    "skills_required": "matplotlib, plotly, python, r, sas, seaborn, spss, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 723713,
    "job_posted_date": "2023-02-13 20:06:14",
    "job_schedule_type": "Full-time",
    "company_name": "Amplified Sourcing",
    "skills_required": "python, r, sas, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1109298,
    "job_posted_date": "2023-12-03 10:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1473524,
    "job_posted_date": "2023-01-25 22:59:51",
    "job_schedule_type": "Full-time",
    "company_name": "Partnership Employment",
    "skills_required": "excel, redshift, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1527329,
    "job_posted_date": "2023-05-30 07:59:57",
    "job_schedule_type": "Full-time",
    "company_name": "Zelo Digital Recruitment",
    "skills_required": "power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1717917,
    "job_posted_date": "2023-03-29 16:00:03",
    "job_schedule_type": "Full-time",
    "company_name": "Taylor",
    "skills_required": null
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 683865,
    "job_posted_date": "2023-03-02 15:49:09",
    "job_schedule_type": "Full-time",
    "company_name": "Global Accounting Network",
    "skills_required": "power bi, python, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Fraud Data Analyst",
    "location": "Anywhere",
    "job_id": 539154,
    "job_posted_date": "2023-09-20 22:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Pentasia",
    "skills_required": "excel, python, r, sql"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Healthcare Contract/Data Analyst",
    "location": "Anywhere",
    "job_id": 339742,
    "job_posted_date": "2023-04-20 09:00:04",
    "job_schedule_type": "Full-time",
    "company_name": "Kermit",
    "skills_required": "excel"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Junior Reporting Data Analyst",
    "location": "Anywhere",
    "job_id": 1264889,
    "job_posted_date": "2023-07-08 10:00:04",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, python, sharepoint, sql, tableau, vba"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Loan Data Analyst",
    "location": "Anywhere",
    "job_id": 50512,
    "job_posted_date": "2023-09-17 15:01:07",
    "job_schedule_type": "Full-time",
    "company_name": "AdelFi",
    "skills_required": "spreadsheet"
  },
  {
    "avg_sal": "70000.0",
    "jobs": "Manufacturing Operations Data Analyst",
    "location": "Anywhere",
    "job_id": 1128522,
    "job_posted_date": "2023-08-16 13:01:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "planner, sql"
  },
  {
    "avg_sal": "69500.0",
    "jobs": "Data & Analytics Analyst - Virtual, USA",
    "location": "Anywhere",
    "job_id": 482909,
    "job_posted_date": "2023-08-16 17:14:31",
    "job_schedule_type": "Full-time",
    "company_name": "Diversified",
    "skills_required": "power bi, python, sql"
  },
  {
    "avg_sal": "69000.0",
    "jobs": "Clinical Data Analyst I (REMOTE-USA)",
    "location": "Anywhere",
    "job_id": 297571,
    "job_posted_date": "2023-08-21 15:00:52",
    "job_schedule_type": "Full-time",
    "company_name": "Ambry Genetics Corporation",
    "skills_required": "aws, excel, mysql, tableau"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 38696,
    "job_posted_date": "2023-01-26 15:51:48",
    "job_schedule_type": "Contractor",
    "company_name": "Insight Global",
    "skills_required": "colocation"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1400357,
    "job_posted_date": "2023-01-25 19:01:59",
    "job_schedule_type": "Full-time",
    "company_name": "AllianceChicago",
    "skills_required": "azure, c#, flow, power bi, python, sass, sql, sql server, ssis, ssrs, terminal"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Data Analyst (SQL) :Role 3354",
    "location": "Anywhere",
    "job_id": 60732,
    "job_posted_date": "2023-04-11 17:01:23",
    "job_schedule_type": "Full-time",
    "company_name": "iTalent Digital",
    "skills_required": "excel, express, python, sql, tableau"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Data Analyst for Democratic Attorneys General and AG Candidates",
    "location": "Anywhere",
    "job_id": 605922,
    "job_posted_date": "2023-05-02 08:00:26",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "looker, python, r, sql"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Forensic Data Analyst",
    "location": "Anywhere",
    "job_id": 534826,
    "job_posted_date": "2023-12-10 07:53:43",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Research/Data Analyst",
    "location": "Anywhere",
    "job_id": 618426,
    "job_posted_date": "2023-09-11 10:44:32",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "ms access"
  },
  {
    "avg_sal": "67500.0",
    "jobs": "Survey Data Analyst",
    "location": "Anywhere",
    "job_id": 243487,
    "job_posted_date": "2023-06-27 19:02:16",
    "job_schedule_type": "Full-time",
    "company_name": "CyberCoders",
    "skills_required": "excel, r, tableau"
  },
  {
    "avg_sal": "66500.0",
    "jobs": "Community Data Analyst",
    "location": "Anywhere",
    "job_id": 1010619,
    "job_posted_date": "2023-11-26 08:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "planner, python, r, spss"
  },
  {
    "avg_sal": "65062.3984375",
    "jobs": "Analyst, Master Data Management",
    "location": "Anywhere",
    "job_id": 871527,
    "job_posted_date": "2023-10-31 10:01:40",
    "job_schedule_type": "Full-time",
    "company_name": "Ascension",
    "skills_required": "excel, sheets"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 179983,
    "job_posted_date": "2023-09-26 18:04:34",
    "job_schedule_type": "Contractor",
    "company_name": "24 Seven Talent",
    "skills_required": "airflow, bigquery, excel, git, python, r, sql"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 450752,
    "job_posted_date": "2023-12-16 01:00:26",
    "job_schedule_type": "Full-time",
    "company_name": "Mothership Strategies, LLC",
    "skills_required": "python, r, spark, sql"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1463732,
    "job_posted_date": "2023-01-17 23:02:07",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1596146,
    "job_posted_date": "2023-05-02 20:56:56",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "alteryx, excel, oracle, power bi, sql, tableau"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1812494,
    "job_posted_date": "2023-07-15 01:59:54",
    "job_schedule_type": "Full-time",
    "company_name": "Bright Power",
    "skills_required": "excel, flow, jira, mysql, python, sql, tableau"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst - Educational Non-profit",
    "location": "Anywhere",
    "job_id": 1538266,
    "job_posted_date": "2023-01-04 19:05:45",
    "job_schedule_type": "Full-time",
    "company_name": "Express Employment Professionals",
    "skills_required": null
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst (Entry Level)",
    "location": "Anywhere",
    "job_id": 1334734,
    "job_posted_date": "2023-07-08 06:59:57",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst (Entry Level) - US/Canada",
    "location": "Anywhere",
    "job_id": 394469,
    "job_posted_date": "2023-07-30 07:00:12",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data Analyst (Entry Level) - US/Canada",
    "location": "Anywhere",
    "job_id": 1785615,
    "job_posted_date": "2023-07-31 07:02:38",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, sheets, sql"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data BI Analyst (Entry Level)",
    "location": "Anywhere",
    "job_id": 604011,
    "job_posted_date": "2023-07-11 07:00:10",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data BI Analyst (Entry Level) - US",
    "location": "Anywhere",
    "job_id": 946898,
    "job_posted_date": "2023-07-28 07:00:17",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data BI Analyst (Entry Level) - US/Canada",
    "location": "Anywhere",
    "job_id": 384112,
    "job_posted_date": "2023-07-30 07:00:15",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Data BI Analyst (Entry Level) - US/Canada",
    "location": "Anywhere",
    "job_id": 1403912,
    "job_posted_date": "2023-08-25 07:03:31",
    "job_schedule_type": "Full-time",
    "company_name": "Patterned Learning AI",
    "skills_required": "excel, hadoop, nosql, oracle, sql, tableau, vba"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Electronic Data Interchange Analyst",
    "location": "Anywhere",
    "job_id": 1705282,
    "job_posted_date": "2023-01-18 23:02:57",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": "excel"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "HR Reporting & Analytics Manager",
    "location": "Anywhere",
    "job_id": 549336,
    "job_posted_date": "2023-09-21 19:01:35",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "flow"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Jr. Marketing Data Analyst- Ecommerce",
    "location": "Anywhere",
    "job_id": 466817,
    "job_posted_date": "2023-01-04 16:00:23",
    "job_schedule_type": "Full-time",
    "company_name": "Aquent Studios",
    "skills_required": "excel, sql, tableau"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 1441940,
    "job_posted_date": "2023-07-22 08:01:52",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, ms access, power bi, powerpoint, sql, tableau, vba, visual basic, word"
  },
  {
    "avg_sal": "65000.0",
    "jobs": "SQL Data Analyst",
    "location": "Anywhere",
    "job_id": 262937,
    "job_posted_date": "2023-10-30 07:00:33",
    "job_schedule_type": "Full-time",
    "company_name": "Citron IT, Inc.",
    "skills_required": "azure, power bi, python, r, sql, tableau"
  },
  {
    "avg_sal": "63991.0",
    "jobs": "Data Analyst - (100% Remote)",
    "location": "Anywhere",
    "job_id": 1526157,
    "job_posted_date": "2023-01-10 00:01:09",
    "job_schedule_type": "Full-time",
    "company_name": "Monterey Park Auto Body Inc",
    "skills_required": null
  },
  {
    "avg_sal": "63594.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 510271,
    "job_posted_date": "2023-12-29 15:59:59",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Healthcare",
    "skills_required": null
  },
  {
    "avg_sal": "63000.0",
    "jobs": "Data Analyst - Bargersville, IN",
    "location": "Anywhere",
    "job_id": 1566988,
    "job_posted_date": "2023-05-17 08:01:46",
    "job_schedule_type": "Full-time",
    "company_name": "VetJobs & Military Spouse Jobs",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Business Data Analyst",
    "location": "Anywhere",
    "job_id": 1301761,
    "job_posted_date": "2023-06-20 17:01:17",
    "job_schedule_type": "Full-time",
    "company_name": "Kaye/Bassman International",
    "skills_required": "excel, github, sheets, smartsheet, sql"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 43776,
    "job_posted_date": "2023-05-24 16:01:05",
    "job_schedule_type": "Full-time",
    "company_name": "Kaye/Bassman International",
    "skills_required": "excel, github, sheets, smartsheet, sql"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 215071,
    "job_posted_date": "2023-01-08 00:01:54",
    "job_schedule_type": "Full-time",
    "company_name": "OZ",
    "skills_required": "aws, bash, python, redshift, spark, sql"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Employee Assistance Program (EAP) Data Analyst",
    "location": "Anywhere",
    "job_id": 132241,
    "job_posted_date": "2023-05-07 09:01:42",
    "job_schedule_type": "Full-time",
    "company_name": "CuraLinc Healthcare",
    "skills_required": null
  },
  {
    "avg_sal": "62500.0",
    "jobs": "HR Report Writer and Data Analyst- REMOTE",
    "location": "Anywhere",
    "job_id": 1513216,
    "job_posted_date": "2023-05-20 00:29:59",
    "job_schedule_type": "Full-time",
    "company_name": "Ryder System",
    "skills_required": "excel, sharepoint, tableau, word"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Internal Audit Data Analyst",
    "location": "Anywhere",
    "job_id": 329855,
    "job_posted_date": "2023-01-06 21:02:36",
    "job_schedule_type": "Full-time",
    "company_name": "Aegon",
    "skills_required": "excel, power bi, python, sql, tableau"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Operations Reporting and Data Analyst - Boston, MA",
    "location": "Anywhere",
    "job_id": 376277,
    "job_posted_date": "2023-02-14 12:00:21",
    "job_schedule_type": "Full-time",
    "company_name": "Crescentia GTS",
    "skills_required": "excel, sas, sql, windows"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Supply Chain Data Integrity Analyst",
    "location": "Anywhere",
    "job_id": 553921,
    "job_posted_date": "2023-12-03 08:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "excel"
  },
  {
    "avg_sal": "62500.0",
    "jobs": "Technology and Data Analyst",
    "location": "Anywhere",
    "job_id": 1650439,
    "job_posted_date": "2023-07-17 14:00:50",
    "job_schedule_type": "Full-time",
    "company_name": "McAllister & Quinn, LLC",
    "skills_required": "excel"
  },
  {
    "avg_sal": "62000.0",
    "jobs": "Business Intelligence Engineer",
    "location": "Anywhere",
    "job_id": 272662,
    "job_posted_date": "2023-05-31 17:53:38",
    "job_schedule_type": "Contractor",
    "company_name": "Neurons Lab",
    "skills_required": "aws, power bi, redshift, sql, tableau"
  },
  {
    "avg_sal": "62000.0",
    "jobs": "Data Processing and Reporting Analyst",
    "location": "Anywhere",
    "job_id": 634102,
    "job_posted_date": "2023-09-08 09:39:55",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel"
  },
  {
    "avg_sal": "60500.0",
    "jobs": "Freelance Online Data Analyst",
    "location": "Anywhere",
    "job_id": 955933,
    "job_posted_date": "2023-11-15 06:02:08",
    "job_schedule_type": "Full-time and Contractor",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "60500.0",
    "jobs": "Freelance Online Data Analyst",
    "location": "Anywhere",
    "job_id": 1579976,
    "job_posted_date": "2023-11-02 08:02:05",
    "job_schedule_type": "Full-time and Contractor",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Admissions & Recruitment Business Data Analyst (Hybrid-80% remote)",
    "location": "Anywhere",
    "job_id": 333817,
    "job_posted_date": "2023-12-07 20:01:55",
    "job_schedule_type": "Full-time",
    "company_name": "University of North Texas Health Science Center",
    "skills_required": null
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Atmospheric Scientist/Data Analyst",
    "location": "Anywhere",
    "job_id": 1424729,
    "job_posted_date": "2023-03-23 11:54:49",
    "job_schedule_type": "Full-time",
    "company_name": "BLUE STORM ASSOCIATES INC",
    "skills_required": "matlab, python"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 212308,
    "job_posted_date": "2023-10-10 18:01:22",
    "job_schedule_type": "Full-time",
    "company_name": "El Buen Samaritano",
    "skills_required": "excel, mysql, power bi, spss, sql, t-sql, tableau"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 286007,
    "job_posted_date": "2023-08-20 10:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "sheets"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Data Analyst - Payroll Operations",
    "location": "Anywhere",
    "job_id": 179907,
    "job_posted_date": "2023-10-10 07:00:12",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Data Science Analyst I",
    "location": "Anywhere",
    "job_id": 1138427,
    "job_posted_date": "2023-07-24 20:04:05",
    "job_schedule_type": "Full-time",
    "company_name": "Aflac, Incorporated",
    "skills_required": "excel, powerpoint, python, r, sql, word"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Entry Level Data Analyst",
    "location": "Anywhere",
    "job_id": 1431520,
    "job_posted_date": "2023-01-18 14:46:40",
    "job_schedule_type": "Full-time",
    "company_name": "Jumpvine",
    "skills_required": "go"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Full-time / Financial Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1009250,
    "job_posted_date": "2023-05-18 07:02:41",
    "job_schedule_type": "Full-time",
    "company_name": "eStaffing Inc.",
    "skills_required": null
  },
  {
    "avg_sal": "60000.0",
    "jobs": "HR Data Analyst",
    "location": "Anywhere",
    "job_id": 758435,
    "job_posted_date": "2023-02-25 09:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "SHI International Corp.",
    "skills_required": "excel, power bi, sharepoint, vba, visual basic"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 143739,
    "job_posted_date": "2023-05-31 07:37:04",
    "job_schedule_type": "Full-time",
    "company_name": "TalentKompass Deutschland",
    "skills_required": null
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 616124,
    "job_posted_date": "2023-09-16 19:03:22",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Finance",
    "skills_required": "excel, power bi, sql, tableau"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Remote Data Analyst",
    "location": "Anywhere",
    "job_id": 697068,
    "job_posted_date": "2023-05-12 19:19:12",
    "job_schedule_type": "Full-time",
    "company_name": "Kaye/Bassman International, Corp.",
    "skills_required": "excel, sheets, smartsheet, sql"
  },
  {
    "avg_sal": "60000.0",
    "jobs": "Social Media Data Analyst",
    "location": "Anywhere",
    "job_id": 163009,
    "job_posted_date": "2023-08-20 14:00:02",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Marketing",
    "skills_required": "sheets"
  },
  {
    "avg_sal": "59500.0",
    "jobs": "Data Analyst - Call Center",
    "location": "Anywhere",
    "job_id": 719006,
    "job_posted_date": "2023-12-22 09:01:35",
    "job_schedule_type": "Full-time",
    "company_name": "Suncoast Credit Union",
    "skills_required": "excel, python, sql"
  },
  {
    "avg_sal": "59000.0",
    "jobs": "HR Data Analyst- REMOTE",
    "location": "Anywhere",
    "job_id": 489565,
    "job_posted_date": "2023-01-04 08:31:12",
    "job_schedule_type": "Full-time",
    "company_name": "Ryder System",
    "skills_required": "excel, sharepoint, tableau, word"
  },
  {
    "avg_sal": "59000.0",
    "jobs": "HR Data Analyst- REMOTE",
    "location": "Anywhere",
    "job_id": 1117967,
    "job_posted_date": "2023-01-18 11:58:39",
    "job_schedule_type": "Full-time",
    "company_name": "Ryder System",
    "skills_required": "excel, sharepoint, tableau, word"
  },
  {
    "avg_sal": "58000.0",
    "jobs": "Logistics Data Analyst (Remote Friendly)",
    "location": "Anywhere",
    "job_id": 1091264,
    "job_posted_date": "2023-06-19 14:00:09",
    "job_schedule_type": "Full-time",
    "company_name": "Webstaurant Store",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "58000.0",
    "jobs": "Remote Data Analyst Consultant",
    "location": "Anywhere",
    "job_id": 863378,
    "job_posted_date": "2023-02-07 23:04:30",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": null
  },
  {
    "avg_sal": "57500.0",
    "jobs": "Data Analyst I",
    "location": "Anywhere",
    "job_id": 441975,
    "job_posted_date": "2023-11-20 19:00:58",
    "job_schedule_type": "Full-time",
    "company_name": "FiberFirst",
    "skills_required": "excel, outlook, powerpoint, sql, visio, word"
  },
  {
    "avg_sal": "57500.0",
    "jobs": "Data Management Analyst- Remote",
    "location": "Anywhere",
    "job_id": 785489,
    "job_posted_date": "2023-09-28 13:15:57",
    "job_schedule_type": "Full-time",
    "company_name": "Stafford Consulting Company, Inc.",
    "skills_required": "microsoft teams, powerpoint"
  },
  {
    "avg_sal": "57500.0",
    "jobs": "Remote Data Analyst II",
    "location": "Anywhere",
    "job_id": 346462,
    "job_posted_date": "2023-10-26 13:00:07",
    "job_schedule_type": "Full-time",
    "company_name": "The Difference Card",
    "skills_required": "excel, power bi, powerpoint, sql, sql server, visio, word"
  },
  {
    "avg_sal": "57500.0",
    "jobs": "Remote Data Analyst II",
    "location": "Anywhere",
    "job_id": 1635949,
    "job_posted_date": "2023-10-23 13:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "power bi, powerpoint, sql, sql server, visio, word"
  },
  {
    "avg_sal": "57300.0",
    "jobs": "Healthcare Data SAS Analyst I",
    "location": "Anywhere",
    "job_id": 739541,
    "job_posted_date": "2023-07-14 19:53:59",
    "job_schedule_type": "Full-time",
    "company_name": "Ascendo Resources",
    "skills_required": "excel, sas, word"
  },
  {
    "avg_sal": "55500.0",
    "jobs": "Lead Data Analyst/Data Architect",
    "location": "Anywhere",
    "job_id": 1598725,
    "job_posted_date": "2023-11-20 08:01:24",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "aws, snowflake"
  },
  {
    "avg_sal": "55000.0",
    "jobs": "CCBHC Data Analyst (Grant Funded Position)",
    "location": "Anywhere",
    "job_id": 837423,
    "job_posted_date": "2023-01-17 00:22:01",
    "job_schedule_type": "Full-time",
    "company_name": "State of Georgia",
    "skills_required": "crystal, excel, html, sql"
  },
  {
    "avg_sal": "55000.0",
    "jobs": "Environmental Data Analyst",
    "location": "Anywhere",
    "job_id": 562116,
    "job_posted_date": "2023-01-13 21:03:57",
    "job_schedule_type": "Full-time",
    "company_name": "JARBO Employment Group",
    "skills_required": "flow, word"
  },
  {
    "avg_sal": "54540.0",
    "jobs": "Data Analyst - US Healthcare (REMOTE)",
    "location": "Anywhere",
    "job_id": 486466,
    "job_posted_date": "2023-05-08 08:02:56",
    "job_schedule_type": "Full-time",
    "company_name": "WALGREENS",
    "skills_required": "c++, cognos, excel, powerpoint, sas, sharepoint, sql, tableau, word"
  },
  {
    "avg_sal": "53000.0",
    "jobs": "Statistical Data Analyst (Buyer Engagement Strategist)",
    "location": "Anywhere",
    "job_id": 198826,
    "job_posted_date": "2023-08-21 21:04:32",
    "job_schedule_type": "Full-time",
    "company_name": "University of South Florida",
    "skills_required": "excel, outlook, powerpoint, word"
  },
  {
    "avg_sal": "52500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 862094,
    "job_posted_date": "2023-05-12 19:01:22",
    "job_schedule_type": "Full-time",
    "company_name": "Kaye/Bassman International",
    "skills_required": "excel, sheets, smartsheet, sql"
  },
  {
    "avg_sal": "52500.0",
    "jobs": "Data Analyst (Remote)",
    "location": "Anywhere",
    "job_id": 1203514,
    "job_posted_date": "2023-01-14 09:43:54",
    "job_schedule_type": "Full-time",
    "company_name": "Acosta, Inc.",
    "skills_required": "excel, power bi, powerpoint, windows, word"
  },
  {
    "avg_sal": "52500.0",
    "jobs": "Data Quality Analyst",
    "location": "Anywhere",
    "job_id": 74841,
    "job_posted_date": "2023-10-04 10:00:19",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, spreadsheet, sql"
  },
  {
    "avg_sal": "52500.0",
    "jobs": "E-Commerce Digital Analyst",
    "location": "Anywhere",
    "job_id": 667237,
    "job_posted_date": "2023-04-11 15:17:43",
    "job_schedule_type": "Full-time",
    "company_name": "Fitsoftware OU",
    "skills_required": "css, excel, html, javascript, qlik, sql"
  },
  {
    "avg_sal": "52500.0",
    "jobs": "Junior Data Analyst",
    "location": "Anywhere",
    "job_id": 902110,
    "job_posted_date": "2023-02-24 18:00:55",
    "job_schedule_type": "Full-time",
    "company_name": "Phoenix Capital Group Holdings LLC",
    "skills_required": "excel, julia, phoenix"
  },
  {
    "avg_sal": "52000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1049427,
    "job_posted_date": "2023-01-18 14:00:12",
    "job_schedule_type": "Full-time",
    "company_name": "Spark451 Inc.",
    "skills_required": "mongodb, powerpoint, sql, tableau, word"
  },
  {
    "avg_sal": "51500.0",
    "jobs": "OPEN RANK: Qualitative Research Data Analyst or Senior Research...",
    "location": "Anywhere",
    "job_id": 642310,
    "job_posted_date": "2023-12-18 19:00:13",
    "job_schedule_type": "Full-time",
    "company_name": "University of Maryland, Baltimore",
    "skills_required": "excel, sas, spss"
  },
  {
    "avg_sal": "51059.0",
    "jobs": "Sr. Data Analyst",
    "location": "Anywhere",
    "job_id": 1073885,
    "job_posted_date": "2023-01-23 00:00:38",
    "job_schedule_type": "Full-time",
    "company_name": "Jacksonville",
    "skills_required": "java, mongodb, python, ruby, ruby on rails"
  },
  {
    "avg_sal": "51000.0",
    "jobs": "Data Quality Analyst",
    "location": "Anywhere",
    "job_id": 44448,
    "job_posted_date": "2023-11-27 10:02:29",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql, ssis"
  },
  {
    "avg_sal": "50500.0",
    "jobs": "Data Analysis & Reporting Specialist",
    "location": "Anywhere",
    "job_id": 1086455,
    "job_posted_date": "2023-12-14 07:34:00",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, tableau"
  },
  {
    "avg_sal": "50000.0",
    "jobs": "Data Analysis & Reporting Specialist",
    "location": "Anywhere",
    "job_id": 522407,
    "job_posted_date": "2023-10-29 14:28:30",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": null
  },
  {
    "avg_sal": "50000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 587906,
    "job_posted_date": "2023-11-11 18:02:54",
    "job_schedule_type": "Full-time and Contractor",
    "company_name": "Makana Technologies",
    "skills_required": null
  },
  {
    "avg_sal": "50000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1278164,
    "job_posted_date": "2023-12-16 08:00:01",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Transportation",
    "skills_required": "excel, power bi, python, r, tableau"
  },
  {
    "avg_sal": "50000.0",
    "jobs": "Data Analyst I - Healthcare Analytics",
    "location": "Anywhere",
    "job_id": 269335,
    "job_posted_date": "2023-05-30 11:01:58",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "python, r"
  },
  {
    "avg_sal": "50000.0",
    "jobs": "Data Entry Analyst",
    "location": "Anywhere",
    "job_id": 1672776,
    "job_posted_date": "2023-09-21 19:01:03",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel"
  },
  {
    "avg_sal": "48500.0",
    "jobs": "Clinical Data Analyst (Entry to Mid Level)",
    "location": "Anywhere",
    "job_id": 1605573,
    "job_posted_date": "2023-08-24 16:01:04",
    "job_schedule_type": "Full-time",
    "company_name": "Allied Technologies & Consulting",
    "skills_required": "excel"
  },
  {
    "avg_sal": "47500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 42319,
    "job_posted_date": "2023-01-25 22:04:45",
    "job_schedule_type": "Full-time",
    "company_name": "Insight Global",
    "skills_required": null
  },
  {
    "avg_sal": "47500.0",
    "jobs": "Data Analyst / Engineer",
    "location": "Anywhere",
    "job_id": 229128,
    "job_posted_date": "2023-01-19 01:28:29",
    "job_schedule_type": "Contractor",
    "company_name": "Men's Health Clinic (MHC)",
    "skills_required": "aws, c, c++, excel, flow, power bi, powerpoint, python, r, sql"
  },
  {
    "avg_sal": "47500.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 1262617,
    "job_posted_date": "2023-10-10 20:38:56",
    "job_schedule_type": "Full-time",
    "company_name": "Ali Awad Law, P.C.",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "46500.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1619146,
    "job_posted_date": "2023-11-05 07:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel, oracle, sas, sharepoint, sql"
  },
  {
    "avg_sal": "42500.0",
    "jobs": "Data Analyst-Operations",
    "location": "Anywhere",
    "job_id": 473213,
    "job_posted_date": "2023-02-28 15:00:06",
    "job_schedule_type": "Full-time",
    "company_name": "U.S. Wire and Cable Company/ Flexon Industries",
    "skills_required": "excel, windows, wire"
  },
  {
    "avg_sal": "41000.0",
    "jobs": "Ecommerce Business Analyst/Data Analyst with Good exp with SQL",
    "location": "Anywhere",
    "job_id": 512966,
    "job_posted_date": "2023-02-15 02:00:35",
    "job_schedule_type": "Contractor",
    "company_name": "BayOne Solutions",
    "skills_required": "sql, tableau"
  },
  {
    "avg_sal": "40000.0",
    "jobs": "Data Quality Analyst (Fraud Prevention)",
    "location": "Anywhere",
    "job_id": 663127,
    "job_posted_date": "2023-10-26 23:55:07",
    "job_schedule_type": "Full-time",
    "company_name": "owl.co",
    "skills_required": null
  },
  {
    "avg_sal": "39000.0",
    "jobs": "Remote Data Analyst",
    "location": "Anywhere",
    "job_id": 994565,
    "job_posted_date": "2023-04-28 12:01:30",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Administrative",
    "skills_required": "excel"
  },
  {
    "avg_sal": "36000.0",
    "jobs": "Financial Data Analyst",
    "location": "Anywhere",
    "job_id": 1349849,
    "job_posted_date": "2023-06-08 08:46:41",
    "job_schedule_type": "Full-time",
    "company_name": "Get It Recruit - Information Technology",
    "skills_required": "excel, sql"
  },
  {
    "avg_sal": "35000.0",
    "jobs": "Data Analyst",
    "location": "Anywhere",
    "job_id": 1178688,
    "job_posted_date": "2023-06-20 21:57:57",
    "job_schedule_type": "Contractor",
    "company_name": "Jobmatchingpartner Ltd",
    "skills_required": "hadoop, looker, python, r, spark, sql"
  },
  {
    "avg_sal": "25000.0",
    "jobs": "Research Scientist",
    "location": "Anywhere",
    "job_id": 216489,
    "job_posted_date": "2023-07-18 07:03:51",
    "job_schedule_type": "Full-time",
    "company_name": "ED-Energy Storage & Distributed R",
    "skills_required": null
  }
]