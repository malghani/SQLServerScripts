SET NOCOUNT ON;
SET NOEXEC OFF;
GO
if NOT Exists(Select * from sys.objects where name='sal002_tier1_sales') OR ((select DB_ID())<=4)
	PRINT 'WRONG DATABASE HAS CHOSEN TO RUN CREATE STORED PROCEDURES. YOU ARE USING UNEXPECTED DATABASE ['+DB_NAME()+']. PLEASE CHOOSE YOUR TARGET DATABASE.'
GO
if NOT Exists(Select * from sys.objects where name='sal002_tier1_sales') OR ((select DB_ID())<=4)
	SET NOEXEC ON;
else
    SET NOEXEC OFF;
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Product_Contract_Count]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Product_Contract_Count]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Product_Contract_Count]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Report]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Report]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Report]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_by_Count]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Variance_by_Count]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_by_Count]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_By_Channel]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Revenue_By_Channel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Revenue_By_Channel]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_Trend]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Revenue_Trend]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Revenue_Trend]
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]    Script Date: 10/07/2013 15:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]
GO


/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]    Script Date: 10/07/2013 15:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]
@Cat nvarchar(320)=NULL
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- EXEC SSRS_SalesTier1_Channel_Revenue_By_Product 'No Category'
Declare @Month Varchar(20)
Declare @Year Varchar(4)

Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth



SELECT Isnull(super_category, 'No Category') 
              AS 
              Product_Category, 
              Isnull(cprod, 'No Product') 
              AS Product, 
              Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, 
              @Month
              + ',' 
              + @Year
              AS 
              Date 
         FROM   dbo.sal002_tier1_sales 
         WHERE Isnull(super_category, 'No Category') = ISNULL(@Cat, ISNULL(Product_Category, 'No Category'))
         GROUP  BY super_category, cprod
         HAVING Sum(ISNULL(disbursement_amount,0)) <> 0
         

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]    Script Date: 10/07/2013 15:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)

Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT Isnull(super_category, 'No Category') 
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
         GROUP  BY super_category
         HAVING  Sum(isnull(disbursement_amount,0)) <> 0
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]    Script Date: 10/07/2013 15:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]
@GroupOn int=0 
--  0 = LOB
--  1 = LOB, EFG_Rep
--  2 = LOB, Account_Group, EFG_Rep, 
AS
DECLARE @y TABLE 
  ( 
     Account_Group varchar(255),
     EFG_Rep varchar(255),
     LOB    VARCHAR(255), 
     Amount float
  ) 
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


