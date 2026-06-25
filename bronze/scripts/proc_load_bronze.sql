/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to
    populate the 'bronze' schema tables from the raw F1 CSV source files.
    Actions Performed:
        - Truncates Bronze tables.
        - Loads raw CSV data into Bronze tables using BULK INSERT.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Note:
    Update the file paths below to match your local source folder.
    Current path base: C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME;
    DECLARE @end_time DATETIME;
    DECLARE @batch_start_time DATETIME;
    DECLARE @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        -- Loading bronze.circuits
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.circuits';
        TRUNCATE TABLE bronze.circuits;
        PRINT '>> Inserting Data Into: bronze.circuits';
        BULK INSERT bronze.circuits
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\circuits.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.constructor_results
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.constructor_results';
        TRUNCATE TABLE bronze.constructor_results;
        PRINT '>> Inserting Data Into: bronze.constructor_results';
        BULK INSERT bronze.constructor_results
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\constructor_results.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.constructor_standings
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.constructor_standings';
        TRUNCATE TABLE bronze.constructor_standings;
        PRINT '>> Inserting Data Into: bronze.constructor_standings';
        BULK INSERT bronze.constructor_standings
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\constructor_standings.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.constructors
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.constructors';
        TRUNCATE TABLE bronze.constructors;
        PRINT '>> Inserting Data Into: bronze.constructors';
        BULK INSERT bronze.constructors
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\constructors.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.driver_standings
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.driver_standings';
        TRUNCATE TABLE bronze.driver_standings;
        PRINT '>> Inserting Data Into: bronze.driver_standings';
        BULK INSERT bronze.driver_standings
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\driver_standings.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.drivers
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.drivers';
        TRUNCATE TABLE bronze.drivers;
        PRINT '>> Inserting Data Into: bronze.drivers';
        BULK INSERT bronze.drivers
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\drivers.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.lap_times
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.lap_times';
        TRUNCATE TABLE bronze.lap_times;
        PRINT '>> Inserting Data Into: bronze.lap_times';
        BULK INSERT bronze.lap_times
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\lap_times.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.pit_stops
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.pit_stops';
        TRUNCATE TABLE bronze.pit_stops;
        PRINT '>> Inserting Data Into: bronze.pit_stops';
        BULK INSERT bronze.pit_stops
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\pit_stops.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.qualifying
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.qualifying';
        TRUNCATE TABLE bronze.qualifying;
        PRINT '>> Inserting Data Into: bronze.qualifying';
        BULK INSERT bronze.qualifying
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\qualifying.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.races
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.races';
        TRUNCATE TABLE bronze.races;
        PRINT '>> Inserting Data Into: bronze.races';
        BULK INSERT bronze.races
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\races.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.results
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.results';
        TRUNCATE TABLE bronze.results;
        PRINT '>> Inserting Data Into: bronze.results';
        BULK INSERT bronze.results
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\results.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.seasons
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.seasons';
        TRUNCATE TABLE bronze.seasons;
        PRINT '>> Inserting Data Into: bronze.seasons';
        BULK INSERT bronze.seasons
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\seasons.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.sprint_results
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.sprint_results';
        TRUNCATE TABLE bronze.sprint_results;
        PRINT '>> Inserting Data Into: bronze.sprint_results';
        BULK INSERT bronze.sprint_results
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\sprint_results.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading bronze.status
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.status';
        TRUNCATE TABLE bronze.status;
        PRINT '>> Inserting Data Into: bronze.status';
        BULK INSERT bronze.status
        FROM 'C:\Users\princ\OneDrive\Desktop\Coding\PYTHON\data_cleaning\F1\status.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        SET @batch_end_time = GETDATE();
        PRINT '==========================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==========================================';

    END TRY
    BEGIN CATCH
        PRINT '==========================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State:   ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH
END
