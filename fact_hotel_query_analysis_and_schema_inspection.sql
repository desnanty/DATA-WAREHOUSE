EXPLAIN ANALYZE 
SELECT market_segment, COUNT(*) 
FROM fact_hotel_partitioned 
GROUP BY market_segment;

EXPLAIN ANALYZE
SELECT *
FROM fact_hotel_booking;

SELECT *
FROM dim_hotel;

SELECT table_name
FROM information_schema.tables
WHERE table_schema='public';

ALTER TABLE fact_hotel_booking
ADD CONSTRAINT fk_time
FOREIGN KEY (time_id)
REFERENCES dim_time(time_id);

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'fact_hotel_booking';