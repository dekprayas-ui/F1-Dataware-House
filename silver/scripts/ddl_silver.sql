/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'silver' Tables.
    Silver layer holds cleaned, typed, and standardized data from bronze.
===============================================================================
*/

-- ============================================================
-- circuits
-- ============================================================

IF OBJECT_ID('silver.circuits', 'U') IS NOT NULL
    DROP TABLE silver.circuits;
GO

CREATE TABLE silver.circuits (
    circuit_id INT PRIMARY KEY,
    circuit_ref NVARCHAR(25),
    name NVARCHAR(50),
    location NVARCHAR(50),
    country NVARCHAR(50),
    lat FLOAT,
    lng FLOAT,
    alt INT,
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- constructor_results
-- ============================================================

IF OBJECT_ID('silver.constructor_results', 'U') IS NOT NULL
    DROP TABLE silver.constructor_results;
GO

CREATE TABLE silver.constructor_results (
    constructor_results_id INT PRIMARY KEY,
    race_id INT,
    constructor_id INT,
    points INT,
    status NVARCHAR(10),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- constructor_standings
-- ============================================================

IF OBJECT_ID('silver.constructor_standings', 'U') IS NOT NULL
    DROP TABLE silver.constructor_standings;
GO

CREATE TABLE silver.constructor_standings (
    constructor_standing_id INT PRIMARY KEY,
    race_id INT,
    constructor_id INT,
    points INT,
    position INT,
    position_text NVARCHAR(10),
    wins INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- constructors
-- ============================================================

IF OBJECT_ID('silver.constructors', 'U') IS NOT NULL
    DROP TABLE silver.constructors;
GO

CREATE TABLE silver.constructors (
    constructor_id INT PRIMARY KEY,
    constructor_ref NVARCHAR(20),
    name NVARCHAR(50),
    nationality NVARCHAR(50),
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- driver_standings
-- ============================================================

IF OBJECT_ID('silver.driver_standings', 'U') IS NOT NULL
    DROP TABLE silver.driver_standings;
GO

CREATE TABLE silver.driver_standings (
    driver_standings_id INT PRIMARY KEY,
    race_id INT,
    driver_id INT,
    points INT,
    position INT,
    position_text NVARCHAR(10),
    wins INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- drivers
-- ============================================================

IF OBJECT_ID('silver.drivers', 'U') IS NOT NULL
    DROP TABLE silver.drivers;
GO

CREATE TABLE silver.drivers (
    driver_id INT PRIMARY KEY,
    driver_ref NVARCHAR(50),
    number INT,
    code NVARCHAR(10),
    forename NVARCHAR(50),
    surname NVARCHAR(50),
    dob DATE,
    nationality NVARCHAR(50),
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- lap_times
-- ============================================================

IF OBJECT_ID('silver.lap_times', 'U') IS NOT NULL
    DROP TABLE silver.lap_times;
GO

CREATE TABLE silver.lap_times (
    race_id INT,
    driver_id INT,
    lap INT,
    position INT,
    time TIME(3),
    milliseconds INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- pit_stops
-- ============================================================

IF OBJECT_ID('silver.pit_stops', 'U') IS NOT NULL
    DROP TABLE silver.pit_stops;
GO

CREATE TABLE silver.pit_stops (
    race_id INT,
    driver_id INT,
    stop INT,
    lap INT,
    time TIME(3),
    duration NVARCHAR(20),
    milliseconds INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- qualifying
-- ============================================================

IF OBJECT_ID('silver.qualifying', 'U') IS NOT NULL
    DROP TABLE silver.qualifying;
GO

CREATE TABLE silver.qualifying (
    qualify_id INT,
    race_id INT,
    driver_id INT,
    constructor_id INT,
    number INT,
    position INT,
    q1 TIME(3),
    q2 TIME(3),
    q3 TIME(3),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- races
-- ============================================================

IF OBJECT_ID('silver.races', 'U') IS NOT NULL
    DROP TABLE silver.races;
GO

CREATE TABLE silver.races (
    race_id INT PRIMARY KEY,
    year INT,
    round INT,
    circuit_id INT,
    name NVARCHAR(100),
    date DATE,
    time TIME(3),
    url NVARCHAR(MAX),
    fp1_date DATE,
    fp1_time TIME(3),
    fp2_date DATE,
    fp2_time TIME(3),
    fp3_date DATE,
    fp3_time TIME(3),
    quali_date DATE,
    quali_time TIME(3),
    sprint_date DATE,
    sprint_time TIME(3),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- results
-- ============================================================

IF OBJECT_ID('silver.results', 'U') IS NOT NULL
    DROP TABLE silver.results;
GO

CREATE TABLE silver.results (
    result_id INT PRIMARY KEY,
    race_id INT,
    driver_id INT,
    constructor_id INT,
    number INT,
    grid INT,
    position INT,
    position_text NVARCHAR(10),
    position_order INT,
    points FLOAT,
    laps INT,
    time NVARCHAR(25),
    milliseconds INT,
    fastest_lap INT,
    rank INT,
    fastest_lap_time NVARCHAR(20),
    fastest_lap_speed FLOAT,
    status_id INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- seasons
-- ============================================================

IF OBJECT_ID('silver.seasons', 'U') IS NOT NULL
    DROP TABLE silver.seasons;
GO

CREATE TABLE silver.seasons (
    year INT,
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- sprint_result
-- ============================================================

IF OBJECT_ID('silver.sprint_result', 'U') IS NOT NULL
    DROP TABLE silver.sprint_result;
GO

CREATE TABLE silver.sprint_result (
    sprint_result_id INT,
    race_id INT,
    driver_id INT,
    constructor_id INT,
    number INT,
    grid INT,
    position INT,
    position_text NVARCHAR(10),
    position_order INT,
    points INT,
    laps INT,
    time NVARCHAR(25),
    milliseconds INT,
    fastest_lap INT,
    fastest_lap_time NVARCHAR(25),
    status_id INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- status
-- ============================================================

IF OBJECT_ID('silver.status', 'U') IS NOT NULL
    DROP TABLE silver.status;
GO

CREATE TABLE silver.status (
    status_id INT,
    status NVARCHAR(50),
    failure_category NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
