-- check the data type of all columns 
describe cyclistic_combined_trip_data;

-- check the number of null values in each column 
SELECT 
    SUM(ride_id IS NULL OR ride_id = '') AS ride_id_null_count,
    SUM(rideable_type IS NULL OR rideable_type = '') AS rideable_type_null_count,
    SUM(started_at IS NULL) AS started_at_null_count,
    SUM(ended_at IS NULL) AS ended_at_null_count,
    SUM(start_station_name IS NULL OR start_station_name = '') AS start_station_name_null_count,
    SUM(start_station_id IS NULL OR start_station_id = '') AS start_station_id_null_count,
    SUM(end_station_name IS NULL OR end_station_name = '') AS end_station_name_null_count,
    SUM(end_station_id IS NULL OR end_station_id = '') AS end_station_id_null_count,
    SUM(start_lat IS NULL OR start_lat = '') AS start_lat_null_count,
    SUM(start_lng IS NULL OR start_lng = '') AS start_lng_null_count,
    SUM(end_lat IS NULL OR end_lat = '') AS end_lat_null_count,
    SUM(end_lng IS NULL OR end_lng = '') AS end_lng_null_count,
    SUM(member_casual IS NULL OR member_casual = '') AS member_casual_null_count
FROM cyclistic_combined_trip_data;
-- columns having null values are: start_station_name, start_station_id, end_station_name, end_station_id, end_lat, end_lng

/* NOTE
-------Analyze columns from left to right for data cleaning--------------------

--#1 ride_id: the length of the rider id should be uniform 
*/

SELECT LENGTH(ride_id) as ride_id_length
FROM cyclistic_combined_trip_data
GROUP BY LENGTH(ride_id);

select count(distinct ride_id)
from cyclistic_combined_trip_data; 

/* NOTE 
-- the length was inconsistent
-- all the ride_id strings are distinct, hence it is the primary key 
-- this column needs cleaning 

--#2 rideable_type: determine the types of vehicle 
*/

SELECT rideable_type 
FROM cyclistic_combined_trip_data
GROUP BY rideable_type;
/* NOTE 	
-- there are three types of bike: electric, classic and docked

--#3 started_at, ended_at: ride duration
*/

SELECT *
FROM cyclistic_combined_trip_data
WHERE TIMESTAMPDIFF(MINUTE, started_at, ended_at) <= 1
   OR TIMESTAMPDIFF(MINUTE, started_at, ended_at) >= 1440;

/* NOTE 
-- there are 63,075 rows with ride duration less than one minute and longer than one day
-- the column needs cleaning 

#4 name & id of start_station and end_station
*/

SELECT DISTINCT start_station_name, COUNT(*) AS start_station_count
FROM cyclistic_combined_trip_data
GROUP BY start_station_name;

SELECT DISTINCT end_station_name, COUNT(*) AS end_station_count
FROM cyclistic_combined_trip_data
GROUP BY end_station_name;

SELECT DISTINCT start_station_id, end_station_id
FROM cyclistic_combined_trip_data	
WHERE start_station_id IS NOT NULL OR
end_station_id IS NOT NULL;
/* NOTE
-- the start and end stations have null values. they will be removed in data cleaning 
-- the string lengths of station id is inconsistent. however, it will be ignored as the station id is not important in our analysis

#5 Check number of rows where latitude and longitude are null
*/

SELECT *
FROM cyclistic_combined_trip_data
WHERE start_lat IS NULL OR start_lat = '' OR
      start_lng IS NULL OR start_lng = '' OR
      end_lat IS NULL OR end_lat = '' OR
      end_lng IS NULL OR end_lng = '';
/*
-- NOTE
-- there are 861 null values so these rows will be removed

#6 member_casual: type of membership 
*/ 

select member_casual, count(*) as membership_count 
from cyclistic_combined_trip_data
group by member_casual;
/* NOTE 
-- two types of membership: member and casual 
-- total number of memberships is equal to the total number of rows

--Now the data is ready to be cleaned