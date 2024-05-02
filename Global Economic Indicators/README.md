# Global Economic Indicators - Power Bi

Directory Includes:

Data Folder - Contains the flag, NASA and Countries csv Files

Images - Includes all Icons used and background

Json Files- Includes the JSON files for the geomap used and countries

Power bi pbix - power bi report.


**Skills Used: Power Bi, Data Modeling, Data Visualization, DAX, Microsoft Excel**

## About The Data:

All the countries data comes from the **World Bank's Economic Development** database at https://databank.worldbank.org

Specific API data sources:

https://api.worldbank.org/v2/country/all?format=JSON&per_page=500﻿

https://api.worldbank.org/v2/sources/2/series/SP.POP.TOTL/metdata

https://api.worldbank.org/v2/sources/2/series/NY.GDP.MKTP.KD/metdata

https://api.worldbank.org/v2/sources/2/series/NY.GDP.PCAP.KD/metdata

Flags are from:

https://www.kaggle.com/datasets/edoardoba/world-flags?resource=download

https://commons.wikimedia.org/wiki/Main_Page


## Question:

Create a report that delves into the **impact of GDP** on countries, as well as researching into the **top and bottom 10** Countries in terms of **GDP and land mass**. Employ data visualization techniques to explore potential **outliers or trends**. Develop a **drill down** page for individual countries, providing detailed information and relevant metrics and potential trends. Additionally create a **global report page** summarizing **key findings** for all countries.

## Data Transforming:

![Soruce Countries - Transfomartion Steps](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/1aba0ff7-1a3c-479d-bd82-d57960019bba)  

Using the World API to get the **Countries data source**. 

**Converted to table** to change the data to a **tabular format**. **Expanded the columns** to access the columns needed for the report, **expanded again** to get the **regions** for each country.

After expanding the data into a usable table, we **cleaned** the data by **changing column names** and changing the **data types** (longitude and latitude to decimal numbers)

To complete the transformation we change the name to **Source Countries** to be used in creating our **Dim and Fact tables**.

![Source Countries - Transformed](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/9c931430-4850-4497-8262-cace213623fc)

![Source- Indicators Transformation step](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/9b7e814e-c996-4a04-8c6d-79450767e0bc)

**Promoting the first line to headers**, cleaning the data by **changing the data type** and **removing the bottom rows** because they are date the data was last updated and finally removing the unwanted columns.

We need to **unpivot the columns** as each year is on a new column rather than a new row. 

The dates needed to be **cleaned from 1973** [YR1973] to just 1973, this was achieved by **extracting the first 4 characters** from each row.

Final clean of **renaming columns** and changing any incorrect data types (IndicatorValue to number) and changing the **name to Source-indicators**

![Source Indicators - Transformed](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/9835c54a-b3c8-4134-908e-877872b99b16)

![Source Metadata - Transformation step](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/cda33e81-2043-4a30-9777-4a450764d93b)

We started by **converting the data to a table**, followed by **expanding the table** sources to get all the columns.

**Removed the columns** (page, pages, total , source_id , source_name, per_page, source_name and source_concept_id) before expanding the source to only include rows with id **NY.GDP.MKTP.KD**

This was done for **each Metadata source table**, 

which includes:

Source-metadata-population

Source-metadata-gdp-per-capita

Source-metadata-gdp

![Source Metadata - Transformed](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/dd1e6df0-42e1-47e3-a55f-29549b9225e4)

## Data Modeling:

![Model](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/0509daf9-6438-41af-9fe2-75787f54ad37)

The report utilizes a **basic star schema** data model for analyzing the economic indicators across different countries.

The central **Fact_indicators** table stores the indicator values (population and GDP for each country), this central table is linked to the **Dim_year** table for year specific analysis ( change in temperature) and Dim_countries table for country level comparisons. 

**Dim_countries** has a sub-dimension table, **Dim_flag** which provides visual flags for visual representation on the report.

Additionally, a **_Measure** table holds all the measure calculations, and a **Metadata** table which stores information about the data sources used in the report.

## Data Visualization:

Before creating visual for our report, we needed to create a few measures to be used in the report and for the visuals.

Below are two of the 15 Dax measures used in the report.

```
GDP Annual Growth % = 
/* 
Description: calculates the annual GDP growth of a given 
country by comparing the current year's GDP value to the 
previous year's GDP value, finding the difference, and using 
that to calculate percentage growth from one year to the next.

Change Tracking:
April 17, 2024: Version 1 
*/

// get the current year of analysis
var Currentyear = SELECTEDVALUE('Fact_Indicators'[Year])

// get GDP value of current year
var CurrentYearGDP = CALCULATE([GDP], 'Fact_Indicators'[Year] = Currentyear)

//get GDP of previous year
var PrevYearGDP = CALCULATE([GDP], 'Fact_Indicators'[Year] = Currentyear - 1)

//Calculate difference between current and previous year gdp
Var Diff = CurrentYearGDP - PrevYearGDP

//calculate annual growth rate
var GrowthRate = DIVIDE(Diff, PrevYearGDP,0)
return 
GrowthRate
```