IF @GroupOn = 0 
Begin
		INSERT INTO @y (lob, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
			   Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 		
		WHERE  CAST(Substring(Cast(admpstdat AS VARCHAR), 5, 2) AS INT) = @Month
			    AND CAST(Substring(Cast(admpstdat AS VARCHAR), 0, 5) AS INT) = @Year-1
		        
		GROUP  BY lob
		SELECT LOB, Amount 
		FROM   @y  		
End 
ELSE IF @GroupOn = 1
Begin
		INSERT INTO @y (LOB, EFG_Rep, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
				EFG_Rep,
			   Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  CAST(Substring(Cast(admpstdat AS VARCHAR), 5, 2) AS INT) = @Month
			    AND CAST(Substring(Cast(admpstdat AS VARCHAR), 0, 5) AS INT) = @Year-1
		GROUP  BY LOB, EFG_Rep
		SELECT LOB, EFG_Rep, Amount 
		FROM   @y  
		
End
ELSE IF @GroupOn = 2
Begin
		INSERT INTO @y (lob, EFG_Rep, Account_Group, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
				EFG_Rep,
				Account_Group,
			   Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  CAST(Substring(Cast(admpstdat AS VARCHAR), 5, 2) AS INT) = @Month
			    AND CAST(Substring(Cast(admpstdat AS VARCHAR), 0, 5) AS INT) = @Year-1
		GROUP  BY LOB, Account_Group, EFG_Rep
		SELECT LOB, Account_Group, EFG_Rep, Amount 
		FROM   @y  
		Return
End


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]    Script Date: 10/07/2013 15:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]
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
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Dealer Services', @EFG_Rep='Paul Roberts', @AccountGroup='Billion Auto Group'
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

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


SELECT	lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		cprod=ISNULL(cprod, 'No Product'), 
		monthdt= convert(int, CASE 
				WHEN admpstdat = 0 THEN @Month
				ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
				END),								   
		[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),
		Amount=Sum(Convert(float, CASE WHEN ISNULL(disbursement_amount,0) >= 0 
					THEN ISNULL(disbursement_amount,0) ELSE 0 END)),
		[year]=convert(int, CASE 
			  WHEN admpstdat = 0 THEN @Year
				ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
				END)
				,
		id=Isnull(lob, 'No LOB') + '-' + Isnull(account_group, 'No Account Group')
		+ '-' + Isnull(efg_rep,'No Rep') +  '-' + Isnull(dealer_name, 'No Account') + '-' + Isnull(cprod, 'No Product'),
		CurrentMonth=@Month,
		CurrentYear=@Year
 FROM   dbo.sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 GROUP  BY lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   cprod,
		   CASE 
			WHEN admpstdat = 0 THEN @Month
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN @Year
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END  ,
		admpstdat


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]    Script Date: 10/07/2013 15:26:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]
AS
DECLARE @x AS TABLE 
	(LOB varchar(255),  Account_Group varchar(255), 
	EFG_Rep varchar(255), Dealer_Name varchar(255), 
	Product_Category varchar(255), Product varchar(255), 
	Count int, Amount float, PreYrAmount float, PreYrCount int); 

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;


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

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod] 
@LOB nvarchar(320),
@Cat nvarchar(320)
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)

Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

-- SSRS_SalesTier1_LOB_Revenue_By_Prod 'Agency Services', 'AM'
SELECT 
  ISNULL(LOB, 'No LOB') AS LOB, 
  Super_Category AS Product_Category,
  ISNULL(cprod, 'No Product') AS cprod,
  SUM(Convert(float, ISNULL(disbursement_amount,0))) AS Amount,
  @Month + ',' + 
  @Year AS Date
 FROM dbo.SAL002_Tier1_Sales
 WHERE ISNULL(LOB, 'No LOB')= @LOB
 AND Super_Category = @Cat
 GROUP BY LOB, Super_Category, cprod
 HAVING SUM(ISNULL(Disbursement_Amount,0))<>0

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]
AS

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT ISNULL(LOB,'No LOB') as LOB,
SUM(CASE
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year 
       OR ADMPSTDAT = 0) 
	THEN Convert(float, ISNULL(disbursement_amount,0)) else 0 End) as Amount_MTD,
SUM(CASE 
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5))=@Year-1
	THEN Convert(float, ISNULL(disbursement_amount,0)) else 0 End) AS Amount_PRM
FROM  dbo.SAL002_Tier1_Sales_YTD
WHERE 
( ADMPSTDAT = 0 OR 
	(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year-1 
	AND  
	SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5,2)=@Month)
)	
GROUP by LOB
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]
@LOB nvarchar(320) = NULL, 
@AccountGroup nvarchar(320) = NULL
AS
-- SSRS_SalesTier1_LOB_Revenue_Trend 'Dealer Services', 'Parkway Group'
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;

