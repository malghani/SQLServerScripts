USE [msdb]
GO

/****** Object:  Job [CDW_SV-SQL05_SV-SQL05_0]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CDW_SV-SQL05_SV-SQL05_0', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'EFG-DOMAIN\aoak', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [CDW_SV-SQL05_SV-SQL05_0_Step]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'CDW_SV-SQL05_SV-SQL05_0_Step', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SERVER sv-sql05.efg.corp /SQL "SV-SQL05\DTS Packages\Copy Database Wizard Packages\CDW_SV-SQL05_SV-SQL05_0" /MAXCONCURRENT 1 /CHECKPOINTING OFF', 
		@flags=6
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

/****** Object:  Job [Checking Memory Dumps Daily]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Checking Memory Dumps Daily', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'EFG-DOMAIN\r.kumar', 
		@notify_email_operator_name=N'Rajesh Kumar', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Checking Memory Dumps and Notifying]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Checking Memory Dumps and Notifying', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'if object_id(''tempdb..#tmpLog'') is not null
		begin
		drop table #tmpLog
		end
		CREATE TABLE #tmpLog
			(	LogDate datetime,   ProcessInfo NVARCHAR(10) ,Text NVARCHAR(4000) )

		INSERT INTO #tmpLog 
		EXEC sp_readerrorlog 0,1,''Stack''
		
	
		DECLARE @Count int
		select @Count=Count(*) from #tmpLog
		
		IF @Count > 0
		BEGIN
			DECLARE @tableHTML  NVARCHAR(MAX) 
			declare @reportdate varchar(12)
			declare @subject as varchar(250)
			declare @server as varchar(250)
			Select @reportdate=convert(varchar(12),getdate())
			select @server=@@servername
			SET @subject= @reportdate+''- ''+ @server +'' SQL Dump''

			SET @tableHTML =
				N''<H1>''+@server+'' SQL Dump ''+@reportdate+'' </H1>'' +
				N''<table border="1">'' +
				N''<tr><th>LogDate</th><th>ProcessInfo</th>'' +
				N''<th>Text</th></tr>'' +
				CAST ( ( SELECT td = [LogDate], '''',
								td = [ProcessInfo], '''',
								td = [Text] FROm #tmpLog
						  FOR XML PATH(''tr''), TYPE 
				) AS NVARCHAR(MAX) ) +
				N''</table>'' ;
			
			EXEC msdb.dbo.sp_send_dbmail @recipients=''rajeshk@plasmacomp.com'',
			@subject = @subject,
			@body = @tableHTML,
			@body_format = ''HTML'',
			@importance=''High'' ;
			
		END', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Runs_daily_8pm', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130702, 
		@active_end_date=99991231, 
		@active_start_time=200000, 
		@active_end_time=235959, 
		@schedule_uid=N'3b996a03-17cd-4021-8fbd-d34e27928bb5'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Database Consistency Checker Weekly]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Database Consistency Checker Weekly', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Rajesh Kumar', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBCC CheckDB]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBCC CheckDB', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/****Database Consistency Checker ********************************************
	Author			: Rajesh Kumar
	Create Date		: 2013-07-09
	Last Modified		: 2013-07-09
	
	Checks consistency of the database, uses [proc_CheckDBIntegrity] ''dbname'', @parameters e.g. = tableResults, Physical_only''
	
****************************************************************************/


use Toolbox

Declare @stime datetime,@etime datetime, @duration int
Declare @sub varchar(100)
,@body varchar(max)

exec [dbo].[proc_CheckDBIntegrity] @parameters = ''TableResults''


Set @sub= ''DBCC CheckDB completed on server ''+@@servername

Set @body = ''Hi, <BR>Please find the Weekly Database Consistency Check Report for ''+@@SERVERNAME+'' <BR><BR><table border=1 align="center"> <TR>
						<TH>DatabaseName</TH><TH>MessageText</TH><TH>TimeStamp</TH><TH>Duration_Seconds</TH>''+
						Cast( (select td=isnull(DBNAME,''-''),'''',
						td = isnull(MessageText,''-''),'''',
						td=isnull(TimeStamp,''-'') ,'''',
						td=isnull(Duration_sec,''-''),'''' from ToolBox.dbo.DBCC_history where TimeStamp >=CONVERT( varchar(100), getdate(),110)
						and messagetext like ''%checkdb%''
						For XML Path (''tr''),type
						) as nvarchar(max))+ N''</table><br><br>Thanks,<br> Database Support Group''


