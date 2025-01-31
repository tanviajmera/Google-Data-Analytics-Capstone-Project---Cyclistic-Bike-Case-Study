-----------DATA CLEANING PROCESS-----------
#1 ride_id 
-- all rows with length of rider id which is not 16 
*/

SELECT *
FROM cyclistic_combined_trip_data
WHERE LENGTH(ride_id) != 16;

-- correcting the length to make it uniform 
UPDATE cyclistic_combined_trip_data
SET ride_id = LPAD(ride_id, 16, '0')
WHERE LENGTH(ride_id) < 16;
-- the length of ride_id was corrected for 697 rows 

/* NOTE 
#2 started_at, ended_at 
-- deleting trips where ride duration was less than a minute and more than a day
*/ 
DELETE FROM cyclistic_combined_trip_data 
WHERE TIMESTAMPDIFF(MINUTE, started_at, ended_at) <= 1
OR TIMESTAMPDIFF(MINUTE, started_at, ended_at) >= 1440; 

-- calculating the ride duration 
-- adding new column ride_length to the table
ALTER TABLE cyclistic_combined_trip_data
ADD COLUMN ride_length int;

-- updating table with vaulue of new column 
UPDATE cyclistic_combined_trip_data
SET ride_length = TIMESTAMPDIFF(MINUTE, start_time, end_time)
WHERE 
  TIMESTAMPDIFF(MINUTE, start_time, end_time) > 1
  AND TIMESTAMPDIFF(MINUTE, start_time, end_time) < 1440;

/* NOTE 
#3 delete rows with null values 
*/ 
  DELETE FROM cyclistic_combined_trip_data
   WHERE start_station_name IS NULL OR start_station_name = ''
   OR start_station_id IS NULL OR start_station_id = ''
   OR end_station_name IS NULL OR end_station_name = ''
   OR end_station_id IS NULL OR end_station_id = ''
   OR end_lat IS NULL OR end_lat = ''
   OR end_lng IS NULL OR end_lng = '';
-- 221083 rows of null values were removed 

/* NOTE 
#4 adding new columns to the table to separate date and time
*/ 
ALTER TABLE cyclistic_combined_trip_data
ADD COLUMN start_date DATE,
ADD COLUMN start_time TIME,
ADD COLUMN end_date DATE,
ADD COLUMN end_time TIME;

-- updating the table with values of new columns
UPDATE cyclistic_combined_trip_data
SET 
  start_date = DATE(started_at),
  start_time = TIME(started_at),
  end_date = DATE(ended_at),
  end_time = TIME(ended_at);
  
/* NOTE
#5 --Extract day of the week and month from the start_date column 
-- adding new columns to the table 
*/
ALTER TABLE cyclistic_combined_trip_data
ADD COLUMN day_of_week varchar(20),
ADD COLUMN month varchar(20);

-- updating table with values of new columns
UPDATE cyclistic_combined_trip_data
SET day_of_week = dayname(start_date),
month = monthname(start_date);

/* NOTE 
#6 -- format the timestamp 
-- adding new column of time in table
*/
ALTER TABLE cyclistic_combined_trip_data
ADD COLUMN time varchar(20);

-- updating table with values of time 
UPDATE cyclistic_combined_trip_data
SET time = DATE_FORMAT(start_time, '%I:%i %p');

-- check the number of null values in each new column created
SELECT 
    SUM(start_date IS NULL) AS start_date_null_count,
    SUM(start_time IS NULL) AS start_time_null_count,
    SUM(end_date IS NULL) AS end_date_null_count,
    SUM(end_time IS NULL) AS end_time_null_count,
    SUM(day_of_week IS NULL OR day_of_week = '') AS day_of_week_null_count,
    SUM(month IS NULL OR month = '') AS month_null_count,
    SUM(time IS NULL OR time = '') AS time_null_count,
    SUM(ride_length IS NULL OR ride_length = '') AS ride_length_null_count
FROM cyclistic_combined_trip_data;
-- ride_length has 2288 null values 

-- deleting null values in ride_length column 

DELETE FROM cyclistic_combined_trip_data
WHERE (ride_length IS NULL OR ride_length = '');

-- creating new table with important columns 
CREATE TABLE `new_tripdata`
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_date, start_time, end_date, end_time,
day_of_week, month, time, ride_length, member_casual 
FROM cyclistic_combined_trip_data;
 
-- export new_tripdata 
SELECT 'ride_id', 'rideable_type', 'started_at', 'ended_at', 'start_station_name', 'end_station_name', 
       'start_date', 'start_time', 'end_date', 'end_time', 'day_of_week', 'month', 'time', 'ride_length', 'member_casual'
UNION ALL
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, 
       start_date, start_time, end_date, end_time, day_of_week, month, time, ride_length, member_casual
FROM new_tripdata
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output_with_headers.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';