WITH a 
     AS (SELECT Isnull(lob, 'No LOB')                                        AS 
                LOB, 
                efg_rep, 
                Isnull(account_group, 'No Account Group')                    AS 
                   Account_Group, 
                dealer_name, 
                admtrntyp, 
                MonthDT=CASE 
                          WHEN admpstdat = 0 THEN @Month 
                          ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                        END, 
                admpstdat, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx)AS 
                Count 
                , 
                Sum(Convert(float, ISNULL(disbursement_amount,0))) 
                AS Amount 
         FROM   [dbo].[sal002_tier1_sales_ytd] 
         WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) =  @Year 
                 OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0)
                 AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
                 AND ISNULL(@AccountGroup, 'No Account Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account Group'))
                 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   cprod, 
                   admpstdat), 
     b 
     AS (SELECT lob, 
                efg_rep, 
                account_group, 
                dealer_name, 
                cprod, 
                monthdt, 
                Sum(( CASE a.admtrntyp 
                        WHEN 'CUR' THEN ( a.count ) 
                        WHEN 'CAN' THEN -( a.count ) 
                        WHEN 'REN' THEN ( a.count ) 
                        ELSE 0 
                      END ))                    AS Count, 
                Sum(amount)                     AS Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') 
                + efg_rep + dealer_name + cprod 
                + Cast(monthdt AS VARCHAR(100)) AS ID 
         FROM   a 
         WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         AND ISNULL(@AccountGroup, 'No Account Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account Group'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   cprod, 
                   monthdt, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') 
                   + efg_rep + dealer_name + cprod), 
     c 
     AS (SELECT lob, 
                Isnull(account_group, 'No Account Group')AS Account_Group, 
                efg_rep, 
                dealer_name, 
                product, 
                Sum(plan_revenue)                        AS Revenue, 
                Sum(plan_count)                          AS Count, 
                month, 
                year, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') 
                + efg_rep + dealer_name + product        AS ID 
         FROM   [dbo].[sal002_tier1_sales_plan] 
         WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         AND ISNULL(@AccountGroup, 'No Account Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account Group'))
         GROUP  BY lob, 
                   account_group, 
                   efg_rep, 
                   dealer_name, 
                   product, 
                   month, 
                   year, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') 
                   + efg_rep + dealer_name + product 
                   + Cast(month AS VARCHAR(100))) 
SELECT Isnull(b.lob, c.lob)                     AS LOB, 
       Isnull(b.account_group, c.account_group) AS Account_Group, 
       Isnull(b.efg_rep, c.efg_rep)             AS EFG_Rep, 
       Isnull(b.dealer_name, c.dealer_name)     AS Dealer_Name, 
       Isnull(b.cprod, c.product)               AS Product, 
       Sum(b.amount)                            AS Amount, 
       Sum(c.revenue)                           AS planrevenue, 
       Sum(b.count)                             AS Count, 
       Sum(c.count)                             AS Plancount, 
       Isnull(b.monthdt, c.month)               AS MONTHDT 
FROM   b 
       FULL OUTER JOIN c 
                    ON b.id = c.id 
GROUP  BY b.lob, 
          c.lob, 
          b.account_group, 
          c.account_group, 
          b.efg_rep, 
          c.efg_rep, 
          b.dealer_name, 
          c.dealer_name, 
          b.cprod, 
          c.product, 
          b.monthdt, 
          c.month  
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]
@LOB nvarchar(320),
@efg_rep nvarchar(320),
@Account_Group nvarchar(320)
AS
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

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
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX)
			 End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Convert(float, ISNULL(disbursement_amount,0))>=0 then Convert(float, ISNULL(disbursement_amount,0)) else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Convert(float, ISNULL(disbursement_amount,0))>=0) then Convert(float, ISNULL(disbursement_amount,0))
			else 0 end) as Amount_Month
      from  [dbo].[SAL002_Tier1_Sales_YTD]
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
	  
      from  [dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=@Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]
