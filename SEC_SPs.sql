USE [EFGSales]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Category_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_By_Category_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Category_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_Trend_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC]    Script Date: 01/17/2014 09:17:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_PremiumSummary_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_PremiumSummary_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_PremiumSummary_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Product_Contract_Count_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Product_Contract_Count_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Product_Contract_Count_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Report_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Report_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Report_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_by_Count_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Variance_by_Count_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_by_Count_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_ProductType_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_ProductType_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_ProductType_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_ProductTypeDetail_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_ProductTypeDetail_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_ProductTypeDetail_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_By_Channel_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Revenue_By_Channel_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Revenue_By_Channel_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_Trend_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Revenue_Trend_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Revenue_Trend_SEC]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC]    Script Date: 01/17/2014 09:17:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC]
GO

USE [EFGSales]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC]    Script Date: 01/17/2014 09:17:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC]
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)

--Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DateName(mm, DATEPART(Month, dbo.GetCurrentPeriod()));

SELECT Isnull(ProductType, 'No Category') 
              AS 
              Product_Category, 
              Sum(Convert(float, ISNULL(disbursement_amount,0))) 
              AS 
                 Amount, 
              @Month
              + ',' 
              + @Year
              AS 
              Date 
         FROM   dbo.sal002_tier1_sales 
         GROUP  BY ProductType
         HAVING  Sum(isnull(disbursement_amount,0)) <> 0



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_SEC]    Script Date: 01/17/2014 09:17:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_SEC]
@Cat nvarchar(320)=NULL
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- EXEC SSRS_SalesTier1_Channel_Revenue_By_Product_SEC 'UNKNOWN'
-- EXEC SSRS_SalesTier1_Channel_Revenue_By_Product_Category_SEC
Declare @Month Varchar(20)
Declare @Year Varchar(4)

--Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DateName(mm, DATEPART(Month, dbo.GetCurrentPeriod()));



SELECT Isnull(ProductType, 'No Category') 
              AS 
              Product_Category, 
              Isnull(ProductName, 'No Product') 
              AS Product, 
              Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, 
              @Month
              + ',' 
              + @Year
              AS 
              Date 
         FROM   dbo.sal002_tier1_sales 
         WHERE Isnull(ProductType, 'No Category') = ISNULL(@Cat, ISNULL(ProductCategory, 'No Category'))         
         GROUP  BY ProductType, ProductName
         HAVING Sum(ISNULL(disbursement_amount,0)) <> 0
         





GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC]    Script Date: 01/17/2014 09:17:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_SEC]
@LOB nvarchar(320),
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL
/*
        Reports Consuming  :  
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services' -- NO CASE OF RUNNING THIS 
				
				Gross Monthly Account Performance by Rep
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Dealer Services', @EFG_Rep='Bryan Durant'
				
				Gross Monthly Account Performance by AccountGroup
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Dealer Services', @EFG_Rep='Hollis Goode', @AccountGroup='Moritz Group', @Account='Moritz Cadillac'
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group'
				
				
						
				Gross Monthly Account Performance by Account
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group', @Account='Aristocrat Motors' 
				
				Gross Monthly Account Performance by Product
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group', @Account='Aristocrat Motors' 				
				

*/

AS 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());


SELECT	lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		ProductName=ISNULL(ProductName, 'No Product'), 
		monthdt= convert(int, CASE 
				WHEN admpstdat = 0 THEN @Month
				ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
				END),								   
		--[count]=Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END),
		[Count]=Sum(ISNULL(GrossCount,0)),
		Amount=Sum(convert(float, ISNULL(GrossAmount,0))),
		[year]=convert(int, CASE 
			  WHEN admpstdat = 0 THEN @Year
				ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
				END)
				,
		CurrentMonth=@Month,
		CurrentYear=@Year
		
FROM   dbo.sal002_tier1_sales_ytd 
 Where  (ADMPSTDAT=0 OR CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) AS INT) = @Year - 1 OR 
 CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) AS INT) = @Year)
 AND ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 
 
 GROUP  BY lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   ProductName,
		   CASE 
			WHEN admpstdat = 0 THEN @Month
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN @Year
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END  ,
		admpstdat
	Having 	Sum(ISNULL(GrossCount,0)) <> 0 OR Sum(convert(float, ISNULL(GrossAmount,0))) <> 0

UNION  -- Just to support UI for Previous Year visibility 
SELECT	lob=@LOB,
		efg_rep=@EFG_Rep, 
		account_group=@AccountGroup, 
		dealer_name=@Account, 
		ProductName=NULL, 
		monthdt= @Month,
		[count]=0,
		Amount=convert(float, 0),
		[year]=@Year-1,			
		CurrentMonth=@Month,
		CurrentYear=@Year
UNION  -- Just to support UI for Previous Year visibility 
SELECT	lob=@LOB,
		efg_rep=@EFG_Rep, 
		account_group=@AccountGroup, 
		dealer_name=@Account, 
		ProductName=NULL, 
		monthdt= @Month,
		[count]=0,
		Amount=convert(float, 0),
		[year]=@Year,		
		CurrentMonth=@Month,
		CurrentYear=@Year

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC]    Script Date: 01/17/2014 09:17:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count_SEC]
AS
DECLARE @x AS TABLE 
	(LOB varchar(255),  Account_Group varchar(255), 
	EFG_Rep varchar(255), Dealer_Name varchar(255), 
	Product_Category varchar(255), Product varchar(255), 
	Count int, Amount float, PreYrAmount float, PreYrCount int); 

Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

