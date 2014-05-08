use StagingSales
go
DBCC Shrinkfile(1,2);
DBCC Shrinkfile(2,2);
DBCC Shrinkfile(3,2);
DBCC Shrinkfile(4,2);
DBCC Shrinkfile(5,2);
DBCC Shrinkfile(6,2);
DBCC Shrinkfile(7,2);
DBCC Shrinkfile(8,2);
DBCC Shrinkfile(9,2);
DBCC Shrinkfile(10,2);

DBCC Shrinkfile(11,2);
DBCC Shrinkfile(12,2);
Go
use EFGSales
go
DBCC Shrinkfile(1,2);
DBCC Shrinkfile(2,2);
DBCC Shrinkfile(11,2);
DBCC Shrinkfile(12,2);
DBCC Shrinkfile(13,2);
DBCC Shrinkfile(14,2);
DBCC Shrinkfile(15,2);
DBCC Shrinkfile(16,2);
DBCC Shrinkfile(17,2);
DBCC Shrinkfile(18,2);
DBCC Shrinkfile(19,2);
DBCC Shrinkfile(20,2);


DBCC Shrinkfile(20,EMPTYFILE);


--------- STILL RUNNING?
EXEC _ETL_T2T3_ProcessAggregateFactSales 20130131, 20140331
EXEC _ETL_T2T3_ProcessReportsParameters