exec msdb.dbo.sp_send_dbmail
@recipients  = ''rkumar@efgusa.com;JSquires@efgusa.com'',
@subject = @sub,
@body_format = ''HTML'',
@body= @body
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly_Sun_10PM', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130709, 
		@active_end_date=99991231, 
		@active_start_time=220000, 
		@active_end_time=235959, 
		@schedule_uid=N'd502bc53-9319-4582-818f-08e3c0fabd34'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Index Anlysis Report Daily]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Index Anlysis Report Daily', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Rajesh Kumar', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Index Analysis Daily]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Index Analysis Daily', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
/****Index Analysis Report scan both indexes and heap table for fragmentation ****************
	Author			: Rajesh Kumar
	Create Date		: 2013-07-05
	Last Modified	: 2013-09-17
	
	Index Analysis job must run before this, that stores it shistory in table "Toolbox.dbo.index_analysis_report"
	Rebuild if pagecount >1000 and fragmentation >40 --offline if non EnterPrise Version of SQL
	Re-organize if pagecount>1000 and fragmentation between 30-40
	
****************************************************************************/

Declare @sql as varchar(max),
@dbname sysname,@dbid varchar(100)

Declare cr Cursor for
Select quotename(name) as name,database_id from sys.databases where name not in (''master'',''model'',''tempdb'',''msdb'',''ReportServertempDB'',''ReportServer'') and state_desc=''online''

Open  cr  
fetch next  from cr into @dbname,@dbid
While @@fetch_status =0
begin
set @sql = ''use ''+@dbname+'' delete from Toolbox.dbo.Index_analysis_report where rundate <=convert(varchar(100),DATEADD(DD,-7,GETDATE()),110)
 insert into Toolbox.dbo.Index_analysis_report 
select DB_NAME(database_id) as dbname,OBJECT_NAME(object_id) as tableName,ph.object_id,
index_id,
(select name  from sys.indexes ix where ix.index_id= ph.index_id and ix.object_id = ph.object_id) as indexName,
(select Type_desc  from sys.indexes ix where ix.index_id= ph.index_id and ix.object_id = ph.object_id) as IndexType,

avg_fragmentation_in_percent,
avg_page_space_used_in_percent,page_count,
Getdate() as RunDate,NULL

 from sys.dm_db_index_physical_stats(''+@dbID+'',null,null,null,null) ph'' 
 exec(@sql)
 --print @sql
 fetch next from cr into @dbname,@dbid
 
end
close cr
deallocate cr
--run time 2 min 10 scnds

-------------------------------------------------------------

update Toolbox.dbo.Index_analysis_report
set Action = (case when (page_count >=1000 and avg_fragmentation_in_percent>40) then ''Rebuild''
					when page_count>=1000 and avg_fragmentation_in_percent between 20 and 40 then ''ReOrganize''
					else ''No Action Required''
				end )
						', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Runs_daily_8pm', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130702, 
		@active_end_date=99991231, 
		@active_start_time=200000, 
		@active_end_time=235959, 
		@schedule_uid=N'3b996a03-17cd-4021-8fbd-d34e27928bb5'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Index Rebuild/ReOrganize- Stats Update Weekly]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Index Rebuild/ReOrganize- Stats Update Weekly', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Rajesh Kumar', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Index Rebuild/ReOrganize]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Index Rebuild/ReOrganize', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/***************************************Index Rebuild/Re-organize****************
	Author			: Rajesh Kumar
	Create Date		: 2013-07-17
	Last Modified		: 2013-09-30
	
	Index Analysis job must run before this, that stores it shistory in table "Toolbox.dbo.index_analysis_report"
	Rebuild if pagecount >1000 and fragmentation >40 --offline if non EnterPrise Version of SQL
	Re-organize if pagecount>1000 and fragmentation between 30-40
	--updated pageCount>500
****************************************************************************/
SET QUOTED_IDENTIFIER ON

Declare @targetDate varchar(100) ,
@sqlRebuild varchar(1000),
@dbname varchar(500),
@tablename varchar(500),
@indexname varchar(500),
@fg_per numeric(10,2)
Set @targetDate = convert(varchar(100),GETDATE(),111)

----select @targetDate
if exists(select distinct quotename(dbname) as dbname,tablename ,indexname,avg_fragmentation_in_percent
from Toolbox.dbo.index_analysis_report
where 1=1 
and index_id <> 0 
and page_count>500 
and avg_fragmentation_in_percent >30 and RunDate >= @targetDate)