@LOB nvarchar(320),
@efg_rep nvarchar(320)
AS
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

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
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Convert(float, ISNULL(disbursement_amount,0))>=0 then Convert(float, ISNULL(disbursement_amount,0)) else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Convert(float, ISNULL(disbursement_amount,0))>=0) then Convert(float, ISNULL(disbursement_amount,0)) else 0 end) as Amount_Month 
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
      Where [Year] <=@Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
      Group By LOB,EFG_Rep,Account_group
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  AND finaldata.Account_Group=finalplan.Account_Group		


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]
@LOB nvarchar(320),
@efg_rep nvarchar(320),
@Account_Group nvarchar(320),
@Dealer_name nvarchar(320)
AS
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

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
      ,isnull(cprod, 'No Product') as cprod
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Convert(float, ISNULL(disbursement_amount,0))>=0 then Convert(float, ISNULL(disbursement_amount,0)) else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Convert(float, ISNULL(disbursement_amount,0))>=0) then Convert(float, ISNULL(disbursement_amount,0)) else 0 end) as Amount_Month

 
      from  [dbo].[SAL002_Tier1_Sales_YTD]
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=@Year OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
	  and isNull(Dealer_Name, 'No Account')  = @dealer_name
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
      ,cprod
 
)
 AS FinalData 
 Full Outer Join 
(	   select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      isNull(Account_Group, 'No Account Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=@Month ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=@Month then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=@Year
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Account Group') = @account_group
	  and isNull(Dealer_Name, 'No Account') = @dealer_name
	  
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
      ,product
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name
      AND finaldata.cprod= finalplan.product


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]
@LOB nvarchar(320) 
AS
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


Select isNull(final_data.LOB,finalplan.LOB) as LOB ,isnull(final_data.Efg_Rep,finalplan.EFG_Rep) as EFG_REp, 
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD 
From 
(select isNull(LOB,'No LOB') as LOB,EFG_Rep
  ,count(distinct(case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
  ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
  ,sum(case when Convert(float, ISNULL(disbursement_amount,0))>=0 then Convert(float, ISNULL(disbursement_amount,0)) else 0 End)'Amount_YTD'
  ,sum( case when (ADMPSTDAT=0 and Convert(float, ISNULL(disbursement_amount,0))>=0) then Convert(float, ISNULL(disbursement_amount,0)) else 0 end) as Amount_Month 
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
      Where [Year] <=@Year
      and isNull(LOB,'No LOB') = @LOB
	  Group By LOB,EFG_Rep
) AS finalplan ON finalplan.LOB=final_data.LOB AND finalplan.EFG_Rep=final_data.EFG_Rep 


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]
@LOB nvarchar(320)=NULL,
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL

AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT	lob=ISNULL(Monthly.lob, 'No LOB'),
		efg_rep=ISNULL(Monthly.efg_rep, 'NO Rep'), 
		account_group=ISNULL(Monthly.Account_Group, 'No Account Group'), 
		dealer_name=ISNULL(Monthly.dealer_name, 'No Account'), 
		cprod=ISNULL(Monthly.cprod, 'No Product'), 
		monthdt= convert(int, CASE 
			WHEN admpstdat = 0 THEN @Month 
			ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
			END),								   
		[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),
		YearCount = MAX(YearCount),
		Amount=Sum(Convert(float, ISNULL(disbursement_amount,0))),
		[year]=Convert(int, CASE 
			 WHEN admpstdat = 0 THEN @Year 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
			END),
		CurrentYear=@Year,
		CurrentMonth=@Month
				,
	id=Isnull(Monthly.lob, 'No LOB') + '-' + Isnull(Monthly.account_group, 'No Account Group')
		+ '-' + Isnull(Monthly.efg_rep,'No Rep') +  '-' + Isnull(Monthly.dealer_name, 'No Account') + '-' + Isnull(Monthly.cprod, 'No Product')
 FROM   [dbo].[sal002_tier1_sales_ytd] Monthly
 INNER JOIN (
				 select	   lob=ISNULL(lob, 'No LOB'),
						   efg_rep=ISNULL(efg_rep, 'NO Rep'), 
						   account_group=ISNULL(Account_Group, 'No Account Group'), 
						   dealer_name=ISNULL(dealer_name, 'No Account'), 
						   cprod=ISNULL(cprod, 'No Product'),
						   [year]=Convert(int, CASE 
										 WHEN admpstdat = 0 THEN @Year 
										ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
										END),
						   YearCount=COUNT(Distinct admclicod + admacccod + admagrcod + admagrsfx)						   
				FROM [dbo].[sal002_tier1_sales_ytd]
				Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
				 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
				 AND ISNULL(account_group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account Group'))
				 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
				group by lob, efg_rep,
						   account_group, 
						   dealer_name, 
						   cprod,
						   Convert(int, CASE 
										 WHEN admpstdat = 0 THEN @Year 
										ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
										END)
			) AS Yearly ON Yearly.lob=Monthly.lob And Yearly.efg_rep=Monthly.efg_rep
			  And Yearly.dealer_name=Monthly.dealer_name and Yearly.cprod=Monthly.cprod
			  And Yearly.[year]=Convert(int, CASE 
									WHEN monthly.admpstdat = 0 THEN @Year 
									ELSE Substring(CONVERT(VARCHAR, monthly.admpstdat), 0, 5)
									END)
			  
 Where ISNULL(Monthly.lob,'No LOB')=ISNULL(@LOB, ISNULL(Monthly.lob, 'No LOB'))
 AND ISNULL(Monthly.efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(Monthly.efg_rep, 'No Rep')) 
 AND ISNULL(Monthly.Account_Group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(Monthly.account_group, 'No Account Group'))
 AND ISNULL(Monthly.Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Monthly.Dealer_Name, 'No Account'))
 GROUP  BY Monthly.lob, 
		   Monthly.efg_rep, 
		   Monthly.account_group, 
		   Monthly.dealer_name, 
		   Monthly.cprod,
		   CASE 
			WHEN admpstdat = 0 THEN @Month
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN @Year
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END,
		admpstdat
Order By 		
Monthly.lob, 
Monthly.efg_rep, 
Monthly.account_group, 
Monthly.dealer_name, 
Monthly.cprod, 
monthdt
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Product_Contract_Count]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Product_Contract_Count]
AS