WITH a AS (
	SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group,
	'No Account Group') AS Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count,
	SUM(Convert(float, ISNULL(disbursement_amount,0))) AS Amount
	FROM dbo.SAL002_Tier1_Sales
	GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, 
	Super_Category, cprod
   ),
  b AS 
   (
	 SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	 SUM(count) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
	 + ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name + 
	 Super_Category + cprod AS ID
	 FROM a
	 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	 ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
	 + EFG_Rep + Dealer_Name + Super_Category + cprod
 ), 
 c AS 
 (
	SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, 
	ISNULL(Account_Group, 'No Account Group') AS Account_Group, Dealer_Name, 
	ADMTRNTYP, Super_Category, cprod,
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
		SUM(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, ISNULL(LOB, 'No LOB') 
            + ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name 
            + Super_Category + cprod + ADMTRNTYP AS ID
      FROM  dbo.SAL002_Tier1_Sales_YTD
      WHERE  
      CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) AS INT) = @Month AND 
      CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) AS INT) = @Year - 1
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP,
      Super_Category,
      cprod, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod
   ), 
 d AS
    (
	SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod,
		SUM(COUNT) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
        + ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name + 
        Super_Category + cprod AS ID
      FROM            c
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod,
      ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod)
    INSERT INTO @x
    SELECT DISTINCT ISNULL(b.LOB, d .LOB), 
		ISNULL(b.Account_Group, d .Account_Group),
		ISNULL(b.EFG_Rep, D .EFG_Rep),
		ISNULL(b.Dealer_Name, D .Dealer_Name), 
		ISNULL(b.Super_Category, D .Super_Category), 
		ISNULL(b.cprod, D .cprod), Sum(b.Count), sum(b.amount) AS Amount, 
		sum(d.Amount) AS PreYrAmount, sum(d .Count) AS PreyrCount
	FROM b 
	FULL OUTER JOIN
		d ON b.ID = d .ID
	 GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, 
	 D.EFG_Rep, b.Dealer_Name, D .Dealer_Name, b.Super_Category, 
       D.Super_Category, b.cprod, D .cprod
     
     SELECT * FROM @x




GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Category_SEC]    Script Date: 01/17/2014 09:17:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Category_SEC]  
@LOB nvarchar(320)=NULL
AS
SELECT 
  ISNULL(LOB, 'No LOB') AS LOB, 
  ISNULL(ProductType, 'No Category') AS Product_Category,
  SUM(Convert(float, ISNULL(Disbursement_Amount,0))) AS Amount,
  CONVERT(varchar, DATENAME(mm, GETDATE())) + ',' + 
  CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
 FROM SAL002_Tier1_Sales
 WHERE ISNULL(LOB, 'No LOB')= ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
 GROUP BY LOB, ProductType
 HAVING SUM(Disbursement_Amount)<>0




GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC]    Script Date: 01/17/2014 09:17:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod_SEC] 
@LOB nvarchar(320),
@Cat nvarchar(320)
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)

--Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DateName(mm, DATEPART(Month, dbo.GetCurrentPeriod()));
-- SSRS_SalesTier1_LOB_Revenue_By_Prod 'Agency Services', 'UNKNOWN'
SELECT 
  ISNULL(LOB, 'No LOB') AS LOB, 
  ProductType,
  ISNULL(ProductName, 'No Product') AS ProductName,
  SUM(Convert(float, ISNULL(disbursement_amount,0))) AS Amount,
  @Month + ',' + 
  @Year AS Date
 FROM dbo.SAL002_Tier1_Sales
 WHERE ISNULL(LOB, 'No LOB')= @LOB
 AND ISNULL(ProductType, 'No Category') = ISNULL(@Cat, ISNULL(ProductType, 'No Category'))
 GROUP BY LOB, ProductType, ProductName
 HAVING SUM(ISNULL(Disbursement_Amount,0))<>0








GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing_SEC]
AS

Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());
SELECT ISNULL(LOB,'No LOB') as LOB,
SUM(CASE
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year 
       OR ADMPSTDAT = 0) 
	THEN Convert(float, ISNULL(Disbursement_Amount,0)) else 0 End) as Amount_MTD,
SUM(CASE
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year 
       OR ADMPSTDAT = 0) 
	THEN Convert(float, ISNULL(NetAmount,0)) else 0 End) as NETAmt_MTD,

SUM(CASE 
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5))=@Year-1
	THEN Convert(float, ISNULL(disbursement_amount,0)) else 0 End) AS Amount_PRM,
	
SUM(CASE 
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5))=@Year-1
	THEN Convert(float, ISNULL(NetAmount,0)) else 0 End) AS NETAmt_PRM
FROM  dbo.SAL002_Tier1_Sales_YTD
WHERE 
( ADMPSTDAT = 0 OR 
	(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year-1 
	AND  
	SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5,2)=@Month)
)	
GROUP by LOB



GO
/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group_SEC]
@LOB nvarchar(320),
@efg_rep nvarchar(320)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

Select isNull(finaldata.LOB,finalplan.LOB) as LOB ,
isnull(finaldata.Efg_Rep,finalplan.EFG_Rep) as EFG_REp,
isNull(finaldata.Account_Group,finalplan.Account_Group)as Account_Group,
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,
isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,
isnull(Amount_YTD,0)Amount_YTD
 From 
(
     select isNull(LOB,'No LOB') as LOB, EFG_Rep
      ,isNull(Account_Group, 'No Account Group')as Account_Group
	  ,Count(DISTINCT CASE WHEN ADMPSTDAT=0 THEN CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END ELSE NULL END) as Cnt_month
	  ,Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END) as cnt_YTD
	  ,Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END)) AS Amount_YTD
	  ,sum( case when ADMPSTDAT=0  Then Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END) else 0 end) as Amount_Month
      from  [dbo].[SAL002_Tier1_Sales_YTD]
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
      Group By LOB,EFG_Rep
      ,Account_group 
)
 AS FinalData 
 Full Outer Join 