```
GDP = 
/*
Calculates the sum of GDP, GDP values are stored in the Fact_indicators table under NY.GDP.MKTP.KD
*/
CALCULATE(
    [SumIndicatorValue],
    'Fact_Indicators'[Series Code] = "NY.GDP.MKTP.KD"
)
```

The report provides a **overview** of **economic indicators** across various countries, presented across **3 main pages** (overview, global and metadata) and a **drill through** page( country detail). Users can **navigate** between pages using the **dedicated buttons** on the top right.

The overview page offers a set of **interactive visualizations**. **A world map** which displays the 7 different world regions. **A bar graph** showcases the distribution of countries by region. **A table** displays key economic indicators (population, GDP, population density, GDP per capita and GDP per year) for each country in 2020. Finally a **scatter plot** allows users to explore the relationship between change in global temperature and GDP growth.

![Overview - None Selected](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/857a4974-8f7d-4d72-ba80-adf592011301)

Users can access **detailed information** for a specific country by **hovering over** it on the visuals and selecting **"drill-through"** or by selecting a country and using the **drill-through button** on the top right (which **turns green** when a country is selected)

![Overview - Selected](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/0923a701-0d60-4e71-b31c-ec4ee957d22b)

Drilling through to the **country detail page** , which will provide the user with a **more in-depth** analysis for the country that was selected. The page includes the **country name** and the **flag** (achieved through using measures)

The users will be greeted with an easy to read **KPI cards** showing **population, GDP, population density and GDP per capita for 2020**, each KPI includes an **image icon** that visually represents the metric. 

A **stacked column and line graph** display the change in **GDP annual growth** (columns) and **GDP** (line) for each **year**, with annual growth values shown in percentages with negative values shown in red and positive shown in blue. A table displays the **GDP, GDP annual growth , population and GDP per capita** for each year (up to 1973)

![Country Detail](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/1fd55dbd-b3dd-414e-ae0f-9a388a320f0f)

The global page **mirrors** the country detail layout, presenting **key global economic** indicators through cards. This section displays four KPI values with informative icons, showcasing **global population , global GDP, average population density and average GDP per capita.** 

The page offers **interactive visualizations** that allow users to explore rankings and trends. By using the buttons, users can switch between the **top 10 and bottom 10** countries based on two key visuals. (bookmarks were used for the buttons)

**Landmass Comparison:** A bar graph visually compares the GDP per capita of the top/bottom 10 countries by landmass, providing insights into economic strength across different geographical sizes.

**GDP per Capita Trends:** A line graph tracks the GDP per capita trends over time for the top/bottom 10 countries, allowing users to identify leading and lagging economies."


Showing the top 10 countries
![Global Top 10](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/636fe7b1-fb60-4715-8fc9-f1a1c8661de3)

Showing the bottom 10 countries 
![Global Bottom 10](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/6d450c7e-a520-4781-adcd-2c62fbf6df13)

The final page provides users with access to **crucial metadata** about the data sources used in the report. This section includes **links** to the **specific API's** employed to retrieve the economic data. Additionally, a comprehensive **matrix table** servers as a **reference guide** for all indicators used. Each indicator has a **full description** and any **notes** regarding the data.

![Metadata](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/98ef3a6d-c373-4659-bfe4-fbbaa6907cb9)

## Conclusion:

To conclude, this report provides an **analysis of economic indicators** across various countries, leveraging data from the **World Bank API's**. 

We **transformed the data** using techniques such as **Converted To table** to convert API responses to tabular format, **Unpivoted other columns** to change the dimensions of the table, **extracting first characters** and more. We also **cleaned** the data by c**hanging data types** , **column names** and **removing unwanted columns and rows** . 

A **star schema model** was employed to efficiently organize the data. The model include a **fact_indicators** table (central table storing core indicators), **Dim_year** (storing years), **Dim_countries** (storing countries details), **Dim_flag** containing the flags for each country, as well as a **metadata and _measures table**.

**Dax** was used in the **measures** which are used in the visuals, as well as techniques such as using **bookmarks and drill through** in the report.

To effectively communicate insights, a variety of **data visualizations** were used across multiple report pages. Some of the visuals utilized were, **World map, bar charts, tables, scatter plots and stacked columns and line graph.**

This project provided a **deeper understanding** of **data transformation, data modeling, DAX and data visualization.**

**Areas of Improvement:**

**Transforming the data** in a more logical manner and to make sure the query folding doesn't get broken.

Creating more comprehensive **star schema's**.

Improve use of **colour** on the report to help aid users with understanding the data.

**Positioning of visuals** need to be improved to use the Z line of site technique

Adding more **comments** to **DAX queries**. 

**Further Analysis** for the indicators is needed for future projects.