Declare @Month Varchar(20)
Declare @Year Varchar(4)

Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


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
	  dealer_name, admtrntyp, admpstdat, cprod, 
	  Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS Count, Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount 
  FROM   [dbo].[sal002_tier1_sales]
  GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, cprod, admpstdat
), 
b AS 
(
   SELECT lob, efg_rep, account_group, dealer_name, cprod, 
	  Sum(( CASE a.admtrntyp 
		WHEN 'CUR' THEN ( a.count ) 
        WHEN 'CAN' THEN -( a.count ) 
        WHEN 'REN' THEN ( a.count ) 
        ELSE 0 
        END )) AS Count, 
      Sum(amount)  AS Amount 
   FROM   a 
   GROUP  BY lob, efg_rep, account_group, dealer_name, cprod) 
INSERT INTO @x 
SELECT cprod, Sum(count) AS Count, Sum(amount) AS Amount, 
       @Month
       + ',' 
       + @Year AS Date 
FROM   b 
GROUP  BY cprod 

SELECT * 
FROM   @x  
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Report]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Production_Report]
@LOB nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL
AS

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

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
		Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
		COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count,
		SUM(CASE WHEN Convert(float, ISNULL(disbursement_amount,0)) >= 0 THEN Convert(float, ISNULL(disbursement_amount,0)) ELSE 0 END) AS Amount
FROM [dbo].[SAL002_Tier1_Sales]
WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod
), 
b AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(count) AS Count, 
	SUM(Amount) AS Amount, 
	ISNULL(LOB, 'No LOB')+ ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
  FROM            a
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
      + EFG_Rep + Dealer_Name + Super_Category + cprod
), 
c AS
(SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account Group') AS Account_Group, 
	Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
    SUM(CASE WHEN Convert(float, ISNULL(disbursement_amount,0)) >= 0 THEN Convert(float, ISNULL(disbursement_amount,0)) ELSE 0 END) AS Amount, 
    ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') + EFG_Rep + Dealer_Name 
    + Super_Category + cprod + ADMTRNTYP AS ID
 FROM   [dbo].[SAL002_Tier1_Sales_YTD]
 WHERE SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) = @Month 
        AND SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) = @Year - 1
		AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
		AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
        
 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
        ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
        + EFG_Rep + Dealer_Name + Super_Category + cprod
),
d AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(count) AS Count, 
		SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB')  + ISNULL(Account_Group, 'No Account Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
  FROM c
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account Group') 
    + EFG_Rep + Dealer_Name + Super_Category + cprod)