Begin
	Declare Crs Cursor for
	select distinct quotename(dbname) as dbname,tablename ,indexname,avg_fragmentation_in_percent
	from Toolbox.dbo.index_analysis_report
	where 1=1 
	and index_id <> 0 
	and page_count>500 
	and avg_fragmentation_in_percent >30 and RunDate >= @targetDate
	Order by dbname,tablename

	Open Crs
	Fetch Next from Crs into @dbname,@tablename,@indexname,@fg_per

	While @@FETCH_STATUS = 0
	Begin
		set @sqlRebuild = ''use ''+@dbname+'' Alter Index [''+@indexname+''] on ''+@tablename
		if @fg_per > 40 
			Set @sqlRebuild = @sqlRebuild + '' Rebuild''
		Else
			Set @sqlRebuild = @sqlRebuild + '' ReOrganize''
		
		----Print @sqlRebuild
		exec ( @sqlRebuild)
	Fetch Next from Crs into @dbname,@tablename,@indexname,@fg_per
	End

	Close Crs
	Deallocate Crs
End

----Send Appropriate Email Msg

Declare @body varchar(max),
@sub varchar(1000)

Set @sub = ''Index Maintenance Job completed for ''+@@SERVERNAME


if exists(select distinct quotename(dbname) as dbname,tablename ,indexname,avg_fragmentation_in_percent
from Toolbox.dbo.index_analysis_report
where 1=1 
and index_id <> 0 
and page_count>1000 
and avg_fragmentation_in_percent >30 and RunDate >= @targetDate)


Begin
Set @body = ''Hi, <BR>Below indexes have been Rebuil/ReOrganize on Server ''+@@servername+''.<BR><BR><table border=1 align="center"> <TR>
						<TH>DatabaseName</TH><TH>TableName</TH><TH>IndexName</TH><TH>Avg Fragmentation Percent</TH>''+
						Cast( (select td = dbname, '''',
						td=tablename,'''',
						td = indexname,'''',
						td=cast(avg_fragmentation_in_percent as numeric(10,2)),''''
						from Toolbox.dbo.index_analysis_report where 1=1 and index_id <> 0 and page_count>500 
						and avg_fragmentation_in_percent >30 and RunDate >= @targetDate
						For XML Path (''tr''),type
						) as nvarchar(max))+ N''</table> <br><br> Thanks, <br> Database Support Group''
End	
Else 
	Set @body = ''Hi, <BR> No fragmentation found in Index Analysis Report, So no index Rebuild/Re-Organize occured.<br><br>Thanks,<br> Database Support Group ''
	
exec msdb.dbo.sp_send_dbmail
	@recipients  = ''rkumar@efgusa.com; JSquires@efgusa.com'',
	@subject = @sub,
	@body_format = ''HTML'',
	@body= @body', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Stats Update]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Stats Update', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/****Index Rebuild/Re-organize****************
	Author			: Rajesh Kumar
	Create Date		: 2013-07-17
	Last Modified		: 2013-08-18
	
	Index Analysis job must run before this, that stores it shistory in table "Toolbox.dbo.index_analysis_report"
	Rebuild if pagecount >1000 and fragmentation >40 --offline if non EnterPrise Version of SQL
	Re-organize if pagecount>1000 and fragmentation between 30-40
	
****************************************************************************/
	
Declare @targetDate varchar(100) ,
@sqlUpdStats varchar(max)= '' '',
@dbname varchar(500),
@tablename varchar(500),

@body varchar(max),
@sub varchar(1000)

Declare Crs Cursor for
select distinct quotename(name) as dbname
from sys.databases where state_desc = ''online'' and is_read_only=0 and name not in (''master'',''tempdb'',''model'')

Open Crs
Fetch Next from Crs into @dbname
While @@Fetch_status = 0
Begin
	set @sqlUpdStats = ''Use ''+@dbname+'' exec sp_updateStats '' 
	--print @sqlUpdStats
	exec(@sqlUpdStats)
	Fetch Next from Crs into @dbname

End
Close Crs
Deallocate Crs
	Set @sub = ''Statistics Updated Sucessfully for all Database on ''+@@SERVERNAME
	Set @body = ''Hi, <BR> Statistics Updated Successfully for all databases.<br><br>Thanks, <br> Database Support Group ''


