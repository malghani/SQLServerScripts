GO
USE [master]
go
xp_cmdshell 'dir "\\sv-sql06\SQL backups"'
go
xp_cmdshell 'ren "\\sv-sql06\SQL backups\EFGSalesV2.bak" "EFGSalesV3.bak"'
go
xp_Cmdshell ' Copy "\\sv-sql06\SQL backups\EFGSalesV3.bak"  H:Full\EFGSalesV3.bak'
go
RESTORE DATABASE EFGSales FROM DISK=N'H:\Full\EFGSalesV3.bak' WITH RECOVERY,
      MOVE 'EFGSales' TO 'E:\SQLData\EFGSales.mdf', 
      MOVE 'EFGSales_Log' TO 'F:\SQLLog\EFGSales_Log.ldf'
GO
USE [EFGSales]
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SSRS_USER')
DROP USER [SSRS_USER]
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SSIS_USER')
DROP USER [SSIS_USER]
GO
CREATE USER [SSRS_USER] FOR LOGIN [SSRS_USER] 
GO
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'SSIS')
DROP USER [SSIS]
GO
CREATE USER [SSIS] FOR LOGIN [SSIS] 
Go
EXEC sp_addrolemember N'db_owner', N'SSRS_USER'
GO
EXEC sp_addrolemember N'db_owner', N'SSIS'
GO
