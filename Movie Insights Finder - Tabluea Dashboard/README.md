# Streamline Your Streaming: A Data-Driven Movie Finder Dashboard

Directory Includes:

Data Folder - Contains Amazon, Netlfix, Disney+ and a merged csv file

Image Folder - Contains the logos and the template for the dashboard

Python Code Folder - Contains a juypter notebook for merging the csv files

Screenshots Folder - Contains the screenshots of the project

Tableau Folder - Contains the Tableau workbook for the dashboard


**Skills Used: Python, Tableau, Excel**

**Tableau:** https://tabsoft.co/3xljdWc

## About The Data:

Dataset source for this project is public on **Kaggle** and can be found at:

**Netflix** https://www.kaggle.com/datasets/shivamb/netflix-shows

**Last updated 2 years ago (2022)**. This dataset contains **6119 rows with 16 columns.**

**Disney+** https://www.kaggle.com/datasets/shivamb/disney-movies-and-tv-shows

**Last updated 2 years ago (2022)**. This dataset contains **1853 rows with 16 columns.**

**Amazon** https://www.kaggle.com/datasets/shivamb/amazon-prime-movies-and-tv-shows

**Last updated 2 years ago (2022)**. This dataset contains **9871 rows with 16 columns.**

The 16 columns shared across each dataset is; id, platform, type, title, runtime, genres, seasons, production_countries, release_year, age_certification, imdb_id, imdb_score, imdb_votes, tmdb_popularity, tmdb_score and a short description. 

The datasets have **missing values** in age_certification , which is **cleaned and updated** to improve the final dashboard. There are missing values in the important fields IMDB and TMDB score, as well as the descriptions.

The datasets provide valuable insights into **each platforms diversity and content**. Providing opportunity for **in-depth insights** into each platform, comparing each.


## Question:

Create a **dashboard on Tableau** using the Netflix, Amazon and Disney+ **datasets** for a user to **find which platform the movie/series** is from, and **provide details** for each movie/show for the user to use. 

Uses calculated fields to **create gauges** for the IMDB and TMDB score, to provide quick insights into shows quality.


## Data Cleaning (Excel):

To ensure **accurate** data representation and **avoid issues** during merging, I **cleaned each file separately** before **joining them using python**. 

This involved separating data using **text to column, checking and removing duplicate entries and addressing missing values**. Specifically, any **Null values** present in the "age_certification" column were replaced with **"NA"**, as this will make the final dashboard more visually appealing.

**Further cleaning was done using Python after the merge** (found in Data Transformation)

## Data Transformation (Python):

Using **python to merge the datasets** Netflix, Disney+ and Amazon together using **pandas** dataframes to store the files and **concat to merge** the dataframes, which we are able to do because each file has **identical column** titles and positions. 
```
# import libraries
import pandas as pd
```
```
# read in the 3 csv files (Amazon, Netflix and Disney)
amazon = pd.read_csv('D:\Learning\Portfolio\Movie Finder\Movie Files\Amazon\\titles.csv',encoding = "UTF-16 Le")

disney = pd.read_csv('D:\Learning\Portfolio\Movie Finder\Movie Files\Disney+\\titles.csv',encoding = "UTF-16 Le")

netflix = pd.read_csv('D:\Learning\Portfolio\Movie Finder\Movie Files\\Netflix\\titles.csv',encoding = "UTF-16 Le")
```
```
# Merge the dataframes amazon, netflix
movies = pd.concat([amazon,netflix,disney])

# Display Merged dataframe
movies
```
![Python part 2 1](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/17477056-1819-43f0-9a90-55f8ea5036f1)

**Second step** while using python is to further clean the data. 

**Remove brackets []** from the genres and production countries columns, **capitalizing** each genre and type, before finally **replacing the quotes on genres**.
```
# Cleaning Genres Data

# Removing the brackets from genres
movies['genres'] = movies['genres'].str.strip('[]')

# Capitalizing each genre
movies['genres'] = movies['genres'].str.title()

# Replacing quotes
movies['genres'] = movies['genres'].str.replace("'",'',regex=True)

# Removing the brackets from production countries
movies['production_countries'] = movies['production_countries'].str.strip('[]')

# Capitalizing type
movies['type'] = movies['type'].str.title()
```

![Python New](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/6747420a-e252-40be-8c72-5e0f7068f472)

Save the new dataframe as **Movies**.
```
movies.to_csv('Movies.csv', index = False)
```

## Dashboard:

![Part 1](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/053854fc-9337-4119-bc15-2cccf314384c)

The dashboard uses a **title filter** to search for the content the user after. The filter will **update all the visuals and insights** providing the user with the **relative information** for the content. The visuals included are **gauges**, providing visuals and number ratings for **TMDB and IMDB**. 

![Gauge](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/a7ef3e3e-e8a9-4a2c-86e2-9849c47f7d5a)

The **gauges are created using 5 calculations** to create **separate slices**, **two pie charts** on the same axis to create **donut effect**. Gauges have been chosen to be used as they give the user a **quick visual idea of the show/movie** rating, with extra detail provided with the value. 

![Part 2](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/6131e554-514d-405e-b21b-dbf65c6b313e)

Alongside the gauges, the dashboard **displays detailed** insights for each selected title.

**This information includes:**

+ Platform

+ Type

+ Genres

+ Release Year

+ Average Runtime (for Series, and runtime for movies)

+ Seasons Count

+ Age Restriction

+ Short Description

![Part 3](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/94869766-73c6-458b-b38c-603284a6a311)

## Conclusion:

This project involved creating a **movie finder using Tableau**, using **three different datasets** (Amazon, Netflix, Disney+), which where **merged together and cleaned using python**, with **original cleaning completed using excel**. The data encompasses **movie titles, two different ratings, genres, runtime, description and more**. 

This was a **basic project** that did **not involve diving deep** in the datasets nor looking for insights, but rather be to **competent in creating a visually appealing** and easy to use **dashboard for users**, without over complicated visuals or filters. 

Improvements for the dashboard is for **better use of space** on each sub section. An **additional feature** of **giving recommended movie/series** based on the show you searched. 

**Updating all the missing values** from the datasets, to have a fully complete dataset for users to use. 

Overall, this project provided **valuable learning opportunities** in **creating gauges within Tableau** and **exploring colour theme design principles**. The skill gained throughout this project will be **instrumental in future projects.**
