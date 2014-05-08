Use master
GO
/****** Object:  StoredProcedure [dbo].[track_waitstats]    Script Date: 2/5/2014 3:59:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[track_waitstats] (@num_samples int=10,@delaynum int=1,@delaytype 
nvarchar(10)='minutes')
AS

-- This stored procedure is provided AS IS with no warranties and confers no rights.
-- Use of included script samples are subject to the terms specified at
-- http://www.microsoft.com/info/cpyright.htm.

-- @num_samples is the number of times to capture waitstats; default is 10 times.
-- @delaynum is the delay interval; can be in minutes or seconds; default is 1 minute.
-- @delaytype is the time specified. Values are "minutes" or "seconds."
-- Create waitstats table if it doesn't exist; otherwise truncate.

SET nocount ON
IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE name = 'waitstats')
   CREATE table waitstats ([wait type] varchar(80),
      requests numeric(20,1),
      [wait time] numeric (20,1),
      [signal wait time] numeric(20,1),
      now datetime default getdate())
ELSE    truncate table waitstats
dbcc sqlperf (waitstats,clear)                               -- Clear out waitstats.
DECLARE @i int,@delay varchar(8),@dt varchar(3),@now datetime,@totalwait numeric(20,1)
   ,@endtime datetime,@begintime datetime,@hr int,@min int,@sec int
SELECT @i = 1
SELECT @dt = case lower(@delaytype)
   WHEN 'minutes' THEN 'm'
   WHEN 'minute' THEN 'm'
   WHEN 'min' THEN 'm'
   WHEN 'mm' THEN 'm'
   WHEN 'mi' THEN 'm'
   WHEN 'm' THEN 'm'
   WHEN 'seconds' THEN 's'
   WHEN 'second' THEN 's'
   WHEN 'sec' THEN 's'
   WHEN 'ss' THEN 's'
   WHEN 's' THEN 's'
   ELSE @delaytype
END
IF @dt NOT IN ('s','m')
BEGIN
   PRINT 'please supply delay type e.g. seconds or minutes'
   RETURN
END
IF @dt = 's'
BEGIN
   SELECT @sec = @delaynum % 60
   SELECT @min = cast((@delaynum / 60) AS int)
   SELECT @hr = cast((@min / 60) AS int)
   SELECT @min = @min % 60
END
IF @dt = 'm'
BEGIN
   SELECT @sec = 0
   SELECT @min = @delaynum % 60
   SELECT @hr = cast((@delaynum / 60) AS int)
END
SELECT @delay= right('0'+ convert(varchar(2),@hr),2) + ':' +
   + right('0'+convert(varchar(2),@min),2) + ':' +
   + right('0'+convert(varchar(2),@sec),2)
IF @hr > 23 or @min > 59 or @sec > 59
BEGIN
   SELECT 'hh:mm:ss delay time cannot > 23:59:59'
   SELECT 'delay interval and type: ' + convert (varchar(10),@delaynum) + ',' + @delaytype + ' 
converts to ' + @delay
   RETURN
END
WHILE (@i <= @num_samples)
BEGIN
             INSERT INTO waitstats ([wait type], requests, [wait time],[signal wait time])
   EXEC ('dbcc sqlperf(waitstats)')
   SELECT @i = @i + 1
   waitfor delay @delay
END


-------------------------------------------------------------------------------------------
GO


SET nocount ON

DECLARE @now datetime,@totalwait numeric(20,1)
   ,@endtime datetime,@begintime datetime
   ,@hr int,@min int,@sec int

SELECT  @now=max(now),@begintime=min(now),@endtime=max(now)
FROM waitstats WHERE [wait type] = 'Total'

-- Subtract waitfor, sleep, and resource_queue from total.
SELECT @totalwait = sum([wait time]) + 1 FROM waitstats
WHERE [wait type] NOT IN ('WAITFOR','SLEEP','RESOURCE_QUEUE', 'Total', '***total***') AND 
now = @now

-- Insert adjusted totals and rank by percentage in descending order.
DELETE waitstats WHERE [wait type] = '***total***' AND now = @now
INSERT INTO waitstats SELECT '***total***',0,@totalwait,@totalwait,@now

SELECT [wait type],[wait time],percentage=cast (100*[wait time]/@totalwait AS numeric(20,1))
FROM waitstats
WHERE [wait type] NOT IN ('WAITFOR','SLEEP','RESOURCE_QUEUE','Total')
AND now = @now
ORDER BY percentage desc



SElect * FROM SalesDisbData (NOLOCK) WHERE NOT [Partner] IS NULL