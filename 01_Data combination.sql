 -- create new table for jan data
CREATE TABLE trip_data_202301 (
    ride_id VARCHAR(100), -- Assuming ride IDs are alphanumeric
    rideable_type VARCHAR(40), -- Types of rides (e.g., "electric_bike", "classic_bike")
    started_at DATETIME, -- Start time of the ride
    ended_at DATETIME, -- End time of the ride
    start_station_name VARCHAR(100), -- Station name at the start
    start_station_id VARCHAR(50), -- Station ID at the start (may include alphanumeric characters)
    end_station_name VARCHAR(100), -- Station name at the end
    end_station_id VARCHAR(50), -- Station ID at the end
    start_lat VARCHAR(50), -- Latitude for the start location
    start_lng VARCHAR(50), -- Longitude for the start location
    end_lat VARCHAR(50), -- Latitude for the end location
    end_lng VARCHAR(50), -- Longitude for the end location
    member_casual VARCHAR(10) -- Membership type (e.g., "member", "casual")
);

-- import csv into jan table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202301-divvy-tripdata.csv'
INTO TABLE `trip_data_202301`
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual);

 	 

-- create new table for feb data
CREATE TABLE trip_data_202302 (
    ride_id VARCHAR(100), -- Assuming ride IDs are alphanumeric
    rideable_type VARCHAR(40), -- Types of rides (e.g., "electric_bike", "classic_bike")
    started_at DATETIME, -- Start time of the ride
    ended_at DATETIME, -- End time of the ride
    start_station_name VARCHAR(100), -- Station name at the start
    start_station_id VARCHAR(50), -- Station ID at the start (may include alphanumeric characters)
    end_station_name VARCHAR(100), -- Station name at the end
    end_station_id VARCHAR(50), -- Station ID at the end
    start_lat VARCHAR(50), -- Latitude for the start location
    start_lng VARCHAR(50), -- Longitude for the start location
    end_lat VARCHAR(50), -- Latitude for the end location
    end_lng VARCHAR(50), -- Longitude for the end location
    member_casual VARCHAR(10) -- Membership type (e.g., "member", "casual")
);

-- import csv into feb table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202302-divvy-tripdata.csv'
INTO TABLE `trip_data_202302`
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual);

-- create new table for mar data
CREATE TABLE trip_data_202303 (
    ride_id VARCHAR(100), -- Assuming ride IDs are alphanumeric
    rideable_type VARCHAR(40), -- Types of rides (e.g., "electric_bike", "classic_bike")
    started_at DATETIME, -- Start time of the ride
    ended_at DATETIME, -- End time of the ride
    start_station_name VARCHAR(100), -- Station name at the start
    start_station_id VARCHAR(50), -- Station ID at the start (may include alphanumeric characters)
    end_station_name VARCHAR(100), -- Station name at the end
    end_station_id VARCHAR(50), -- Station ID at the end
    start_lat VARCHAR(50), -- Latitude for the start location
    start_lng VARCHAR(50), -- Longitude for the start location
    end_lat VARCHAR(50), -- Latitude for the end location
    end_lng VARCHAR(50), -- Longitude for the end location
    member_casual VARCHAR(10) -- Membership type (e.g., "member", "casual")
);

-- import csv into mar table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202303-divvy-tripdata.csv'
INTO TABLE `trip_data_202303`
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual);

-- create new table for apr data
CREATE TABLE trip_data_202304 (
    ride_id VARCHAR(100), -- Assuming ride IDs are alphanumeric
    rideable_type VARCHAR(40), -- Types of rides (e.g., "electric_bike", "classic_bike")
    started_at DATETIME, -- Start time of the ride
    ended_at DATETIME, -- End time of the ride
    start_station_name VARCHAR(100), -- Station name at the start
    start_station_id VARCHAR(50), -- Station ID at the start (may include alphanumeric characters)
    end_station_name VARCHAR(100), -- Station name at the end
    end_station_id VARCHAR(50), -- Station ID at the end
    start_lat VARCHAR(50), -- Latitude for the start location
    start_lng VARCHAR(50), -- Longitude for the start location
    end_lat VARCHAR(50), -- Latitude for the end location
    end_lng VARCHAR(50), -- Longitude for the end location
    member_casual VARCHAR(10) -- Membership type (e.g., "member", "casual")
);

-- import csv into apr table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/202304-divvy-tripdata.csv'
INTO TABLE `trip_data_202304`
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual);

-- merge the four tables into one table named `cylcistic_combined_data`
create table `cyclistic_combined_trip_data` AS 
select * from `tripdata_202301`
UNION ALL 
SELECT * FROM `tripdata_202302`
UNION ALL
SELECT * FROM `tripdata_202303`
UNION ALL
SELECT * FROM `tripdata_202304`;
-- the combined table contains 10,66,014 rows