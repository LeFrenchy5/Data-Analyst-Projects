# Unveiling the Secrets of Box Office Success: A Data-Driven Exploration of Movie Profitability

Directory Includes:

Data Folder - Contains the movies, missing values and updated movies csv files, as well a zip file.

Correlation Python Folder - Contains The Api Jupyter Notebook python file, as well as the correlation project code (also on Jupyter Notebook)

Screenshot Folder - Contains all the screenshots for the project

Thumbnail Folder - Contains the thumbnail for the portfolio


**Skills Used: Python - Pandas, Seaborn, Matplotlib, Numpy , Requests (API)**


## About The Data:

Dataset source for this project is public on Kaggle and can be found at 

https://www.kaggle.com/datasets/danielgrijalvas/movies

The dataset was **last updated 3 years ago (2021)**

This dataset contains **7668 rows** with **15 columns**,encompassing **various film details** like move title, rating, release year, budget and gross profit.

To address the **missing values** and enhance data quality for insights, I will use **TMDB API** to **update missing values** where possible. This will be achieved using Python.

## Question:

This project delves into a rich dataset of movies to uncover the factors that hold the **strongest influence on a film's financial performance**. By **analyzing correlations** between **gross earning and various film attributes**, we aim to answer a critical question: 

**Which factor has the highest correlation with a movie's gross earnings?**

## Transforming Data Using API:

Over **2000 budgets** are missing from the dataset, this may **skew the results**. I will use a **movie database API** to update these missing values.

Using the **TMDB Api** to update missing values to my dataset budget. Import both packages used, **pandas** to store the dataframe and **requests** to use the API.
```
# import Packages
import pandas as pd
import requests
```
First **Read** in the movies dataset to a **dataframe called movies_df**
```
# Read in the Movies.csv to find the movies with missing values
movies_df = pd.read_csv("D:\Learning\Portfolio\Movie Python Project\\movies.csv")
```
**Search** through **movies_df** to find **null values** and save these movie titles to **missing_data_movies**.
```
# Find movies with missing data in any column
missing_data_movies = movies_df[movies_df.isnull().any(axis=1)]["name"].tolist()

# Remove any potential duplicates
unique_missing_movies = list(set(missing_data_movies))

print("Movies with missing data (unique):", unique_missing_movies)
```
![part 1](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/e8eedffc-0488-4439-b211-5ddaab736f3a)

**Store my api key** from TMDB to use to request use of their APi. (**Key is hidden** for security reasons but it is free and easy to apply and receive a TMDB Key)
```
# storing api key for TMDB (Hidden for Security)
api_key = "#####################"
```
Using the **api key and the requests package**, we'll search the **TMDB database** for the movie title in our **unique_missing_movie**s list. This Will be stored in **missing_df**.
```
# Using the TMDB Api to find data for the missing movie values
# Using unique_missing_movies to iterate through missing values

for movie_title in unique_missing_movies:
    try:
        # Search for the movie using the title
        search_url = f"https://api.themoviedb.org/3/search/movie?api_key={api_key}&query={movie_title}"
        search_response = requests.get(search_url)
        search_response.raise_for_status()  # Raise error for non-200 status codes
        search_data = search_response.json()

        # Check if any results were found
        if search_data["results"]:
            movie_id = search_data["results"][0]["id"]  # Get the ID of the first result

            # Fetch movie details using the ID
            detail_url = f"https://api.themoviedb.org/3/movie/{movie_id}?api_key={api_key}"
            detail_response = requests.get(detail_url)
            detail_response.raise_for_status()
            movie_data.append(detail_response.json())

        else:
            print(f"Movie '{movie_title}' not found.")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data for movie '{movie_title}': {e}")

# Create a Pandas DataFrame from the collected movie data
missing_df = pd.DataFrame(movie_data)

# Show Dataframe
missing_df
```
![Part 2](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/1be0c828-76fd-4ef4-96e4-6256b8f65e9f)

