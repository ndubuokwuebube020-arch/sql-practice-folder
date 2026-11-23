select DISTINCT 
  jobs.job_title_short as job_roles,
  skills.skills as required_skills,
  TO_CHAR(AVG(jobs.salary_year_avg), '$FM999,999,999') AS average_yearly_salary
  from
  job_postings_fact as jobs
inner join 
  skills_job_dim as skills_id
  on skills_id.job_id = jobs.job_id
inner join 
  skills_dim as skills
  on skills.skill_id = skills_id.skill_id
where 
  jobs.job_title_short = 'Data Analyst' 
  and jobs.salary_year_avg is not NULL 
  and skills.skills is not NULL
group by 
  job_roles,required_skills
  order by 
  average_yearly_salary DESC
  /*
 # Skills Associated with the Highest Average Salaries

In this dataset, **SVN** has the highest average yearly salary at **$400,000**. The next highest are **Solidity** at **$179,000**, **Couchbase** at **$160,515**, **DataRobot** at **$155,486**, and **Golang** at **$155,000**.

SVN’s average is much higher than the rest. The other top skills range from about **$155,000 to $179,000**.

These figures show the average salaries associated with job postings that mention each skill. They do not show that a skill alone causes higher pay. The dataset covers **Data Analyst** roles.

[
  {
    "job_roles": "Data Analyst",
    "required_skills": "matlab",
    "average_yearly_salary": "$99,909"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "unity",
    "average_yearly_salary": "$99,617"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "dax",
    "average_yearly_salary": "$99,549"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ggplot2",
    "average_yearly_salary": "$99,416"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "matplotlib",
    "average_yearly_salary": "$99,307"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "docker",
    "average_yearly_salary": "$99,262"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "yarn",
    "average_yearly_salary": "$99,150"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "seaborn",
    "average_yearly_salary": "$98,748"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "c",
    "average_yearly_salary": "$98,715"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "r",
    "average_yearly_salary": "$98,708"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "django",
    "average_yearly_salary": "$98,544"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "flow",
    "average_yearly_salary": "$98,020"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "tableau",
    "average_yearly_salary": "$97,978"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "node",
    "average_yearly_salary": "$97,900"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "spring",
    "average_yearly_salary": "$97,454"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "go",
    "average_yearly_salary": "$97,267"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "c#",
    "average_yearly_salary": "$97,248"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ssis",
    "average_yearly_salary": "$97,235"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sql",
    "average_yearly_salary": "$96,435"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sql server",
    "average_yearly_salary": "$96,191"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "mariadb",
    "average_yearly_salary": "$96,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "jquery",
    "average_yearly_salary": "$95,772"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "t-sql",
    "average_yearly_salary": "$95,723"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "microstrategy",
    "average_yearly_salary": "$94,486"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "vba",
    "average_yearly_salary": "$93,845"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sas",
    "average_yearly_salary": "$93,707"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "webex",
    "average_yearly_salary": "$92,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sap",
    "average_yearly_salary": "$92,446"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "power bi",
    "average_yearly_salary": "$92,324"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "pascal",
    "average_yearly_salary": "$92,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "javascript",
    "average_yearly_salary": "$91,805"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ssrs",
    "average_yearly_salary": "$91,537"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "cognos",
    "average_yearly_salary": "$90,407"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "airtable",
    "average_yearly_salary": "$90,006"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "clickup",
    "average_yearly_salary": "$90,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "zoom",
    "average_yearly_salary": "$89,791"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "typescript",
    "average_yearly_salary": "$89,323"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "unreal",
    "average_yearly_salary": "$89,113"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sharepoint",
    "average_yearly_salary": "$89,027"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "react",
    "average_yearly_salary": "$88,567"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "drupal",
    "average_yearly_salary": "$88,328"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "powerpoint",
    "average_yearly_salary": "$88,316"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "firebase",
    "average_yearly_salary": "$87,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "crystal",
    "average_yearly_salary": "$87,327"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "visual basic",
    "average_yearly_salary": "$86,972"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "arch",
    "average_yearly_salary": "$86,835"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "windows",
    "average_yearly_salary": "$86,513"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "excel",
    "average_yearly_salary": "$86,419"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "symphony",
    "average_yearly_salary": "$86,267"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "microsoft teams",
    "average_yearly_salary": "$85,570"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "assembly",
    "average_yearly_salary": "$85,390"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "asana",
    "average_yearly_salary": "$85,339"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "css",
    "average_yearly_salary": "$85,317"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "spss",
    "average_yearly_salary": "$85,293"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ms access",
    "average_yearly_salary": "$84,873"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "cobol",
    "average_yearly_salary": "$84,745"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "html",
    "average_yearly_salary": "$84,383"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sheets",
    "average_yearly_salary": "$84,130"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "terminal",
    "average_yearly_salary": "$83,567"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "slack",
    "average_yearly_salary": "$83,442"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "word",
    "average_yearly_salary": "$82,941"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "chef",
    "average_yearly_salary": "$82,825"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "fortran",
    "average_yearly_salary": "$82,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "selenium",
    "average_yearly_salary": "$82,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ruby",
    "average_yearly_salary": "$80,960"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "outlook",
    "average_yearly_salary": "$80,680"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "monday.com",
    "average_yearly_salary": "$79,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "spreadsheet",
    "average_yearly_salary": "$78,466"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "planner",
    "average_yearly_salary": "$77,039"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "workfront",
    "average_yearly_salary": "$76,820"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "wrike",
    "average_yearly_salary": "$75,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "julia",
    "average_yearly_salary": "$73,680"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "npm",
    "average_yearly_salary": "$73,419"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "dart",
    "average_yearly_salary": "$72,674"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "erlang",
    "average_yearly_salary": "$72,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "smartsheet",
    "average_yearly_salary": "$71,221"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "tidyverse",
    "average_yearly_salary": "$70,600"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "vb.net",
    "average_yearly_salary": "$69,600"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "wire",
    "average_yearly_salary": "$68,375"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "opencv",
    "average_yearly_salary": "$67,818"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sass",
    "average_yearly_salary": "$67,699"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "colocation",
    "average_yearly_salary": "$67,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "trello",
    "average_yearly_salary": "$65,193"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "vue",
    "average_yearly_salary": "$65,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "macos",
    "average_yearly_salary": "$57,933"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "graphql",
    "average_yearly_salary": "$57,009"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ruby on rails",
    "average_yearly_salary": "$51,059"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "svn",
    "average_yearly_salary": "$400,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "solidity",
    "average_yearly_salary": "$179,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "couchbase",
    "average_yearly_salary": "$160,515"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "datarobot",
    "average_yearly_salary": "$155,486"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "golang",
    "average_yearly_salary": "$155,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "mxnet",
    "average_yearly_salary": "$149,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "dplyr",
    "average_yearly_salary": "$147,633"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "vmware",
    "average_yearly_salary": "$147,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "terraform",
    "average_yearly_salary": "$146,734"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "twilio",
    "average_yearly_salary": "$138,500"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "gitlab",
    "average_yearly_salary": "$134,126"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "kafka",
    "average_yearly_salary": "$129,999"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "puppet",
    "average_yearly_salary": "$129,820"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "keras",
    "average_yearly_salary": "$127,013"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "pytorch",
    "average_yearly_salary": "$125,226"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "perl",
    "average_yearly_salary": "$124,686"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ansible",
    "average_yearly_salary": "$124,370"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "hugging face",
    "average_yearly_salary": "$123,950"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "tensorflow",
    "average_yearly_salary": "$120,647"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "cassandra",
    "average_yearly_salary": "$118,407"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "notion",
    "average_yearly_salary": "$118,092"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "atlassian",
    "average_yearly_salary": "$117,966"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "bitbucket",
    "average_yearly_salary": "$116,712"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "airflow",
    "average_yearly_salary": "$116,387"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "scala",
    "average_yearly_salary": "$115,480"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "linux",
    "average_yearly_salary": "$114,883"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "confluence",
    "average_yearly_salary": "$114,153"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "pyspark",
    "average_yearly_salary": "$114,058"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "mongodb",
    "average_yearly_salary": "$113,608"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "aurora",
    "average_yearly_salary": "$113,394"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "cordova",
    "average_yearly_salary": "$113,270"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "gcp",
    "average_yearly_salary": "$113,065"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "spark",
    "average_yearly_salary": "$113,002"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "splunk",
    "average_yearly_salary": "$112,928"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "databricks",
    "average_yearly_salary": "$112,881"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "unify",
    "average_yearly_salary": "$112,317"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "git",
    "average_yearly_salary": "$112,250"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "dynamodb",
    "average_yearly_salary": "$111,840"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "snowflake",
    "average_yearly_salary": "$111,578"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "shell",
    "average_yearly_salary": "$111,496"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "electron",
    "average_yearly_salary": "$111,175"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "unix",
    "average_yearly_salary": "$111,123"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "hadoop",
    "average_yearly_salary": "$110,888"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "pandas",
    "average_yearly_salary": "$110,767"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "node.js",
    "average_yearly_salary": "$110,230"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "phoenix",
    "average_yearly_salary": "$109,259"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "php",
    "average_yearly_salary": "$109,052"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "neo4j",
    "average_yearly_salary": "$108,646"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "nosql",
    "average_yearly_salary": "$108,331"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "express",
    "average_yearly_salary": "$108,221"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "watson",
    "average_yearly_salary": "$108,103"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "redshift",
    "average_yearly_salary": "$107,969"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "jira",
    "average_yearly_salary": "$107,931"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "rust",
    "average_yearly_salary": "$107,925"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "elasticsearch",
    "average_yearly_salary": "$107,816"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "no-sql",
    "average_yearly_salary": "$107,405"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "numpy",
    "average_yearly_salary": "$107,398"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "db2",
    "average_yearly_salary": "$107,130"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "swift",
    "average_yearly_salary": "$107,100"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "redis",
    "average_yearly_salary": "$107,044"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "postgresql",
    "average_yearly_salary": "$106,853"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "plotly",
    "average_yearly_salary": "$106,603"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "aws",
    "average_yearly_salary": "$106,440"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "c++",
    "average_yearly_salary": "$105,696"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "alteryx",
    "average_yearly_salary": "$105,580"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "azure",
    "average_yearly_salary": "$105,400"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "gdpr",
    "average_yearly_salary": "$105,329"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "bigquery",
    "average_yearly_salary": "$105,238"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "bash",
    "average_yearly_salary": "$105,075"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "powershell",
    "average_yearly_salary": "$105,041"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "mongo",
    "average_yearly_salary": "$104,274"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "scikit-learn",
    "average_yearly_salary": "$103,932"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "looker",
    "average_yearly_salary": "$103,855"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "jupyter",
    "average_yearly_salary": "$103,522"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "ibm cloud",
    "average_yearly_salary": "$103,313"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "kubernetes",
    "average_yearly_salary": "$103,089"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "angular",
    "average_yearly_salary": "$102,103"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "flask",
    "average_yearly_salary": "$101,863"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "asp.net",
    "average_yearly_salary": "$101,667"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "sqlite",
    "average_yearly_salary": "$101,625"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "python",
    "average_yearly_salary": "$101,512"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "github",
    "average_yearly_salary": "$101,498"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "jenkins",
    "average_yearly_salary": "$101,419"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "mysql",
    "average_yearly_salary": "$101,381"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "visio",
    "average_yearly_salary": "$101,036"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "oracle",
    "average_yearly_salary": "$100,964"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "qlik",
    "average_yearly_salary": "$100,933"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "java",
    "average_yearly_salary": "$100,214"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "chainer",
    "average_yearly_salary": "$100,000"
  },
  {
    "job_roles": "Data Analyst",
    "required_skills": "theano",
    "average_yearly_salary": "$100,000"
  }
]