
CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

CREATE TABLE IF NOT EXISTS SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);


CREATE INDEX idx_fat_covering ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);


INSERT INTO SensorLogs (sensor_id, recorded_at, temperature, humidity, status) VALUES
(105, '2026-06-20 08:00:00', 36.50, 60.00, 'NORMAL'),
(105, '2026-06-20 08:00:01', 37.20, 58.50, 'NORMAL'),
(102, '2026-06-20 08:00:02', 45.00, 80.00, 'CRITICAL');


EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';


ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;


CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);


EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';


SELECT 
    TABLE_NAME AS 'Table',
    ROUND((DATA_LENGTH / 1024 / 1024), 2) AS 'Data Size (MB)',
    ROUND((INDEX_LENGTH / 1024 / 1024), 2) AS 'Index Size (MB)'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db' AND TABLE_NAME = 'SensorLogs';