Getting on **overview** of missing_df to determine how many rows we have and any **potential issues** with **missing values** in budget column or column **name issues** that will affect merging the two dataframes.
```
# Inspecting the dataframe
missing_df.info()
```
![Part 3](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/cb8d7d1a-20e7-41e1-bd3c-193820ccd167)

**Dropping the unwanted columns** from the dataframe and changing column **"name" to title**.
```
# Removing unwanted columns from missing_df
missing_copy_df = missing_df.drop(['adult', 'backdrop_path','belongs_to_collection','homepage','id','imdb_id'                             ,'original_language','original_title','overview','popularity','poster_path','spoken_languages','status','tagline','video','rating', 'genres', 'year', 'released', 'vote_average', 'vote_count','director','writer', 'star','production_countries', 'revenue','production_companies', 'runtime'],axis = 1)
```
```
# Rename the title column to match the Movies column name
missing_copy_df = missing_copy_df.rename(columns = {'title': 'name'})
```
Inspecting the **clean dataframe** to check for any **issues with the transformation** from dropping columns. Checking columns names, values are in the correct column.
```
# Checking the changes made
missing_copy_df
```
![Part 4](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/adbbb2b5-fdf2-497a-9f32-4be84c1afeaa)

Creating **copies** of the movies and missing data, these will be used to **update the movies dataframe** with the missing values.
```
# Create Copies of both the main dataframe (movies) and the edited missing values dataframe

original_df = movies_df.copy()
update_df = missing_copy_df.copy()
```
```
# Check the original dataframe
original_df
```
```
# Check the update dataframe
update_df
```

**Creating a dictionary** that will store the **movie name** as the key and the **movie budget** as the value. This dictionary (called update) will be used to **update the movies dataframe** with the missing budget values.
```
# Create a dictionary called update that uses name as the key and budget as the value
update = {row['name']: row['budget'] for index, row in update_df.iterrows()}
```
```
# Check update values and format
update
```
![Part 7](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/bfbcbe22-22e9-4b26-a905-c73ebbde3729)

**Iterating through the update dictionary to update the movies dataframe.** 
```
# Find all the unqiue values in original_df
existing_movies = set(original_df['name'])

# Iterate through update to remove any movie names not in the movies.csv
update_filtered = {key: budget for key, budget in update.items() if key in existing_movies}

# Check for Null values in original and update the value using the budget of update_filtered
# If the budget value in update_filtered is 0, then ignore the value and keep Null
for key, budget in update_filtered.items():
    if budget > 0:
        original_df.loc[(original_copy['name'] == key) & (original_df['budget'].isnull()), 'budget'] = budget
    else:
        continue
```
```
# Write a new Csv called Movies_updated.csv
original_df.to_csv('Movies_updated.csv')
```
## Python Project:

Using **Python** to determine if there is any **correlation between movies gross earnings** and different **movies factors** (budget, genre, release year, etc) this will be achieved with visuals such as **heat maps and scatter plots, as well as tables.**

Firstly, we **imported** all the **libraries** needed, pandas for dataframe **manipulation, searborn and matplotlib for visuals.**  

Read the **movies file** that have been updated (Movies_updated) into a **pandas dataframe,** using head and info functions to check for any issues with the columns or the data types.
```
# Import Libraries
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib
import matplotlib.pyplot as plt

# Figure size and style
plt.style.use('ggplot')
%matplotlib inline
matplotlib.rcParams['figure.figsize'] = (12,8)
```
```
# Read in the data from csv file
movies_df = pd.read_csv("D:\Learning\Portfolio\Movie Python Project\movies_updated.csv")
```
```
# Checking the first value in Movies_df
movies_df.head()
```
![1](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/04c4c92e-5c6e-4f32-849b-12ca875e38e0)

```
# Inspecting the Movies dataframe 
movies_df.info()
```
![2](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/29698d23-e1b2-4dfd-89ae-79718b9aae9c)