exec msdb.dbo.sp_send_dbmail
	@recipients  = ''rkumar@efgusa.com;JSquires@efgusa.com '',
	@subject = @sub,
	@body_format = ''HTML'',
	@body= @body
	', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly_Sat_10pm', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=64, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130717, 
		@active_end_date=99991231, 
		@active_start_time=220000, 
		@active_end_time=235959, 
		@schedule_uid=N'fa9bb339-765e-4b33-8414-dc6291e8158e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [MaintenancePlan Databases.Subplan_1]    Script Date: 09/30/2013 15:46:24 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 09/30/2013 15:46:24 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MaintenancePlan Databases.Subplan_1', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'EFG-DOMAIN\rls', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1]    Script Date: 09/30/2013 15:46:24 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\MaintenancePlan Databases" /set "\Package\Subplan_1.Disable;false"', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'MaintenancePlan Databases.Subplan_1', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110817, 
		@active_end_date=99991231, 
		@active_start_time=230000, 
		@active_end_time=235959, 
		@schedule_uid=N'24aaacd1-15c0-4993-baa0-5eea5001941f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [MaintenancePlan Logs.Subplan_1]    Script Date: 09/30/2013 15:46:25 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 09/30/2013 15:46:25 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MaintenancePlan Logs.Subplan_1', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'EFG-DOMAIN\rls', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "Maintenance Plans\MaintenancePlan Logs" /SERVER "sv-sql05" /CHECKPOINTING OFF /SET "\Package\Subplan_1.Disable";false /REPORTING E', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'MaintenancePlan Logs.Subplan_1', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110817, 
		@active_end_date=99991231, 
		@active_start_time=165500, 
		@active_end_time=235959, 
		@schedule_uid=N'cda372aa-52d6-4088-b47c-fcac78c72641'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [MaintenancePlan System DB.Subplan_1]    Script Date: 09/30/2013 15:46:25 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 09/30/2013 15:46:25 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MaintenancePlan System DB.Subplan_1', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'EFG-DOMAIN\rls', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Subplan_1]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Subplan_1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/Server "$(ESCAPE_NONE(SRVR))" /SQL "Maintenance Plans\MaintenancePlan System DB" /set "\Package\Subplan_1.Disable;false"', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'MaintenancePlan System DB.Subplan_1', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110817, 
		@active_end_date=99991231, 
		@active_start_time=223000, 
		@active_end_time=235959, 
		@schedule_uid=N'71205171-81ce-4fba-b06e-9d9efaec6692'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Purging Backup History Older than 60 Days]    Script Date: 09/30/2013 15:46:25 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:25 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Purging Backup History Older than 60 Days', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'Database Support Group', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Purging Backup History]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Purging Backup History', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE msdb
GO
DECLARE @DaysToKeepHistory DATETIME
SET @DaysToKeepHistory = CONVERT(VARCHAR(10), DATEADD(dd, -60, GETDATE()), 101)
--select @DaysToKeepHistory
EXEC sp_delete_backuphistory @DaysToKeepHistory
GO', 
		@database_name=N'master', 
		@flags=0
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

/****** Object:  Job [syspolicy_purge_history]    Script Date: 09/30/2013 15:46:25 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:25 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'syspolicy_purge_history', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verify that automation is enabled.]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verify that automation is enabled.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'IF (msdb.dbo.fn_syspolicy_is_automation_enabled() != 1)
        BEGIN
            RAISERROR(34022, 16, 1)
        END', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Purge history.]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Purge history.', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC msdb.dbo.sp_syspolicy_purge_history', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Erase Phantom System Health Records.]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Erase Phantom System Health Records.', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'(Get-Item SQLSERVER:\SQLPolicy\SV-SQL05\DEFAULT).EraseSystemHealthPhantomRecords()', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'syspolicy_purge_history_schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20080101, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'445e8011-e2a8-4bb7-97c8-f4d90072b035'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Update tblVendorsUpdated where null]    Script Date: 09/30/2013 15:46:25 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/30/2013 15:46:25 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Update tblVendorsUpdated where null', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'EFG-DOMAIN\jwp', 
		@notify_email_operator_name=N'SQL Operators', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update tblVendorsUpdated]    Script Date: 09/30/2013 15:46:25 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update tblVendorsUpdated', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'update tblVendorsUpdated set PortableGap = 2 where PortableGap is null', 
		@database_name=N'sguard_portal', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run Every 5 minutes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130509, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'2321a200-b3e9-40c7-8b6c-ffd8dc4e1c2f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