(	  select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,      
      isNull(Account_Group, 'No Account Group')as Account_Group,
      sum(case when (Plan_Revenue > 0 and [Month]=@Month ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',
      sum( case when [Month]=@Month then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
      from  [dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] =@Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
      Group By LOB,EFG_Rep,Account_group
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  AND finaldata.Account_Group=finalplan.Account_Group		





GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_SEC]
@LOB nvarchar(320),
@efg_rep nvarchar(320),
@Account_Group nvarchar(320)
AS
-- [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account] 'Agency Services', 'Paul Roberts', 'Autocenters Group'
-- [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group] 'Agency Services', 'Paul Roberts'
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

Select isNull(finaldata.LOB,finalplan.LOB) as LOB ,
isnull(finaldata.Efg_Rep,finalplan.EFG_Rep) as EFG_REp,
isNull(finaldata.Account_Group,finalplan.Account_Group)as Account_Group,
isnull(finaldata.Dealer_Name,finalplan.Dealer_Name) as Dealer_name,
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,
isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,
isnull(Amount_YTD,0)Amount_YTD
 From 
(
     select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,isNull(Account_Group, 'No Account Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
	  ,Count(DISTINCT CASE WHEN ADMPSTDAT=0 THEN CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END ELSE NULL END) as Cnt_month
	  ,Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END) as cnt_YTD
	  ,Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END)) AS Amount_YTD
	  ,sum( case when ADMPSTDAT=0  Then Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END) else 0 end) as Amount_Month
      from  [SAL002_Tier1_Sales_YTD]
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
 
)
 AS FinalData 
 Full Outer Join 
(	   select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,      
      isNull(Account_Group, 'No Account Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      sum(case when (Plan_Revenue > 0 and [Month]=@Month ) then Plan_Revenue 
		else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 
			End )'Amount_Plan_YTD',

      sum( case when [Month]=@Month then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      FROM [SAL002_Tier1_Sales_Plan]
      Where [Year] = @Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name





GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product_SEC]
@LOB nvarchar(320),
@efg_rep nvarchar(320),
@Account_Group nvarchar(320),
@Dealer_name nvarchar(320)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());
Select isNull(finaldata.LOB,finalplan.LOB) as LOB ,
isnull(finaldata.Efg_Rep,finalplan.EFG_Rep) as EFG_REp,
isNull(finaldata.Account_Group,finalplan.Account_Group)as Account_Group,
isnull(finaldata.Dealer_Name,finalplan.Dealer_Name) as Dealer_name,
ISNULL(finaldata.cprod,finalplan.Product) as Product,
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,
isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,
isnull(Amount_YTD,0)Amount_YTD
 From 
(
     select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,isNull(Account_Group, 'No Account Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
      ,isnull(ProductName, 'No Product') as cprod
	  ,Count(DISTINCT CASE WHEN ADMPSTDAT=0 THEN CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END ELSE NULL END) as Cnt_month
	  ,Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END) as cnt_YTD
	  ,Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END)) AS Amount_YTD
	  ,sum( case when ADMPSTDAT=0  Then Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END) else 0 end) as Amount_Month

 
      from  [dbo].[SAL002_Tier1_Sales_YTD]
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
	  and isNull(Dealer_Name, 'No Account')  = @dealer_name
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
      ,ProductName
 
)
 AS FinalData 
 Full Outer Join 
(	   select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      isNull(Account_Group, 'No Account Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      isNull(ProductName,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=@Month ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=@Month then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] =@Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
	  and isNull(Dealer_Name, 'No Account') = @dealer_name
	  
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
      ,ProductName 
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name
      AND finaldata.cprod= finalplan.product





GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep_SEC] 
@LOB nvarchar(320) 
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @Month int
Declare @Year int
-- [SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep] 'Agency Services'
--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());
Select isNull(final_data.LOB,finalplan.LOB) as LOB ,isnull(final_data.Efg_Rep,finalplan.EFG_Rep) as EFG_REp, 
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD,
AccessDenied=convert(bit, 0)
From 
(select isNull(LOB,'No LOB') as LOB,EFG_Rep
  ,Count(DISTINCT CASE WHEN ADMPSTDAT=0 THEN CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END ELSE NULL END) as Cnt_month
  ,Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END) as cnt_YTD
  ,Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END)) AS Amount_YTD
  ,sum( case when ADMPSTDAT=0  Then Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN ISNULL(disbursement_amount,0) ELSE 0 END) else 0 end) as Amount_Month
  from  [dbo].[SAL002_Tier1_Sales_YTD]
  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year OR ADMPSTDAT = 0)
  and isNull(LOB,'No LOB') = @LOB
  Group By LOB,EFG_Rep)
AS final_data
Full Outer Join 
(
 select
      isNull(LOB,'No LOB') as LOB,EFG_Rep,       
      sum(case when (Plan_Revenue > 0 and [Month]=@Month ) 
            then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 
             then Plan_Revenue else 0 End )'Amount_Plan_YTD',
      sum( case when [Month]=@Month then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
	  
      from  [dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] =@Year
      and isNull(LOB,'No LOB') = @LOB
	  Group By LOB,EFG_Rep
) AS finalplan ON finalplan.LOB=final_data.LOB AND finalplan.EFG_Rep=final_data.EFG_Rep 





GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance_SEC]
@LOB nvarchar(320)=NULL,
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL
-- [SSRS_SalesTier1_NET_Monthly_Account_Performance] 'Agency Services', 'Adam Ouart', 'No Account Group', 'Anaheim Mitsubishi'
AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