**Error** in the movies_df with a column name **"Unnamed: 0".** We will **drop** this column to clean the dataframe up before moving forward in analysis.
```
# Dropping Unnamed column as its a duplicate column
movies_df = movies_df.drop(['Unnamed: 0'], axis = 1)
```
```
# Sorting by gross in descending order
movies_df.sort_values(by=['gross'], inplace = False, ascending = False)
```
![3](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/e44cf670-5c5f-49cb-9e3d-915774606595)

```
# Scatter Plot comparing Budget and Gross

plt.scatter(x=movies_df['budget'], y= movies_df['gross'])
sns.regplot(x='budget', y= 'gross', data = movies_df, scatter_kws = {'color':'red'}, line_kws={'color': 'blue'})

# Labels
plt.title('Budget vs Gross Earnings')
plt.xlabel('Budget')
plt.ylabel('Gross')

# display plot
plt.show()
```

From the **scatter plot** (image below), it appears there is a **positive correlation** between a **movies budget and the gross earnings**. There is a general **upward trend**, where movies with **higher budget tend to have higher earnings**, however there are multiple points below the trend line indicating **some lower budget movies also achieved high earnings**.

There are **outliers** with some films with **higher budgets**  with **exceptionally high earnings**,as well as **exceptionally low earnings**. This could lead to further investigation as to why these **movies did so well or so terribly**.

The **spread of data points** around the trend line indicates that **budget is not the sole factor** affecting gross earnings and further analysis is needed. 

![4](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/bb8f79d3-8cb1-414d-9768-4edd45533dae)

```
# Checking the correlations of Movies_df dataframe using Pearson
# Different correlation options Pearson Kendall and Spearman to test
movies_df.select_dtypes(include=[int, float]).corr(method = 'pearson')
```
To gain a **more in-depth** look at potential **correlation** for gross earnings,using a **table and Pearson method**. We can see that **gross has higher correlation with budget and votes** (total people voting on a score) than **year, score and runtime**. With score having the lowest correlation. 

![5](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/2f521b14-2be5-4260-a38c-9a15efd87f2b)

```
# Creating a Correlation Matrix for Movies_df using a heat map from seaborn
correlation_matrix = movies_df.select_dtypes(include=[int, float]).corr(method = 'pearson')

# Creating a heatmap to visually display the potential correlations
sns.heatmap(correlation_matrix, annot = True)

# Labels for the plot
plt.title('Correlation Matrix')
plt.xlabel('Movie Features')
plt.ylabel('Movie Features')

# Show plot
plt.show()
```
Using a **heat map (correlation matrix)** as a visual aid, we can validate our **initial observations** regarding factors influencing movie profitability, as expected a **movies budget has a very strong correlation of 0.74** with gross earnings. This aligns with the idea that **bigger budget films** tend to have **more resources for marketing** and wider releases.

**Votes** (total audience votes on IMDB) has a **strong correlation of 0.63** with gross earnings. This suggests that movies **generating greater user interest** on IMDB and **popularity tend** to translate to higher earnings.

The heatmap also reveals some interesting **counter-intuitive findings**. **Release year** and **runtime** display only **weak positive correlations** with gross earnings. This implies that a movie's release year and its length might **not** **significantly impact its financial performance**.

The **surprising insights** come from **score (IMDB Rating)** having a **weak correlation of 0.19** with gross earnings, suggesting that even though a movie has a **high rating**, doesn't mean it will have the **popularity to bring in more earnings**. There's a possibility that **audience preferences and genre popularity** might play a more significant role in **movie selection than ratings**,  a movie could also have a **lower number of votes which could skew the score** into being higher or lower than it would normally be.

![6](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/98215e14-1b5d-4df9-beaa-d1bcb4e9bdac)

```
# Convert object column types to catergorical to be used for calculations in a heat map

# Create a copy of movies_df for manipulation
companies_df = movies_df.copy()

# Iterate through columns to check for object type
for col_name in companies_df.columns:
    if(companies_df[col_name].dtype == 'object'):
		# Convert to catergory type
        companies_df[col_name] = companies_df[col_name].astype('category') 
		# Assign numerical codes to catergories
        companies_df[col_name] = companies_df[col_name].cat.codes

 # Display modfied dataframe        
companies_df
```
**Preparing all data** to be used for a heat map. This will be achieved by a **two step approach** by converting from **object to category** using the **.astype('category')** Second step will use the **.cat.codes** method to **assigned numerical codes** to each distinct category. 

