USE [master]
-- Close connections to DB
Declare @SP int
	Declare @BatchCommand varchar(255)
	DECLARE cur_SP INSENSITIVE SCROLL CURSOR FOR 
	select spid from master..sysprocesses sp
	Inner join master..sysdatabases sd on sd.dbid=sp.dbid and sd.name='EFGSales'
	union
	select spid from master..sysprocesses sp Where loginame='SSRS_USER'
	OPEN  cur_SP
	FETCH FIRST FROM cur_SP INTO @SP
	WHILE (@@fetch_status = 0)
	   BEGIN
		SELECT @BatchCommand = 'KILL ' +  Convert(varchar, @SP)
	--	SELECT @BatchCommand
		EXEC (@BatchCommand)
	      FETCH NEXT FROM cur_SP INTO @SP
	   END
	CLOSE cur_SP
	DEALLOCATE cur_SP
GO
IF EXISTS(Select * from master..sysdatabases sd WHERE sd.name='EFGSales')
	DROP DATABASE EFGSales 
GO
IF EXISTS(
		SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin 
		FROM  sys.server_principals p 
		LEFT JOIN sys.syslogins l ON l.name = p.name
		WHERE p.type IN ( 'S', 'G', 'U' ) And p.name = 'SSRS_USER')
Begin      
	declare @username varchar(255)= 'SSRS_USER'
	exec sp_droplogin @username
End
Go
USE [msdb]
GO
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL For Recently Closed Period')
Begin
Declare @JobID varchar(255)
Select @JobID=job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL For Recently Closed Period'
EXEC msdb.dbo.sp_delete_job @job_id=@JobID, @delete_unused_schedule=1
End
GO
USE [msdb]
GO
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL Open Period')
Begin
 Declare @JobID varchar(255)
Select @JobID=job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL Open Period'
 EXEC msdb.dbo.sp_delete_job @job_id=@jobid, @delete_unused_schedule=1
End
GO
