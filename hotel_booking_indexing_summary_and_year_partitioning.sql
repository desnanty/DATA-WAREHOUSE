-- EXTENSION
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- INDEX
CREATE INDEX idx_country
ON fact_hotel_booking(country);

CREATE INDEX idx_hotel
ON fact_hotel_booking(hotel);

CREATE INDEX idx_year
ON fact_hotel_booking(year);

-- MATERIALIZED VIEW
CREATE MATERIALIZED VIEW monthly_booking_summary AS

SELECT
year,
month,
hotel,
COUNT(*) AS total_booking,
AVG(average_daily_rate) AS avg_adr,
SUM(is_canceled) AS total_canceled

FROM fact_hotel_booking

GROUP BY
year,
month,
hotel;

-- PARTITION TABLE
CREATE TABLE fact_hotel_partitioned (
hotel TEXT,
country TEXT,
adults INT,
children FLOAT,
babies INT,
market_segment TEXT,
distribution_channel TEXT,
lead_time INT,
is_canceled INT,
reserved_room_type TEXT,
assigned_room_type TEXT,
booking_changes INT,
stays_in_weekend_nights INT,
stays_in_week_nights INT,
average_daily_rate FLOAT,
year INT,
month INT,
quarter INT,
day INT
)
PARTITION BY RANGE (year);

-- PARTITION 2015
CREATE TABLE fact_hotel_2015
PARTITION OF fact_hotel_partitioned
FOR VALUES FROM (2015) TO (2016);

-- PARTITION 2016
CREATE TABLE fact_hotel_2016
PARTITION OF fact_hotel_partitioned
FOR VALUES FROM (2016) TO (2017);

-- PARTITION 2017
CREATE TABLE fact_hotel_2017
PARTITION OF fact_hotel_partitioned
FOR VALUES FROM (2017) TO (2018); 