This **refined data** preparation process ensure **all movie features**, including those initially containing text data, could be integrated into the heat map for analysis.

![7](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/55031b71-d4ae-47ea-8eba-5b3b312c99e1)

```
# Using the modfied companies_df to create a correlation matrix with all columns

# Using Pearson method
correlation_matrix = companies_df.corr(method = 'pearson')

# Labels for Correlation Matrix
sns.heatmap(correlation_matrix, annot = True)
plt.title('Correlation Matrix')
plt.xlabel('Movie Features')
plt.ylabel('Movie Features')

# Show Correlation Matrix for all columns
plt.show()
```
As identified earlier in the data, it reveals a **very high positive correlation (0.74) between budget and gross earnings**, and a **strong positive correlation (0.63) between votes** and gross earnings but interestingly **genre proved to be a weak negative correlation.**

The analysis shows **weak negative correlation (-0.24) between genre and gross earnings**. This suggests that genre itself might not be a **strong predictor of financial success**. While there might be some underlying cost or audience preference differences between genres, factors like budget allocated for production and marketing, or the level of audience interest (as indicated by votes), seem to have a more significant influence on a movie's overall profitability.

![8](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/293f85a4-50e2-4e62-a757-da9b740b7fd9)

```
# Creating a table to compare correlation easier for gross 
correlation_matrix = companies_df.corr()

# Filter for correlations with 'gross'
gross_corr = correlation_matrix['gross'].sort_values()

# Show values
gross_corr
```
![9](https://github.com/LeFrenchy5/Data-Analyst-Projects/assets/123564919/2ef42ec9-9483-4a2b-9375-f2e1fe92360a)

## Conclusion:

This project investigated the **factors influencing a movie's financial performance** using a dataset of **7,668 films**. By leveraging the **TMDB API** to **update missing budgets** from the original dataset, also Python libraries like **Pandas and Seaborn**, were used able to **clean, analyze, and visualize** the data to uncover key insights.

Our analysis revealed that **budget and audience interest**, as measured by votes, **hold the strongest correlations** with gross earnings **(0.74 and 0.63 respectively)**. This suggests that movies with **larger budgets and higher pre-release popularity** tend to perform better **financially**. These findings align with the **notion that bigger budgets** allow for **wider marketing campaigns** and potentially higher production value, while audience interest translates into ticket sales. This interest can snowball, as **high vote counts signal a movie's popularity,** potentially **attracting even more viewers** who want to be part of the **cultural conversation or avoid missing out on a widely discussed film.**

**Interestingly**, the data indicates that factors like **release year, runtime**, and even **critical reception** (as measured by IMDB score) have **weaker correlations with gross earnings**. This implies that a **movie's release timing, length**, and c**ritical acclaim** might **not be as influential** on its financial success as previously thought.

A **interesting discovery** lies in the **weak negative correlation (-0.24)** between **genre and gross earnings**. While there might be cost or **audience preference** variations between genres, it appears **genre itself isn't a strong predictor** of a movie's financial outcome.


### Future Considerations:

This project provides a **valuable starting point** for understanding the **financial landscape** of the film industry. However, there's room for **further exploration**. Here are some areas for future investigation:

**Sub genres**: Delving deeper into sub genres within broader categories might reveal stronger correlations with gross earnings compared to analyzing genres as a whole.


**Marketing Spend:** If data on marketing spend is available, it would be interesting to see how it interacts with budget and influences gross earnings.


**Critical Reception:** Exploring alternative measures of critical reception beyond IMDB score could provide a more nuanced view of how critics' opinions impact a movie's success.


**Streaming vs. Theatrical Release:** Analyzing the impact of release format (streaming vs. theatrical) on financial performance could offer valuable insights in today's evolving film industry.
