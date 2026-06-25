/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables.
    Source data: F1 CSV files loaded via BULK INSERT.
    Note: Columns that arrive as '\N' (null sentinel) or mixed formats are kept
          as NVARCHAR in bronze. Clean numeric/integer columns use proper types.
===============================================================================
*/

-- ============================================================
-- circuits
-- ============================================================

IF OBJECT_ID('bronze.circuits', 'U') IS NOT NULL
    DROP TABLE bronze.circuits;
GO

CREATE TABLE bronze.circuits (
    circuitId INT,
    circuitRef NVARCHAR(25),
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

IF OBJECT_ID('bronze.constructor_results', 'U') IS NOT NULL
    DROP TABLE bronze.constructor_results;
GO

CREATE TABLE bronze.constructor_results (
    constructorResultsId INT,
    raceId INT,
    constructorId INT,
    points INT,
    status NVARCHAR(10),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- constructor_standings
-- ============================================================

IF OBJECT_ID('bronze.constructor_standings', 'U') IS NOT NULL
    DROP TABLE bronze.constructor_standings;
GO

CREATE TABLE bronze.constructor_standings (
    constructorStandingsId INT,
    raceId INT,
    constructorId INT,
    points INT,
    position INT,
    positionText NVARCHAR(10),
    wins INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- constructors
-- ============================================================

IF OBJECT_ID('bronze.constructors', 'U') IS NOT NULL
    DROP TABLE bronze.constructors;
GO

CREATE TABLE bronze.constructors (
    constructorId INT,
    constructorRef NVARCHAR(20),
    name NVARCHAR(50),
    nationality NVARCHAR(50),
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- driver_standings
-- ============================================================

IF OBJECT_ID('bronze.driver_standings', 'U') IS NOT NULL
    DROP TABLE bronze.driver_standings;
GO

CREATE TABLE bronze.driver_standings (
    driverStandingsId INT,
    raceId INT,
    driverId INT,
    points INT,
    position INT,
    positionText NVARCHAR(10),
    wins INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- drivers
-- ============================================================

IF OBJECT_ID('bronze.drivers', 'U') IS NOT NULL
    DROP TABLE bronze.drivers;
GO

CREATE TABLE bronze.drivers (
    driverId INT,
    driverRef NVARCHAR(50),
    number NVARCHAR(10),
    code NVARCHAR(10),
    forename NVARCHAR(50),
    surname NVARCHAR(50),
    dob NVARCHAR(20),
    nationality NVARCHAR(50),
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- lap_times
-- ============================================================

IF OBJECT_ID('bronze.lap_times', 'U') IS NOT NULL
    DROP TABLE bronze.lap_times;
GO

CREATE TABLE bronze.lap_times (
    raceId INT,
    driverId INT,
    lap INT,
    position INT,
    time NVARCHAR(20),
    milliseconds INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- pit_stops
-- ============================================================

IF OBJECT_ID('bronze.pit_stops', 'U') IS NOT NULL
    DROP TABLE bronze.pit_stops;
GO

CREATE TABLE bronze.pit_stops (
    raceId INT,
    driverId INT,
    stop INT,
    lap INT,
    time NVARCHAR(20),
    duration NVARCHAR(20),
    milliseconds INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- qualifying
-- ============================================================

IF OBJECT_ID('bronze.qualifying', 'U') IS NOT NULL
    DROP TABLE bronze.qualifying;
GO

CREATE TABLE bronze.qualifying (
    qualifyId INT,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    position INT,
    q1 NVARCHAR(20),
    q2 NVARCHAR(20),
    q3 NVARCHAR(20),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- races
-- ============================================================

IF OBJECT_ID('bronze.races', 'U') IS NOT NULL
    DROP TABLE bronze.races;
GO

CREATE TABLE bronze.races (
    raceId INT,
    year INT,
    round INT,
    circuitId INT,
    name NVARCHAR(100),
    date NVARCHAR(20),
    time NVARCHAR(20),
    url NVARCHAR(MAX),
    fp1_date NVARCHAR(20),
    fp1_time NVARCHAR(20),
    fp2_date NVARCHAR(20),
    fp2_time NVARCHAR(20),
    fp3_date NVARCHAR(20),
    fp3_time NVARCHAR(20),
    quali_date NVARCHAR(20),
    quali_time NVARCHAR(20),
    sprint_date NVARCHAR(20),
    sprint_time NVARCHAR(20),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- results
-- ============================================================

IF OBJECT_ID('bronze.results', 'U') IS NOT NULL
    DROP TABLE bronze.results;
GO

CREATE TABLE bronze.results (
    resultId INT,
    raceId INT,
    driverId INT,
    constructorId INT,
    number NVARCHAR(10),
    grid INT,
    position NVARCHAR(10),
    positionText NVARCHAR(10),
    positionOrder INT,
    points FLOAT,
    laps INT,
    time NVARCHAR(25),
    milliseconds NVARCHAR(15),
    fastestLap NVARCHAR(10),
    rank NVARCHAR(10),
    fastestLapTime NVARCHAR(20),
    fastestLapSpeed NVARCHAR(20),
    statusId INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- seasons
-- ============================================================

IF OBJECT_ID('bronze.seasons', 'U') IS NOT NULL
    DROP TABLE bronze.seasons;
GO

CREATE TABLE bronze.seasons (
    year INT,
    url NVARCHAR(MAX),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- sprint_results
-- ============================================================

IF OBJECT_ID('bronze.sprint_results', 'U') IS NOT NULL
    DROP TABLE bronze.sprint_results;
GO

CREATE TABLE bronze.sprint_results (
    resultId INT,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    grid INT,
    position NVARCHAR(10),
    positionText NVARCHAR(10),
    positionOrder INT,
    points INT,
    laps INT,
    time NVARCHAR(25),
    milliseconds NVARCHAR(15),
    fastestLap NVARCHAR(10),
    fastestLapTime NVARCHAR(25),
    statusId INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- ============================================================
-- status
-- ============================================================

IF OBJECT_ID('bronze.status', 'U') IS NOT NULL
    DROP TABLE bronze.status;
GO

CREATE TABLE bronze.status (
    statusId INT,
    status NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