SELECT	lob=ISNULL(Monthly.lob, 'No LOB'),
		efg_rep=ISNULL(Monthly.efg_rep, 'NO Rep'), 
		account_group=ISNULL(Monthly.Account_Group, 'No Account Group'), 
		dealer_name=ISNULL(Monthly.dealer_name, 'No Account'), 
		ProductName=ISNULL(Monthly.ProductName, 'No Product'), 
		monthdt= convert(int, CASE 
			WHEN admpstdat = 0 THEN @Month 
			ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
			END),								   
		--[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),		
    [Count]=SUM(ISNULL(NetCount,0)),    		
	Amount=convert(float,SUM(ISNULL(NetAmount,0.00))),
	[year]=Convert(int, CASE 
			 WHEN admpstdat = 0 THEN @Year 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
			END),
		CurrentYear=@Year,
		CurrentMonth=@Month
 FROM   [dbo].[sal002_tier1_sales_ytd] Monthly
 			  
 Where  (ADMPSTDAT=0 OR CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) AS INT) = @Year - 1 OR 
 CAST(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) AS INT) = @Year)
 AND ISNULL(Monthly.lob,'No LOB')=ISNULL(@LOB, ISNULL(Monthly.lob, 'No LOB'))
 AND ISNULL(Monthly.efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(Monthly.efg_rep, 'No Rep')) 
 AND ISNULL(Monthly.Account_Group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(Monthly.account_group, 'No Account Group'))
 AND ISNULL(Monthly.Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Monthly.Dealer_Name, 'No Account'))
 
 GROUP  BY Monthly.lob, 
		   Monthly.efg_rep, 
		   Monthly.account_group, 
		   Monthly.dealer_name, 
		   ISNULL(Monthly.ProductName, 'No Product'), 
		   CASE 
			WHEN admpstdat = 0 THEN @Month
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN @Year
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END,
		admpstdat


UNION  -- Just to support UI for Previous Year visibility 
SELECT	lob=@LOB,
		efg_rep=@EFG_Rep, 
		account_group=@AccountGroup, 
		dealer_name=@Account, 
		ProductName=NULL, 
		monthdt= @Month,
		[count]=0,
		Amount=convert(float, 0.00),
		[year]=@Year-1,
		CurrentYear=@Year,		
		CurrentMonth=@Month		
		
UNION
SELECT	lob=@LOB,
		efg_rep=@EFG_Rep, 
		account_group=@AccountGroup, 
		dealer_name=@Account, 
		ProductName=NULL, 
		monthdt= @Month,
		[count]=0,
		Amount=convert(float, 0.00),
		[year]=@Year,
		CurrentYear=@Year,		
		CurrentMonth=@Month
		



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_PremiumSummary_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_PremiumSummary_SEC]
@Period int
-- [SSRS_SalesTier1_PremiumSummary] 0
AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT	ADMACCCOD = ADMACCCOD + '     ('+ Dealer_Name + ')',
		CPROG,	
		ADMTRNTYP=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 'Issue' ELSE 
				  CASE WHEN ADMTRNTYP='CAN' THEN 'Canceled' ELSE 
				  CASE WHEN ADMTRNTYP='AMD' THEN 'Amended' ELSE 
				  CASE WHEN ADMTRNTYP='REN' THEN 'Reinstate' ELSE 'Amended' END END END END,
		Disbursement_Code,	
		ProductName,
		ProductType,
		CPROD,
		NetCount=Sum(ISNULL(NetCount,0)),
		--NetCount=ISNULL(Count(Distinct CASE WHEN admtrntyp='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx END)-
		--Count(Distinct CASE admtrntyp 	WHEN 'CAN' THEN admclicod + admacccod + admagrcod + admagrsfx END)+
		--Count(Distinct CASE admtrntyp 	WHEN 'REN' THEN admclicod + admacccod + admagrcod + admagrsfx END),0),
		NetAmount=Sum(Convert(float, ISNULL(disbursement_amount,0))),
--		GrossCount=ISNULL(Count(Distinct CASE WHEN admtrntyp='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx END),0),
		GrossCount=Sum(ISNULL(GrossCount,0)),
		GrossAmount=ISNULL(Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT
					THEN ISNULL(disbursement_amount,0) ELSE 0 END)),0)
					

FROM dbo.SAL002_Tier1_Sales_YTD Monthly
 			  
 Where ADMPSTDAT=@Period 
 GROUP  BY Monthly.ADMACCCOD, Dealer_Name,
		   Monthly.cprog, 
		   CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 'Issue' ELSE 
				  CASE WHEN ADMTRNTYP='CAN' THEN 'Canceled' ELSE 
				  CASE WHEN ADMTRNTYP='AMD' THEN 'Amended' ELSE 
				  CASE WHEN ADMTRNTYP='REN' THEN 'Reinstate' ELSE 'Amended' END END END END,
		   Monthly.Disbursement_Code,
		   Monthly.ProductType,
		   Monthly.ProductName,
		   Monthly.cprod
		   




GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Product_Contract_Count_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SSRS_SalesTier1_Product_Contract_Count_SEC]
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @Month Varchar(20)
Declare @Year Varchar(4)

--Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATENAME(mm, DATEPART(Month, dbo.GetCurrentPeriod()));

DECLARE @x AS TABLE 
  ( 
     product VARCHAR(50), 
     count   INT, 
     amount  float, 
     date    VARCHAR(50) 
  ); 

WITH 
a AS 
(
  SELECT Isnull(lob, 'No LOB') AS LOB,  efg_rep, Isnull(account_group, 'No Account Group') AS Account_Group, 
	  dealer_name, admtrntyp, admpstdat, ProductName, 
	  Count = Sum(ISNULL(NetCount,0)), 
	  Amount = Sum(Convert(float, ISNULL(NetAmount,0)))
  FROM   [dbo].[sal002_tier1_sales]
  GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, ProductName, admpstdat
)