INSERT INTO @x
SELECT DISTINCT  ISNULL(b.LOB, d .LOB), ISNULL(b.Account_Group, d .Account_Group), 
		ISNULL(b.EFG_Rep, D .EFG_Rep), ISNULL(b.Dealer_Name, D .Dealer_Name), 
        ISNULL(b.Super_Category, D .Super_Category), ISNULL(b.cprod, D .cprod),
        Sum(b.Count), sum(b.amount) AS Amount, sum(d .Amount)  AS PreYrAmount
FROM b 
FULL OUTER JOIN d ON b.ID = d .ID
GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, D .EFG_Rep, 
b.Dealer_Name, D.Dealer_Name, b.Super_Category, D .Super_Category, b.cprod, D .cprod

SELECT * FROM @x
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_by_Count]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_by_Count] 
@LOB varchar(320) = NULL,
@AccountGroup varchar(255)=NULL
AS

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;


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
                super_category, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS
                 Count, 
                Sum(Convert(float, ISNULL(disbursement_amount,0)))                                      AS
                 Amount 
         FROM   [dbo].[sal002_tier1_sales]
         WHERE ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
         AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   super_category, 
                   cprod), 
     b 
     AS (SELECT lob, 
                efg_rep, 
                account_group, 
                dealer_name, 
                super_category, 
                cprod, 
                Sum(count)                             AS Count, 
                Sum(amount)                            AS Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + super_category + cprod AS ID 
         FROM   a 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + super_category + cprod), 
     c 
     AS (SELECT Isnull(lob, 'No LOB')                                         AS
                 LOB, 
                efg_rep, 
                Isnull(account_group, 'No Account Group')                             AS
                    Account_Group, 
                dealer_name, 
                admtrntyp, 
                super_category, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS
                 Count, 
                Sum(Convert(float, ISNULL(disbursement_amount,0)))			AS
                 Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + super_category + cprod + admtrntyp            AS
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
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + super_category + cprod), 
     d 
     AS (SELECT lob, 
                efg_rep, 
                account_group, 
                dealer_name, 
                super_category, 
                cprod, 
                Sum(count)                             AS Count, 
                Sum(amount)                            AS Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account Group') + efg_rep 
                + dealer_name + super_category + cprod AS ID 
         FROM   c 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + super_category + cprod) 
INSERT INTO @x 
SELECT DISTINCT Isnull(b.lob, d .lob), 
                Isnull(b.account_group, d .account_group), 
                Isnull(b.efg_rep, d .efg_rep), 
                Isnull(b.dealer_name, d .dealer_name), 
                Isnull(b.super_category, d .super_category), 
                Isnull(b.cprod, d .cprod), 
                Sum(b.count), 
                Sum(b.amount)  AS Amount, 
                Sum(d.amount) AS PreYrAmount, 
                Sum(d.count)  AS PreyrCount 
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
          b.super_category, 
          d .super_category, 
          b.cprod, 
          d .cprod 

SELECT * 
FROM   @x  

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Production_Variance_By_Revenue]
@LOB nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL

AS

DECLARE @x AS TABLE 
  ( lob VARCHAR(255), account_group VARCHAR(255), efg_rep VARCHAR(255), 
     dealer_name VARCHAR(255), product_category VARCHAR(255), product VARCHAR(255), 
     count INT, amount float, preyramount float
   );
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth;
    

