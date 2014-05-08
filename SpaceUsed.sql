 Select DB_NAME([database_id])AS [Database Name], 
	 FileGroupName = filegroup_name(a.data_space_id)
	,TableName = object_name(p.object_id)
	,IndexName = i.name
	,LOBUsedPages = a.used_pages
	,LOBTotalPages = a.total_pages
	,LOBDataSizeMB = a.used_pages * 8/1024	
	,a.type
	,CASE i.[index_id]
     WHEN 0 THEN 'HEAP'
     WHEN 1 THEN 'CLUSTERED'
     ELSE 'NON-CLUSTERED'
    END AS index_type,	
        mf.[file_id], mf.name FileName, mf.physical_name, mf.type_desc, mf.state_desc, 
        CONVERT( bigint, mf.size/128.0) AS [Total Size in MB]

	From sys.allocation_units a
		Inner Join sys.partitions p
			On p.partition_id = a.container_id
			--And a.type = 2					--LOB data is stored in pages of type Text/Image
		Left Outer Join sys.indexes i
			On i.object_id = p.object_id
			And i.index_id = p.index_id
		Left join sys.database_files df on df.data_space_id=a.data_space_id
		Left Join sys.master_files mf on mf.file_guid=df.file_guid
	Where OBJECTPROPERTY(p.object_id,'IsMSShipped') = 0
		And a.data_pages > 0
		--And filegroup_name(a.data_space_id) <> 'Primary'
Order By TableName asc



	--DBCC SHRINKFILE ( 7, EMPTYFILE)
	--ALTER DATABASE efgsales_prod REMOVE FILE  EFGSales2006 