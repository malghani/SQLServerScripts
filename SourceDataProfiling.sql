--Declare @SourceDataBase varchar(255) = 'I400DASQL.EFGAS400.SESCSEFG' -- Src = Linked AS400
--Declare @SourceDataBase varchar(255) = 'SrcDatabase' -- SQL = SQL
IF exists(Select * from tempdb.dbo.sysobjects where name like '#SrcTableColumns%')
  drop table #SrcTableColumns
  
  
Create Table #SrcTableColumns
		(TableName varchar(255),
		 ColumnName Varchar(255)
		 )
		 
-- You Can Import from Excel Table Columns as well in a non-temp table
INSERT #SrcTableColumns

--SELECT 'AGDTA00','AGDPRDCOD' UNION
--SELECT 'AGDTA00','AGDPRDSTS' UNION
--SELECT 'SCAGRDM','ADMTRNTYP' UNION
--SELECT 'SCAGRDM06','ADMDISAMT' UNION
--SELECT 'SCAGREP','AEPERNCM' UNION
SELECT 'SCAGRPVM','APVRECTYP' UNION
SELECT 'SCAGRPVM','APVPRDCOD' 
--SELECT 'SCCLM','CIMATHAMT' UNION
--SELECT 'SCCLM','CIMCLMTID' UNION
--SELECT 'SCPAYRD','PRDCHKAMT' 

Declare @RowCount table (TableName varchar(255), ColumnName varchar(255), RowsCount bigint)
Declare @DisRowCount table (TableName varchar(255), ColumnName varchar(255), DisRowsCount bigint)
Declare @NNRowCount table (TableName varchar(255), ColumnName varchar(255), NNRowsCount bigint)
Declare @Top20Count table (TableName varchar(255), ColumnName varchar(255), Top20Count bigint, To20Val Varchar(255))


Declare @Table varchar(255), @Column varchar(255), @Query varchar(max)
Declare @SourceDataBase varchar(255) = 'I400DASQL.EFGAS400.SESCSEFG' -- Src = Linked AS400
SET ROWCOUNT 20
DECLARE Cur CURSOR FOR
      SELECT TableName, ColumnName 
	  FROM #SrcTableColumns 
   OPEN Cur   
   FETCH NEXT FROM Cur INTO @Table, @Column
   WHILE (@@fetch_status <> -1)
   BEGIN   
   --SELECT @Table [Table], @Column [Column]
	
	-- Validate if column exists   SQL Server
   --SELECT * FROM RptDataDaily.dbo.syscolumns 
   --WHERE name=@Column and id in (Select * from RptDataDaily.dbo.sysobjects where name = @Table)
   
   SELECT @Query = 'SELECT '''+@Table + ''' [Table],'''+ @Column + ''' [Column],  Count(*) RowsCount FROM ' + @SourceDataBase + '.' + @Table
   
   PRINT @Query 
   INSERT @RowCount
   EXEC(@Query)
   SELECT @Query = 'SELECT '''+@Table + ''' [Table],'''+ @Column + ''' [Column],  Count(Distinct ' + @Column + ') DistinctRowsCount FROM ' + @SourceDataBase + '.' + @Table
   PRINT @Query 
   INSERT @DisRowCount
   EXEC(@Query)
   SELECT @Query = 'SELECT '''+@Table + ''' [Table],'''+ @Column + ''' [Column],  Count(*) NotNULLCount FROM ' + @SourceDataBase + '.' + @Table + ' WHERE NOT ' + @Column + ' IS NULL '
   PRINT @Query 
   INSERT @NNRowCount
   EXEC(@Query)

   SELECT @Query = 'SELECT '''+@Table + ''' [Table],'''+ @Column + ''' [Column],  Count(*) Top20Count, ' + @Column + '   FROM ' + @SourceDataBase + '.' + @Table + ' GROUP BY ' + @Column + ' Order by 3 Desc '
   PRINT @Query 
   INSERT @Top20Count
   EXEC(@Query)
      
   
   FETCH NEXT FROM Cur INTO @Table, @Column
   End
CLOSE Cur
DEALLOCATE Cur
SET ROWCOUNT 0
Select RC.*, DRC.DisRowsCount, NNRC.NNRowsCount, T20.To20Val, T20.Top20Count From @RowCount RC
JOIN @DisRowCount DRC ON RC.TableName=DRC.TableName AND RC.ColumnName=DRC.ColumnName
JOIN @NNRowCount NNRC ON RC.TableName=NNRC.TableName AND RC.ColumnName=NNRC.ColumnName
JOIN @Top20Count T20 ON RC.TableName=T20.TableName AND T20.ColumnName=NNRC.ColumnName