WITH a AS 
(SELECT Isnull(lob, 'No LOB') AS
   LOB, efg_rep, Isnull(account_group, 'No Account Group') AS Account_Group, 
   dealer_name,  admtrntyp, super_category, cprod, 
   Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS Count, 
   Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount 
FROM   dbo.sal002_tier1_sales 
WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
	AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, super_category, cprod
), 
b AS 
(SELECT lob, 
   efg_rep, account_group, dealer_name, super_category, cprod, 
   Sum(( CASE a.admtrntyp 
	WHEN 'CUR' THEN ( a.count ) 
    WHEN 'CAN' THEN -( a.count ) 
    WHEN 'REN' THEN ( a.count ) 
    ELSE 0 
    END ))AS Count, 
	Sum(amount) AS Amount,  
	Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep +
	dealer_name + super_category + cprod AS ID 
 FROM   a 
 WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
	AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
 GROUP  BY lob, efg_rep, account_group, dealer_name, super_category, cprod, 
                   Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') 
                   + efg_rep  + dealer_name + super_category + cprod
), 
c AS 
(SELECT Isnull(lob, 'No LOB')AS LOB, efg_rep, 
	Isnull(account_group, 'No Account Group') AS Account_Group, 
    dealer_name, admtrntyp, super_category, cprod, 
    Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS Count, 
	Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, 
    Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep +
    dealer_name + super_category + cprod + admtrntyp AS ID 
 FROM   sal002_tier1_sales_ytd 
 WHERE  Substring(CONVERT(VARCHAR, admpstdat), 5, 2) = @Month 
  AND Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year - 1 
  AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
  AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group'))
  
  GROUP  BY lob, efg_rep, account_group, dealer_name, admtrntyp, super_category, 
	cprod, Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + super_category + cprod
),
d AS 
(SELECT lob, efg_rep, account_group, dealer_name, super_category, cprod, 
  Sum(( CASE c.admtrntyp 
           WHEN 'CUR' THEN ( c.count ) 
           WHEN 'CAN' THEN -( c.count ) 
           WHEN 'REN' THEN ( c.count ) 
           ELSE 0 
           END ))AS Count, 
  Sum(amount) AS Amount,  
  Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
  + dealer_name + super_category + cprod AS ID 
 FROM   c 
 WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
  AND ISNULL(Account_Group, 'No Account Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account Group')) 
 GROUP  BY lob, efg_rep, account_group, dealer_name,  super_category, cprod, 
        Isnull(lob, 'No LOB') + Isnull(account_group, 'No Account Group') + efg_rep 
                   + dealer_name + super_category + cprod) 
INSERT INTO @x 
SELECT DISTINCT Isnull(b.lob, d .lob), 
                Isnull(b.account_group, d .account_group), 
                Isnull(b.efg_rep, d .efg_rep), 
                Isnull(b.dealer_name, d .dealer_name), 
                Isnull(b.super_category, d .super_category), 
                Isnull(b.cprod, d .cprod), 
                Sum(b.count), 
                Sum(b.amount)  AS Amount, 
                Sum(d.amount) AS PreYrAmount 
FROM   b 
       FULL OUTER JOIN d ON b.id = d .id 
GROUP BY b.lob, d .lob, b.account_group, d .account_group, b.efg_rep, d .efg_rep, 
b.dealer_name, d .dealer_name, b.super_category, d .super_category, b.cprod, d .cprod 
SELECT * FROM   @x  
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_By_Channel]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Revenue_By_Channel]
AS
Declare @Month Varchar(20)
Declare @Year Varchar(4)

Select @Year=LEFT(ClosedPeriod,4), @Month=Convert(Varchar(10), DateName(mm, DateAdd(Month, 1, Convert(DateTime,(LEFT(ClosedPeriod,4)+'/'+SUBSTRING(closedPeriod,5,2)+'/01')))))
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


SELECT Isnull(lob, 'NO LOB')                         AS LOB, 
       Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount, 
       @Month
       + ',' 
       + @Year
