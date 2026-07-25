/*
==========================
Creating database and schemas
==========================

This script creates a new database called 'DataWarehouse' after checking if it exists. If it does, it is dropped and recreated. Additionally, the script sets up three schemas
in the database: 'bronze', 'silver', and 'gold'.

Important: Running this script will drop the entire 'DataWarehouse' database if it exist. All data in the database will be permanently deleted. Ensure you have proper backups
before running this script.
*/


use master;
GO
-- drop and recreate datawarehouse database
if exists (select 1 from sys.databases where name = 'DataWarehouse')
begin
	alter database DataWarehouse set single_user with rollback immediate;
	drop database DataWarehouse;
end;
Go

-- create the datawarehouse database
create database DataWarehouse;
Go

Use DataWarehouse;
Go

-- create schemas
create schema Bronze;
Go

create schema Silver;
Go

create schema Gold;
Go
