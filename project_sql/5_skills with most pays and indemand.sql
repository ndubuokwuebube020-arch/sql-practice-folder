select 
    skills.skills as skills,
    count(DISTINCT jobs.job_id) as Number_of_job_posting ,
    TO_CHAR(ROUND(AVG(jobs.salary_year_avg)), 'FM$999,999,999') AS avg_salary
from 
    job_postings_fact as jobs
left join skills_job_dim as skills_id
on 
    skills_id.job_id = jobs.job_id
left join skills_dim as skills
on 
    skills.skill_id = skills_id.skill_id
where 
    jobs.salary_year_avg is not NULL and skills.skills is not NULL
group by
    skills 
order by 
     count(DISTINCT jobs.job_id) DESC,
    AVG(jobs.salary_year_avg) DESC;



      /* Quick summary
The results are sorted by job posting count first, with average salary used to break ties. 
So the first rows show the most frequently requested skills; they are not necessarily the highest paying overall.
- SQL and Python lead demand, with about 13,000 postings each. 
Their average salaries are roughly $125K for SQL and $132K for Python.
- R, AWS, and Tableau are the next most in demand, with about 4,800–5,100 postings. AWS pays more on average ($136K) than Tableau ($117K).
- Among skills with substantial demand, Scala, Kafka, Airflow, Spark, and Redshift stand out for pay, averaging around $141K–$145K while appearing in roughly 1,500–4,000 postings.
- The very highest averages—such as Debian, RingCentral, and Lua—come from skills with only one or two postings. Those figures are too sparse to treat as reliable market-wide salary signals.
Takeaway: SQL and Python are the strongest choices for broad demand. For a higher-paying combination with meaningful demand in this dataset, consider cloud and data engineering skills such as AWS, Spark, 
Scala, Kafka, and Airflow. These are averages from the dataset, so they don’t guarantee an individual salary.


[
  {
    "skills": "sql",
    "number_of_job_posting": "12974",
    "avg_salary": "$124,935"
  },
  {
    "skills": "python",
    "number_of_job_posting": "12883",
    "avg_salary": "$132,440"
  },
  {
    "skills": "r",
    "number_of_job_posting": "5088",
    "avg_salary": "$127,115"
  },
  {
    "skills": "aws",
    "number_of_job_posting": "4952",
    "avg_salary": "$136,481"
  },
  {
    "skills": "tableau",
    "number_of_job_posting": "4830",
    "avg_salary": "$116,796"
  },
  {
    "skills": "spark",
    "number_of_job_posting": "4025",
    "avg_salary": "$141,734"
  },
  {
    "skills": "excel",
    "number_of_job_posting": "3835",
    "avg_salary": "$99,751"
  },
  {
    "skills": "azure",
    "number_of_job_posting": "3480",
    "avg_salary": "$130,433"
  },
  {
    "skills": "java",
    "number_of_job_posting": "2760",
    "avg_salary": "$136,210"
  },
  {
    "skills": "power bi",
    "number_of_job_posting": "2589",
    "avg_salary": "$106,738"
  },
  {
    "skills": "snowflake",
    "number_of_job_posting": "2458",
    "avg_salary": "$137,960"
  },
  {
    "skills": "hadoop",
    "number_of_job_posting": "2272",
    "avg_salary": "$138,574"
  },
  {
    "skills": "scala",
    "number_of_job_posting": "1912",
    "avg_salary": "$145,120"
  },
  {
    "skills": "nosql",
    "number_of_job_posting": "1686",
    "avg_salary": "$137,039"
  },
  {
    "skills": "kafka",
    "number_of_job_posting": "1642",
    "avg_salary": "$144,754"
  },
  {
    "skills": "sas",
    "number_of_job_posting": "1563",
    "avg_salary": "$112,788"
  },
  {
    "skills": "databricks",
    "number_of_job_posting": "1521",
    "avg_salary": "$131,525"
  },
  {
    "skills": "redshift",
    "number_of_job_posting": "1520",
    "avg_salary": "$140,792"
  },
  {
    "skills": "airflow",
    "number_of_job_posting": "1506",
    "avg_salary": "$142,386"
  },
  {
    "skills": "go",
    "number_of_job_posting": "1394",
    "avg_salary": "$131,689"
  },
  {
    "skills": "git",
    "number_of_job_posting": "1358",
    "avg_salary": "$128,316"
  },
  {
    "skills": "oracle",
    "number_of_job_posting": "1357",
    "avg_salary": "$115,125"
  },
  {
    "skills": "sql server",
    "number_of_job_posting": "1321",
    "avg_salary": "$112,487"
  },
  {
    "skills": "gcp",
    "number_of_job_posting": "1252",
    "avg_salary": "$131,738"
  },
  {
    "skills": "tensorflow",
    "number_of_job_posting": "1225",
    "avg_salary": "$142,370"
  },
  {
    "skills": "docker",
    "number_of_job_posting": "1112",
    "avg_salary": "$132,040"
  },
  {
    "skills": "pytorch",
    "number_of_job_posting": "1081",
    "avg_salary": "$144,470"
  },
  {
    "skills": "pandas",
    "number_of_job_posting": "1049",
    "avg_salary": "$137,518"
  },
  {
    "skills": "flow",
    "number_of_job_posting": "1037",
    "avg_salary": "$120,211"
  },
  {
    "skills": "word",
    "number_of_job_posting": "1012",
    "avg_salary": "$99,012"
  },
  {
    "skills": "powerpoint",
    "number_of_job_posting": "956",
    "avg_salary": "$99,160"
  },
  {
    "skills": "kubernetes",
    "number_of_job_posting": "923",
    "avg_salary": "$137,949"
  },
  {
    "skills": "looker",
    "number_of_job_posting": "918",
    "avg_salary": "$129,006"
  },
  {
    "skills": "mysql",
    "number_of_job_posting": "912",
    "avg_salary": "$135,432"
  },
  {
    "skills": "pyspark",
    "number_of_job_posting": "880",
    "avg_salary": "$135,011"
  },
  {
    "skills": "bigquery",
    "number_of_job_posting": "782",
    "avg_salary": "$133,649"
  },
  {
    "skills": "javascript",
    "number_of_job_posting": "752",
    "avg_salary": "$114,837"
  },
  {
    "skills": "c++",
    "number_of_job_posting": "750",
    "avg_salary": "$133,733"
  },
  {
    "skills": "shell",
    "number_of_job_posting": "731",
    "avg_salary": "$143,370"
  },
  {
    "skills": "linux",
    "number_of_job_posting": "691",
    "avg_salary": "$128,614"
  },
  {
    "skills": "scikit-learn",
    "number_of_job_posting": "688",
    "avg_salary": "$139,603"
  },
  {
    "skills": "numpy",
    "number_of_job_posting": "664",
    "avg_salary": "$136,809"
  },
  {
    "skills": "github",
    "number_of_job_posting": "658",
    "avg_salary": "$124,816"
  },
  {
    "skills": "jira",
    "number_of_job_posting": "646",
    "avg_salary": "$124,154"
  },
  {
    "skills": "c",
    "number_of_job_posting": "599",
    "avg_salary": "$135,987"
  },
  {
    "skills": "ssis",
    "number_of_job_posting": "569",
    "avg_salary": "$112,265"
  },
  {
    "skills": "postgresql",
    "number_of_job_posting": "560",
    "avg_salary": "$126,401"
  },
  {
    "skills": "cassandra",
    "number_of_job_posting": "530",
    "avg_salary": "$154,124"
  },
  {
    "skills": "jenkins",
    "number_of_job_posting": "521",
    "avg_salary": "$128,872"
  },
  {
    "skills": "sap",
    "number_of_job_posting": "503",
    "avg_salary": "$108,103"
  },
  {
    "skills": "c#",
    "number_of_job_posting": "496",
    "avg_salary": "$122,307"
  },
  {
    "skills": "mongodb",
    "number_of_job_posting": "487",
    "avg_salary": "$131,207"
  },
  {
    "skills": "spss",
    "number_of_job_posting": "476",
    "avg_salary": "$102,627"
  },
  {
    "skills": "matlab",
    "number_of_job_posting": "469",
    "avg_salary": "$122,048"
  },
  {
    "skills": "terraform",
    "number_of_job_posting": "467",
    "avg_salary": "$133,161"
  },
  {
    "skills": "keras",
    "number_of_job_posting": "409",
    "avg_salary": "$136,026"
  },
  {
    "skills": "alteryx",
    "number_of_job_posting": "386",
    "avg_salary": "$112,907"
  },
  {
    "skills": "matplotlib",
    "number_of_job_posting": "372",
    "avg_salary": "$132,508"
  },
  {
    "skills": "qlik",
    "number_of_job_posting": "366",
    "avg_salary": "$115,040"
  },
  {
    "skills": "jupyter",
    "number_of_job_posting": "354",
    "avg_salary": "$133,829"
  },
  {
    "skills": "unix",
    "number_of_job_posting": "347",
    "avg_salary": "$122,118"
  },
  {
    "skills": "vba",
    "number_of_job_posting": "347",
    "avg_salary": "$101,846"
  },
  {
    "skills": "express",
    "number_of_job_posting": "334",
    "avg_salary": "$131,088"
  },
  {
    "skills": "ssrs",
    "number_of_job_posting": "330",
    "avg_salary": "$103,189"
  },
  {
    "skills": "windows",
    "number_of_job_posting": "321",
    "avg_salary": "$109,718"
  },
  {
    "skills": "outlook",
    "number_of_job_posting": "305",
    "avg_salary": "$93,220"
  },
  {
    "skills": "sharepoint",
    "number_of_job_posting": "301",
    "avg_salary": "$98,611"
  },
  {
    "skills": "elasticsearch",
    "number_of_job_posting": "298",
    "avg_salary": "$132,742"
  },
  {
    "skills": "mongo",
    "number_of_job_posting": "262",
    "avg_salary": "$170,715"
  },
  {
    "skills": "confluence",
    "number_of_job_posting": "260",
    "avg_salary": "$123,223"
  },
  {
    "skills": "t-sql",
    "number_of_job_posting": "247",
    "avg_salary": "$112,403"
  },
  {
    "skills": "html",
    "number_of_job_posting": "236",
    "avg_salary": "$109,678"
  },
  {
    "skills": "bash",
    "number_of_job_posting": "230",
    "avg_salary": "$123,893"
  },
  {
    "skills": "dynamodb",
    "number_of_job_posting": "220",
    "avg_salary": "$139,548"
  },
  {
    "skills": "spring",
    "number_of_job_posting": "220",
    "avg_salary": "$119,397"
  },
  {
    "skills": "sheets",
    "number_of_job_posting": "215",
    "avg_salary": "$94,455"
  },
  {
    "skills": "react",
    "number_of_job_posting": "197",
    "avg_salary": "$123,799"
  },
  {
    "skills": "gitlab",
    "number_of_job_posting": "194",
    "avg_salary": "$130,257"
  },
  {
    "skills": "dax",
    "number_of_job_posting": "186",
    "avg_salary": "$109,408"
  },
  {
    "skills": "powershell",
    "number_of_job_posting": "172",
    "avg_salary": "$116,803"
  },
  {
    "skills": "visio",
    "number_of_job_posting": "169",
    "avg_salary": "$103,749"
  },
  {
    "skills": "plotly",
    "number_of_job_posting": "167",
    "avg_salary": "$131,610"
  },
  {
    "skills": "spreadsheet",
    "number_of_job_posting": "167",
    "avg_salary": "$93,746"
  },
  {
    "skills": "db2",
    "number_of_job_posting": "166",
    "avg_salary": "$119,824"
  },
  {
    "skills": "splunk",
    "number_of_job_posting": "160",
    "avg_salary": "$135,746"
  },
  {
    "skills": "perl",
    "number_of_job_posting": "153",
    "avg_salary": "$134,374"
  },
  {
    "skills": "microstrategy",
    "number_of_job_posting": "153",
    "avg_salary": "$119,563"
  },
  {
    "skills": "gdpr",
    "number_of_job_posting": "152",
    "avg_salary": "$130,194"
  },
  {
    "skills": "seaborn",
    "number_of_job_posting": "151",
    "avg_salary": "$135,501"
  },
  {
    "skills": "cognos",
    "number_of_job_posting": "146",
    "avg_salary": "$101,469"
  },
  {
    "skills": "css",
    "number_of_job_posting": "144",
    "avg_salary": "$113,897"
  },
  {
    "skills": "phoenix",
    "number_of_job_posting": "138",
    "avg_salary": "$122,996"
  },
  {
    "skills": "ruby",
    "number_of_job_posting": "135",
    "avg_salary": "$130,712"
  },
  {
    "skills": "crystal",
    "number_of_job_posting": "132",
    "avg_salary": "$99,942"
  },
  {
    "skills": "flask",
    "number_of_job_posting": "131",
    "avg_salary": "$131,959"
  },
  {
    "skills": "ansible",
    "number_of_job_posting": "129",
    "avg_salary": "$124,991"
  },
  {
    "skills": "aurora",
    "number_of_job_posting": "128",
    "avg_salary": "$131,308"
  },
  {
    "skills": "neo4j",
    "number_of_job_posting": "123",
    "avg_salary": "$147,708"
  },
  {
    "skills": "redis",
    "number_of_job_posting": "118",
    "avg_salary": "$139,213"
  },
  {
    "skills": "typescript",
    "number_of_job_posting": "118",
    "avg_salary": "$132,149"
  },
  {
    "skills": "php",
    "number_of_job_posting": "113",
    "avg_salary": "$123,898"
  },
  {
    "skills": "angular",
    "number_of_job_posting": "112",
    "avg_salary": "$125,600"
  },
  {
    "skills": "bitbucket",
    "number_of_job_posting": "110",
    "avg_salary": "$126,316"
  },
  {
    "skills": "golang",
    "number_of_job_posting": "109",
    "avg_salary": "$143,139"
  },
  {
    "skills": "julia",
    "number_of_job_posting": "104",
    "avg_salary": "$128,319"
  },
  {
    "skills": "ggplot2",
    "number_of_job_posting": "104",
    "avg_salary": "$126,630"
  },
  {
    "skills": "django",
    "number_of_job_posting": "103",
    "avg_salary": "$128,528"
  },
  {
    "skills": "atlassian",
    "number_of_job_posting": "101",
    "avg_salary": "$138,651"
  },
  {
    "skills": "terminal",
    "number_of_job_posting": "101",
    "avg_salary": "$111,582"
  },
  {
    "skills": "ms access",
    "number_of_job_posting": "99",
    "avg_salary": "$92,341"
  },
  {
    "skills": "no-sql",
    "number_of_job_posting": "92",
    "avg_salary": "$133,556"
  },
  {
    "skills": "slack",
    "number_of_job_posting": "89",
    "avg_salary": "$120,118"
  },
  {
    "skills": "nltk",
    "number_of_job_posting": "88",
    "avg_salary": "$129,738"
  },
  {
    "skills": "node.js",
    "number_of_job_posting": "85",
    "avg_salary": "$126,156"
  },
  {
    "skills": "opencv",
    "number_of_job_posting": "81",
    "avg_salary": "$127,034"
  },
  {
    "skills": "unify",
    "number_of_job_posting": "81",
    "avg_salary": "$120,251"
  },
  {
    "skills": "zoom",
    "number_of_job_posting": "78",
    "avg_salary": "$128,427"
  },
  {
    "skills": "assembly",
    "number_of_job_posting": "72",
    "avg_salary": "$113,119"
  },
  {
    "skills": "rust",
    "number_of_job_posting": "71",
    "avg_salary": "$139,349"
  },
  {
    "skills": "visual basic",
    "number_of_job_posting": "71",
    "avg_salary": "$98,511"
  },
  {
    "skills": "ibm cloud",
    "number_of_job_posting": "70",
    "avg_salary": "$127,753"
  },
  {
    "skills": "graphql",
    "number_of_job_posting": "66",
    "avg_salary": "$128,659"
  },
  {
    "skills": "node",
    "number_of_job_posting": "65",
    "avg_salary": "$154,408"
  },
  {
    "skills": "yarn",
    "number_of_job_posting": "58",
    "avg_salary": "$111,963"
  },
  {
    "skills": "chef",
    "number_of_job_posting": "56",
    "avg_salary": "$126,314"
  },
  {
    "skills": "tidyverse",
    "number_of_job_posting": "55",
    "avg_salary": "$129,103"
  },
  {
    "skills": "mxnet",
    "number_of_job_posting": "50",
    "avg_salary": "$143,695"
  },
  {
    "skills": "jquery",
    "number_of_job_posting": "50",
    "avg_salary": "$114,645"
  },
  {
    "skills": "kotlin",
    "number_of_job_posting": "49",
    "avg_salary": "$135,639"
  },
  {
    "skills": "fastapi",
    "number_of_job_posting": "48",
    "avg_salary": "$136,574"
  },
  {
    "skills": "unity",
    "number_of_job_posting": "45",
    "avg_salary": "$126,608"
  },
  {
    "skills": "swift",
    "number_of_job_posting": "41",
    "avg_salary": "$119,972"
  },
  {
    "skills": "datarobot",
    "number_of_job_posting": "38",
    "avg_salary": "$132,211"
  },
  {
    "skills": "hugging face",
    "number_of_job_posting": "37",
    "avg_salary": "$148,648"
  },
  {
    "skills": "theano",
    "number_of_job_posting": "37",
    "avg_salary": "$143,404"
  },
  {
    "skills": "smartsheet",
    "number_of_job_posting": "35",
    "avg_salary": "$81,049"
  },
  {
    "skills": "puppet",
    "number_of_job_posting": "34",
    "avg_salary": "$122,649"
  },
  {
    "skills": "selenium",
    "number_of_job_posting": "34",
    "avg_salary": "$119,914"
  },
  {
    "skills": "watson",
    "number_of_job_posting": "31",
    "avg_salary": "$152,844"
  },
  {
    "skills": "asana",
    "number_of_job_posting": "31",
    "avg_salary": "$132,697"
  },
  {
    "skills": "notion",
    "number_of_job_posting": "31",
    "avg_salary": "$127,007"
  },
  {
    "skills": "planner",
    "number_of_job_posting": "31",
    "avg_salary": "$83,420"
  },
  {
    "skills": "asp.net",
    "number_of_job_posting": "30",
    "avg_salary": "$110,963"
  },
  {
    "skills": "rshiny",
    "number_of_job_posting": "29",
    "avg_salary": "$151,611"
  },
  {
    "skills": "mariadb",
    "number_of_job_posting": "28",
    "avg_salary": "$119,354"
  },
  {
    "skills": "couchbase",
    "number_of_job_posting": "27",
    "avg_salary": "$131,959"
  },
  {
    "skills": "svn",
    "number_of_job_posting": "27",
    "avg_salary": "$129,287"
  },
  {
    "skills": "unreal",
    "number_of_job_posting": "27",
    "avg_salary": "$112,667"
  },
  {
    "skills": "centos",
    "number_of_job_posting": "24",
    "avg_salary": "$125,953"
  },
  {
    "skills": "vue",
    "number_of_job_posting": "23",
    "avg_salary": "$129,863"
  },
  {
    "skills": "airtable",
    "number_of_job_posting": "22",
    "avg_salary": "$140,615"
  },
  {
    "skills": "vmware",
    "number_of_job_posting": "22",
    "avg_salary": "$124,486"
  },
  {
    "skills": "sqlite",
    "number_of_job_posting": "21",
    "avg_salary": "$124,976"
  },
  {
    "skills": "trello",
    "number_of_job_posting": "20",
    "avg_salary": "$92,643"
  },
  {
    "skills": "dplyr",
    "number_of_job_posting": "19",
    "avg_salary": "$160,667"
  },
  {
    "skills": "ruby on rails",
    "number_of_job_posting": "18",
    "avg_salary": "$140,130"
  },
  {
    "skills": "microsoft teams",
    "number_of_job_posting": "18",
    "avg_salary": "$93,559"
  },
  {
    "skills": "ubuntu",
    "number_of_job_posting": "16",
    "avg_salary": "$127,649"
  },
  {
    "skills": "groovy",
    "number_of_job_posting": "16",
    "avg_salary": "$119,251"
  },
  {
    "skills": "firebase",
    "number_of_job_posting": "14",
    "avg_salary": "$109,095"
  },
  {
    "skills": "wire",
    "number_of_job_posting": "13",
    "avg_salary": "$100,704"
  },
  {
    "skills": "vb.net",
    "number_of_job_posting": "13",
    "avg_salary": "$87,226"
  },
  {
    "skills": "clojure",
    "number_of_job_posting": "12",
    "avg_salary": "$139,342"
  },
  {
    "skills": "react.js",
    "number_of_job_posting": "12",
    "avg_salary": "$114,450"
  },
  {
    "skills": "macos",
    "number_of_job_posting": "12",
    "avg_salary": "$105,771"
  },
  {
    "skills": "solidity",
    "number_of_job_posting": "10",
    "avg_salary": "$153,640"
  },
  {
    "skills": "npm",
    "number_of_job_posting": "10",
    "avg_salary": "$97,030"
  },
  {
    "skills": "redhat",
    "number_of_job_posting": "9",
    "avg_salary": "$121,467"
  },
  {
    "skills": "electron",
    "number_of_job_posting": "9",
    "avg_salary": "$114,678"
  },
  {
    "skills": "pulumi",
    "number_of_job_posting": "9",
    "avg_salary": "$111,772"
  },
  {
    "skills": "fortran",
    "number_of_job_posting": "9",
    "avg_salary": "$110,083"
  },
  {
    "skills": "dart",
    "number_of_job_posting": "9",
    "avg_salary": "$105,373"
  },
  {
    "skills": "next.js",
    "number_of_job_posting": "8",
    "avg_salary": "$135,663"
  },
  {
    "skills": "arch",
    "number_of_job_posting": "8",
    "avg_salary": "$132,376"
  },
  {
    "skills": "twilio",
    "number_of_job_posting": "8",
    "avg_salary": "$126,210"
  },
  {
    "skills": "cordova",
    "number_of_job_posting": "8",
    "avg_salary": "$117,921"
  },
  {
    "skills": "elixir",
    "number_of_job_posting": "8",
    "avg_salary": "$112,073"
  },
  {
    "skills": "flutter",
    "number_of_job_posting": "8",
    "avg_salary": "$87,702"
  },
  {
    "skills": "monday.com",
    "number_of_job_posting": "8",
    "avg_salary": "$77,880"
  },
  {
    "skills": "openstack",
    "number_of_job_posting": "7",
    "avg_salary": "$137,455"
  },
  {
    "skills": "sass",
    "number_of_job_posting": "7",
    "avg_salary": "$109,585"
  },
  {
    "skills": "drupal",
    "number_of_job_posting": "7",
    "avg_salary": "$105,234"
  },
  {
    "skills": "symphony",
    "number_of_job_posting": "7",
    "avg_salary": "$98,400"
  },
  {
    "skills": "workfront",
    "number_of_job_posting": "7",
    "avg_salary": "$97,841"
  },
  {
    "skills": "codecommit",
    "number_of_job_posting": "6",
    "avg_salary": "$152,289"
  },
  {
    "skills": "heroku",
    "number_of_job_posting": "6",
    "avg_salary": "$141,667"
  },
  {
    "skills": "erlang",
    "number_of_job_posting": "6",
    "avg_salary": "$121,583"
  },
  {
    "skills": "cobol",
    "number_of_job_posting": "6",
    "avg_salary": "$106,497"
  },
  {
    "skills": "vue.js",
    "number_of_job_posting": "6",
    "avg_salary": "$104,958"
  },
  {
    "skills": "colocation",
    "number_of_job_posting": "5",
    "avg_salary": "$92,943"
  },
  {
    "skills": "laravel",
    "number_of_job_posting": "5",
    "avg_salary": "$82,200"
  },
  {
    "skills": "lisp",
    "number_of_job_posting": "4",
    "avg_salary": "$104,124"
  },
  {
    "skills": "webex",
    "number_of_job_posting": "4",
    "avg_salary": "$88,750"
  },
  {
    "skills": "haskell",
    "number_of_job_posting": "3",
    "avg_salary": "$155,758"
  },
  {
    "skills": "couchdb",
    "number_of_job_posting": "3",
    "avg_salary": "$144,167"
  },
  {
    "skills": "clickup",
    "number_of_job_posting": "3",
    "avg_salary": "$105,000"
  },
  {
    "skills": "firestore",
    "number_of_job_posting": "3",
    "avg_salary": "$80,019"
  },
  {
    "skills": "blazor",
    "number_of_job_posting": "3",
    "avg_salary": "$74,733"
  },
  {
    "skills": "ringcentral",
    "number_of_job_posting": "2",
    "avg_salary": "$182,500"
  },
  {
    "skills": "gatsby",
    "number_of_job_posting": "2",
    "avg_salary": "$147,500"
  },
  {
    "skills": "objective-c",
    "number_of_job_posting": "2",
    "avg_salary": "$131,825"
  },
  {
    "skills": "angular.js",
    "number_of_job_posting": "2",
    "avg_salary": "$127,050"
  },
  {
    "skills": "xamarin",
    "number_of_job_posting": "2",
    "avg_salary": "$121,250"
  },
  {
    "skills": "chainer",
    "number_of_job_posting": "2",
    "avg_salary": "$105,000"
  },
  {
    "skills": "wrike",
    "number_of_job_posting": "2",
    "avg_salary": "$101,250"
  },
  {
    "skills": "svelte",
    "number_of_job_posting": "2",
    "avg_salary": "$94,575"
  },
  {
    "skills": "apl",
    "number_of_job_posting": "2",
    "avg_salary": "$90,000"
  },
  {
    "skills": "digitalocean",
    "number_of_job_posting": "2",
    "avg_salary": "$65,000"
  },
  {
    "skills": "debian",
    "number_of_job_posting": "1",
    "avg_salary": "$196,500"
  },
  {
    "skills": "lua",
    "number_of_job_posting": "1",
    "avg_salary": "$170,500"
  },
  {
    "skills": "asp.net core",
    "number_of_job_posting": "1",
    "avg_salary": "$155,000"
  },
  {
    "skills": "mlr",
    "number_of_job_posting": "1",
    "avg_salary": "$145,000"
  },
  {
    "skills": "fastify",
    "number_of_job_posting": "1",
    "avg_salary": "$133,000"
  },
  {
    "skills": "suse",
    "number_of_job_posting": "1",
    "avg_salary": "$125,000"
  },
  {
    "skills": "qt",
    "number_of_job_posting": "1",
    "avg_salary": "$110,000"
  },
  {
    "skills": "delphi",
    "number_of_job_posting": "1",
    "avg_salary": "$98,496"
  },
  {
    "skills": "homebrew",
    "number_of_job_posting": "1",
    "avg_salary": "$96,773"
  },
  {
    "skills": "pascal",
    "number_of_job_posting": "1",
    "avg_salary": "$92,000"
  },
  {
    "skills": "kali",
    "number_of_job_posting": "1",
    "avg_salary": "$89,100"
  }
]
