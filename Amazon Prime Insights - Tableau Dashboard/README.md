# Amazon Prime Insights: A Data Exploration

Directory includes:

Data folder - Contains the datasets (csv), zip folder of the data and a link to the dataset

Prime Logo - Contains the logo used

Screenshots - Contains screenshots of the project

Tableau Workbook - Contains the dashboards workbook


**Skills Used: Tableau, Excel, Radial Bar Chart (Advanced Tableau Calculations)**

**Tableau:** https://tabsoft.co/4cJW53T

## About The Data:

Dataset source for this project is public on Kaggle and can be found at 

https://www.kaggle.com/datasets/shivamb/amazon-prime-movies-and-tv-shows

**No definite date** for the dataset but it was **last updated 2 years ago** (2022)

The dataset contains **9668 rows** of movies and series, with **12 columns**

(Show_id, Title, Type, Director, Cast, Country, Date Added, Release Year, Rating, Duration, Genre listed, Description)

The dataset has **missing values**, which could cause **issues** in in the analysis and the dataset could benefit from **further transformation**, with the **addition of user reviews and IMDB scores**.

The **dataset provides valuable insights** into the platform's content offerings, allowing for an **exploration of trends** in genre, release years, and potentially user preferences.

## Question:

Using the Amazon Prime video dataset, implement a **informative, interactive dashboard** to provide **data-driven insights** into Amazon's library preferences. Work with the given data , **implement no transformation's nor update missing values.**

## Dashboard:

![Main Newer](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/7e8a9721-cbce-4864-8ee2-fd971a0c3edf)

The dashboard is **designed in two parts**. The **first section provides insights** into Amazon Prime's collection of movies and series. **Notably**, Amazon Prime boasts a vast library of **movies**, making up **80% of the collection**, with series constituting the remaining 20%. Additionally, **drama reigns supreme** as the most prominent **genre**, with 986 movies/series falling under this category. **Furthermore, 4** of the **top 10 genres** include **drama** as a **category or sub-category.**

![Insights 1 new](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/fff7fd63-68b3-45bf-8f54-366659dc66fd)

The dashboard is designed in the Amazon Prime **blue and white** with minimal headers and **minimalistic design**, for ease of understanding the visuals. 

![Insights 2](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/65716e1a-5c3c-4a09-924b-00ad229c5964)

The **second section** allows users to **delve deeper into individual movies and series**. Leveraging a **title search** feature, users can explore a wealth of information about each **title**, including its **type** (movie or series), **length** (seasons for series or runtime for movies), **year of release, cast, and a short description**. The search will also display the genre(s) associated with each title, allowing users to find movies and series based on their **preferences**. 

![movie search new](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/a33fdb9a-0c87-4b0c-98bb-afa4cb687a9e)


## Conclusion:

An **interactive dashboard** was created to analyze potential **user preferences** within the Amazon Prime media library. The analysis revealed **Drama** as the **most prominent genre**, with 986  movies/series being labeled drama, closest is comedy with 531 movies/shows. **Drama is also featured in 4 of the top 10 genres.**

Interestingly, **movies constituted the majority of the content** with **80% (7750)**, suggesting potential user preferences for **long form entertainment or Amazon's preference** for movie's of shows. **United States of America** has produced the most **content (292)** with **India** a close second with **238**, this insight is **misleading** as a major portion of the datasets country column has **missing values.**

**Notably**, the analysis revealed an **exponential increase in recently released or Amazon** **produced content**, suggesting a strategic shift towards original content or modern content, catering to user preferences for fresh entertainment.

While this project provides valuable insights, **limitations** exist:

**Improvements** include, to **update all missing values**, to provide a full in-depth analysis, as well as **transforming** the data to **include IMDB ratings** and **Amazon Prime user reviews**, providing a further analysis for the company to compare the platforms content. To gather further insights into how the **content is perceived** by the users.

**Improvements** for the **dashboard** include more in depth visuals, this improvement with the above transformation, would allow a **deep analysis** of **each genre to user rating**, **specific actors and directors** to **IMDB rating** and **user ratings** to provide an understanding of whom is preferred on the platform.  

The **removal** of the **second section** (title search feature) for more **visuals or insights** to provide the company would be more **beneficial.** 

By **implementing** these suggestions, my **future iterations** of this project can offer even more **valuable insights** into understanding **user preferences and optimizing** the Amazon Prime video platform.