INSERT INTO @x 
SELECT ProductName, Sum(count) AS Count, Sum(amount) AS Amount, 
       @Month
       + ',' 
       + @Year AS Date 
FROM   a 
GROUP  BY ProductName 

SELECT * 
FROM   @x  



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Report_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_Production_Report_SEC]
@LOB nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

DECLARE @x AS TABLE 
(LOB varchar(255), 
Account_Group varchar(255), 
EFG_Rep varchar(255), 
Dealer_Name varchar(255), 
Product_Category varchar(255), 
Product varchar(255), 
Count int, 
Amount float, 
PreYrAmount float); 


WITH a AS 
(SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account Group') AS Account_Group, 
		Dealer_Name, ADMTRNTYP, ProductType, ProductName, 
		
		Count=Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END),
		Amount=Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT
					THEN ISNULL(disbursement_amount,0) ELSE 0 END))
FROM [dbo].[SAL002_Tier1_Sales]
WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ProductType, ProductName
), 
b AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, ProductType, ProductName, SUM(count) AS Count, 
	SUM(Amount) AS Amount, 
	ISNULL(LOB, 'No LOB')+ ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name + ProductType + ProductName AS ID
  FROM            a
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ProductType, ProductName, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
      + EFG_Rep + Dealer_Name + ProductType + ProductName
), 
c AS
(SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account Group') AS Account_Group, 
	Dealer_Name, ADMTRNTYP, ProductType, ProductName, 
		Count=Count(DISTINCT CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN admclicod + admacccod + admagrcod + admagrsfx ELSE NULL END),
		Amount=Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT
					THEN ISNULL(disbursement_amount,0) ELSE 0 END)),
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name 
    + ProductType + ProductName + ADMTRNTYP AS ID
 FROM   [dbo].[SAL002_Tier1_Sales_YTD]
 WHERE SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) = @Month 
        AND SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) = @Year - 1
		AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
		AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
        
 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ProductType, ProductName, 
        ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
        + EFG_Rep + Dealer_Name + ProductType + ProductName
),
d AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, ProductType, ProductName, SUM(count) AS Count, 
		SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB')  + ISNULL(Account_Group, 'No Account Group') 
		+ EFG_Rep + Dealer_Name + ProductType + ProductName AS ID
  FROM c
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ProductType, ProductName, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
    + EFG_Rep + Dealer_Name + ProductType + ProductName)

INSERT INTO @x
SELECT DISTINCT  ISNULL(b.LOB, d .LOB), ISNULL(b.Account_Group, d.Account_Group), 
		ISNULL(b.EFG_Rep, D .EFG_Rep), ISNULL(b.Dealer_Name, D.Dealer_Name), 
        ISNULL(b.ProductType, D .ProductType), ISNULL(b.ProductName, D.ProductName),
        Sum(convert(float, isnull(b.Count,0))), sum(convert(float, isnull(b.amount,0))) AS Amount, sum(convert(float, isnull(d.Amount,0)))  AS PreYrAmount
FROM b 
FULL OUTER JOIN d ON b.ID = d.ID
GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, D .EFG_Rep, 
b.Dealer_Name, D.Dealer_Name, b.ProductType, D .ProductType, b.ProductName, D .ProductName

SELECT * FROM @x



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_by_Count_SEC]    Script Date: 01/17/2014 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_by_Count_SEC] 
@LOB varchar(320) = NULL,
@AccountGroup varchar(255)=NULL
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

DECLARE @x AS TABLE 
  ( 
     lob              VARCHAR(255), 
     account_group    VARCHAR(255), 
     efg_rep          VARCHAR(255), 
     dealer_name      VARCHAR(255), 
     product_category VARCHAR(255), 
     product          VARCHAR(255), 
     count            INT, 
     amount           float, 
     preyramount      float, 
     preyrcount       INT 
  ); 

WITH a 
     AS (SELECT Isnull(lob, 'No LOB')                                         AS
                 LOB, 
                efg_rep, 
                Isnull(account_group, 'No Account Group')                             AS
                    Account_Group, 
                dealer_name, 
                admtrntyp, 
                ProductType, 
                ProductName, 
                Count=Sum(ISNULL(GrossCount,0)),
				Amount=Sum(Convert(float, ISNULL(GrossAmount,0))) 
         FROM   [sal002_tier1_sales]
         WHERE ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
         AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   ProductType, 
                   ProductName
                   Having Sum(ISNULL(GrossCount,0))<>0 OR Sum(Convert(float, ISNULL(GrossAmount,0)))<>0), 
     b 
     AS (SELECT lob, 
                efg_rep, 
                account_group, 
                dealer_name, 
                ProductType, 
                ProductName, 
                Sum(count)                             AS Count, 
                Sum(amount)                            AS Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + ProductType + ProductName AS ID 
         FROM   a 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   ProductType, 
                   ProductName, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + ProductType + ProductName), 
     c 
     AS (SELECT Isnull(lob, 'No LOB')                                         AS
                 LOB, 
                efg_rep, 
                Isnull(account_group, 'No Account Group')                             AS
                    Account_Group, 
                dealer_name, 
                admtrntyp, 
                ProductType, 
                ProductName, 
                Count=Sum(ISNULL(GrossCount,0)),
				Amount=Sum(Convert(float, ISNULL(GrossAmount,0))),
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + ProductType + ProductName + admtrntyp            AS
                 ID 
         FROM   [dbo].[sal002_tier1_sales_ytd]
         WHERE  Substring(CONVERT(VARCHAR, admpstdat), 5, 2) =  @Month 
                AND Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year - 1 
             AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
             AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   ProductType, 
                   ProductName, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + ProductType + ProductName
                   Having Sum(ISNULL(GrossCount,0))<>0 OR Sum(Convert(float, ISNULL(GrossAmount,0)))<>0), 
     d 
     AS (SELECT lob, 
                efg_rep, 
                account_group, 
                dealer_name, 
                ProductType, 
                ProductName, 
                Sum(count)                             AS Count, 
                Sum(amount)                            AS Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + ProductType + ProductName AS ID 
         FROM   c 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   ProductType, 
                   ProductName, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + ProductType + ProductName) 
