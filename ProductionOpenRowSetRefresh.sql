SELECT * into #tmp FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC @UserID=''amaqsood''') 
SELECT * into #tmp1 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Channel_Revenue_By_Product_SEC ''UNKNOWN'', ''amaqsood''') 
SELECT * into #tmp2 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC @LOB=''Dealer Services'', @EFG_Rep=''Bryan Durant'', @UserID=''amaqsood''') 
SELECT * into #tmp3 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB=''Dealer Services'', @EFG_Rep=''Hollis Goode'', @AccountGroup=''Moritz Group'', @Account=''Moritz Cadillac''') 
SELECT * into #tmp4 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB=''Agency Services'', @EFG_Rep=''Paul Roberts'', @AccountGroup=''No Account Group''') 
SELECT * into #tmp5 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB=''Agency Services'', @EFG_Rep=''Paul Roberts'', @AccountGroup=''No Account Group'', @Account=''Aristocrat Motors'' ') 
SELECT * into #tmp6 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC') 
SELECT * into #tmp7 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_LOB_Revenue_By_Category_SEC ''Agency Services'', ''amaqsood''') 
SELECT * into #tmp8 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC ''Agency Services'', ''UNKNOWN'', ''amaqsood''') 
SELECT * into #tmp9 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_LOB_Revenue_Pacing_SEC ''amaqsood''') 
SELECT * into #tmp10 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_LOB_Revenue_Trend_SEC ''Agency Services'', ''No Account Group'', ''amaqsood''') 
SELECT * into #tmp11 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC ''Agency Services'', ''Paul Roberts'', ''amaqsood''') 
SELECT * into #tmp12 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC ''Agency Services'', ''Paul Roberts'', ''No Account Group'', ''amaqsood''') 
SELECT * into #tmp13 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC ''Agency Services'', ''Paul Roberts'', ''No Account Group'', ''Autocenter Nissan'', ''amaqsood''') 
SELECT * into #tmp14 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC ''Agency Services'', ''amaqsood''') 
SELECT * into #tmp15 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC ''Agency Services'', ''Adam Ouart'', ''No Account Group'', ''Anaheim Mitsubishi'', ''amaqsood''') 
SELECT * into #tmp16 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Product_Contract_Count_SEC ''amaqsood''') 
SELECT * into #tmp17 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Production_Report_SEC ''Agencey Services'', ''No Account Group'', ''amaqsood''') 
SELECT * into #tmp18 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Production_Variance_by_Count_SEC ''Agency Services'', ''No Account Group'', ''amaqsood''') 
SELECT * into #tmp19 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Production_Variance_By_Revenue_SEC ''Agency Services'', ''No Account Group'', ''amaqsood''') 
SELECT * into #tmp20 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_ProductType_SEC') 
SELECT * into #tmp21 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_ProductTypeDetail_SEC') 
SELECT * into #tmp22 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;exec SSRS_SalesTier1_Revenue_By_Channel_SEC ''amaqsood''') 
SELECT * into #tmp23 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @Product=''Classic''') 
SELECT * into #tmp24 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''salesreptestuser'', @Product=''Classic''') 
SELECT * into #tmp25 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''salesmgrtestuser'', @Product=''Classic''') 
SELECT * into #tmp26 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services''') 
SELECT * into #tmp27 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services'', @EFGRep=''Adam Ouart''') 
SELECT * into #tmp28 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services'', @EFGRep=''Paul Roberts''') 
SELECT * into #tmp29 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services'', @EFGRep=''Adam Ouart'', @AccountGroup=''Rairdon Group''') 
SELECT * into #tmp30 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services'', @EFGRep=''Adam Ouart'', @AccountGroup=''Rairdon Group'', @Account=''Rairdons Dodge Chrysler Jeep of Kirkland''') 
SELECT * into #tmp31 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
'SET FMTONLY OFF;SET NOCOUNT ON;EXEC SSRS_SalesTier1_Revenue_Trend_SEC @UserID=''amaqsood'', @LOB=''Agency Services'', @EFGRep=''Adam Ouart'', @AccountGroup=''Rairdon Group'', @Account=''Rairdons Dodge Chrysler Jeep of Kirkland'', @Product=''Classic''') 
SELECT * into #tmp32 FROM OPENROWSET('SQLNCLI10', 'Server=SV-SQLPRODVM;database=efgsales;Uid=SSRS_USER;Pwd=EFG2013*',
     'SET FMTONLY OFF;SET NOCOUNT ON;EXEC [SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC] ''amaqsood''') 

Select * From #tmp
Select * From #tmp1
Select * From #tmp2
Select * From #tmp3
Select * From #tmp4
Select * From #tmp5
Select * From #tmp6
Select * From #tmp7
Select * From #tmp8
Select * From #tmp9
Select * From #tmp10
Select * From #tmp11
Select * From #tmp12
Select * From #tmp13
Select * From #tmp14
Select * From #tmp15
Select * From #tmp16
Select * From #tmp17
Select * From #tmp18
Select * From #tmp19
Select * From #tmp20
Select * From #tmp21
Select * From #tmp22
Select * From #tmp23
Select * From #tmp24
Select * From #tmp25
Select * From #tmp26
Select * From #tmp27
Select * From #tmp28
Select * From #tmp29
Select * From #tmp30
Select * From #tmp31
Select * From #tmp32

Drop table #tmp
Drop table #tmp1
Drop table #tmp2
Drop table #tmp3
Drop table #tmp4
Drop table #tmp5
Drop table #tmp6
Drop table #tmp7
Drop table #tmp8
Drop table #tmp9
Drop table #tmp10
Drop table #tmp11
Drop table #tmp12
Drop table #tmp13
Drop table #tmp14
Drop table #tmp15
Drop table #tmp16
Drop table #tmp17
Drop table #tmp18
Drop table #tmp19
Drop table #tmp20
Drop table #tmp21
Drop table #tmp22
Drop table #tmp23
Drop table #tmp24
Drop table #tmp25
Drop table #tmp26
Drop table #tmp27
Drop table #tmp28
Drop table #tmp29
Drop table #tmp30
Drop table #tmp31
Drop table #tmp32