FROM   sal002_tier1_sales 
GROUP  BY lob  
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Revenue_Trend]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Revenue_Trend]
@LOB varchar(255)=NULL,
@EFGRep varchar(255)=NULL,
@AccountGroup varchar(255)=NULL,
@Account varchar(255)=NULL,
@Product varchar(255)=NULL
/*
SSRS_SalesTier1_Revenue_Trend 'Dealer Services', 'Bryan Durant', 'Davis-Moore Group', 'Davis-Moore Chevrolet', 'CHOICE'
SSRS_SalesTier1_Revenue_Trend 'No LOB'
SSRS_SalesTier1_Revenue_Trend @EFGRep='No Rep'
SSRS_SalesTier1_Revenue_Trend @AccountGroup='No Account Group'
SSRS_SalesTier1_Revenue_Trend @Account='No Account'
SSRS_SalesTier1_Revenue_Trend @Product = 'No Product'

*/
AS

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


 SELECT Isnull(lob, 'No LOB') AS lob, isnull(efg_rep, 'No Rep') as efg_rep, Isnull(account_group, 'No Account Group') AS  account_group, 
            ISNULL(Dealer_Name, 'No Account') as dealer_name, 
            ISNULL(cprod, 'No Product') as Product,
            CASE admtrntyp 
				 WHEN 'CAN' THEN 
					Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) * -1
				 WHEN 'AMD' THEN 0
				 ELSE 
				    Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) 
				 END AS Count,
            Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount,             
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
		AND Isnull(cprod, 'No Product') = ISNULL(@Product, isnull(cprod, 'No Product'))				
     GROUP  BY lob, efg_rep, account_group, dealer_name, cprod, admpstdat,admtrntyp
     ORDER BY lob, efg_rep, account_group, dealer_name, cprod, admtrntyp,monthdt
     
     


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]    Script Date: 10/07/2013 15:26:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]
AS
Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


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
GO
GO
/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail]    Script Date: 10/18/2013 18:04:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail]
GO


/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail]    Script Date: 10/18/2013 18:04:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail]
@LOB nvarchar(320),
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL,
@prod nvarchar(320)=NULL
/*
        Reports Consuming  :  
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services' -- NO CASE OF RUNNING THIS 
				
				Gross Monthly Account Performance by Rep
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services', @EFG_Rep='Paul Roberts'
				
				Gross Monthly Account Performance by AccountGroup
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='Billion Auto Group'
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group'
				
						
				Gross Monthly Account Performance by Account
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group', @Account='Aristocrat Motors' 
				
				Gross Monthly Account Performance by Product
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance_Detail @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account Group', @Account='Aristocrat Motors' 				
				

*/

AS 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth

SELECT	
		APVALPVAL,
		ADMPSTDAT,
		ADMCLICOD,
		ADMACCCOD,
		ADMAGRCOD,
		ADMAGRSFX,
		ADMTRNTYP,
		ADMDISTYP,
		AGMPRGCOD,		
		lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		cprod=ISNULL(cprod, 'No Product'), 		
		cprog=ISNULL(cprog, 'No Prog'),
		cplan=ISNULL(cplan, 'No Plan'),
		Program_Code,
		Product_Category,
		Super_Category,
		ISNULL(flg_exception,'') Exception,		
		NON_CANCELFEE_STATUS,
		Disbursement_Amount=Convert(float, ISNULL(disbursement_amount,0)),
		Amount=CASE WHEN ISNULL(disbursement_amount,0) >= 0 
					THEN ISNULL(disbursement_amount,0) ELSE 0 END,
		ExcludedAmount=CASE WHEN ISNULL(disbursement_amount,0) < 0 
					THEN ISNULL(disbursement_amount,0) ELSE 0 END,					
		MonthDate= CASE 
				WHEN admpstdat = 0 THEN @Month 
				ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
				END,								   
					
		[year]=CASE 
			  WHEN admpstdat = 0 THEN @Year 
				ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
				END,
		RptRunDT
 FROM   dbo.sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 AND ISNULL(cprod, 'No Product') = ISNULL(@prod, ISNULL(cprod, 'No Product'))


GO



GO

select 'Script Successfully Executed on [' + DB_NAME() +']'
PRINT 'Script Successfully Executed on [' + DB_NAME() +']'


GO
    SET NOEXEC OFF;
    
