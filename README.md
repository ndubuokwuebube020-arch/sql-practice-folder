# Data Analyst Skills Market Analysis

![Data Analyst skills market analysis cover](market-analysis-cover.png)

> **Portfolio project · PostgreSQL · 2023 job postings**  
> An evidence-based look at which skills appear most often in Data Analyst postings and how skill requirements differ in higher-paying jobs.

## Project at a glance

| | |
|---|---|
| **Business question** | Which skills show the strongest combination of demand and earning potential for Data Analysts? |
| **Dataset** | 600,000+ job postings from the 2023 Kaggle Data Science job-postings dataset |
| **Approach** | Four PostgreSQL analyses of skill demand and salary patterns |
| **Tools** | PostgreSQL, SQL, Git/GitHub, VS Code |
| **Audience** | Data Analyst job seekers and people planning their analytics skill development |

## Explore the SQL project

Go to [project_sqlfolder](/project_sql/) to browse the analysis queries. 

## Executive finding

The strongest general-purpose foundation in the supplied results is **SQL + Excel + Python**. Add **one** visualization platform, then build a portfolio project that shows how you turn a business question into a clear recommendation. Cloud and data-engineering skills appear more often in specialized and higher-paying postings, but this analysis cannot prove that learning one of those tools by itself raises salary.

**The practical takeaway:** establish the core, demonstrate business impact, and specialize toward the roles you want.

### The skill stack

<p align="center">
  <img src="sticker-sql.png" alt="SQL sticker" width="135" />&nbsp;&nbsp;
  <img src="sticker-excel.png" alt="Excel sticker" width="135" />&nbsp;&nbsp;
  <img src="sticker-python.png" alt="Python sticker" width="135" />&nbsp;&nbsp;
  <img src="sticker-viz.png" alt="Visualization sticker" width="135" />
</p>

## What I analyzed

The project uses a PostgreSQL schema linking job postings to skill requirements, skill metadata, and company information. It examines the market from four angles:

| Analysis | Question | Finding from the project |
|---|---|---|
| Overall demand and pay | Which skills combine broad demand and higher average pay across roles? | SQL and Python lead by volume. AWS, Spark, Kafka, and Airflow show reported averages above $140K in the broad, all-role analysis. |
| Data Analyst demand | Which skills are most frequently requested in Data Analyst postings? | SQL ~93%, Excel ~67%, Python ~57%, Tableau ~47%, Power BI ~39%, R ~30%, SAS ~28%. |
| Salary by skill | Which skills appear alongside higher average salaries in Data Analyst postings? | Specialized tools such as Kafka, Terraform, and Go appear near the top (~$130K+), while common foundational skills average less. |
| Higher-paying roles | What skills appear in Data Analyst jobs with salaries above $150K? | SQL ~66%, Excel ~42%, Python ~39%, Tableau ~38%, plus cloud/data platforms, engineering workflow, and communication tools. |

*Percentages and salary figures above are reported from the project draft. Verify the query filters, salary units, and denominators before publishing or comparing them with another source.*

## What the results suggest

### 1. Prioritize the skills with the broadest coverage

SQL appears in about 93% of the analyzed Data Analyst postings. Excel appears in about 67%, and Python in about 57%. These results support prioritizing query skills, spreadsheet fluency, and reproducible analysis before collecting a long list of niche tools.

### 2. Learn one visualization platform well

Tableau (~47%) and Power BI (~39%) both appear frequently. The evidence points to learning one platform deeply enough to build a useful dashboard and explain what decision it supports. It does not show that every candidate needs both.

### 3. Interpret high salaries with care

Specialized skills have higher average salaries in the skill-level analysis, but they may be indicators of seniority, industry, location, or data-engineering responsibilities. They are not proof that the tool caused the higher pay. Use them to identify role directions worth exploring.

### 4. Higher-paying analyst jobs ask for broader contribution

The $150K+ group includes analytics fundamentals along with cloud/data platforms, engineering practices, and communication tools. A strong candidate story should therefore show the full path from data to decision: clarify the question, prepare and analyze the data, communicate the result, and recommend an action.

## Step-by-step: turn this project into hiring evidence

### Step 1 — Make the analysis easy to verify

- Add the four SQL query files to the repository and link each query from the project README.
- Document the dataset source, schema, date range, and any exclusions.
- For every result, state the denominator, filters, salary unit/currency, and whether the figure is a count, share, or average.
- Add a short note on missing salary data and how outliers were handled.