INSERT INTO @x 
SELECT DISTINCT Isnull(b.lob, d .lob), 
                Isnull(b.account_group, d .account_group), 
                Isnull(b.efg_rep, d .efg_rep), 
                Isnull(b.dealer_name, d .dealer_name), 
                Isnull(b.ProductType, d .ProductType), 
                Isnull(b.ProductName, d .ProductName), 
                Sum(ISNULL(b.count,0)), 
                Sum(ISNULL(b.amount,0))  AS Amount, 
                Sum(ISNULL(d.amount,0)) AS PreYrAmount, 
                Sum(ISNULL(d.count,0))  AS PreyrCount 
FROM   b 
       FULL OUTER JOIN d 
                    ON b.id = d .id 
GROUP  BY b.lob, 
          d.lob, 
          b.account_group, 
          d .account_group, 
          b.efg_rep, 
          d .efg_rep, 
          b.dealer_name, 
          d.dealer_name, 
          b.ProductType, 
          d.ProductType, 
          b.ProductName, 
          d.ProductName 

SELECT * 
FROM   @x  




GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue_SEC]
@LOB nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL

AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @x AS TABLE 
  ( lob VARCHAR(255), account_group VARCHAR(255), efg_rep VARCHAR(255), 
     dealer_name VARCHAR(255), product_category VARCHAR(255), product VARCHAR(255), 
     count INT, amount float, preyramount float
   );
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;
    
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

WITH a AS 
(SELECT Isnull(lob, 'No LOB') AS
   LOB, efg_rep, Isnull(account_group, 'No Account Group') AS Account_Group, 
   dealer_name,  admtrntyp, ProductType, ProductName, 
   	[Count]=SUM(ISNULL(NetCount,0)),
	Amount=Sum(Convert(float, ISNULL(NetAmount,0))) 
FROM   dbo.sal002_tier1_sales 
WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
	AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, ProductType, ProductName
 HAVING SUM(ISNULL(NetCount,0)) <> 0 OR Sum(Convert(float, ISNULL(NetAmount,0)))<>0                                 
), 
b AS 
(SELECT lob, 
   efg_rep, account_group, dealer_name, ProductType, ProductName,
   Sum(( CASE a.admtrntyp 
	WHEN 'CUR' THEN ( a.count ) 
    WHEN 'CAN' THEN -( a.count ) 
    WHEN 'REN' THEN ( a.count ) 
    ELSE 0 
    END ))AS Count, 
	Sum(amount) AS Amount,  
	Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep +
	dealer_name + ProductType + ProductName AS ID 
 FROM   a 
 WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
	AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
 GROUP  BY lob, efg_rep, account_group, dealer_name, ProductType, ProductName, 
                   Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') 
                   + efg_rep  + dealer_name + ProductType + ProductName

), 
c AS 
(SELECT Isnull(lob, 'No LOB')AS LOB, efg_rep, 
	Isnull(account_group, 'No Account Group') AS Account_Group, 
    dealer_name, admtrntyp, ProductType, ProductName, 
   	[Count]=SUM(ISNULL(NetCount,0)),
	Amount=Sum(Convert(float, ISNULL(NetAmount,0))),
    Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep +
    dealer_name + ProductType + ProductName + admtrntyp AS ID 
 FROM   sal002_tier1_sales_ytd 
 WHERE  Substring(CONVERT(VARCHAR, admpstdat), 5, 2) = @Month 
  AND Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year - 1 
  AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
  AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
  
  GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, ProductType, ProductName,
   Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + ProductType + ProductName
  HAVING      SUM(ISNULL(NetCount,0)) <> 0 OR Sum(Convert(float, ISNULL(NetAmount,0)))<>0              
),
d AS 
(SELECT lob, efg_rep, account_group, dealer_name, ProductType, ProductName, 
  Sum(( CASE c.admtrntyp 
           WHEN 'CUR' THEN ( c.count ) 
           WHEN 'CAN' THEN -( c.count ) 
           WHEN 'REN' THEN ( c.count ) 
           ELSE 0 
           END ))AS Count, 
  Sum(amount) AS Amount,  
  Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
  + dealer_name + ProductType + ProductName AS ID 
 FROM   c 
 WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
  AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group')) 
 GROUP  BY lob, efg_rep, account_group, dealer_name,  ProductType, ProductName, 
        Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + ProductType + ProductName) 
INSERT INTO @x 
SELECT DISTINCT Isnull(b.lob, d.lob), 
                Isnull(b.account_group, d.account_group), 
                Isnull(b.efg_rep, d.efg_rep), 
                Isnull(b.dealer_name, d.dealer_name), 
                Isnull(b.ProductType, d.ProductType), 
                Isnull(b.ProductName, d.ProductName), 
                Sum(ISNULL(b.count,0)), 
                Sum(ISNULL(b.amount,0))  AS Amount, 
                Sum(ISNULL(d.amount,0)) AS PreYrAmount 
FROM   b 
       FULL OUTER JOIN d ON b.id = d.id 
GROUP BY b.lob, d.lob, b.account_group, d.account_group, b.efg_rep, d.efg_rep, 
b.dealer_name, d.dealer_name, b.ProductType, d.ProductType, b.ProductName, d.ProductName 
SELECT * FROM   @x  



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_ProductType_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SSRS_SalesTier1_ProductType_SEC]
@Period int=0

