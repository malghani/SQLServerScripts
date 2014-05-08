use master;
GO
SET NOEXEC OFF;
GO
if NOT Exists(Select * from sys.objects 
              where name='sal002_tier1_sales') 
                    OR ((select DB_ID())<=4)
  PRINT 'WRONG DATABASE HAS CHOSEN TO RUN CREATE STORED PROCEDURES. '+ 
   'YOU ARE USING UNEXPECTED DATABASE ['+DB_NAME()+'].' +
   'PLEASE CHOOSE YOUR TARGET DATABASE.'
GO
if NOT Exists(Select * from sys.objects 
    where name='sal002_tier1_sales') 
    OR ((select DB_ID())<=4)
 SET NOEXEC ON;
else
    SET NOEXEC OFF;
GO
   Print 'Batch Script Goes Here--- '
GO
SET NOEXEC OFF;
GO