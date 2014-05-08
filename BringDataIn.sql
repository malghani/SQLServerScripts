--sp_configure 'Ad Hoc Distributed Queries', 1
--RECONFIGURE WITH OVERRIDE;
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4  
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2006'
GO

                         
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 20072008'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 20072008'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4  
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 20072008'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 20072008'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
DECLARE @JobStatus INT
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2009'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2009'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2009'', @job_aspect = ''JOB''')

End
GO
PRINT 'DONE FOR 2009'
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2010'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2010'', @job_aspect = ''JOB''')
WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2010'', @job_aspect = ''JOB''')

End
GO
PRINT 'DONE FOR 2010'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
DECLARE @JobStatus INT
SET @JobStatus = 0     

EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2011'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2011'', @job_aspect = ''JOB''')
WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2011'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2011'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2012'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2012'', @job_aspect = ''JOB''')
WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2012'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2012'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2013'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2013'', @job_aspect = ''JOB''')
WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2013'', @job_aspect = ''JOB''')


End
PRINT 'DONE FOR 2013'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO

DECLARE @JobStatus INT
SET @JobStatus = 0     
EXEC MSDB.dbo.sp_start_job @Job_Name = 'Get Tier 2 and 3 Sales 2014'
WAITFOR DELAY '00:00:06'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2014'', @job_aspect = ''JOB''')

WHILE @JobStatus <> 4
BEGIN
WAITFOR DELAY '00:05:00'
SELECT @JobStatus = current_execution_status  FROM OPENROWSET('SQLNCLI', 'Server=sv-sqldev01vm;Trusted_Connection=yes;',  
                         'SET FMTONLY OFF exec msdb.dbo.sp_help_job_with_results @job_name = ''Get Tier 2 and 3 Sales 2014'', @job_aspect = ''JOB''')

End
PRINT 'DONE FOR 2014'
GO
exec EFGSales_Prod.dbo.ShrinkLogFile
GO
