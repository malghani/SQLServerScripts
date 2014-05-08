kill 59

Select distinct identity(int, 1,1) as ID, period, producttypeid into T3Permutations From factSales WHERE Period>=20080131 Order by Period Desc
   
sp_whoisactive
--Select Distinct ProductTypeID From fActSales (nolock) Where Period=20140131
Select Distinct P.Period, P.ProductTypeID, ProductTypeName, ProductCategoryName, T3.Period From T3Permutations P (NOLOCK)
left join ReportTier3 T3(nolock) ON P.Period=T3.Period And P.ProductTypeID=T3.ProductTypeID
Where NOT T3.Period IS NULL
Order by T3.Period Desc, P.Period Desc, P.ProductTypeID 


Select Period, ProductTypeID From ReportTier3 Group By Period, ProductTypeID

Select Period From ReportTier3 (nolock) Group By Period



Select distinct period, producttypeid into T3Permutations From factSales
DBCC INPUTBUFFER (60)


Select max(ADMPSTDAT), count(*) From efgsales_prod.dbo.SalesDisbDataHist2006 (nolock)
select max(AEPYRMON), COUNT(*) from efgsales_prod.dbo.ClaimSummaryHist2006(nolock)
--select max(PRDPRTDATMIN), COUNT(*) from efgsales_prod.dbo.ClaimsHist2006(nolock)
select COUNT(*) from efgsales_prod.dbo.FactSales2006(nolock)

Select Count(*) From ClaimSummaryHist2006 Where AEPYRMON=199811

SELECT	Count(*) 

FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE AEPYRMON BETWEEN 199811 AND 199811
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON

Backup Database EFGSales TO DISK='F:\AS Data Backup\EFGSales.bak' WITH INIT, NAME='EFGSalesSet', COMPRESSION
Backup Database EFGSales_Prod TO DISK='F:\AS Data Backup\EFGSales_Prod.bak' WITH INIT, NAME='EFGSalesSetProd', COMPRESSION


xp_cmdshell 'Dir "F:\AS Data Backup"'
xp_cmdshell 'Del "F:\AS Data Backup\Efgsales.bak"'

xp_cmdshell 'Del "F:\AS Data Backup\EFGSales_Prod.bak"'

xp_cmdshell 'Dir "D:"'
xp_cmdshell 'Dir "E:"'
xp_cmdshell 'Dir "G" '
xp_cmdshell 'Dir "H" '
xp_cmdshell 'Dir "F:\SQLLog"'
xp_cmdshell 'Dir "E:\SQLData"'
xp_cmdshell 'Dir "G:\Backups" '
xp_cmdshell 'Dir "D:\SQL\tempData"'
xp_cmdshell 'Dir "D:\SQL\tempLog"'




xp_cmdshell 'Net Stop MSSQLServer -y'
xp_cmdshell 'Net Start MSSQLServer'

xp_cmdshell 'whoami.exe' ;


DBCC ShrinkFile(7,0)
DBCC ShrinkFile(7,0, Truncateonly)
DBCC ShrinkFile(7,0, notruncate)



select * from sysfiles

use EFGSales_Prod
DBCC ShrinkFile(2,2), NOTRUNCATE)





Select * From sysfiles

Select @@TRANCOUNT

Select * From sys.databases where name='efgsales'
ALTER DATABASE EFGSales SET RECOVERY FULL
ALTER DATABASE EFGSales SET RECOVERY SIMPLE WITH NO_WAIT


DBCC CHECKDB (EFGSales)



use master;
ALTER DATABASE EFGSales_prod
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE EFGSales_prod
SET MULTI_USER;


use master;
ALTER DATABASE StagingSales
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE StagingSales
SET MULTI_USER;








DECLARE @results TABLE(results varchar(255))
declare @command varchar(2000)
--zip one file
SET @command = 
    'Net Stop MSSQLServer' --path to 7za command line utility note the dbl quotes for long file names!
     + ' < "F:\SSIS\Yes.txt"'             --suppress any dialogs by answering yes to any and all prompts
print @command
--"C:\DataFiles\7zip_CommandLine_7za465\7za.exe" a "C:\DataFiles\myZipFile.zip" "C:\DataFiles\SandBox_2011-07-25.bak" -y
insert into @results
exec xp_cmdshell @command  
Select * From @Results

exec xp_cmdshell 'Net Start MSSQLServer'
exec xp_cmdshell 'Net Stop SQLServerAgent'



03/12/2014  01:25 AM    16,784,359,424 EFGSales.mdf
03/11/2014  08:56 AM    26,319,257,600 EFGSalesFact2006.mdf
03/11/2014  11:52 AM     4,666,163,200 EFGSalesFact20072008.mdf
03/11/2014  01:19 PM     1,782,579,200 EFGSalesFact2009.mdf
03/11/2014  05:54 PM     2,097,152,000 EFGSalesFact2010.mdf
03/11/2014  07:46 PM     3,355,443,200 EFGSalesFact2011.mdf
03/11/2014  09:30 PM     2,726,297,600 EFGSalesFact2012.mdf
03/12/2014  12:41 AM     3,093,299,200 EFGSalesFact2013.mdf
03/12/2014  01:40 AM       419,430,400 EFGSalesFact2014.mdf


Select AgreementID, Period From SalesDisbDataHist2006 Group by AgreementID, .ADMPSTDAT having COUNT(*) > 1





SELECT a.*
FROM OPENROWSET('IBM DB2 for i IBMDASQL OLE DB Provider', 'Server=I400DASQL;Trusted_Connection=yes;',
'Select count(*)
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
							  
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
										ON  a.AGMCLICOD = D.ADMCLICOD AND
										  a.AGMACCCOD = D.ADMACCCOD AND
										  a.AGMAGRCOD = D.ADMAGRCOD AND
										  a.AGMAGRSFX = D.ADMAGRSFX ') AS a;
GO


sp_help ClaimSummaryHist2006