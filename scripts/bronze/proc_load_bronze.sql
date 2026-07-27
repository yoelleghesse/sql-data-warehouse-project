/*
=======================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=======================================================

Script purpose:
	This stored procedure loads data into the bronze schema from external csv files.
	It performs the following actions:
		- truncates the bronze tables before loading data
		- uses the 'bulk insert' command to load data from the csv files into the bronze tables

Parameters:
	None; this stored procedure does not accept any parameters or return any values.

Usage:
	exec bronze.load_bronze;

========================================================
*/

create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print'=========================';
		print 'Loading the bronze layer';
		print'=========================';

		print'-------------------------';
		print'Loading CRM tables';
		print'-------------------------';

		set @start_time = getdate();
		print'>> Truncating table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info

		print'>> Inserting data into table: bronze.crm_cust_info';
		bulk insert Bronze.crm_cust_info
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'

		set @start_time = getdate();
		print'>> Truncating table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info

		print'>> Inserting data into table: bronze.crm_prd_info';
		bulk insert Bronze.crm_prd_info
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'

		set @start_time = getdate();
		print'>> Truncating table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details

		print'>> Inserting data into table: bronze.crm_sales_details';
		bulk insert Bronze.crm_sales_details
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'

		print'-------------------------';
		print'Loading ERP tables';
		print'-------------------------';

		set @start_time = getdate();
		print'>> Truncating table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12

		print'>> Inserting data into table: bronze.erp_cust_az12';
		bulk insert Bronze.erp_cust_az12
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'

		set @start_time = getdate();
		print'>> Truncating table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101

		print'>> Inserting data into table: bronze.erp_loc_a101';
		bulk insert Bronze.erp_loc_a101
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'

		set @start_time = getdate();
		print'>> Truncating table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2

		print'>> Inserting data into table: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\yoell\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print'---------------'
		set @batch_end_time = getdate();
		print'>> Total Batch Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds';
	end try
	begin catch
		print'============================================='
		print'Error occured during loading of bronze layer'
		print'Error message:' + error_message();
		print'Error message:' + cast(error_number() as nvarchar);
		print'Error message:' + cast(error_state() as nvarchar);
		print'=============================================='
	end catch
end
