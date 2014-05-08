
ALTER PROC _ETL_T2T3_ProcessAggregateFactSales
@PeriodFrom bigint,
@PeriodTo bigint
AS
-- _ETL_T2T3_ProcessAggregateFactSales 20130131, 20140331
Set NOCOUNT ON 
Declare @Periods TABLE (Period bigint)
Declare @MaxPeriod bigint

Select @MaxPeriod = Max(period) From FactSalesAggregate
If @MaxPeriod > @PeriodTo
   SET @PeriodTo = @MaxPeriod


INSERT @Periods (Period)
SELECT DateID From Calendar Where DateID Between @PeriodFrom And @PeriodTo Group by DateID Order by DateID

IF Exists(Select * From FactSalesAggregate Where Period Between @PeriodFrom And @PeriodTo)
	Begin
		Delete FactSalesAggregate Where Period Between @PeriodFrom And @PeriodTo
	End 

   DECLARE @Period bigint   
   DECLARE period_cursor CURSOR  STATIC LOCAL 
      FOR
       SELECT Period From @Periods Order by Period-- Order is very Important for ITD being sum of previous
	  
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @Period
   WHILE (@@fetch_status <> -1)
   BEGIN  
      EXEC _ETL_T2T3_AggregateFactSales @Period
	  --SELECT 'Processed ' + Convert(Varchar, @Period)
      FETCH NEXT FROM period_cursor INTO @Period
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor

