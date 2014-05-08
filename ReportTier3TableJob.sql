   Set NOCOUNT ON 
   TRUNCATE TABLE ReportTier3
   --Select distinct identity(int, 1,1) as ID, period, producttypeid into #tmp From factSales
   -- Drop table #tmp
   
   DECLARE @PSTDATE bigint, @ProductTypeID int, @ID int
   
   DECLARE period_cursor CURSOR  STATIC LOCAL 
      FOR
      SELECT  ID, Period, ProductTypeID From #tmp
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @ID, @PSTDATE, @ProductTypeID
   WHILE (@@fetch_status <> -1)
   BEGIN  
		   --Print @PSTDATE  
		   --Print @ProductTypeID
		   SELECT @ID, @PSTDATE  PSTDATE, @ProductTypeID ProductTypeID
           EXEC SSRS_SalesTier3_Product_Performance_Fill_Tier3 @ProductTypeID, @PSTDATE
      FETCH NEXT FROM period_cursor INTO @ID, @PSTDATE, @ProductTypeID
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor

--  Select * From ReportTier3