-- [SSRS_SalesTier1_PremiumSummary] 0
AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());
SELECT	
		ProductName,
		ProductType,
		cprog Program,
		NetCount=Sum(NetCount),
		NetAmount=Sum(Convert(float, ISNULL(disbursement_amount,0))),
		GrossCount=Sum(GrossCount),
		GrossAmount=ISNULL(Sum(Convert(float, CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT
					THEN ISNULL(disbursement_amount,0) ELSE 0 END)),0)
					

FROM dbo.SAL002_Tier1_Sales_YTD Monthly
 			  
 Where ADMPSTDAT=@Period 
 GROUP  BY Monthly.cprog,
		   Monthly.ProductType,
		   Monthly.ProductName
		   



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_ProductTypeDetail_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SSRS_SalesTier1_ProductTypeDetail_SEC]
@Period int=0,
@ProductType varchar(50)=NULL,
@ProductName varchar(50)=NULL
-- [SSRS_SalesTier1_PremiumSummary] 0
AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

SELECT	*, ContractStatus=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 'Issue' ELSE 
				  CASE WHEN ADMTRNTYP='CAN' THEN 'Canceled' ELSE 
				  CASE WHEN ADMTRNTYP='AMD' THEN 'Amended' ELSE 
				  CASE WHEN ADMTRNTYP='REN' THEN 'Reinstate' ELSE 'Amended' END END END END

FROM dbo.SAL002_Tier1_Sales_YTD
 			  
Where ADMPSTDAT=@Period AND ProductType=ISNULL(@ProductType, ProductType) AND ProductName= ISNULL(@ProductName, ProductName)
 		   



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_By_Channel_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_Revenue_By_Channel_SEC]
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATENAME(mm, DATEPART(Month, dbo.GetCurrentPeriod()));

SELECT Isnull(lob, 'NO LOB') AS LOB, 
       Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, 
       @Month
       + ',' 
       + @Year as Date
FROM   sal002_tier1_sales 
GROUP  BY lob  



GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_Trend_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SSRS_SalesTier1_Revenue_Trend_SEC]
@LOB varchar(255)= NULL,
@EFGRep varchar(255)=NULL,
@AccountGroup varchar(255)=NULL,
@Account varchar(255)=NULL,
@Product varchar(255)=NULL
/*

Declare @LOB varchar(255)= 'Agency Services',
@EFGRep varchar(255)='Adam Ouart',
@AccountGroup varchar(255)='No Account Group',
@Account varchar(255)='Peters Honda of Nashua',
@Product varchar(255)='GAP'

EXEC SSRS_SalesTier1_Revenue_Trend 'Agency Services', 'Adam Ouart', 'No Account Group', 'Peters Honda of Nashua', 'GAP'


SSRS_SalesTier1_Revenue_Trend 'Agency Services', 'Adam Ouart', 'No Account Group', 'Peters Honda of Nashua', 'GAP'
SSRS_SalesTier1_Revenue_Trend 'No LOB'
SSRS_SalesTier1_Revenue_Trend @EFGRep='No Rep'
SSRS_SalesTier1_Revenue_Trend @AccountGroup='No Account Group'
SSRS_SalesTier1_Revenue_Trend @Account='No Account'
SSRS_SalesTier1_Revenue_Trend @Product = 'No Product'

*/
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int
SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());


If ISNULL(@Product,'')='' 
Begin
 SELECT Isnull(lob, 'No LOB') AS lob, isnull(efg_rep, 'No Rep') as efg_rep, Isnull(account_group, 'No Account Group') AS  account_group, 
            ISNULL(Dealer_Name, 'No Account') as dealer_name, 
            ISNULL(ProductName, 'No Product') as Product,
            0 As CanFeeCount,
			[Count]=SUM(ISNULL(NetCount,0)),            
            Amount=Sum(Convert(float, ISNULL(NetAmount,0))),             
            MONTHDT=CASE 
                      WHEN admpstdat = 0 THEN @Month
                      ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                    END,             
            CASE admtrntyp 
				 WHEN 'CAN' THEN 'Cancellations' 
				 WHEN 'CUR' THEN 'Current' 
				 WHEN 'REN' THEN 'Reinstatements' 
				 WHEN 'AMD' THEN 'Amendments' 
	       END AS ADMTRNTYP
	       
     FROM   [sal002_tier1_sales_ytd] 
     WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year 
			OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0 )
		AND isnull(lob, 'No LOB') = ISNULL(@LOB, isnull(lob, 'No LOB'))				
		AND Isnull(EFG_Rep, 'No Rep') = ISNULL(@EFGRep, isnull(EFG_Rep, 'No Rep'))
		AND Isnull(Account_Group, 'No Account Group') = ISNULL(@AccountGroup, isnull(Account_Group, 'No Account Group'))
		AND Isnull(Dealer_Name, 'No Account') = ISNULL(@Account, isnull(Dealer_Name, 'No Account'))
		AND Isnull(ProductName, 'No Product') = ISNULL(@Product, isnull(ProductName, 'No Product'))
     GROUP  BY lob, efg_rep, account_group, dealer_name, ProductName, admpstdat,admtrntyp
     ORDER BY lob, efg_rep, account_group, dealer_name, ProductName, admtrntyp,monthdt
     
     
