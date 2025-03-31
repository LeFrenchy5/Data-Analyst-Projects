# Building Retention Strategies: An Interactive HR Attrition Dashboard For IBM

Directory Includes:

Data Folder - Contains the IBM data (csv) and the kaggle link

IBM Logo - Contains the logo

Dashboard Screenshots - Includes all the screenshots for the project (includes orginal and new screenshots)

Power Bi Folder - Contains the full dashboard on power bi workbook

Thumbnail folder - Contains the portfolio thumbnail


**Skills used: Power bi, Excel**


## About the data:

Data source for this project is public on Kaggle and can be found at 

https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

**No definite date** for the dataset but it was **last updated 7 years ago (2017)**

**The dataset is fictionally created by IBM data scientist for practice purposes.**

This dataset contains **1470 rows** of data with **35 columns** **(No missing values)**, the dataset includes **demographic information** like age, education, and marital status, as well as **work-related attributes** like business travel frequency and hourly rate.

This dataset is interesting as there is **potential key insights** to be found for **HR managers** in the **age compared to business travel, gender to martial status**. Analyzing these potential relationships could help HR managers identify **groups at risk of leaving** or implement targeted initiatives to improve employee satisfaction.


## Question:

Leveraging an **IBM HR dataset**, I designed and implemented an **interactive dashboard** to empower HR managers with **data-driven insights** into employee demographics (gender, marital status, education, age) and compensation. This project aimed to **identify potential issues with attrition** in the company and find causes.


## Data Cleaning (Excel):

I used excel to check for any potential issues with the data, such as **duplicates, incorrect data and missing values**. Some of the techniques used where **columns to text, removing duplicates, data validation and find and replace**. The data was clean with no duplicates nor any missing values, just 0 values but that is expected in the dataset (Training time last year, Stock options level, Years with current manager, can all have 0 value)

## IBM HR Dashboard:

This **Power Bi dashboard** aims to empowers HR managers with comprehensive insights into employee demographics and potential pay gaps. It offers an **interactive experience** - click on any insight segment (eg. gender, age , education) and every visualization updates, dynamically reflecting the chosen filter. The dashboard features **12 interconnected visualizations.**

![IBM dashboard new](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/4a8b8a08-8f0c-485e-999b-e261edc7a52e)

· **Click-to-filter functionality:** Explore data intuitively by simply clicking on specific demographics. Every chart, graph, and visual updates, displaying only relevant information for the chosen segment.

·  **Interconnected analysis:** No need to navigate through multiple menus or drill down levels. All visualizations are dynamically linked, providing a holistic view of the impact of each filter selection.

· **Real-time insights:** Instantly see how changes in demographics affect salary distributions, department composition, and potential pay gaps, empowering informed decision-making.

![IBM dashboard new 2](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/8cace7b0-56c2-4498-a32a-ef29d6e7864e)

· **Visually appealing:** Light blue color scheme (hex code #118DFF) aligns with IBM branding and promotes readability. Clear labeling and intuitive layout further enhance user experience.

· **Visually appealing:** light grey used for the worksheet provides a reprieve for your eyes and helps highlight the insights.

· **Focus on actionability:** Insights are presented in a clear and concise manner, with easy to read labels and text, enabling HR managers to quickly identify potential areas of concern and take data-driven action.

![IBM dashboard new 1](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/380503ee-e0a7-45bc-ace0-ff059fe55ab9)

## Conclusion:

Our analysis reveals a potential concerning **16.12% employee attrition rate**, exceeding industry benchmarks like the recommended **10% annual turnover**. This translates to **237 departures**, potentially resulting in lost knowledge, decreased productivity, and higher recruitment costs.

### Key Findings:

· **Sales representatives exhibit a concerning attrition rate of 39.75%**, with 33 individuals leaving the company. Further investigation reveals the **average monthly income is $2000**, with only 4 sales representatives exceeding $3000. Considering the prevalent commission-based structure of sales roles, this disparity might **incentivize departures** for **more stable income or enhanced compensation** elsewhere. Notably, **23 of the departing sales representatives are 30 or under**, suggesting potential influence of early career aspirations on their decision.

· **68% (162 individuals)** of departing employees had a **tenure of 5 years or less**, signifying a **concerning trend of early-career departures** with an additional **23% (54 individuals)** left after **6-10 years with the company**, demonstrating a second plateau of potential talent loss.

· **45 individuals** departing within the **2-5 year range** originated from the **Research & Development department**, representing a **significant portion (51%) of this group**. A concerning trend lies in the demographic with 43 individuals receiving a **monthly salary of $4000 or less**, and **25** individuals **earning $2000**.

· **A concerning 59% (79 individuals)** of **departing Research and Development employees** left within the **first 3 years** of working under their **current manager**. This is further **amplified by 36% (48 individuals)** leaving within their **first year** of working **under a new manager**, **43** of those individuals are **new hires**.


Improvements for future iterations of the project, include working with non-generative datasets, as the data is too perfect with no outliers. Improve visuals used to create a more diverse dashboard for more visualizing appealing insights and in-depth analysis.



References:

Apollo technical : https://bit.ly/4bN0P8G

Office Vibe Linkedin: https://bit.ly/4bGdcmF

IBM logo: https://en.m.wikipedia.org/wiki/File:IBM_logo.svg
