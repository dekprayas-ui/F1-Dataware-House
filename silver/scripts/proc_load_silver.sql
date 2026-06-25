/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to
    populate the 'silver' schema tables from the 'bronze' schema.
    Actions Performed:
        - Truncates Silver tables.
        - Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME;
    DECLARE @end_time DATETIME;
    DECLARE @batch_start_time DATETIME;
    DECLARE @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

        -- Loading silver.circuits
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.circuits';
        TRUNCATE TABLE silver.circuits;
        PRINT '>> Inserting Data Into: silver.circuits';
        INSERT INTO silver.circuits (
            circuit_id,
            circuit_ref,
            name,
            location,
            country,
            lat,
            lng,
            alt,
            url
        )
        SELECT
            circuitId,
            circuitRef,
            name,
            location,
            country,
            lat,
            lng,
            alt,
            url
        FROM bronze.circuits;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.constructor_results
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.constructor_results';
        TRUNCATE TABLE silver.constructor_results;
        PRINT '>> Inserting Data Into: silver.constructor_results';
        INSERT INTO silver.constructor_results (
            constructor_results_id,
            race_id,
            constructor_id,
            points,
            status
        )
        SELECT
            constructorResultsId,
            raceId,
            constructorId,
            points,
            CASE
                WHEN status = '\N' THEN '0'
                ELSE status
            END AS status -- Replace null sentinel with default value
        FROM bronze.constructor_results;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.constructor_standings
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.constructor_standings';
        TRUNCATE TABLE silver.constructor_standings;
        PRINT '>> Inserting Data Into: silver.constructor_standings';
        INSERT INTO silver.constructor_standings (
            constructor_standing_id,
            race_id,
            constructor_id,
            points,
            position,
            position_text,
            wins
        )
        SELECT
            constructorStandingsId,
            raceId,
            constructorId,
            points,
            position,
            positionText,
            wins
        FROM bronze.constructor_standings;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.constructors
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.constructors';
        TRUNCATE TABLE silver.constructors;
        PRINT '>> Inserting Data Into: silver.constructors';
        INSERT INTO silver.constructors (
            constructor_id,
            constructor_ref,
            name,
            nationality,
            url
        )
        SELECT
            constructorId,
            constructorRef,
            name,
            nationality,
            url
        FROM bronze.constructors;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.driver_standings
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.driver_standings';
        TRUNCATE TABLE silver.driver_standings;
        PRINT '>> Inserting Data Into: silver.driver_standings';
        INSERT INTO silver.driver_standings (
            driver_standings_id,
            race_id,
            driver_id,
            points,
            position,
            position_text,
            wins
        )
        SELECT
            driverStandingsId,
            raceId,
            driverId,
            points,
            position,
            positionText,
            wins
        FROM bronze.driver_standings;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.drivers
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.drivers';
        TRUNCATE TABLE silver.drivers;
        PRINT '>> Inserting Data Into: silver.drivers';
        INSERT INTO silver.drivers (
            driver_id,
            driver_ref,
            number,
            code,
            forename,
            surname,
            dob,
            nationality,
            url
        )
        SELECT
            driverId,
            driverRef,
            CAST(
                CASE
                    WHEN number = '\N' THEN '0'
                    ELSE number
                END
            AS INT) AS number, -- Replace null sentinel then cast to INT
            CASE
                WHEN code = '\N' THEN '0'
                ELSE code
            END AS code, -- Replace null sentinel with default value
            TRIM(forename) AS forename,
            TRIM(surname) AS surname,
            CAST(dob AS DATE) AS dob,
            TRIM(nationality) AS nationality,
            url
        FROM bronze.drivers;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.lap_times
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.lap_times';
        TRUNCATE TABLE silver.lap_times;
        PRINT '>> Inserting Data Into: silver.lap_times';
        INSERT INTO silver.lap_times (
            race_id,
            driver_id,
            lap,
            position,
            time,
            milliseconds
        )
        SELECT
            raceId,
            driverId,
            lap,
            position,
            TRY_CAST('00:' + time AS TIME(3)) AS time, -- Prepend hours to make valid TIME format
            milliseconds
        FROM bronze.lap_times;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.pit_stops
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.pit_stops';
        TRUNCATE TABLE silver.pit_stops;
        PRINT '>> Inserting Data Into: silver.pit_stops';
        INSERT INTO silver.pit_stops (
            race_id,
            driver_id,
            stop,
            lap,
            time,
            duration,
            milliseconds
        )
        SELECT
            raceId,
            driverId,
            stop,
            lap,
            CASE
                WHEN time = '\N' THEN NULL
                ELSE CAST(time AS TIME)
            END AS time, -- Handle null sentinel before casting to TIME
            CASE
                WHEN duration = '\N' THEN NULL
                ELSE duration
            END AS duration, -- Handle null sentinel for duration
            milliseconds
        FROM bronze.pit_stops;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.qualifying
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.qualifying';
        TRUNCATE TABLE silver.qualifying;
        PRINT '>> Inserting Data Into: silver.qualifying';
        INSERT INTO silver.qualifying (
            qualify_id,
            race_id,
            driver_id,
            constructor_id,
            number,
            position,
            q1,
            q2,
            q3
        )
        SELECT
            qualifyId,
            raceId,
            driverId,
            constructorId,
            number,
            position,
            TRY_CAST(q1 AS TIME(3)) AS q1, -- Null sentinel and invalid formats safely become NULL
            TRY_CAST(q2 AS TIME(3)) AS q2,
            TRY_CAST(q3 AS TIME(3)) AS q3
        FROM bronze.qualifying;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.races
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.races';
        TRUNCATE TABLE silver.races;
        PRINT '>> Inserting Data Into: silver.races';
        INSERT INTO silver.races (
            race_id,
            year,
            round,
            circuit_id,
            name,
            date,
            time,
            url,
            fp1_date,
            fp1_time,
            fp2_date,
            fp2_time,
            fp3_date,
            fp3_time,
            quali_date,
            quali_time,
            sprint_date,
            sprint_time
        )
        SELECT
            raceId,
            year,
            round,
            circuitId,
            name,
            TRY_CAST(date AS DATE) AS date,
            TRY_CAST(time AS TIME(3)) AS time,
            url,
            TRY_CAST(fp1_date AS DATE) AS fp1_date,
            TRY_CAST(fp1_time AS TIME(3)) AS fp1_time,
            TRY_CAST(fp2_date AS DATE) AS fp2_date,
            TRY_CAST(fp2_time AS TIME(3)) AS fp2_time,
            TRY_CAST(fp3_date AS DATE) AS fp3_date,
            TRY_CAST(fp3_time AS TIME(3)) AS fp3_time,
            TRY_CAST(quali_date AS DATE) AS quali_date,
            TRY_CAST(quali_time AS TIME(3)) AS quali_time,
            TRY_CAST(sprint_date AS DATE) AS sprint_date,
            TRY_CAST(sprint_time AS TIME(3)) AS sprint_time
        FROM bronze.races;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.results
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.results';
        TRUNCATE TABLE silver.results;
        PRINT '>> Inserting Data Into: silver.results';
        INSERT INTO silver.results (
            result_id,
            race_id,
            driver_id,
            constructor_id,
            number,
            grid,
            position,
            position_text,
            position_order,
            points,
            laps,
            time,
            milliseconds,
            fastest_lap,
            rank,
            fastest_lap_time,
            fastest_lap_speed,
            status_id
        )
        SELECT
            resultId,
            raceId,
            driverId,
            constructorId,
            CASE
                WHEN number = '\N' THEN NULL
                ELSE CAST(number AS INT)
            END AS number,
            grid,
            CASE
                WHEN position = '\N' THEN NULL
                ELSE CAST(position AS INT)
            END AS position,
            positionText,
            positionOrder,
            points,
            laps,
            CASE
                WHEN time = '\N' THEN NULL
                ELSE time
            END AS time,
            CASE
                WHEN milliseconds = '\N' THEN NULL
                ELSE CAST(milliseconds AS INT)
            END AS milliseconds,
            CASE
                WHEN fastestLap = '\N' THEN NULL
                ELSE CAST(fastestLap AS INT)
            END AS fastest_lap,
            CASE
                WHEN rank = '\N' THEN NULL
                ELSE CAST(rank AS INT)
            END AS rank,
            CASE
                WHEN fastestLapTime = '\N' THEN NULL
                ELSE fastestLapTime
            END AS fastest_lap_time,
            CASE
                WHEN fastestLapSpeed = '\N' THEN NULL
                ELSE CAST(fastestLapSpeed AS FLOAT)
            END AS fastest_lap_speed,
            statusId
        FROM bronze.results;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.seasons
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.seasons';
        TRUNCATE TABLE silver.seasons;
        PRINT '>> Inserting Data Into: silver.seasons';
        INSERT INTO silver.seasons (
            year,
            url
        )
        SELECT
            year,
            url
        FROM bronze.seasons;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.sprint_result
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.sprint_result';
        TRUNCATE TABLE silver.sprint_result;
        PRINT '>> Inserting Data Into: silver.sprint_result';
        INSERT INTO silver.sprint_result (
            sprint_result_id,
            race_id,
            driver_id,
            constructor_id,
            number,
            grid,
            position,
            position_text,
            position_order,
            points,
            laps,
            time,
            milliseconds,
            fastest_lap,
            fastest_lap_time,
            status_id
        )
        SELECT
            resultId,
            raceId,
            driverId,
            constructorId,
            number,
            grid,
            CASE
                WHEN position = '\N' THEN NULL
                ELSE CAST(position AS INT)
            END AS position, -- Handle retirement cases where position is null sentinel
            CASE
                WHEN positionText = '\N' THEN NULL
                ELSE positionText
            END AS position_text,
            positionOrder,
            points,
            laps,
            CASE
                WHEN time = '\N' THEN NULL
                ELSE time
            END AS time,
            CASE
                WHEN milliseconds = '\N' THEN NULL
                ELSE CAST(milliseconds AS INT)
            END AS milliseconds,
            CASE
                WHEN fastestLap = '\N' THEN NULL
                ELSE CAST(fastestLap AS INT)
            END AS fastest_lap,
            CASE
                WHEN fastestLapTime = '\N' THEN NULL
                ELSE fastestLapTime
            END AS fastest_lap_time,
            statusId
        FROM bronze.sprint_results;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.status
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.status';
        TRUNCATE TABLE silver.status;
        PRINT '>> Inserting Data Into: silver.status';
        INSERT INTO silver.status (
            status_id,
            status,
            failure_category
        )
        SELECT
            statusId,
            status,
            CASE
                WHEN status IN ('Finished') OR status LIKE '+% Lap%'
                    THEN 'Finished'
                WHEN status IN (
                    'Accident', 'Collision', 'Spun off', 'Stalled',
                    '107% Rule', 'Did not qualify', 'Did not prequalify'
                )
                    THEN 'Driver Error'
                WHEN status IN ('Disqualified', 'Excluded', 'Underweight')
                    THEN 'Violations/Disqualifications'
                WHEN status IN (
                    'Illness', 'Driver unwell', 'Injured',
                    'Injury', 'Fatal accident'
                )
                    THEN 'Human/Medical Factors'
                ELSE 'Technical/Mechanical'
            END AS failure_category -- Categorize all statuses into 5 buckets
        FROM bronze.status;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        SET @batch_end_time = GETDATE();
        PRINT '==========================================';
        PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==========================================';

    END TRY
    BEGIN CATCH
        PRINT '==========================================';
        PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State:   ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH
END
