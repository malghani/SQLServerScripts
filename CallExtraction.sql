IF OBJECT_ID('tempdb..#test') IS NOT NULL
BEGIN
    DROP TABLE #test
END

CREATE TABLE #test(Callid varchar(100) NOT NULL, data varchar(max))

INSERT INTO #test
(Callid,data)
(SELECT Callid,CallEventLog from [I3_IC].[dbo].[CallDetail] cd where
cd.InteractionType = 0 and
cd.InitiatedDate >'2014-04-24' and
cd.CallEventLog like '%ACD interaction%' and
cd.CallEventLog like '%Entered Workgroup%')
--INSERT INTO #test VALUES (2,'See,if,it,can,be,split,into,many,columns') 

SELECT Agent=ACDTo, WorkGroup=EnteredTo, CallsTaken=count(*), TimeTaken=Sum(TimeTakeninMinutes)
FROM (
Select ACDStart=Substring(data,CHaRINDEX('ACD Interaction',data)-10,8), 
	   ACDStartTo=Substring(data,CHaRINDEX('ACD Interaction',data)-10,(CHaRINDEX(char(10),data,CHaRINDEX('ACD Interaction',data))-CHaRINDEX('ACD Interaction',data)+10 )), 
	   ACDTo=Substring(data,CHaRINDEX('ACD Interaction',data),(CHaRINDEX(char(10),data,CHaRINDEX('ACD Interaction',data))-CHaRINDEX('ACD Interaction',data) )), 
	   EnteredWorkGroup=Substring(data,CHaRINDEX('Entered Workgroup',data)-10,8), 
	   EnteredWorkGroupTo=Substring(data,CHaRINDEX('Entered Workgroup',data)-10,(CHaRINDEX(char(10),data,CHaRINDEX('Entered Workgroup',data))-CHaRINDEX('Entered Workgroup',data)+10 )), 
	   EnteredTo=Substring(data,CHaRINDEX('Entered Workgroup',data),(CHaRINDEX(char(10),data,CHaRINDEX('Entered Workgroup',data))-CHaRINDEX('Entered Workgroup',data) )),
	   TimeTakeninMinutes=DateDiff(MINUTE, Convert(DateTime, Substring(data,CHaRINDEX('Entered Workgroup',data)-10,8)),Convert(DateTime, Substring(data,CHaRINDEX('ACD Interaction',data)-10,8)))	   
from #test
) AS Tabb 
Group by ACDTo, EnteredTo



Select * From #test


DECLARE @pivot varchar(max)
DECLARE @select varchar(max)

SELECT 
        @pivot=coalesce(@pivot+',','')+'[CallEvent'+cast(number+1 as varchar(10))+']'
FROM 
        master..spt_values where type='p' and 
        number<=(SELECT max(len(data)-len(replace(data,char(10),''))) FROM #test)

SELECT 
    @select='
        select p.*
        from (
        select 
            Callid,substring(data, start+2, endPos-Start-2) as token,
            ''CallEvent''+cast(row_number() over(partition by callid order by start) as varchar(10)) as n
        from (
            select 
                Callid, data, n as start, charindex(CHAR(10),data,n+2) endPos
                from (select number as n from master..spt_values where type=''p'') num
                cross join 
                (
                    select 
                        Callid, CHAR(10) + data +CHAR(10) as data 
                    from 
                        #test
                ) m
            where n < len(data)-1
            and substring(data,n+1,1) = CHAR(10)) as data
        ) pvt
        Pivot ( max(token)for n in ('+@pivot+'))p'

EXEC(@select)