### Step 2 — Show the work visually

![Four step Data Analyst skills roadmap](skills-roadmap.png)

- Create one clean dashboard or set of charts for demand and salary.
- Label the chart sample and time period; do not imply that 2023 results describe today's market.
- Use a chart to compare skill demand, and a separate view for salary so the two measures are not confused.
- Add a short takeaway beside each chart in plain language.

### Step 3 — Demonstrate skills with a focused portfolio project

Build a small companion analysis using a business dataset. Include:

1. A specific stakeholder question.
2. Data cleaning and quality checks.
3. SQL queries that answer the question.
4. A dashboard or clear visual summary.
5. A recommendation and a note on uncertainty.

This lets employers see how you work, not only which tools you list.

### Step 4 — Tailor the skills you develop to job descriptions

Collect 15–20 current postings for the roles and locations you want. Record repeated skills and classify them as **core**, **visualization**, **platform**, or **workflow/communication**. Compare those current requirements with this 2023 snapshot, then choose the next skill based on the gap you see most often.

### Step 5 — Present the project clearly on your resume

Use a result-first project entry. Replace the bracketed items with numbers you have personally verified:

> **Data Analyst Skills Market Analysis | PostgreSQL, SQL** — Analyzed 600K+ 2023 job postings using four SQL analyses to compare skill demand and salary patterns; found SQL in ~93% of sampled Data Analyst postings and identified cloud/data-platform skills common in the selected $150K+ segment. Documented sample limitations and translated findings into a prioritized learning roadmap.

Only keep the 600K+, 93%, or salary claims if the dataset and query outputs in your repository support them. If the 600K+ figure is the full dataset size rather than the analyzed subset, say “dataset containing 600K+ postings” instead of implying every row was included in each analysis.

### Step 6 — Prepare a concise interview explanation

Practice this four-part story:

1. **Problem:** “I wanted to understand which analyst skills are broadly requested and what appears in higher-paying postings.”
2. **Method:** “I used PostgreSQL joins and aggregations to connect postings with skill and salary information, then compared four views of the market.”
3. **Finding:** “SQL, Excel, and Python were the strongest broad foundation in my results; specialized skills clustered in higher-paying roles.”
4. **Judgment:** “I treated salary patterns as associations, because seniority and job mix can explain the difference. I recommended validating requirements against current target postings.”

Be ready to open one query and explain its joins, filters, denominator, and one data-quality decision.

### Step 7 — Use a steady application routine

- Apply to roles whose responsibilities match your demonstrated work, not only roles with a perfect tool checklist.
- Customize the resume summary and project bullet to the posting's repeated requirements.
- Put the repository or portfolio link near the top of your resume or profile.
- Track applications, interview questions, and skill gaps; use the pattern to decide what to improve next.
- Keep building and applying in parallel rather than waiting until you have learned every tool.

## Recommended learning order

1. **Foundation:** SQL and Excel.
2. **Analysis:** Python for data manipulation and repeatable work.
3. **Communication:** Tableau or Power BI, plus concise written recommendations.
4. **Specialization:** one cloud or data-platform skill aligned with target roles, such as AWS, Azure, Snowflake, or Databricks.
5. **Workflow:** Git and, where relevant, dbt or Airflow.
6. **Proof:** publish a complete project with a question, reproducible analysis, visualization, recommendation, and limitations.

## Limitations

- This is a 2023 snapshot. It does not represent current hiring demand, and newer requirements may be absent.
- Salary results use postings that report salary, which may differ from postings without salary data.
- The $150K+ analysis describes a selected salary segment, not the typical Data Analyst posting.
- Job ads describe requested skills; they do not establish what employees use daily or what caused a hiring decision.
- Seniority, geography, industry, company, and role specialization may affect both salary and requested skills.
- The project summary was drafted from reported findings. Confirm the exact SQL outputs and methodology before publishing claims.

## Final recommendation

Build a credible **SQL + Excel + Python** foundation, get strong in **one** visualization platform, and prove your ability to communicate a decision from data. Add a cloud or engineering tool when it matches the roles you are targeting. This roadmap can make your application clearer and your skills more relevant; no project or skill list can guarantee a job.

---

*Analysis based on 2023 job postings. GenAI-related requirements that emerged later may not be captured.*
