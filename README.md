# Cyclistic Bike Share Case Study

## Introduction
The Cyclistic Bike Share Case Study is a capstone project in the Google Data Analytics Professional Certificate program. During the course, I learned the six stages of data analysis process: ask, prepare, process, analyse, share and act. The case study showcases my understanding and the technical skills learned throughout this course. 
Background
I am assuming the position of ‘Jr. Data Analyst’ at Cyclistic, a bike-share company in Chicago. The company offers more than 6,000 bicycles at over 600 docking stations across Chicago. At present, they provide two types of bikes: classic and electric. Cyclistic users are divided in two categories: Casual and Members. Customers who purchase single-ride or full-day passes are referred to as casual riders, whereas customers purchasing annual memberships fall under the members category. 
The director of marketing believes that the company can maximize profits by increasing the number of annual memberships. However, she also believes that there is an opportunity to target the casual riders and convert them into members. In order to fulfil this, it is important to understand what are the major differences between the annual members and casual riders. 

## Ask
In this first step of data analytics process, it is important to understand the problem we are trying to solve. Given that the marketing team is aiming to convert the casual riders into annual members, I am allotted the task to answer how annual members and casual riders use Cyclistic bikes differently. 
Prepare
The historical trip data for analysis was collected from here. For the purpose of this case study, I have used the data of 2023 quarter 1. Due to the data-privacy issues, the rider’s personally identifiable information has been hidden. The data is unbiased and credible. It has been made available by Motivate International Inc. under this license. I have stored the dataset files in my local drive on computer. 	
Process
The tools used for this analysis are: 
Data cleaning and processing: MySQL workbench, RStudio
Data visualization: RStudio, PowerBI 
The steps taken in the processing of the data are as follows: 
Data combination
•	I created four tables in MySQL for the datasets of the first quarter of 2023. After importing the datasets in their respective tables, I created a new table called ‘cyclistic_combined_data’ to merge all tables into one. 
•	The new table contains 10,66,014 rows and 13 columns. Following is a snapshot of the code used: 
 
•	Below is the name of each column and its data type:
 
Data exploration
I analysed all columns from left to right by running queries and making note of any column that needs cleaning. The queries of data exploration can be found here on Github. Following is a snapshot of the query run for the first column: 
 
Quick summary of data exploration process: 
•	ride_id: the length of ride_id is inconsistent, data cleaning is required. It is a primary key and there are no duplicates. A total of 10,66,014 unique rides were made in the first quarter of 2023. 
•	rideable_type: there are three types of bikes named electric, classic and docked.
•	started_at/ended_at: these columns represent the time at which the ride started or ended. 63,705 rows have the ride duration less than a minute or more than a day. These rows will be removed during data cleaning. 
•	start_station_name/end_station_name: there are 3,13,564 trips with null values in either the starting station name column or ending station name column. Since there is insufficient information to determine the station names for these rows, they will be deleted. 
•	start_station_id/end_station_id: the string lengths of both start station id and end station id is inconsistent. However, it will be ignored as the station id is not important in our analysis.
•	start_lat/end_lat & start_lng/end_lng: these four columns showcase the start and end location of the trips. There are 861 null values in these columns, hence these rows will be removed. 
•	member_casual: there are two types of members – casual and members. The total number of memberships is equal to the total number of rows, therefore there are no null values in this column.  
Data cleaning
Now that I am done with the data exploration process, I know which columns needs to be cleaned and which new columns can be created from this data to assist me further in the analysis. My data cleaning process can be viewed here on Github. Here is a snapshot of the first query of cleaning: 
 
A summary of the cleaning steps is as follows: 
•	Corrected the length of ride_id to make it uniform with 16 characters. 
•	Removed trips where ride duration was less than/equal to one minute and more than/equal to one day. 
•	Created new column ‘ride_length’ to calculate the time difference between start and end time. 
•	Removed trips that had null values for start station name & id, end station name & id, end latitude and longitude rows. A total of 221083 rows were removed. 
•	Created new columns to separate date and time from started_at and ended_at columns. New columns added were: start_date, start_time, end_date and end_time. 
•	Created new columns ‘day_of_week’ and ‘month’ to support the analysis further. 
•	Added a new column of ‘time’ to format the timestamp of the trips for an easy understanding.
•	Thereafter, I again checked for null values in all the newly created columns. ‘ride_length’ column had 2288 null values which were removed
•	At last, I created a new table ‘new_tripdata’ with all the important columns for analysis. This new table has 7,79,569 rows after data cleaning.
Analyze and Share
Now that my data is clean and prepared for analysis, it is time to analyze the data and answer the question: “How do annual members and casual members use bike differently?”. 
The ‘new_tripdata’ table created in MySQL was exported to my file directory and later imported in Tableau Public to proceed further in the analysis. To illustrate how casual riders and annual members use the bike differently, I created a visualization. The tableau dashboard can be found here. 
Below are the summary insights of the visualizations from the dashboard. This will assist me in analyzing and answering the business question. 
1.	Ride distribution 

 
In the above visualization, we see a distribution of the number of rides by both types of customers. Annual members accounted for a maximum share of 72.9% of the total rides. On the other hand, casual rides accounted for 27.09%. 
2.	Bike preference 

 
On comparing the bike preference by the customers, I found that annual members prefer to ride classic bikes. They have never used docked bikes. Whereas casual riders use both classic bikes almost as much as electric bikes. A small proportion of casual riders use docked bikes. 
3.	Rides by day of the week 

 
In the above visualization, we can see the total number of rides for both categories by day of the week. With each passing the day, the numbers of casual rides increase in a small percentage. Annual members, on the other hand, take more rides on the weekdays as compared to on weekends. This suggests that annual members use the bike to ride to their workplace. 
4.	Rides per hour on a daily basis 

 
From the above line chart, it is clear that members had a higher usage of bikes than the casual customers. The annual members had two peak times during the day, 8 am and 5 pm. The maximum of number of bikes were used between 4-6 pm. However, casual riders only peaked at 5 pm. 
5.	Most popular start stations for Casual riders 

 
Act
Key takeaways: 
•	There was an almost equal distribution of casual riders between classic and electric bikes. Whereas, members prefer classic bikes over electric. 
•	The casual users tend to use the bike for leisure purposes, mostly on weekends. On the other hand, members use it for daily commute on weekdays.
•	Both annual and casual users have a high demand for the bike around 5 pm. Therefore, there are chances of shortage of bikes during that time. 
Recommendations: 
Based on the above analysis and driven insights, I would like to give the following recommendations to design marketing strategies aimed at converting casual riders into annual members:
1.	Casual users tend to ride on weekends, so offering weekday discounts for them could encourage more frequent use, familiarizing them with the convenience of biking for commuting.
2.	We can introduce flexible or short-term memberships (e.g. monthly or seasonal passes) for casual riders. This can act as a trial phase for conversion into annual memberships. 
3.	Since casual riders already show interest in electric bikes, marketing campaigns could emphasize how annual memberships reduce the overall cost of using electric bikes regularly.
4.	Addressing the potential bike shortages at 5 pm should also be part of the strategy. For example, dynamic bike allocation and station monitoring could improve availability during peak hours.
5.	Use the top 10 start stations as prime locations for targeted outdoor advertising. Promote annual memberships, discounts, or other benefits to casual riders directly at these stations.

Thank you for reading my Capstone Project! 
