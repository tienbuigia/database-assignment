-- Connection 3

USE TestDB;
GO


-- step 7:
SELECT
	resource_type
	,request_mode
	,request_status
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID('TestDB')
	AND request_mode IN ('S', 'X')
	AND resource_type <> 'DATABASE';

-- step 8:
SELECT * FROM sys.dm_tran_version_store
WHERE database_id = DB_ID('TestDB');