End
Else
Begin
SELECT Isnull(lob, 'No LOB') AS lob, isnull(efg_rep, 'No Rep') as efg_rep, Isnull(account_group, 'No Account Group') AS  account_group, 
            ISNULL(Dealer_Name, 'No Account') as dealer_name, 
            ISNULL(ProductName, 'No Product') as Product,
            0 As CanFeeCount,
            [Count]=SUM(ISNULL(NetCount, 0)),
            Amount=Sum(Convert(float, ISNULL(NetAmount,0))),
            MONTHDT=CASE 
                      WHEN admpstdat = 0 THEN @Month
                      ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                    END,             
            CASE admtrntyp 
				 WHEN 'CAN' THEN 'Cancellations' 
				 WHEN 'CUR' THEN 'Current' 
				 WHEN 'REN' THEN 'Reinstatements' 
				 WHEN 'AMD' THEN 'Amendments' 
	       END AS ADMTRNTYP
	       
     FROM   [sal002_tier1_sales_ytd] 
     WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year 
			OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0 )
		AND isnull(lob, 'No LOB') = ISNULL(@LOB, isnull(lob, 'No LOB'))				
		AND Isnull(EFG_Rep, 'No Rep') = ISNULL(@EFGRep, isnull(EFG_Rep, 'No Rep'))
		AND Isnull(Account_Group, 'No Account Group') = ISNULL(@AccountGroup, isnull(Account_Group, 'No Account Group'))
		AND Isnull(Dealer_Name, 'No Account') = ISNULL(@Account, isnull(Dealer_Name, 'No Account'))
		AND Isnull(ProductName, 'No Product') = ISNULL(@Product, isnull(ProductName, 'No Product'))
		AND Disbursement_Code<>'CANCELFEE'
     GROUP  BY lob, efg_rep, account_group, dealer_name, ProductName, admpstdat,admtrntyp
    UNION
	SELECT Isnull(lob, 'No LOB') AS lob, isnull(efg_rep, 'No Rep') as efg_rep, Isnull(account_group, 'No Account Group') AS  account_group, 
            ISNULL(Dealer_Name, 'No Account') as dealer_name, 
            ISNULL(ProductName, 'No Product') as Product,
			Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx)  as CanFeeCount,
			0 as Count,
            Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount,             
            MONTHDT=CASE 
                      WHEN admpstdat = 0 THEN @Month
                      ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                    END,             
            CASE admtrntyp 
				 WHEN 'CAN' THEN 'CancelFee' 
				 WHEN 'CUR' THEN 'Current' 
				 WHEN 'REN' THEN 'Reinstatements' 
				 WHEN 'AMD' THEN 'Amendments' 
	       END AS ADMTRNTYP
	       
     FROM   [sal002_tier1_sales_ytd] 
     WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year 
			OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0 )
		AND isnull(lob, 'No LOB') = ISNULL(@LOB, isnull(lob, 'No LOB'))				
		AND Isnull(EFG_Rep, 'No Rep') = ISNULL(@EFGRep, isnull(EFG_Rep, 'No Rep'))
		AND Isnull(Account_Group, 'No Account Group') = ISNULL(@AccountGroup, isnull(Account_Group, 'No Account Group'))
		AND Isnull(Dealer_Name, 'No Account') = ISNULL(@Account, isnull(Dealer_Name, 'No Account'))
		AND Isnull(ProductName, 'No Product') = ISNULL(@Product, isnull(ProductName, 'No Product'))
		AND Disbursement_Code='CANCELFEE' AND ADMTRNTYP='CAN'
     GROUP  BY lob, efg_rep, account_group, dealer_name, ProductName, admpstdat,admtrntyp
     
    ORDER BY lob, efg_rep, account_group, dealer_name, Product, admtrntyp,monthdt
     
End     






GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC]    Script Date: 01/17/2014 09:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB_SEC]
AS
Declare @Month int
Declare @Year int
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
--From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT @Year=DATEPART(Year, dbo.GetCurrentPeriod()), @Month=DATEPART(Month, dbo.GetCurrentPeriod());

SELECT *, 
       Isnull ((SELECT Sum(Convert(float, ISNULL(disbursement_amount,0))) 
                FROM   dbo.sal002_tier1_sales_ytd 
                WHERE  lob = tblreport.lob 
                       AND Substring(( CONVERT(VARCHAR(50), admpstdat) ), 5, 2) = @Month
                       AND Substring(( CONVERT(VARCHAR(50), admpstdat) ), 0, 5) = (@Year - 1 )), 0) AS 'PriorMonth', 
                       Convert(DateTime, '01/'+convert(varchar, @Month)+'/'+convert(varchar, @Year)) AS 'CurrentDate' 
			  FROM   (SELECT lob, 
               Isnull([baseadmin], 0) AS 'Admin', 
               Isnull([roadadmin], 0) AS 'Roadside', 
               Isnull([excins], 0)    AS 'ExcessReserve', 
               Isnull([asgdfadm], 0)  AS 'DeferredAdmin', 
               Isnull([okwaract], 0)  AS 'OKWARACT', 
               Isnull([rasadmin], 0)  AS 'RASADMIN', 
               Isnull([repof], 0)     AS 'REPOF', 
               Isnull([cancelfee], 0) AS 'CANCELFEE', 
               Isnull([claimresv], 0) AS 'CLAIMRESV', 
               Isnull([cedingfee], 0) AS 'CEDINGFEE', 
               Isnull([efgadmin], 0)  AS 'EFGADMIN' 
        FROM   (SELECT lob, 
                       disbursement_code, 
                       Convert(float, ISNULL(disbursement_amount,0)) AS disbursement_amount
                FROM   dbo.sal002_tier1_sales) p 
               PIVOT (Sum(disbursement_amount) 
                     FOR disbursement_code IN ([BASEADMIN], 
                                               [ROADADMIN], 
                                               [EXCINS], 
                                               [ASGDFADM], 
                                               [OKWARACT], 
                                               [RASADMIN], 
                                               [REPOF], 
                                               [CANCELFEE], 
                                               [CLAIMRESV], 
                                               [CEDINGFEE], 
                                               [EFGADMIN])) AS pvt) AS tblreport  
ORDER by lob


GO


