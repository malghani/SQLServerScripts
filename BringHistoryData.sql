--sp_configure 'Ad Hoc Distributed Queries', 1
--RECONFIGURE WITH OVERRIDE;
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2006 DISB'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 DISB'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4  
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 DISB'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2006 DISB'
PRINT GetDate()
GO
                         
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2006 CSH'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 CSH'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4  
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 CSH'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2006 CSH'
PRINT GetDate()

GO
                  
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2006 CP'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 CP'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4  
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2006 CP'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2006 CP'
PRINT GetDate()

GO
