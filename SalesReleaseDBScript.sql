GO
USE [master]
RESTORE DATABASE EFGSales FROM DISK=N'H:\\Full\\EFGSales.bak' WITH RECOVERY,
      MOVE 'EFGSales' TO 'E:\SQLData\EFGSales.mdf', 
      MOVE 'EFGSales_Log' TO 'F:\SQLLog\EFGSales_Log.ldf'
GO
IF NOT EXISTS(
		SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin 
		FROM  sys.server_principals p 
		LEFT JOIN sys.syslogins l ON l.name = p.name
		WHERE p.type IN ( 'S', 'G', 'U' ) And p.name = 'SSRS_USER')
Begin      
	declare @username varchar(255)= 'SSRS_USER', @password varchar(255)='EFG2013*'
	exec sp_addlogin @username, @password
End
Go
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
CREATE USER [SSIS] FOR LOGIN [SSIS] WITH DEFAULT_SCHEMA=[dbo]
Go
EXEC sp_addrolemember N'db_owner', N'SSRS_USER'
GO
EXEC sp_addrolemember N'db_owner', N'SSIS'
GO
USE [msdb]
GO
/****** Object:  Job [Sales Tier 1 ETL For Recently Closed Period]    Script Date: 12/30/2013 17:07:44 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL For Recently Closed Period')
Begin
Declare @JobID varchar(255)
Select @JobID=job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL For Recently Closed Period'
EXEC msdb.dbo.sp_delete_job @job_id=@JobID, @delete_unused_schedule=1
End

GO
USE [msdb]
GO

/****** Object:  Job [Sales Tier 1 ETL For Recently Closed Period]    Script Date: 12/30/2013 17:07:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Sales ETL]]]    Script Date: 12/30/2013 17:07:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Sales ETL]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Sales ETL]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Sales Tier 1 ETL For Recently Closed Period', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Runs Sales Tier 1 ETL to get disbursements for recently closed period.', 
		@category_name=N'[Sales ETL]', 
		@owner_login_name=N'SSIS', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Call ETL SP to run for recently closed period.]    Script Date: 12/30/2013 17:07:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Call ETL SP to run for recently closed period.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC GetTier1Sales @Period=''Monthly''', 
		@database_name=N'EFGSales', 
		@database_user_name=N'SSIS', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


USE [msdb]
GO

/****** Object:  Job [Sales Tier 1 ETL Open Period]    Script Date: 12/30/2013 17:05:09 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL Open Period')
Begin
Declare @JobID varchar(255)
Select @JobID=job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Sales Tier 1 ETL Open Period'
 EXEC msdb.dbo.sp_delete_job @job_id=@jobid, @delete_unused_schedule=1
End
GO

USE [msdb]
GO

/****** Object:  Job [Sales Tier 1 ETL Open Period]    Script Date: 12/30/2013 17:05:09 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Sales ETL]]]    Script Date: 12/30/2013 17:05:10 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Sales ETL]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Sales ETL]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Sales Tier 1 ETL Open Period', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Runs the ETL For Sales Tier 1 to get the open period disbursements.', 
		@category_name=N'[Sales ETL]', 
		@owner_login_name=N'SSIS', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Call ETL SP for Open Period]    Script Date: 12/30/2013 17:05:10 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Call ETL SP for Open Period', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC GetTier1Sales @Period=''Daily''', 
		@database_name=N'EFGSales', 
		@database_user_name=N'SSIS', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily at 4:00AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20131230, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959, 
		@schedule_uid=N'c471431b-6e9c-4418-a800-e56a599476fd'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


