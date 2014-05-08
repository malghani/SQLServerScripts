USE [RptDataDaily_Dev]
GO

/****** Object:  StoredProcedure [dbo].[Cession2]    Script Date: 10/11/2013 15:57:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<report build>
-- =============================================
CREATE PROCEDURE [dbo].[Cession2]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here




DECLARE @PMonth VARCHAR(10) 
SET @PMonth = CONVERT(CHAR(6), DATEADD(MONTH, -2, GETDATE()), 112)
DECLARE @CMonth VARCHAR(10)
SET @CMonth = CONVERT(CHAR(6), DATEADD(MONTH, -1, GETDATE()), 112)
DECLARE @CRRNCONTCT VARCHAR (500)
SET @CRRNCONTCT = (SELECT SUM(RRNCONTCT) [C-RRNCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @cMonth )
DECLARE @CRRNCANCT VARCHAR(500)
SET @CRRNCANCT = (select SUM(RRNCANCT) [C-RRNCANCT] FROM dbo.CessionDev WHERE RRYRMON = @CMonth)
DECLARE @CRRNNETCEDR VARCHAR(500)
SET @CRRNNETCEDR = (SELECT SUM(RRNNETCEDR) [CRRNNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRNCLMCED VARCHAR(500)
SET @CRRNCLMCED = (SELECT SUM(RRNCLMCED) [CRRNCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRNUNERNCD VARCHAR(500)
SET @CRRNUNERNCD = (SELECT SUM(RRNUNERNCD) [C-RRNUNERNCD] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRREINFEE VARCHAR(500)
SET @CRRREINFEE = (SELECT SUM(RRREINFEE) [C-RRREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRNPREMTAX VARCHAR(500)
SET @CRRNPREMTAX = (SELECT SUM(RRNPREMTAX) [C-RRNPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRNEXCSTAX VARCHAR(500)
SET @CRRNEXCSTAX = (SELECT SUM(RRNEXCSTAX) [C-RRNEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUCONTCT VARCHAR(500)
SET @CRRUCONTCT = (SELECT SUM(RRUCONTCT) [C-RRUCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUCANCT VARCHAR(500)
SET @CRRUCANCT = (SELECT SUM(RRUCANCT) [C-RRUCANCT] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUNETCEDR VARCHAR(500)
SET @CRRUNETCEDR = (SELECT SUM(RRUNETCEDR) [C-RRUNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUCLMCED VARCHAR(500)
SET @CRRUCLMCED = (SELECT SUM(RRUCLMCED) [C-RRUCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUREINFEE VARCHAR(500)
SET @CRRUREINFEE = (SELECT SUM(RRUREINFEE) [C-RRUREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUPREMTAX VARCHAR(500)
SET @CRRUPREMTAX = (SELECT SUM(RRUPREMTAX) [C-RRUPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUEXCSTAX VARCHAR(500)
SET @CRRUEXCSTAX = (SELECT SUM(RRUEXCSTAX) [C-RRUEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTCONTCT VARCHAR(500)
SET @CRRTCONTCT = (SELECT SUM(RRTCONTCT) [C-RRTCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTCANCT VARCHAR(500)
SET @CRRTCANCT = (SELECT SUM(RRTCANCT) [C-RRTCANCT] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTNETCEDR VARCHAR(500)
SET @CRRTNETCEDR = (SELECT SUM(RRTNETCEDR) [C-RRTNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTCLMCED VARCHAR(500)
SET @CRRTCLMCED = (SELECT SUM(RRTCLMCED) [C-RRTCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTREINFEE VARCHAR(500)
SET @CRRTREINFEE = (SELECT SUM(RRTREINFEE) [C-RRTREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTPREMTAX VARCHAR(500)
SET @CRRTPREMTAX = (SELECT SUM(RRTPREMTAX) [C-RRTPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRTEXCSTAX VARCHAR(500)
SET @CRRTEXCSTAX = (SELECT SUM(RRTEXCSTAX) [C-RRTEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @cMonth)
DECLARE @CRRUUNERNCD NUMERIC (38,2)
SET @CRRUUNERNCD = (SELECT SUM(RRUUNERNCD * .01) [NPC-RRUUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @cMonth) -- current month
---create previous month data 
DECLARE @PRRNCONTCT VARCHAR (500)
SET @PRRNCONTCT = (SELECT SUM(RRNCONTCT) [C-RRNCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth )
DECLARE @PRRNCANCT VARCHAR(500)
SET @PRRNCANCT = (select SUM(RRNCANCT) [C-RRNCANCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRNNETCEDR VARCHAR(500)
SET @PRRNNETCEDR = (SELECT SUM(RRNNETCEDR) [CRRNNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRNCLMCED VARCHAR(500)
SET @PRRNCLMCED = (SELECT SUM(RRNCLMCED) [CRRNCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRNUNERNCD VARCHAR(500)
SET @PRRNUNERNCD = (SELECT SUM(RRNUNERNCD) [C-RRNUNERNCD] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRREINFEE VARCHAR(500)
SET @PRRREINFEE = (SELECT SUM(RRREINFEE) [C-RRREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRNPREMTAX VARCHAR(500)
SET @PRRNPREMTAX = (SELECT SUM(RRNPREMTAX) [C-RRNPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRNEXCSTAX VARCHAR(500)
SET @PRRNEXCSTAX = (SELECT SUM(RRNEXCSTAX) [C-RRNEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUCONTCT VARCHAR(500)
SET @PRRUCONTCT = (SELECT SUM(RRUCONTCT) [C-RRUCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUCANCT VARCHAR(500)
SET @PRRUCANCT = (SELECT SUM(RRUCANCT) [C-RRUCANCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUNETCEDR VARCHAR(500)
SET @PRRUNETCEDR = (SELECT SUM(RRUNETCEDR) [C-RRUNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUCLMCED VARCHAR(500)
SET @PRRUCLMCED = (SELECT SUM(RRUCLMCED) [C-RRUCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUREINFEE VARCHAR(500)
SET @PRRUREINFEE = (SELECT SUM(RRUREINFEE) [C-RRUREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUPREMTAX VARCHAR(500)
SET @PRRUPREMTAX = (SELECT SUM(RRUPREMTAX) [C-RRUPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRUEXCSTAX VARCHAR(500)
SET @PRRUEXCSTAX = (SELECT SUM(RRUEXCSTAX) [C-RRUEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTCONTCT VARCHAR(500)
SET @PRRTCONTCT = (SELECT SUM(RRTCONTCT) [C-RRTCONTCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTCANCT VARCHAR(500)
SET @PRRTCANCT = (SELECT SUM(RRTCANCT) [C-RRTCANCT] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTNETCEDR VARCHAR(500)
SET @PRRTNETCEDR = (SELECT SUM(RRTNETCEDR) [C-RRTNETCEDR] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTCLMCED VARCHAR(500)
SET @PRRTCLMCED = (SELECT SUM(RRTCLMCED) [C-RRTCLMCED] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTREINFEE VARCHAR(500)
SET @PRRTREINFEE = (SELECT SUM(RRTREINFEE) [C-RRTREINFEE] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTPREMTAX VARCHAR(500)
SET @PRRTPREMTAX = (SELECT SUM(RRTPREMTAX) [C-RRTPREMTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)
DECLARE @PRRTEXCSTAX VARCHAR(500)
SET @PRRTEXCSTAX = (SELECT SUM(RRTEXCSTAX) [C-RRTEXCSTAX] FROM dbo.CessionDev WHERE RRYRMON = @pMonth)


DECLARE @NPCRRNUNERNCD NUMERIC (38,2)
SET @NPCRRNUNERNCD = (SELECT SUM(RRNUNERNCD * .01) [NPC-RRNUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @cMonth) -- current month
DECLARE @NPCRRUUNERNCD NUMERIC (38,2)
SET @NPCRRUUNERNCD = (SELECT SUM(RRUUNERNCD * .01) [NPC-RRUUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @cMonth) -- current month
DECLARE @NPCRRTUNERNCD NUMERIC (38,2)
SET @NPCRRTUNERNCD = (SELECT SUM(RRTUNERNCD * .01) [NPC-RRTUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @cMonth) -- current month
DECLARE @NPPRRNUNERNCD NUMERIC (38,2)
SET @NPPRRNUNERNCD = (SELECT SUM(RRNUNERNCD * .01) [PPC-RRNUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @pMonth) -- previous month
DECLARE @NPPRRUUNERNCD NUMERIC (38,2)
SET @NPPRRUUNERNCD = (SELECT SUM(RRUUNERNCD * .01) [PPC-RRUUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @pMonth) -- previous month
DECLARE @NPPRRTUNERNCD NUMERIC (38,2)
SET @NPPRRTUNERNCD = (SELECT SUM(RRTUNERNCD * .01) [PPC-RRTUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P' AND RRYRMON = @pMonth) -- previous month
DECLARE @RRUUNERNCD NUMERIC (38,2)
SET @RRUUNERNCD = (SELECT SUM(RRUUNERNCD * .01) [PPC-RRUUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P') -- previous month
DECLARE @RRTUNERNCD NUMERIC (38,2)
SET @RRTUNERNCD = (SELECT SUM(RRTUNERNCD * .01) [PPC-RRTUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P') -- previous month
DECLARE @RRNUNERNCD NUMERIC (38,2)
SET @RRNUNERNCD = (SELECT SUM(RRNUNERNCD * .01) [PPC-RRNUNERNCD] FROM dbo.CessionDev WHERE RRCLMWHEN <> 'P') -- previous month

SELECT DISTINCT
[C-RRNCONTCT] = @CRRNCONTCT ,
[C-RRNCANCT] = @CRRNCANCT ,
[C-RRNNETCEDR] = @CRRNNETCEDR,
[C-RRNCLMCED] = @CRRNCLMCED,
[C-RRNUNERNCD] = @CRRNUNERNCD,
[C-RRREINFEE] = @CRRREINFEE,
[C-RRNPREMTAX] = @CRRNPREMTAX,
[C-RRNEXCSTAX] = @CRRNEXCSTAX,
[C-RRUCONTCT] = @CRRUCONTCT,
[C-RRUCANCT] = @CRRUCANCT,
[C-RRUNETCEDR] = @CRRUNETCEDR,
[C-RRUCLMCED] = @CRRUCLMCED,
[C-RRUREINFEE] = @CRRUREINFEE,
[C-RRUPREMTAX] = @CRRUPREMTAX,
[C-RRUEXCSTAX] = @CRRUEXCSTAX,
[C-RRTCONTCT] = @CRRTCONTCT,
[C-RRTCANCT] = @CRRTCANCT,
[C-RRTNETCEDR] = @CRRTNETCEDR,
[C-RRTCLMCED] = @CRRTCLMCED,
[C-RRTREINFEE] = @CRRTREINFEE,
[C-RRTPREMTAX] = @CRRTPREMTAX,
[C-RRTEXCSTAX] = @CRRTEXCSTAX,
[C-RRUUNERNCD] = @RRUUNERNCD, 

[P-RRNCONTCT] = @PRRNCONTCT ,
[P-RRNCANCT] = @PRRNCANCT ,
[P-RRNNETCEDR] = @PRRNNETCEDR,
[P-RRNCLMCED] = @PRRNCLMCED,
[P-RRNUNERNCD] = @PRRNUNERNCD,
[P-RRREINFEE] = @PRRREINFEE,
[P-RRNPREMTAX] = @PRRNPREMTAX,
[P-RRNEXCSTAX] = @PRRNEXCSTAX,
[P-RRUCONTCT] = @PRRUCONTCT,
[P-RRUCANCT] = @PRRUCANCT,
[P-RRUNETCEDR] = @PRRUNETCEDR,
[P-RRUCLMCED] = @PRRUCLMCED,
[P-RRUREINFEE] = @PRRUREINFEE,
[P-RRUPREMTAX] = @PRRUPREMTAX,
[P-RRUEXCSTAX] = @PRRUEXCSTAX,
[P-RRTCONTCT] = @PRRTCONTCT,
[P-RRTCANCT] = @PRRTCANCT,
[P-RRTNETCEDR] = @PRRTNETCEDR,
[P-RRTCLMCED] = @PRRTCLMCED,
[P-RRTREINFEE] = @PRRTREINFEE,
[P-RRTPREMTAX] = @PRRTPREMTAX,
[P-RRTEXCSTAX] = @PRRTEXCSTAX,


SUM(RRNCONTCT) [RRNCONTCT] ,
SUM(RRNCANCT) [RRNCANCT],
SUM(RRNNETCEDR) [RRNNETCEDR],
SUM(RRNCLMCED) [RRNCLMCED],
SUM(RRNUNERNCD) [RRNUNERNCD],
SUM(RRREINFEE) [RRREINFEE],
SUM(RRNPREMTAX) [RRNPREMTAX],
SUM(RRNEXCSTAX) [RRNEXCSTAX],
SUM(RRUCONTCT) RRUCONTCT,
SUM(RRUCANCT) RRUCANCT, 
SUm(RRUNETCEDR) RRUNETCEDR,
SUM(RRUCLMCED) RRUCLMCED,
SUM(RRUREINFEE) RRUREINFEE,
SUM(RRUPREMTAX) RRUPREMTAX,
SUM(RRUEXCSTAX) RRUEXCSTAX,
SUM(RRTCONTCT) RRTCONTCT,
SUM(RRTCANCT) RRTCANCT,
SUM(RRTNETCEDR) RRTNETCEDR,
SUM(RRTCLMCED) RRTCLMCED,
SUM(RRTREINFEE) RRTREINFEE,
SUM(RRTPREMTAX) RRTPREMTAX,
SUM(RRTEXCSTAX) RRTEXCSTAX,
SUM(RRNTOTDED) RRNTOTDED,
SUM(RRUTOTDED) RRUTOTDED,
SUM(RRTTOTDED) RRTTOTDED, 
RRUUNERNCD= @RRUUNERNCD,  
RRTUNERNCD= @RRTUNERNCD,
[SUM-RRNUNERNCD]= @RRNUNERNCD,


[NPC-RRNUNERNCD] = @NPCRRNUNERNCD,
[NPC-RRUUNERNCD] = @NPCRRUUNERNCD,
[NPC-RRTUNERNCD] = @NPCRRTUNERNCD,
[PPC-RRNUNERNCD] = @NPPRRNUNERNCD,
[PPC-RRUUNERNCD] = @NPPRRUUNERNCD,
[PPC-RRTUNERNCD] = @NPPRRTUNERNCD


FROM dbo.Cession





END

GO

/****** Object:  StoredProcedure [dbo].[ChannelRevenuebyProduct]    Script Date: 10/11/2013 15:57:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07/24/2013>
-- Description:	<Channel Revenue by product>
-- =============================================
CREATE PROCEDURE [dbo].[ChannelRevenuebyProduct] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

WITH x AS (SELECT        TOP (100) PERCENT ISNULL(Super_Category, 'No Category') AS Product_Category, ISNULL(cprod, 'No Product') AS Product, SUM(Disbursement_Amount) 
                                                   AS Amount, CONVERT(varchar, DATENAME(mm, GETDATE())) + ',' + CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
                         FROM            SAL002_Tier1_Sales
                         GROUP BY Super_Category, cprod)
    SELECT        Product_Category, Product, Amount, Date
     FROM            x AS x_1
     WHERE        (Amount <> 0)END

GO

/****** Object:  StoredProcedure [dbo].[ChannelRevenuebyProductCategory]    Script Date: 10/11/2013 15:57:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07/24/2013>
-- Description:	<[ChannelRevenuebyProductCategory]>
-- =============================================
CREATE PROCEDURE [dbo].[ChannelRevenuebyProductCategory]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

WITH x AS (SELECT        TOP (100) PERCENT ISNULL(Super_Category, 'No Category') AS Product_Category, SUM(Disbursement_Amount) AS Amount, CONVERT(varchar, 
                                                   DATENAME(mm, GETDATE())) + ',' + CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
                         FROM            SAL002_Tier1_Sales
                         GROUP BY Super_Category
                         ORDER BY Super_Category)
    SELECT        Product_Category, Amount, Date
     FROM            x AS x_1
     WHERE        (Amount <> 0)END

GO

/****** Object:  StoredProcedure [dbo].[CommissionReport]    Script Date: 10/11/2013 15:57:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<R.Green>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CommissionReport]   
	-- Add the parameters for the stored procedure here
   @UserName VARCHAR(MAX)
   , @StartDate Datetime 
   , @EndDate Datetime 
   

AS BEGIN


	SET NOCOUNT ON;




    
DECLARE @User varchar (35)
DECLARE @RptCode VARCHAR(10)
SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode;


WITH Forsum --Start of CTE to get cal numbers 
AS (


SELECT Distinct 
account_group,
RptRunDT,
ADMACCCOD,
Dealer_Name,
EFG_Rep, 
LOB,
COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Contract_Count, 
ADMTRNTYP, 
NON_CANCELFEE_STATUS, 
CAST(NON_CANCELFEE_STATUS AS VARCHAR) AS RepGroupID,  
SUM(Disbursement_Amount)   AS amt


              FROM            [SAL001_GetDailyDataCommissions-UAT2]
              
              
             WHERE  
       efg_rep = (@UserName)
     --AND RptRunDT between (@StartDate) and (@EndDate)            
               
and APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')          
AND Disbursement_Code NOT IN (SELECT FieldValue FROM @ExceptionsTbl)
OR Disbursement_Code IN('ASGDFADM','BASEADMIN','CLAIMRESV',                                      
       'EFGADMIN','EXCINS','ROADADMIN','OKWARACT','RASADMIN','REPOF','ROADADMIN')



         GROUP BY LOB, efg_rep,    ADMTRNTYP, NON_CANCELFEE_STATUS, Dealer_Name,ADMACCCOD, RptRunDT,account_group) ,
          B AS 
          
          (
				SELECT DISTINCT COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Contract_Count2,
				ADMACCCOD AAC,
				Dealer_Name DDD,
				EFG_Rep EEE, 
				LOB ASA
				FROM  [SAL001_GetDailyDataCommissions-UAT2]
				WHERE Disbursement_code = 'CANCELFEE' 
				   and   efg_rep = (@UserName)
     --AND RptRunDT between (@StartDate) and (@EndDate) 
				GROUP BY
				ADMACCCOD,
				Dealer_Name,
				EFG_Rep, 
				LOB  ) 
         
      
      
      
      
				 SELECT       SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN Contract_Count END) AS New_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN amt END) AS New_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN Contract_Count END) AS CB_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN amt END) AS CB_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' THEN Contract_Count2 END) AS CF_Count,
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' OR RepGroupID = 0 THEN amt END) AS CF_Amt,
                              SUM(CASE WHEN ADMTRNTYP = 'REN' AND RepGroupID = 1 THEN Contract_Count END) AS REN_Count, 
                              SUM(CASE WHEN ADMTRNTYP = 'REN' AND RepGroupID = 1 THEN amt END) AS REN_amt, 
                              SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN Contract_Count END) AS AMD_Count, 
                              SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN amt END) AS AMD_Amt, 
                              LOB,
                              EFG_Rep, 
                              Dealer_Name,
                              COUNT(RepGroupID) [Number Of Accounts],
                              ADMACCCOD,
                              account_group

                              
                        
     FROM            FORSUM 
     full outer JOIN B
     ON FORSUM.ADMACCCOD = B.AAC

     
     WHERE 
     FORSUM.efg_rep = (@UserName)
     AND RptRunDT between (@StartDate) and (@EndDate) 
      
   
     group by LOB  , EFG_Rep, Dealer_Name, ADMACCCOD, account_group
     order by EFG_Rep , LOB ASC 
     
     END


GO

/****** Object:  StoredProcedure [dbo].[DailyCommissionsEFGRepAcctGroupDealerSubtotals]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DailyCommissionsEFGRepAcctGroupDealerSubtotals]
as
Begin

; WITH toppart AS (SELECT DISTINCT 
                                                                  [efg_rep], [account_group], [dealer_name], [admclicod], [admacccod], [admagrcod], [admagrsfx], [apvalpval], [admtrntyp], [non_cancelfee_status], 
                                                                  admdistyp, 
                                                                 sum(Disbursement_Amount) as Disbursement_Amt,
                                                                  Cnt = count(DISTINCT [admclicod] + [admacccod] + [admagrcod] + [admagrsfx])
                                        FROM            [RptDataDaily].[dbo].[sal001_getdailydatacommissions]
                                        GROUP BY [efg_rep], [account_group], [dealer_name], [admclicod], [admacccod], [admagrcod], [admagrsfx], [apvalpval], [admtrntyp], [non_cancelfee_status], 
                                                                  admdistyp), final AS
    (SELECT        EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, NON_CANCELFEE_STATUS,
					RepGroupID = (EFG_Rep + (CASE WHEN Account_Group IS NULL  THEN '-' ELSE Account_Group END) + Dealer_Name), sum(cnt) AS Contract_Count
                    , Disbursement_Amt
                                
      FROM            toppart
      GROUP BY EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, NON_CANCELFEE_STATUS,Disbursement_Amt)
    SELECT        *
     FROM            final

END

-- background subtotals by EFG Rep/Account Group/Dealer for the Commissions report and related
GO

/****** Object:  StoredProcedure [dbo].[GetAS400MTDDailyDataCommissions]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetAS400MTDDailyDataCommissions]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table MTDAS400Pull  -- Removes Data from Stagging Table 



--Gets Current Month Data 

DECLARE @PstEndDatCur INT  --variable that set date to month end of current month 
SET @PstEndDatCur = 
(SELECT CONVERT(VARCHAR(10), (DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))), 112))
DECLARE @PstEndDatPerv INT
SET @PstEndDatPerv = 
(SELECT CONVERT(VARCHAR(10), (DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE())-1,0))), 112))
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 


SELECT ADMPSTDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD, NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL   

                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                                          
                               where ADMEFRTYN = 'Y'
                           		AND ADMPSTDAT in ('0')    ---gets zero values for current moth processing without a postdate
                                AND admtrntyp in ('AMD','amd','REN', 'ren', 'CUR','cur','CAN','can')
                                AND ADMDISCOD NOT IN (SELECT FieldValue FROM [sv-sql06].RptRulesMaster.dbo.Exceptions where RptCode = 'SAL001' ) --removes invalid disbursements codes
							    AND AGMPRGCOD NOT IN (SELECT FieldValue FROM [sv-sql06].RptRulesMaster.dbo.Exceptions where RptCode = 'SAL001')  --removes invalid program codes
							    AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED') -- gets only used status codes
							    OR  admtrntyp in ( ' amd ', ' amd' , 'amd ', ' REN ' , ' ren' , 'ren ' , ' cur ' , 
                                    ' cur' , 'cur ', ' can ', 'can ', 'can ' ) -- checks for codes that might be missed 





GO

/****** Object:  StoredProcedure [dbo].[GetAS400MTDDailyDataCommissionsPostDate]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetAS400MTDDailyDataCommissionsPostDate]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table MTDAS400Pull  -- Removes Data from Stagging Table 

--Gets Current Month Data 

DECLARE @PstEndDatCur INT  --variable that set date to month end of current month 
SET @PstEndDatCur = 
(SELECT CONVERT(VARCHAR(10), (DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE()),0))), 112))
--DECLARE @PstEndDatPerv INT
--SET @PstEndDatPerv = 
--(SELECT CONVERT(VARCHAR(10), (DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE())-1,0))), 112))



SELECT ADMPSTDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD, NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL   

                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                                          
                               where ADMEFRTYN = 'Y'
                           		AND ADMPSTDAT =  @PstEndDatCur  ---gets zero values for current moth processing without a postdate
                                AND admtrntyp in ('AMD','amd','REN','CUR','CAN','can')
                                AND ADMDISCOD NOT IN (SELECT FieldValue FROM [sv-sql06].RptRulesMaster.dbo.Exceptions where RptCode = 'SAL001' ) --removes invalid disbursements codes
							    AND AGMPRGCOD NOT IN (SELECT FieldValue FROM [sv-sql06].RptRulesMaster.dbo.Exceptions where RptCode = 'SAL001')  --removes invalid program codes
							    AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED') -- gets only used status codes
                                --OR  ADMPSTDAT is null --gets null values postdates 
                                --OR  admtrntyp in ( ' amd ', ' amd' , 'amd ', ' REN ' , ' ren' , 'ren ' , ' cur ' , 
                                  --  ' cur' , 'cur ', ' can ', 'can ', 'can ' ) -- checks for codes that might be missed 




GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]


DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(20733 row(s) affected) UPDATE ON 05-15-13

--- INITIAL TEST FOR: where DD.ADMACCCOD = '0000091731'


--BEFORE UPDATE:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		NULL			NULL				NULL			KK87			Dent Zone			AM

--UPDATED:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		KK87			Dent Zone			AM				KK87			Dent Zone			AM
-- ==========================================================================================================================================================




-- ==========================================================================================================================================================
-- UPDATE LOB FIELD		[KVT ADDED 05-07-13]: USE EFGCubeFactsDims
-- [KVT 05-28-13: LOB IS NOW IN THE MAIN QUERY: EFG_MSCRM].[dbo].[BusinessUnitBase] BU on a.OwningBusinessUnit = BU.BusinessUnitId; LOB = BU.NAME]
--;
--WITH mycrmreplacement 
--     AS (SELECT DISTINCT dm.[account code], 
--                         CASE 
--                           WHEN c.dealership IS NOT NULL THEN c.dealership 
--                           ELSE [account name] 
--                         END                AS DealerName, 
--                         CASE 
--                           WHEN c2.groupname = '' THEN NULL 
--                           ELSE c2.groupname 
--                         END                AS GroupName, 
--                         CASE 
--                           WHEN c2.agent IS NOT NULL 
--                                AND c2.agent <> '' THEN c2.agent 
--                           ELSE NULL 
--                         END                AS Agent, 
--                         CASE 
--                           WHEN c2.efgrep IS NOT NULL THEN c2.efgrep 
--                           WHEN c2.efgrep IS NULL 
--                                AND c.repagent IS NOT NULL THEN c.repagent 
--                           ELSE NULL 
--                         END                AS EFGRep, 
--                         c2.lob AS crm_lob, 
--                         dm.[record status] AS AccountStatus 
--         FROM   efgdw.dbo.dealermaster AS dm 
--                LEFT OUTER JOIN efgdw.dbo.crmreplacement2 AS c2 
--                             ON dm.[account code] = c2.accountcode 
--                LEFT OUTER JOIN efgdw.dbo.crmdata AS c 
--                             ON dm.[account code] = c.billingaccountnumber 
--         WHERE  ( dm.[account type] = 'DL' ))
         
--, DailyData as
--(SELECT [APVALPVAL]
--      ,[ADMPSTDAT]
--      ,[ADMCLICOD]
--      ,[ADMACCCOD]
--      ,[ADMAGRCOD]
--      ,[ADMAGRSFX]
--      ,[EFG_Rep]
--      ,[Account_Group]
--      ,[Dealer_Name]
--      ,[ADMTRNTYP]
--      ,[ADMDISTYP]
--      ,[AGMPRGCOD]
--      ,[Disbursement_Code]
--      ,[Disbursement_Amount]
--      ,[NON_CANCELFEE_STATUS]
--      ,[RptRunDT]
--      ,[LOB]
--  FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions])
-- ,
--Final AS (
--      SELECT c.*,dd.*
--      FROM DailyData dd
--      LEFT OUTER JOIN mycrmreplacement c ON dd.ADMACCCOD = c.[Account Code]
--      )
                 
----SELECT ADMACCCOD,LOB,[Account Code],crm_lob                       
--UPDATE F SET LOB = crm_lob
--FROM Final F


-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
--SELECT * FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] D

--05-07-13 testing
--(140 row(s) affected)
--(3639 row(s) affected)

--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD	ADMAGRSFX	EFG_Rep	Account_Group	Dealer_Name	ADMTRNTYP	ADMDISTYP	AGMPRGCOD	Disbursement_Code	Disbursement_Amount	NON_CANCELFEE_STATUS	RptRunDT	LOB
--INFORCE	0	EFG	0000027170	             0028319		Cesar Flores	NULL	Santa Fe Mazda	CUR	ADMIN	MAP01	ASGDFADM	10.00	1	2013-05-07 05:00:01.987	Dealer Channel
-- ==========================================================================================================================================================

-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions__prior_to_05_28_13]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions__prior_to_05_28_13]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]


DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT]
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================
-- UPDATE LOB FIELD		[KVT ADDED 05-07-13]: USE EFGCubeFactsDims
;
WITH mycrmreplacement 
     AS (SELECT DISTINCT dm.[account code], 
                         CASE 
                           WHEN c.dealership IS NOT NULL THEN c.dealership 
                           ELSE [account name] 
                         END                AS DealerName, 
                         CASE 
                           WHEN c2.groupname = '' THEN NULL 
                           ELSE c2.groupname 
                         END                AS GroupName, 
                         CASE 
                           WHEN c2.agent IS NOT NULL 
                                AND c2.agent <> '' THEN c2.agent 
                           ELSE NULL 
                         END                AS Agent, 
                         CASE 
                           WHEN c2.efgrep IS NOT NULL THEN c2.efgrep 
                           WHEN c2.efgrep IS NULL 
                                AND c.repagent IS NOT NULL THEN c.repagent 
                           ELSE NULL 
                         END                AS EFGRep, 
                         c2.lob AS crm_lob, 
                         dm.[record status] AS AccountStatus 
         FROM   efgdw.dbo.dealermaster AS dm 
                LEFT OUTER JOIN efgdw.dbo.crmreplacement2 AS c2 
                             ON dm.[account code] = c2.accountcode 
                LEFT OUTER JOIN efgdw.dbo.crmdata AS c 
                             ON dm.[account code] = c.billingaccountnumber 
         WHERE  ( dm.[account type] = 'DL' ))
         
, DailyData as
(SELECT [APVALPVAL]
      ,[ADMPSTDAT]
      ,[ADMCLICOD]
      ,[ADMACCCOD]
      ,[ADMAGRCOD]
      ,[ADMAGRSFX]
      ,[EFG_Rep]
      ,[Account_Group]
      ,[Dealer_Name]
      ,[ADMTRNTYP]
      ,[ADMDISTYP]
      ,[AGMPRGCOD]
      ,[Disbursement_Code]
      ,[Disbursement_Amount]
      ,[NON_CANCELFEE_STATUS]
      ,[RptRunDT]
      ,[LOB]
  FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions])
 ,
Final AS (
      SELECT c.*,dd.*
      FROM DailyData dd
      LEFT OUTER JOIN mycrmreplacement c ON dd.ADMACCCOD = c.[Account Code]
      )
                 
--SELECT ADMACCCOD,LOB,[Account Code],crm_lob                       
UPDATE F SET LOB = crm_lob
FROM Final F


-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(20733 row(s) affected) UPDATE ON 05-15-13

--- INITIAL TEST FOR: where DD.ADMACCCOD = '0000091731'


--BEFORE UPDATE:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		NULL			NULL				NULL			KK87			Dent Zone			AM

--UPDATED:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		KK87			Dent Zone			AM				KK87			Dent Zone			AM

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
--SELECT * FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] D

--05-07-13 testing
--(140 row(s) affected)
--(3639 row(s) affected)

--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD	ADMAGRSFX	EFG_Rep	Account_Group	Dealer_Name	ADMTRNTYP	ADMDISTYP	AGMPRGCOD	Disbursement_Code	Disbursement_Amount	NON_CANCELFEE_STATUS	RptRunDT	LOB
--INFORCE	0	EFG	0000027170	             0028319		Cesar Flores	NULL	Santa Fe Mazda	CUR	ADMIN	MAP01	ASGDFADM	10.00	1	2013-05-07 05:00:01.987	Dealer Channel
-- ==========================================================================================================================================================

-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_JP_update_04_18_13]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[GetDailyDataCommissions_JP_update_04_18_13]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              --inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D		-- KVT updated 04-18-13 2:55 PM FROM JWP: use logical instead of physical for files in SE
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM08 D                              
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              --INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p		-- KVT updated 04-18-13 2:55 PM FROM JWP: use logical instead of physical for files in SE
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM06 p                                        
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT]
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD
-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_no_insert]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[GetDailyDataCommissions_no_insert]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
      
SELECT      APVALPVAL,ADMPSTDAT,ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
            EFG_Rep, Account_Group, Dealer_Name,
            ADMTRNTYP,ADMDISTYP,AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_Orig_04_18_13]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[GetDailyDataCommissions_Orig_04_18_13]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT]
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD
-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_orig_04_22_13]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions_orig_04_22_13]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT]
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD
-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_Orig_05_03_13]    Script Date: 10/11/2013 15:57:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[GetDailyDataCommissions_Orig_05_03_13]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
            select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
            FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT]
            --,ADMENTDAT,ADMRECDAT
                        
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD
-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions_prior_yr]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetDailyDataCommissions_prior_yr]
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
     Amount FLOAT 
  ) 

IF @GroupOn = 0 
Begin
		INSERT INTO @y (lob, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
		GROUP  BY lob
		SELECT LOB, Amount 
		FROM   @y  		
End
ELSE IF @GroupOn = 1
Begin
		INSERT INTO @y (LOB, EFG_Rep, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
				EFG_Rep,
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
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
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
		GROUP  BY LOB, Account_Group, EFG_Rep
		SELECT LOB, Account_Group, EFG_Rep, Amount 
		FROM   @y  
		Return
End


GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions-test]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[GetDailyDataCommissions-test]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS




DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(20733 row(s) affected) UPDATE ON 05-15-13

--- INITIAL TEST FOR: where DD.ADMACCCOD = '0000091731'


--BEFORE UPDATE:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		NULL			NULL				NULL			KK87			Dent Zone			AM

--UPDATED:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		KK87			Dent Zone			AM				KK87			Dent Zone			AM
-- ==========================================================================================================================================================




-- ==========================================================================================================================================================
-- UPDATE LOB FIELD		[KVT ADDED 05-07-13]: USE EFGCubeFactsDims
-- [KVT 05-28-13: LOB IS NOW IN THE MAIN QUERY: EFG_MSCRM].[dbo].[BusinessUnitBase] BU on a.OwningBusinessUnit = BU.BusinessUnitId; LOB = BU.NAME]
--;
--WITH mycrmreplacement 
--     AS (SELECT DISTINCT dm.[account code], 
--                         CASE 
--                           WHEN c.dealership IS NOT NULL THEN c.dealership 
--                           ELSE [account name] 
--                         END                AS DealerName, 
--                         CASE 
--                           WHEN c2.groupname = '' THEN NULL 
--                           ELSE c2.groupname 
--                         END                AS GroupName, 
--                         CASE 
--                           WHEN c2.agent IS NOT NULL 
--                                AND c2.agent <> '' THEN c2.agent 
--                           ELSE NULL 
--                         END                AS Agent, 
--                         CASE 
--                           WHEN c2.efgrep IS NOT NULL THEN c2.efgrep 
--                           WHEN c2.efgrep IS NULL 
--                                AND c.repagent IS NOT NULL THEN c.repagent 
--                           ELSE NULL 
--                         END                AS EFGRep, 
--                         c2.lob AS crm_lob, 
--                         dm.[record status] AS AccountStatus 
--         FROM   efgdw.dbo.dealermaster AS dm 
--                LEFT OUTER JOIN efgdw.dbo.crmreplacement2 AS c2 
--                             ON dm.[account code] = c2.accountcode 
--                LEFT OUTER JOIN efgdw.dbo.crmdata AS c 
--                             ON dm.[account code] = c.billingaccountnumber 
--         WHERE  ( dm.[account type] = 'DL' ))
         
--, DailyData as
--(SELECT [APVALPVAL]
--      ,[ADMPSTDAT]
--      ,[ADMCLICOD]
--      ,[ADMACCCOD]
--      ,[ADMAGRCOD]
--      ,[ADMAGRSFX]
--      ,[EFG_Rep]
--      ,[Account_Group]
--      ,[Dealer_Name]
--      ,[ADMTRNTYP]
--      ,[ADMDISTYP]
--      ,[AGMPRGCOD]
--      ,[Disbursement_Code]
--      ,[Disbursement_Amount]
--      ,[NON_CANCELFEE_STATUS]
--      ,[RptRunDT]
--      ,[LOB]
--  FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions])
-- ,
--Final AS (
--      SELECT c.*,dd.*
--      FROM DailyData dd
--      LEFT OUTER JOIN mycrmreplacement c ON dd.ADMACCCOD = c.[Account Code]
--      )
                 
----SELECT ADMACCCOD,LOB,[Account Code],crm_lob                       
--UPDATE F SET LOB = crm_lob
--FROM Final F


-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
--SELECT * FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] D

--05-07-13 testing
--(140 row(s) affected)
--(3639 row(s) affected)

--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD	ADMAGRSFX	EFG_Rep	Account_Group	Dealer_Name	ADMTRNTYP	ADMDISTYP	AGMPRGCOD	Disbursement_Code	Disbursement_Amount	NON_CANCELFEE_STATUS	RptRunDT	LOB
--INFORCE	0	EFG	0000027170	             0028319		Cesar Flores	NULL	Santa Fe Mazda	CUR	ADMIN	MAP01	ASGDFADM	10.00	1	2013-05-07 05:00:01.987	Dealer Channel
-- ==========================================================================================================================================================

-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions-TEST2]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions-TEST2]
-- testing for type 2 created by robert green

AS



DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL, CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END as NON_CANCELFEE_STATUS
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit
				, GETDATE() as RptRunDT
           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A)
            , AGA as (select p.[Program Code], p.[Product Category], p.[Super Category]
            FROM  EFGCubeFactsDims.dbo.DimProgramProductCategory P)

      SELECT distinct  se.*, c.*, dd.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      inner join AGA dd
      on se.AGMPRGCOD =  dd.[Program Code]
      WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD
      
 
GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions-UAT]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions-UAT]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

truncate table [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions-UAT2]


DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions-UAT2]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(20733 row(s) affected) UPDATE ON 05-15-13

--- INITIAL TEST FOR: where DD.ADMACCCOD = '0000091731'


--BEFORE UPDATE:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		NULL			NULL				NULL			KK87			Dent Zone			AM

--UPDATED:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		KK87			Dent Zone			AM				KK87			Dent Zone			AM
-- ==========================================================================================================================================================




-- ==========================================================================================================================================================
-- UPDATE LOB FIELD		[KVT ADDED 05-07-13]: USE EFGCubeFactsDims
-- [KVT 05-28-13: LOB IS NOW IN THE MAIN QUERY: EFG_MSCRM].[dbo].[BusinessUnitBase] BU on a.OwningBusinessUnit = BU.BusinessUnitId; LOB = BU.NAME]
--;
--WITH mycrmreplacement 
--     AS (SELECT DISTINCT dm.[account code], 
--                         CASE 
--                           WHEN c.dealership IS NOT NULL THEN c.dealership 
--                           ELSE [account name] 
--                         END                AS DealerName, 
--                         CASE 
--                           WHEN c2.groupname = '' THEN NULL 
--                           ELSE c2.groupname 
--                         END                AS GroupName, 
--                         CASE 
--                           WHEN c2.agent IS NOT NULL 
--                                AND c2.agent <> '' THEN c2.agent 
--                           ELSE NULL 
--                         END                AS Agent, 
--                         CASE 
--                           WHEN c2.efgrep IS NOT NULL THEN c2.efgrep 
--                           WHEN c2.efgrep IS NULL 
--                                AND c.repagent IS NOT NULL THEN c.repagent 
--                           ELSE NULL 
--                         END                AS EFGRep, 
--                         c2.lob AS crm_lob, 
--                         dm.[record status] AS AccountStatus 
--         FROM   efgdw.dbo.dealermaster AS dm 
--                LEFT OUTER JOIN efgdw.dbo.crmreplacement2 AS c2 
--                             ON dm.[account code] = c2.accountcode 
--                LEFT OUTER JOIN efgdw.dbo.crmdata AS c 
--                             ON dm.[account code] = c.billingaccountnumber 
--         WHERE  ( dm.[account type] = 'DL' ))
         
--, DailyData as
--(SELECT [APVALPVAL]
--      ,[ADMPSTDAT]
--      ,[ADMCLICOD]
--      ,[ADMACCCOD]
--      ,[ADMAGRCOD]
--      ,[ADMAGRSFX]
--      ,[EFG_Rep]
--      ,[Account_Group]
--      ,[Dealer_Name]
--      ,[ADMTRNTYP]
--      ,[ADMDISTYP]
--      ,[AGMPRGCOD]
--      ,[Disbursement_Code]
--      ,[Disbursement_Amount]
--      ,[NON_CANCELFEE_STATUS]
--      ,[RptRunDT]
--      ,[LOB]
--  FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions])
-- ,
--Final AS (
--      SELECT c.*,dd.*
--      FROM DailyData dd
--      LEFT OUTER JOIN mycrmreplacement c ON dd.ADMACCCOD = c.[Account Code]
--      )
                 
----SELECT ADMACCCOD,LOB,[Account Code],crm_lob                       
--UPDATE F SET LOB = crm_lob
--FROM Final F


-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
--SELECT * FROM [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions] D

--05-07-13 testing
--(140 row(s) affected)
--(3639 row(s) affected)

--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD	ADMAGRSFX	EFG_Rep	Account_Group	Dealer_Name	ADMTRNTYP	ADMDISTYP	AGMPRGCOD	Disbursement_Code	Disbursement_Amount	NON_CANCELFEE_STATUS	RptRunDT	LOB
--INFORCE	0	EFG	0000027170	             0028319		Cesar Flores	NULL	Santa Fe Mazda	CUR	ADMIN	MAP01	ASGDFADM	10.00	1	2013-05-07 05:00:01.987	Dealer Channel
-- ==========================================================================================================================================================

-- ==========================================================================================================================================================
-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMAGRCOD = '26653000197' AND ADMCLICOD= 'EA') - NO SFX
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	AGMPRGCOD	ADMTRNTYP	EFG_Rep		Account_Group	Dealer_Name							ADMDISTYP	ADMDISCOD	AGMPRGCOD	ADMDISAMT
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84
--CANCELLED	0			EA			0000026653	         26653000197				MAP19		CAN			Adam Ouart	NULL			Porterville Chrysler Jeep Dodge		ADMIN		ASGDFADM	MAP19		-6.84

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================

-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_04_04_2013
-- EXEC RptRulesMaster.dbo.GetDailyDataCommissions_KT_orig


--ADMENTDAT	Entered Date 
--ADMRECDAT	Record Date 

GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataCommissions-UAT2]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataCommissions-UAT2]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS




DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL   
                              ,t.[Product Category]
                              ,t.[Program Code]
                              ,t.[Super Category]
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                             inner join  [SV-SQL06].EFGCubeFactsDims.dbo.[DimProgramProductCategory] T
									on a.AGMPRGCOD =  T.[Program Code]
                              where ADMEFRTYN = 'Y'
                                   AND  ADMPSTDAT >= '20130607'
                                 --   OR  ADMPSTDAT is null 
                                 --   OR  ADMPSTDAT IN (0)
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL001_GetDailyDataCommissions-UAT5]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB]
           ,Product_Category
           ,Program_Code
           ,Super_Category)
         
------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() -18 as [RptRunDT],
            LOB = BusinessUnit
           ,[Product Category]
           ,[Program Code]
           ,[Super Category]
            
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 


AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
 

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD



GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataTier1Sales]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataTier1Sales]

AS

truncate table [RptDataDaily].[dbo].[SAL002_Tier1_Sales]


DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL002' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL002'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL002_Tier1_Sales]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- UPDATE CPROG / CPROD / CPLAN				-- [KVT ADDED 06-11-13]: USE  i400dasql.efgas400.SESCSEFG.AGDTA00 Q 
-- --[KVT UPDATED 06-11-13 FROM CHARLIE'S SAVED QRY]

-- Select * FROM  i400dasql.efgas400.SESCSEFG.AGDTA00 Q  
-- SELECT * FROM RptDataDaily.dbo.SAL002_Tier1_Sales T WHERE T.cprod IS NULL OR T.cplan IS NULL 

-- RptDataDaily.dbo.SAL002_Tier1_Sales T

--SELECT	Q.AGDCLICOD,Q.AGDACCCOD,Q.AGDAGRCOD,Q.AGDAGRSFX,Q.AGDPRDSTS,T.APVALPVAL,
--		T.ADMPSTDAT,T.[ADMCLICOD],T.[ADMACCCOD],T.[ADMAGRCOD],T.[ADMAGRSFX],
--		Q.AGDPRGCOD,Q.AGDPRDCOD,Q.AGDPLNCOD,								
--	    T.AGMPRGCOD,T.cprog, T.cprod, T.cplan				

	UPDATE T SET T.cprog = Q.AGDPRGCOD, T.cprod = Q.AGDPRDCOD, T.cplan = Q.AGDPLNCOD

FROM RptDataDaily.dbo.SAL002_Tier1_Sales T
LEFT JOIN i400dasql.efgas400.SESCSEFG.AGDTA00 Q                                    
	ON  Q.AGDCLICOD = T.ADMCLICOD and
	Q.AGDACCCOD = T.ADMACCCOD and
	Q.AGDAGRCOD = T.ADMAGRCOD and
	Q.AGDAGRSFX = T.ADMAGRSFX and
	Q.AGDPRGCOD = T.AGMPRGCOD
		WHERE T.cprod IS NULL OR T.cplan IS NULL 

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT T.ADMACCCOD,T.LOB, T.AGMPRGCOD,T.Program_Code,T.Product_Category,T.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE T SET T.Program_Code = p.[Program Code],T.Product_Category = p.[Product Category], T.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL002_Tier1_Sales] T
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on T.AGMPRGCOD =  p.[Program Code]
where T.Product_Category is null or  T.Super_Category is null

-- ==========================================================================================================================================================


GO

/****** Object:  StoredProcedure [dbo].[GetDailyDataTier1SalesYTD]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetDailyDataTier1SalesYTD]

AS

--truncate table [RptDataDaily].[dbo].[SAL002_Tier1_Sales_YTD]

DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL002' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL002'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL into #SEDisbData
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and (ADMPSTDAT = @PstDat )--OR LEFT(ADMPSTDAT,4) = YEAR(GETDATE()))
                                   
     
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit
             into #CRMData
           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A
            
  create index idx_acc_code on #CRMData(Account_Code)
  create index idx_ADM_Acnt_Code on   #SEDisbData(ADMACCCOD)       

      SELECT se.*, c.* into #final
      FROM #SEDisbData se
      LEFT OUTER JOIN #CRMData c ON se.ADMACCCOD = c.Account_Code
      
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL002_Tier1_Sales_YTD]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM #final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL002_Tier1_Sales_YTD] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(20733 row(s) affected) UPDATE ON 05-15-13

--- INITIAL TEST FOR: where DD.ADMACCCOD = '0000091731'


--BEFORE UPDATE:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		NULL			NULL				NULL			KK87			Dent Zone			AM

--UPDATED:
--ADMACCCOD		LOB				AGMPRGCOD	Program_Code	Product_Category	Super_Category	Program Code	Product Category	Super Category
--0000091731	Agency Channel	KK87		KK87			Dent Zone			AM				KK87			Dent Zone			AM
-- ==========================================================================================================================================================







GO

/****** Object:  StoredProcedure [dbo].[GetSQLMTDDailyDataCommissions]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GetSQLMTDDailyDataCommissions]
-- testing on 04-04-13 for 1 rec: CREATE PROCEDURE GetDailyDataCommissions_test_26653000197

AS

TRUNCATE TABLE dbo.MTDSQLPull --prevents duplicate data

select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code,
                  BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as LOB, 
ChangeSt = 'Current'
                  

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() -18 as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
                    ) a



GO

/****** Object:  StoredProcedure [dbo].[GrossMonthlyAccountPerformancebyRep]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<GrossMonthlyAccountPerformancebyRep>
-- =============================================
CREATE PROCEDURE [dbo].[GrossMonthlyAccountPerformancebyRep] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
DECLARE @x AS TABLE (LOB varchar(255), Account_Group varchar(255), EFG_Rep varchar(255), Dealer_Name varchar(255), Product_Category varchar(255), 
Program_Code varchar(255), CurrCount int, PreyrCount int, Amount float, PreYrAmount float); 
WITH a AS 

(SELECT        ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, 
                      ISNULL(Account_Group, 'No Group') AS Account_Group, 
                      Dealer_Name, ADMTRNTYP, Product_Category, 
                      Program_Code, 
                      COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD
                       + ADMAGRSFX) AS Count, SUM(Disbursement_Amount) 
                      AS Amount, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group,
                       'No Group') 
                      + EFG_Rep + Dealer_Name + Product_Category + Program_Code
                       + ADMTRNTYP AS ID
FROM            SAL001_GetDailyDataCommissions
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP,
                       Product_Category, Program_Code, ISNULL(LOB, 'No LOB') 
                      + ISNULL(Account_Group, 'No Group') 
                      + EFG_Rep + Dealer_Name + Product_Category + Program_Code),
 b AS
    (SELECT        ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, 
    ISNULL(Account_Group, 'No Group') AS Account_Group, 
    Dealer_Name, ADMTRNTYP, 
    Product_Category, 
     Program_Code,
      COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
      SUM(Disbursement_Amount) AS Amount, 
      ISNULL(LOB,'No LOB') + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + Product_Category + Program_Code + ADMTRNTYP AS ID
      FROM            SAL001_GetDailyDataCommissions_prior_YR
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Product_Category, Program_Code, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
                                + EFG_Rep + Dealer_Name + Product_Category + Program_Code)
    INSERT        
     INTO               @x
                                  SELECT DISTINCT 
                                                            a.LOB, a.Account_Group, a.EFG_Rep, a.Dealer_Name, a.Product_Category, a.Program_Code, 
                                                            CurrCount = SUM(CASE a.ADMTRNTYP WHEN 'CUR' THEN (a.Count) WHEN 'CAN' THEN - (a.Count) WHEN 'REN' THEN (a.Count) ELSE 0 END), 
                                                            PreyrCount = SUM(CASE b.ADMTRNTYP WHEN 'CUR' THEN (b.Count) WHEN 'CAN' THEN - (b.Count) WHEN 'REN' THEN (b.Count) ELSE 0 END), 
                                                            sum(a.amount) AS Amount, sum(b.amount) AS PreYrAmount
                                   FROM            a LEFT OUTER JOIN
                                                            b ON a.ID = b.ID
                                   GROUP BY a.LOB, a.Account_Group, a.EFG_Rep, a.Dealer_Name, a.Product_Category, a.Program_Code
                                                                SELECT        *
                                                                 FROM            @x
                                                                 
                                                                 
END

GO

/****** Object:  StoredProcedure [dbo].[GrossMonthlyAccountPerformancebyRep-RepPullup]    Script Date: 10/11/2013 15:57:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<GrossMonthlyAccountPerformancebyRep>
-- =============================================
CREATE PROCEDURE [dbo].[GrossMonthlyAccountPerformancebyRep-RepPullup]  

@LOBPara varchar (60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
WITH a AS (SELECT        ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account_Group') AS Account_Group, Dealer_Name, ADMTRNTYP, 
                                                   CASE WHEN ADMPSTDAT = 0 THEN DATEPART(MM, GETDATE()) ELSE SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) END AS MonthDT, 
                                                   CASE WHEN ADMPSTDAT = 0 THEN DATEPART(yyyy, GETDATE()) ELSE SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) END AS Year, cprod, 
                                                   COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
                                                   SUM(CASE WHEN Disbursement_Amount >= 0 THEN Disbursement_Amount ELSE 0 END) AS Amount
                         FROM            SAL002_Tier1_Sales_YTD
                         GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMPSTDAT, cprod), b AS
    (SELECT        LOB, EFG_Rep, Account_Group, Dealer_Name, cprod, MonthDT, SUM(Count) AS Count, SUM(Amount) AS Amount, Year, ISNULL(LOB, 'No LOB') 
                                + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + cprod + CAST(MonthDT AS varchar(100)) AS ID
      FROM            a AS a_1
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, cprod, MonthDT, Year, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
                                + EFG_Rep + Dealer_Name + cprod, Year)
    SELECT        LOB, EFG_Rep, Account_Group, Dealer_Name, cprod, MonthDT, Count, Amount, Year, ID
     FROM            b AS b_1
     WHERE        (LOB = @LOBPara)
     
     
     END

GO

/****** Object:  StoredProcedure [dbo].[LOBProductVariancebyCount]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<LOB Product Variance by Count>
-- =============================================
CREATE PROCEDURE [dbo].[LOBProductVariancebyCount]

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @x AS TABLE (LOB varchar(255), Account_Group varchar(255), EFG_Rep varchar(255), Dealer_Name varchar(255), Product_Category varchar(255), 
Product varchar(255), Count int, Amount float, PreYrAmount float, PreYrCount int); WITH a AS (SELECT        ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 
                                          'No Group') AS Account_Group, Dealer_Name, ADMTRNTYP, 
                                          Super_Category, cprod, 
                                          COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX)
                                           AS Count, SUM(Disbursement_Amount) AS Amount
                 FROM            dbo.SAL002_Tier1_Sales
                 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, 
                                          Super_Category, cprod), b AS
(SELECT        LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(count) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
                                + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
      FROM            a
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
                                + EFG_Rep + Dealer_Name + Super_Category + cprod), c AS
    (SELECT        ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Group') AS Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
                                COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, SUM(Disbursement_Amount) AS Amount, ISNULL(LOB, 'No LOB') 
                                + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + Super_Category + cprod + ADMTRNTYP AS ID
      FROM            SAL002_Tier1_Sales_YTD
      WHERE        SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) = datepart(mm, Getdate()) AND SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) = DATEPART(yyyy, 
                                Getdate()) - 1
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
                                + EFG_Rep + Dealer_Name + Super_Category + cprod), d AS
    (SELECT        LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(COUNT) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
                                + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
      FROM            c
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
                                + EFG_Rep + Dealer_Name + Super_Category + cprod)
    INSERT        
     INTO               @x
                                  SELECT DISTINCT 
                                                            ISNULL(b.LOB, d .LOB), ISNULL(b.Account_Group, d .LOB), ISNULL(b.EFG_Rep, D .EFG_Rep), ISNULL(b.Dealer_Name, D .Dealer_Name), 
                                                            ISNULL(b.Super_Category, D .Super_Category), ISNULL(b.cprod, D .cprod), Sum(b.Count), sum(b.amount) AS Amount, sum(d .Amount) 
                                                            AS PreYrAmount, sum(d .Count) AS PreyrCount
                                   FROM            b FULL OUTER JOIN
                                                            d ON b.ID = d .ID
                                   GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, D .EFG_Rep, b.Dealer_Name, D .Dealer_Name, b.Super_Category, 
                                                            D .Super_Category, b.cprod, D .cprod
                                                                SELECT        *
                                                                 FROM            @x


END

GO

/****** Object:  StoredProcedure [dbo].[LOB-Revenue]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LOB-Revenue] 
	-- Add the parameters for the stored procedure here
@LOB Varchar (80) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
WITH x AS (SELECT        TOP (100) PERCENT ISNULL(LOB, 'No LOB') AS LOB, Super_Category, SUM(Disbursement_Amount) AS Amount, CONVERT(varchar, DATENAME(mm, 
                                                   GETDATE())) + ',' + CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
                         FROM            SAL002_Tier1_Sales
                         GROUP BY LOB, Super_Category
                         ORDER BY LOB)
    SELECT        LOB, Super_Category AS Product_Category, Amount, Date
     FROM            x AS x_1
	 WHERE        (LOB = ISNULL(@LOB, LOB)) AND (Amount <> 0)END

GO

/****** Object:  StoredProcedure [dbo].[LOBRevenuePacing]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<LOB Revenue Pacing>
-- =============================================
CREATE PROCEDURE [dbo].[LOBRevenuePacing] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select ISNULL(LOB,'No LOB') as LOB,

SUM(case when ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0) then Disbursement_amount else 0 End) as Amount_MTD,
SUM(case when ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate())-1  ) then Disbursement_amount else 0 End) as Amount_PRM

from RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
where ( ADMPSTDAT = 0 OR 
		(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate())-1 AND  SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5,2)=DATEPART(mm,getdate()) )
	 )	

Group by LOB


END

GO

/****** Object:  StoredProcedure [dbo].[LOBRevenueTrend]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07252013>
-- Description:	<LOB Revenue Trend>
-- =============================================
CREATE PROCEDURE [dbo].[LOBRevenueTrend]
AS
BEGIN
	SET NOCOUNT ON;

WITH a AS (SELECT      ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account_Group') 
AS Account_Group, Dealer_Name, ADMTRNTYP,MonthDT=CASE WHEN ADMPSTDAT=0 THEN DATEPART(MM,GETDATE()) ELSE
SUBSTRING(CONVERT(VARCHAR,ADMPSTDAT),5,2) END ,ADMPSTDAT,
cprod,COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX)AS Count, SUM(Disbursement_Amount) AS Amount
FROM           [SAL002_Tier1_Sales_YTD] where SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)= DATEPART(yyyy,Getdate()) or SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=0
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP,  cprod,ADMPSTDAT),
 b as 

(select LOB,EFG_Rep,Account_Group,Dealer_Name,cprod,  MONTHDT,SUM((CASE a.ADMTRNTYP WHEN 'CUR' THEN (a.Count) WHEN 'CAN' THEN - (a.Count) WHEN 'REN' THEN (a.Count) ELSE 0 END)) as Count,SUM(Amount) as Amount,
ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
+ EFG_Rep + Dealer_Name +  cprod+ cast(MONTHDT as varchar(100)) as ID
FROM a  
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name,cprod,MONTHDT, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
+ EFG_Rep + Dealer_Name +  cprod),c as
(select LOB,ISNULL(Account_Group,'No Group')as Account_Group,EFG_Rep,Dealer_Name,product,sum(Plan_Revenue) as Revenue,sum(Plan_Count) as Count ,MOnth,YEAR ,ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
+ EFG_Rep + Dealer_Name +  Product as ID from [SAL002_Tier1_Sales_Plan] 
group by LOB,Account_Group,EFG_Rep,Dealer_Name,product,MOnth,YEAR,ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
+ EFG_Rep + Dealer_Name +  Product+ cast(MOnth as varchar(100)) )

select ISNULL(B.LOB,C.LOB) AS LOB,ISNULL(B.Account_Group,C.Account_Group) as Account_Group,ISNULL(B.EFG_Rep,C.EFG_Rep)as EFG_Rep,ISNULL(B.Dealer_Name,C.Dealer_Name)as Dealer_Name,ISNULL(B.CPROD,C.PRODUCT)as Product,sum(B.Amount) as Amount,sum(c.Revenue) as planrevenue,sum(b.Count)as Count,sum(c.count) as Plancount,ISNULL(b.MonthDT,C.Month)AS MONTHDT
from b full outer join c on b.id=c.ID
group by b.LOB,c.lob,b.Account_Group,c.Account_Group,b.EFG_Rep,C.EFG_Rep,b.Dealer_Name,C.Dealer_Name,b.cprod,c.Product,B.MonthDT,C.Month

END

GO

/****** Object:  StoredProcedure [dbo].[Month_Account_Performance_to_Plan_by_Product]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <C07252013>
-- Description:	<Month_Account_Performance_to_Plan_by_Product>
-- =============================================
CREATE PROCEDURE [dbo].[Month_Account_Performance_to_Plan_by_Product]

@LOB VARCHAR(60),
@efg_rep VARCHAR(60),
@account_group VARCHAR(60),
@dealer_name VARCHAR(125)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

With final_data As
(
   select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,isNull(Account_Group, 'No Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
      ,isnull(cprod, 'No Product') as cprod
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month

 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
	  and isNull(Dealer_Name, 'No Account')  = @dealer_name
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
      ,cprod
 
)
, final_plan AS
(
 select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      isNull(Account_Group, 'No Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
	  and isNull(Dealer_Name, 'No Account') = @dealer_name
	  
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
      ,product
)

--Pull final ResultSet
Select isNull(c.LOB,p.LOB) as LOB ,isnull(c.Efg_Rep,p.EFG_Rep) as EFG_REp, isNull(c.Account_Group,p.Account_Group)as Account_Group,
isnull(c.Dealer_Name,p.Dealer_Name) as Dealer_name,ISNULL(c.cprod,p.Product) as Product,

isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD
 
 From Final_Data c Full Outer Join Final_plan p  
	ON 
		c.LOB=p.LOB AND c.EFG_Rep=p.EFG_Rep  AND c.Account_Group=p.Account_Group 
		AND c.Dealer_Name = p.Dealer_Name AND c.cprod= p.product
 
END

GO

/****** Object:  StoredProcedure [dbo].[Month_Account_Performance_to_Plan_by_Product-Acct]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <C07252013>
-- Description:	<Month_Account_Performance_to_Plan_by_Product-AcctGroup>
-- =============================================
CREATE PROCEDURE [dbo].[Month_Account_Performance_to_Plan_by_Product-Acct]

@LOB VARCHAR(60),
@efg_rep VARCHAR(60),
@Account_group NCHAR(125)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

With final_data As
(
     select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,isNull(Account_Group, 'No Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
      --,isnull(cprod, 'No Product') as cprod
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month

 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
      --,cprod
 
)
, final_plan AS
(
 select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      isNull(Account_Group, 'No Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      --isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
      --,product
)

--Pull final ResultSet
Select isNull(c.LOB,p.LOB) as LOB ,isnull(c.Efg_Rep,p.EFG_Rep) as EFG_REp, isNull(c.Account_Group,p.Account_Group)as Account_Group,
isnull(c.Dealer_Name,p.Dealer_Name) as Dealer_name,

isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD
 
 From Final_Data c Full Outer Join Final_plan p  
	ON 
		c.LOB=p.LOB AND c.EFG_Rep=p.EFG_Rep  AND c.Account_Group=p.Account_Group 
		AND c.Dealer_Name = p.Dealer_Name 
 
 
 
 
END

GO

/****** Object:  StoredProcedure [dbo].[Month_Account_Performance_to_Plan_by_Product-AcctGroup]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <C07252013>
-- Description:	<Month_Account_Performance_to_Plan_by_Product-AcctGroup>
-- =============================================
CREATE PROCEDURE [dbo].[Month_Account_Performance_to_Plan_by_Product-AcctGroup]

@LOB VARCHAR(60),
@efg_rep VARCHAR(60)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

With final_data As
(
     select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,isNull(Account_Group, 'No Group')as Account_Group
      --,isNull(Dealer_Name, 'No Account') as Dealer_Name
      --,isnull(cprod, 'No Product') as cprod
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month

 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
      Group By LOB,EFG_Rep
      ,Account_group 
      --,Dealer_Name,cprod
 
)
, final_plan AS
(
 select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      isNull(Account_Group, 'No Group')as Account_Group,
      --isNull(Dealer_Name,' No Account') as Dealer_Name,
      --isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  --and Account_Group = @account_group
      Group By LOB,EFG_Rep,Account_group
      --,Dealer_Name
      --,product
)

--Pull final ResultSet
Select isNull(c.LOB,p.LOB) as LOB ,isnull(c.Efg_Rep,p.EFG_Rep) as EFG_REp, isNull(c.Account_Group,p.Account_Group)as Account_Group,

isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD
 
 From Final_Data c Full Outer Join Final_plan p  
	ON c.LOB=p.LOB AND c.EFG_Rep=p.EFG_Rep  AND c.Account_Group=p.Account_Group
 
 
 
END

GO

/****** Object:  StoredProcedure [dbo].[Month_Account_Performance_to_Plan_by_RepMain_home]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07242013>
-- Description:	<Month_Account_Performance_to_Plan_by_RepMain_home6>
-- =============================================
CREATE PROCEDURE [dbo].[Month_Account_Performance_to_Plan_by_RepMain_home]
@LOB varchar (60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


With Final_data As
(
      select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month

 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
      Group By LOB,EFG_Rep
 
)
--Plan Data
, final_plan AS
(
 select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,
      
      --isNull(Account_Group, 'No Group')as Account_Group,
      --isNull(Dealer_Name,' No Account') as Dealer_Name,
      --isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  Group By LOB,EFG_Rep
      --,Account_group,Dealer_Name
      --,product
)

--Pull final ResultSet
Select isNull(c.LOB,p.LOB) as LOB ,isnull(c.Efg_Rep,p.EFG_Rep) as EFG_REp, isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD
 
 From Final_Data c Full Outer Join Final_plan p  ON c.LOB=p.LOB AND c.EFG_Rep=p.EFG_Rep 



END

GO

/****** Object:  StoredProcedure [dbo].[MTD-Report]    Script Date: 10/11/2013 15:57:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07/24/2013>
-- Description:	<Gets Commissions report data>
-- =============================================
CREATE PROCEDURE [dbo].[MTD-Report] 
@StartDate Datetime , @EndDate Datetime , @UserName VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
DECLARE @User varchar (35)
DECLARE @RptCode VARCHAR(10)
SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode

SELECT DISTINCT 
	   LOB,
	   efg_rep, 
       account_group, 
       dealer_name, 
       non_cancelfee_status, 
       admtrntyp, 
       Sum(disbursement_amount)         AS amt, 
       Count(DISTINCT admclicod + admacccod + admagrcod + 
                                        admagrsfx 
                         )    AS contract_count ,
       CAST(NON_CANCELFEE_STATUS AS VARCHAR) AS RepGroupID,
      '1' AS id
        
FROM   [SAL001_GetDailyDataCommissions-UAT2] F00
WHERE Disbursement_Code NOT IN (SELECT FieldValue FROM @ExceptionsTbl)
and RptRunDT between (@StartDate) and (@EndDate) 
and ChangeST = 'Current'
and efg_rep in (@UserName)
GROUP  BY efg_rep, 
          account_group, 
          dealer_name, 
          non_cancelfee_status, 
          F00.admtrntyp, LOB
ORDER  BY F00.efg_rep

END

GO

/****** Object:  StoredProcedure [dbo].[MTD-Summary-MTD-Report]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07/24/2013>
-- Description:	<MTD summary for commission report>
-- =============================================
CREATE PROCEDURE [dbo].[MTD-Summary-MTD-Report]

@StartDate DateTime,
@EndDate DATETIME,
@UserName varchar (50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @RptCode VARCHAR(10)
SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode;


WITH Forsum --Start of CTE to get cal numbers for output --R.Green designed 
AS (SELECT    EFG_Rep, LOB,   COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Contract_Count,
ADMTRNTYP, NON_CANCELFEE_STATUS, CAST(NON_CANCELFEE_STATUS AS VARCHAR) AS RepGroupID,  SUM(Disbursement_Amount) 
                          AS amt
              FROM            [SAL001_GetDailyDataCommissions-UAT2]
              where ChangeST = 'current'
and Disbursement_Code NOT IN (SELECT FieldValue FROM @ExceptionsTbl)
and RptRunDT between (@StartDate) and (@EndDate) 
and efg_rep in (@UserName)
         GROUP BY LOB, efg_rep,   Dealer_Name, ADMTRNTYP, NON_CANCELFEE_STATUS) 
         
      
      
				 SELECT       SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN Contract_Count END) AS New_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN amt END) AS New_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN Contract_Count END) AS CB_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN amt END) AS CB_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' THEN Contract_Count END) AS CF_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' THEN amt END) AS CF_amt, 
                              SUM(CASE WHEN ADMTRNTYP = 'REN' THEN Contract_Count END) AS REN_Count, SUM(CASE WHEN ADMTRNTYP = 'REN' THEN amt END) AS REN_amt, 
                              SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN Contract_Count END) AS AMD_Count, SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN amt END) AS AMD_Amt, 
                              LOB,
                              COUNT(RepGroupID) [Number Of Accounts]

                              
                        
     FROM            FORSUM AS FORSUM_1
     
     group by LOB
     order by  LOB ASC 
END

GO

/****** Object:  StoredProcedure [dbo].[RevenuebyProduct]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RevenuebyProduct]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


WITH x AS (SELECT        TOP (100) PERCENT ISNULL(LOB, 'No LOB') AS LOB, Super_Category, ISNULL(cprod, 'No Product') AS cprod, SUM(Disbursement_Amount) AS Amount, 
                                                   CONVERT(varchar, DATENAME(mm, GETDATE())) + ',' + CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
                         FROM            SAL002_Tier1_Sales
                         GROUP BY LOB, Super_Category, cprod
                         ORDER BY LOB)
    SELECT        LOB, Super_Category AS Product_Category, cprod, Amount, Date
     FROM            x AS x_1
     WHERE        (Amount <> 0)END

GO

/****** Object:  StoredProcedure [dbo].[spGetDataforDailyreport]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[spGetDataforDailyreport]
as
Begin
truncate table RptGetDatatbl
insert into RptGetDatatbl(EFG_Rep,Account_Group,Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,Disbursement_Code,Count,Disbursement_Amount,Status) 
SELECT EFG_Rep, Account_Group, Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,disbursement_code,COUNT(*) as Contract_Count,Sum(Disbursement_Amount) as Disbursement_Amount,1 as Status  
FROM dbo.SAL001_GetDailyDataCommissions
group by EFG_Rep, Account_Group, Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,disbursement_code
order by EFG_Rep, Account_Group, Dealer_Name,APVALPVAL DESC

update RptGetDatatbl set Status=case when disbursement_code like '%CANCELFEE%' THEN 0 ELSE 1 END
select EFG_Rep,Account_Group,Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,Disbursement_Code,Count as Contract_Count,Disbursement_Amount,Status from RptGetDatatbl
END
GO

/****** Object:  StoredProcedure [dbo].[spGetDataforDailyreport_jp]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[spGetDataforDailyreport_jp]
as
Begin
truncate table RptGetDatatbl
insert into RptGetDatatbl(EFG_Rep,Account_Group,Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,Disbursement_Code,Count,Disbursement_Amount,Status) 
SELECT EFG_Rep, Account_Group, Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,disbursement_code,COUNT(*) as Contract_Count,Sum(Disbursement_Amount) as Disbursement_Amount,1 as Status  
FROM dbo.SAL001_GetDailyDataCommissions
group by EFG_Rep, Account_Group, Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,disbursement_code
order by EFG_Rep, Account_Group, Dealer_Name,APVALPVAL DESC

update RptGetDatatbl set Status=case when disbursement_code like '%CANCELFEE%' THEN 0 ELSE 1 END
select EFG_Rep,Account_Group,Dealer_Name,APVALPVAL,ADMTRNTYP,ADMPSTDAT,Disbursement_Code,Count as Contract_Count,Disbursement_Amount,Status from RptGetDatatbl
END
GO

/****** Object:  StoredProcedure [dbo].[spgetdataforTier2]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[spgetdataforTier2]
as
with CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
            
            CLAIM_AMOUNT AS (select PRDACCCOD,SUM(PRDCHKAMT) AS CLAIM_AMOUNT,PRDPRDCOD  from I400DASQL.EFGAS400.SESCSEFG.SCPAYRD
WHERE PRDPAYTYP = 'CL' AND PRDCRTDAT BETWEEN 20120101 AND 20120131
GROUP BY PRDACCCOD,PRDPRDCOD),

Earned_data as 
(select AEPACCCOD,AEPPRDCOD,SUM(AEPERNCM) as EarnedReserves from I400DASQL.EFGAS400.SESCSEFG.SCAGREP where  AEPCRTDAT BETWEEN 20120101 AND 20120131
group by AEPACCCOD,AEPPRDCOD),

CRM_CA AS
(SELECT CRM.*,ISNULL(CS.PRDPRDCOD,'') AS PRDPRDCOD,CS.CLAIM_AMOUNT FROM  CRMData CRM  left OUTER JOIN CLAIM_AMOUNT CS ON CRM.ACCOUNT_CODE=CS.PRDACCCOD),

CRM_ED AS 
(SELECT CRM.*,ISNULL(ED.AEPPRDCOD,'') AS AEPPRDCOD,ED.EarnedReserves FROM CRMData CRM left OUTER JOIN Earned_data ED ON CRM.ACCOUNT_CODE=ED.AEPACCCOD),
TRN_TYP AS 
( select * from openquery(I400dasql,
      'SELECT ADMACCCOD, Count(Distinct((ADMACCCOD||ADMAGRCOD||ADMAGRSFX||ADMCLICOD||ADMPRDCOD))) as Count,ADMPRDCOD,ADMTRNTYP
                              FROM SESCSEFG.SCAGRM A                                     
                              inner join SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = ''~MVPRDSTS''
                              where ADMEFRTYN = ''Y'' and ADMPSTDAT = 20120131
                                    
                                    group by ADMACCCOD,ADMPRDCOD,ADMTRNTYP')      
                                    ),
    CRM_TRNTYP AS (SELECT CRMData.*,TRN_TYP.Count,TRN_TYP.ADMTRNTYP,ISNULL(TRN_TYP.ADMPRDCOD,'') AS ADMPRDCOD from  CRMData left outer join TRN_TYP on CRMData.Account_Code=TRN_TYP.ADMACCCOD)
      ,
   sfinal as                      
                                    

--SELECT COUNT(*)FROM CRM_CA  FULL OUTER JOIN  CRM_ED ON CRM_CA.Account_Code=CRM_ED.AEPACCCOD AND CRM_CA.PRDPRDCOD=CRM_ED.AEPPRDCOD
(SELECT ISNULL(CRM_CA.EFG_Rep,CRM_ED.EFG_Rep) AS EFG_Rep,ISNULL(CRM_CA.ACCOUNT_GROUP,CRM_ED.ACCOUNT_GROUP) AS ACCOUNT_GROUP,
ISNULL(CRM_CA.DEALER_NAME,CRM_ED.DEALER_NAME) AS DEALER_NAME,ISNULL(CRM_CA.ACCOUNT_CODE,CRM_ED.ACCOUNT_CODE) AS ACCOUNT_CODE,
ISNULL(CRM_CA.BusinessUnit,CRM_ED.BusinessUnit) AS BusinessUnit,ISNULL(CRM_CA.PRDPRDCOD,CRM_ED.AEPPRDCOD) AS PRODUCT_CODE,
ISNULL(CRM_CA.CLAIM_AMOUNT,0.00) AS CLAIM_AMOUNT,ISNULL(CRM_ED.EARNEDRESERVES,0.00) AS EARNED_RESERVES
FROM CRM_CA FULL OUTER JOIN  CRM_ED ON CRM_CA.Account_Code=CRM_ED.Account_Code AND CRM_CA.PRDPRDCOD=CRM_ED.AEPPRDCOD),
Total_ReserveData as 
(select * from openquery(I400dasql,
      'SELECT ADMACCCOD, SUM(ADMDISAMT) as Total_Reserves,ADMPRDCOD
                              FROM SESCSEFG.SCAGRM A                                     
                              inner join SESCSEFG.SCAGRDM06 D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = ''~MVPRDSTS''
                              where ADMEFRTYN = ''Y'' and ADMPSTDAT = 20130131
                                    group by ADMACCCOD,ADMPRDCOD,ADMTRNTYP')),CRM_TRD AS
 (SELECT  CRMData.* ,ISNULL(TRD.ADMPRDCOD,'') AS ADMPRDCOD,TRD.Total_Reserves FROM CRMData LEFT OUTER JOIN  Total_ReserveData TRD ON CRMData.Account_Code=TRD.ADMACCCOD)
,
                   
final as

(select ISNULL(sf.EFG_Rep,CRM_TRD.EFG_Rep) AS EFG_Rep,ISNULL(sf.ACCOUNT_GROUP,CRM_TRD.ACCOUNT_GROUP) AS ACCOUNT_GROUP ,ISNULL(sf.DEALER_NAME,CRM_TRD.DEALER_NAME) AS DEALER_NAME,ISNULL(sf.ACCOUNT_CODE,CRM_TRD.ACCOUNT_CODE) AS ACCOUNT_CODE,ISNULL(sf.BusinessUnit,CRM_TRD.BusinessUnit) AS BusinessUnit,ISNULL(sf.PRODUCT_CODE,CRM_TRD.ADMPRDCOD) AS PRODUCT_CODE ,ISNULL(sf.CLAIM_AMOUNT,0.00) AS CLAIM_AMOUNT,ISNULL(sf.EARNED_RESERVES,0.00) AS EARNED_RESERVES ,ISNULL(CRM_TRD.Total_Reserves,0) AS Total_Reserves from sfinal sf full outer join CRM_TRD on sf.ACCOUNT_CODE=CRM_TRD.Account_Code and sf.PRODUCT_CODE=
CRM_TRD.ADMPRDCOD)
,
Final00 as
(select final.*,CRM_TRNTYP.Count as Contract_Count,CRM_TRNTYP.ADMTRNTYP,'20120131' as PSTDATE from final full outer join  CRM_TRNTYP  on final.Account_Code=CRM_TRNTYP.Account_Code and final.PRODUCT_CODE=CRM_TRNTYP.ADMPRDCOD)
select * from  Final00 

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product]
@Cat nvarchar(320)=NULL
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- EXEC SSRS_SalesTier1_Channel_Revenue_By_Product 'No Category'
SELECT Isnull(super_category, 'No Category') 
              AS 
              Product_Category, 
              Isnull(cprod, 'No Product') 
              AS Product, 
              Sum(disbursement_amount) AS Amount, 
              CONVERT(VARCHAR, Datename(mm, Getdate())) 
              + ',' 
              + CONVERT(VARCHAR, Datepart(yyyy, Getdate())) 
              AS 
              Date 
         FROM   sal002_tier1_sales 
         WHERE Isnull(super_category, 'No Category') = ISNULL(@Cat, ISNULL(Product_Category, 'No Category'))
         GROUP  BY super_category, cprod
         HAVING Sum(disbursement_amount) <> 0
         

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Channel_Revenue_By_Product_Category]
AS
SELECT Isnull(super_category, 'No Category') 
              AS 
              Product_Category, 
              Sum(disbursement_amount) 
              AS 
                 Amount, 
              CONVERT(VARCHAR, Datename(mm, Getdate())) 
              + ',' 
              + CONVERT(VARCHAR, Datepart(yyyy, Getdate())) 
              AS 
              Date 
         FROM   sal002_tier1_sales 
         GROUP  BY super_category
         HAVING  Sum(disbursement_amount) <> 0
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_GetDailyDataCommissions_prior_yr]    Script Date: 10/11/2013 15:57:49 ******/
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
     Amount FLOAT 
  ) 

IF @GroupOn = 0 
Begin
		INSERT INTO @y (lob, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
		GROUP  BY lob
		SELECT LOB, Amount 
		FROM   @y  		
End
ELSE IF @GroupOn = 1
Begin
		INSERT INTO @y (LOB, EFG_Rep, Amount) 
		SELECT ISNULL(lob, 'NO LOB'), 
				EFG_Rep,
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
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
			   Sum(disbursement_amount) AS Amount 
		FROM   sal001_getdailydatacommissions_prior_yr 
		WHERE  ( Substring(Cast(admpstdat AS VARCHAR), 5, 2) = Datepart(mm, Getdate()) )
		        AND ( Substring(Cast(admpstdat AS VARCHAR), 0, 5) = Datepart(yyyy, Getdate()) - 1 ) 
		GROUP  BY LOB, Account_Group, EFG_Rep
		SELECT LOB, Account_Group, EFG_Rep, Amount 
		FROM   @y  
		Return
End


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Gross_Monthly_Account_Performance]    Script Date: 10/11/2013 15:57:49 ******/
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
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts'
				
				Gross Monthly Account Performance by AccountGroup
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='Billion Auto Group'
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group'
				
						
				Gross Monthly Account Performance by Account
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group', @Account='Aristocrat Motors' 
				
				Gross Monthly Account Performance by Product
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group', @Account='Aristocrat Motors' 				
				

*/

AS 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

SELECT	lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account_Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		cprod=ISNULL(cprod, 'No Product'), 
		monthdt= CASE 
				WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
				ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
				END,								   
		[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),
		Amount=Sum(CASE WHEN disbursement_amount >= 0 
					THEN disbursement_amount ELSE 0 END),
		[year]=CASE 
			  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
				ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
				END
				,
		id=Isnull(lob, 'No LOB') + '-' + Isnull(account_group, 'No Account Group')
		+ '-' + Isnull(efg_rep,'No Rep') +  '-' + Isnull(dealer_name, 'No Account') + '-' + Isnull(cprod, 'No Product')
 FROM   sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account_Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account_Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 GROUP  BY lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   cprod,
		   CASE 
			WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END  ,
		admpstdat

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Product_Variance_by_Count]    Script Date: 10/11/2013 15:57:49 ******/
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

WITH a AS (
	SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group,
	'No Group') AS Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count,
	SUM(Disbursement_Amount) AS Amount
	FROM dbo.SAL002_Tier1_Sales
	GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, 
	Super_Category, cprod
   ),
  b AS 
   (
	 SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	 SUM(count) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
	 + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + 
	 Super_Category + cprod AS ID
	 FROM a
	 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	 ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
	 + EFG_Rep + Dealer_Name + Super_Category + cprod
 ), 
 c AS 
 (
	SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, 
	ISNULL(Account_Group, 'No Group') AS Account_Group, Dealer_Name, 
	ADMTRNTYP, Super_Category, cprod,
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
		SUM(Disbursement_Amount) AS Amount, ISNULL(LOB, 'No LOB') 
            + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name 
            + Super_Category + cprod + ADMTRNTYP AS ID
      FROM  SAL002_Tier1_Sales_YTD
      WHERE  
      SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) = datepart(mm, Getdate()) AND 
      SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) = DATEPART(yyyy, Getdate()) - 1
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP,
      Super_Category,
      cprod, ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod
   ), 
 d AS
    (
	SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod,
		SUM(COUNT) AS Count, SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB') 
        + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + 
        Super_Category + cprod AS ID
      FROM            c
      GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod,
      ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod)
    INSERT INTO @x
    SELECT DISTINCT ISNULL(b.LOB, d .LOB), 
		ISNULL(b.Account_Group, d .Account_Group),
		ISNULL(b.EFG_Rep, D .EFG_Rep),
		ISNULL(b.Dealer_Name, D .Dealer_Name), 
		ISNULL(b.Super_Category, D .Super_Category), 
		ISNULL(b.cprod, D .cprod), Sum(b.Count), sum(b.amount) AS Amount, 
		sum(d .Amount) AS PreYrAmount, sum(d .Count) AS PreyrCount
	FROM b 
	FULL OUTER JOIN
		d ON b.ID = d .ID
	 GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, 
	 D.EFG_Rep, b.Dealer_Name, D .Dealer_Name, b.Super_Category, 
       D.Super_Category, b.cprod, D .cprod
     
     SELECT * FROM @x

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_By_Prod] 
@LOB nvarchar(320),
@Cat nvarchar(320)
AS
-- SSRS_SalesTier1_LOB_Revenue_By_Prod 'Agency Services', 'AM'
SELECT 
  ISNULL(LOB, 'No LOB') AS LOB, 
  Super_Category AS Product_Category,
  ISNULL(cprod, 'No Product') AS cprod,
  SUM(Disbursement_Amount) AS Amount,
  CONVERT(varchar, DATENAME(mm, GETDATE())) + ',' + 
  CONVERT(varchar, DATEPART(yyyy, GETDATE())) AS Date
 FROM SAL002_Tier1_Sales
 WHERE ISNULL(LOB, 'No LOB')= @LOB
 AND Super_Category = @Cat
 GROUP BY LOB, Super_Category, cprod
 HAVING SUM(Disbursement_Amount)<>0

GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_Pacing]
AS

SELECT ISNULL(LOB,'No LOB') as LOB,
SUM(CASE
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) 
       OR ADMPSTDAT = 0) 
	THEN Disbursement_amount else 0 End) as Amount_MTD,
SUM(CASE 
	WHEN (SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate())-1)
	THEN Disbursement_amount else 0 End) AS Amount_PRM
FROM  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
WHERE 
( ADMPSTDAT = 0 OR 
	(SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate())-1 
	AND  
	SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5,2)=DATEPART(mm,getdate()))
)	
GROUP by LOB
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_LOB_Revenue_Trend]
@LOB nvarchar(320) = NULL, 
@AccountGroup nvarchar(320) = NULL
AS
-- SSRS_SalesTier1_LOB_Revenue_Trend 'Dealer Services', 'Parkway Group'
WITH a 
     AS (SELECT Isnull(lob, 'No LOB')                                        AS 
                LOB, 
                efg_rep, 
                Isnull(account_group, 'No Account_Group')                    AS 
                   Account_Group, 
                dealer_name, 
                admtrntyp, 
                MonthDT=CASE 
                          WHEN admpstdat = 0 THEN Datepart(mm, Getdate()) 
                          ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                        END, 
                admpstdat, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx)AS 
                Count 
                , 
                Sum(disbursement_amount) 
                AS Amount 
         FROM   [sal002_tier1_sales_ytd] 
         WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) =  Datepart(yyyy, Getdate()) 
                 OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0)
                 AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
                 AND ISNULL(@AccountGroup, 'No Account_Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account_Group'))
                 
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
                + Isnull(account_group, 'No Account_Group') 
                + efg_rep + dealer_name + cprod 
                + Cast(monthdt AS VARCHAR(100)) AS ID 
         FROM   a 
         WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         AND ISNULL(@AccountGroup, 'No Account_Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account_Group'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   cprod, 
                   monthdt, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account_Group') 
                   + efg_rep + dealer_name + cprod), 
     c 
     AS (SELECT lob, 
                Isnull(account_group, 'No Account_Group')AS Account_Group, 
                efg_rep, 
                dealer_name, 
                product, 
                Sum(plan_revenue)                        AS Revenue, 
                Sum(plan_count)                          AS Count, 
                month, 
                year, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Account_Group') 
                + efg_rep + dealer_name + product        AS ID 
         FROM   [sal002_tier1_sales_plan] 
         WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
         AND ISNULL(@AccountGroup, 'No Account_Group') = ISNULL(@AccountGroup, Isnull(account_group, 'No Account_Group'))
         GROUP  BY lob, 
                   account_group, 
                   efg_rep, 
                   dealer_name, 
                   product, 
                   month, 
                   year, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Account_Group') 
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

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]    Script Date: 10/11/2013 15:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account]
@LOB nvarchar(320),
@efg_rep nvarchar(320),
@Account_Group nvarchar(320)
AS
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
      ,isNull(Account_Group, 'No Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX)
			 End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount 
			else 0 end) as Amount_Month
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
      Group By LOB,EFG_Rep
      ,Account_group 
      ,Dealer_Name
 
)
 AS FinalData 
 Full Outer Join 
(	   select
      isNull(LOB,'No LOB') as LOB,
      EFG_Rep,      
      isNull(Account_Group, 'No Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue 
		else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 
			End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Account_Group]
@LOB nvarchar(320),
@efg_rep nvarchar(320)
AS

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
      ,isNull(Account_Group, 'No Group')as Account_Group
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
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
      isNull(Account_Group, 'No Group')as Account_Group,
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',
      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
      Group By LOB,EFG_Rep,Account_group
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  AND finaldata.Account_Group=finalplan.Account_Group		


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Product]    Script Date: 10/11/2013 15:57:50 ******/
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
      ,isNull(Account_Group, 'No Group')as Account_Group
      ,isNull(Dealer_Name, 'No Account') as Dealer_Name
      ,isnull(cprod, 'No Product') as cprod
      ,count(distinct ( case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
      ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
      ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
	  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month

 
      from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
	  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
	  and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
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
      
      isNull(Account_Group, 'No Group')as Account_Group,
      isNull(Dealer_Name,' No Account') as Dealer_Name,
      isNull(product,'No Product')as Product,
       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 then Plan_Revenue else 0 End )'Amount_Plan_YTD',

      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  and EFG_Rep = @efg_rep
	  and isNull(Account_Group, 'No Group') = @account_group
	  and isNull(Dealer_Name, 'No Account') = @dealer_name
	  
      Group By LOB,EFG_Rep,Account_group,Dealer_Name
      ,product
  ) As FinalPlan
      ON finaldata.LOB=finalplan.LOB AND finaldata.EFG_Rep=finalplan.EFG_Rep  
      AND finaldata.Account_Group=finalplan.Account_Group		
      AND finaldata.Dealer_Name = finalplan.Dealer_Name
      AND finaldata.cprod= finalplan.product


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Month_Account_Performance_to_Plan_by_Rep]
@LOB nvarchar(320) 
AS


Select isNull(final_data.LOB,finalplan.LOB) as LOB ,isnull(final_data.Efg_Rep,finalplan.EFG_Rep) as EFG_REp, 
isnull(Cnt_Month,0)Cnt_Month,isnull(Amount_Month,0)Amount_Month,
isnull(Cnt_Plan,0)Cnt_Plan,isnull(Amount_Plan,0)Amount_Plan,
isnull(Cnt_Plan_YTD,0)Cnt_Plan_YTD,isnull(Amount_Plan_YTD,0)Amount_Plan_YTD,
isnull(Cnt_YTD,0)Cnt_YTD,isnull(Amount_YTD,0)Amount_YTD 
From 
(select isNull(LOB,'No LOB') as LOB,EFG_Rep
  ,count(distinct(case when  ADMPSTDAT=0 then (ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) End) ) as Cnt_month
  ,count(distinct ADMCLICOD+ADMACCCOD+ADMAGRCOD+ADMAGRSFX) as cnt_YTD
  ,sum(case when Disbursement_amount>=0 then Disbursement_amount else 0 End)'Amount_YTD'
  ,sum( case when (ADMPSTDAT=0 and Disbursement_amount>=0) then Disbursement_amount else 0 end) as Amount_Month 
  from  RptDataDaily.dbo.SAL002_Tier1_Sales_YTD
  where ( SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0,5)=YEAR(getdate()) OR ADMPSTDAT = 0)
  and isNull(LOB,'No LOB') = @LOB
  Group By LOB,EFG_Rep)
AS final_data
Full Outer Join 
(
 select
      isNull(LOB,'No LOB') as LOB,EFG_Rep,       
      sum(case when (Plan_Revenue > 0 and [Month]=Month(getdate()) ) 
            then Plan_Revenue else 0 End )'Amount_Plan',
      sum(case when Plan_Revenue >0 
             then Plan_Revenue else 0 End )'Amount_Plan_YTD',
      sum( case when [Month]=Month(getdate()) then Plan_Count else 0 End )  'Cnt_Plan',
	  Sum(plan_count) as Cnt_Plan_YTD
	  
      from  [RptDataDaily].[dbo].[SAL002_Tier1_Sales_Plan]
      Where [Year] <=DATEPART(yy,getdate())
      and isNull(LOB,'No LOB') = @LOB
	  Group By LOB,EFG_Rep
) AS finalplan ON finalplan.LOB=final_data.LOB AND finalplan.EFG_Rep=final_data.EFG_Rep 


GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_NET_Monthly_Account_Performance]
@LOB nvarchar(320),
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL
AS 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SELECT	lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account_Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		cprod=ISNULL(cprod, 'No Product'), 
		monthdt= CASE 
			WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
			ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
			END,								   
		[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),
		Amount=Sum(disbursement_amount),
		[year]=CASE 
			 WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
			END
				,
	id=Isnull(lob, 'No LOB') + '-' + Isnull(account_group, 'No Account Group')
		+ '-' + Isnull(efg_rep,'No Rep') +  '-' + Isnull(dealer_name, 'No Account') + '-' + Isnull(cprod, 'No Product')
 FROM   sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account_Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account_Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 GROUP  BY lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   cprod,
		   CASE 
			WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END  ,
		admpstdat
 Order By 		
 lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   cprod, monthdt
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Report]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_Production_Report]
@LOB nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL
AS
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
(SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account_Group') AS Account_Group, 
		Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
		COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count,
		SUM(CASE WHEN Disbursement_Amount >= 0 THEN Disbursement_Amount ELSE 0 END) AS Amount
FROM dbo.SAL002_Tier1_Sales
WHERE ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
AND ISNULL(Account_Group, 'No Account_Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account_Group'))
GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod
), 
b AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(count) AS Count, 
	SUM(Amount) AS Amount, 
	ISNULL(LOB, 'No LOB')+ ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
  FROM            a
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
      + EFG_Rep + Dealer_Name + Super_Category + cprod
), 
c AS
(SELECT ISNULL(LOB, 'No LOB') AS LOB, EFG_Rep, ISNULL(Account_Group, 'No Account_Group') AS Account_Group, 
	Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
	COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Count, 
    SUM(CASE WHEN Disbursement_Amount >= 0 THEN Disbursement_Amount ELSE 0 END) AS Amount, 
    ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Group') + EFG_Rep + Dealer_Name 
    + Super_Category + cprod + ADMTRNTYP AS ID
 FROM            SAL002_Tier1_Sales_YTD
 WHERE SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 5, 2) = datepart(mm, Getdate()) 
        AND SUBSTRING(CONVERT(VARCHAR, ADMPSTDAT), 0, 5) = DATEPART(yyyy, Getdate()) - 1
		AND ISNULL(LOB, 'No LOB')=ISNULL(@LOB, ISNULL(LOB, 'No LOB'))
		AND ISNULL(Account_Group, 'No Account_Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account_Group'))
        
 GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, Super_Category, cprod, 
        ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
        + EFG_Rep + Dealer_Name + Super_Category + cprod
),
d AS
(SELECT LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, SUM(count) AS Count, 
		SUM(Amount) AS Amount, ISNULL(LOB, 'No LOB')  + ISNULL(Account_Group, 'No Account_Group') 
		+ EFG_Rep + Dealer_Name + Super_Category + cprod AS ID
  FROM c
  GROUP BY LOB, EFG_Rep, Account_Group, Dealer_Name, Super_Category, cprod, 
	ISNULL(LOB, 'No LOB') + ISNULL(Account_Group, 'No Account_Group') 
    + EFG_Rep + Dealer_Name + Super_Category + cprod)

INSERT INTO @x
SELECT DISTINCT  ISNULL(b.LOB, d .LOB), ISNULL(b.Account_Group, d .Account_Group), 
		ISNULL(b.EFG_Rep, D .EFG_Rep), ISNULL(b.Dealer_Name, D .Dealer_Name), 
        ISNULL(b.Super_Category, D .Super_Category), ISNULL(b.cprod, D .cprod),
        Sum(b.Count), sum(b.amount) AS Amount, sum(d .Amount)  AS PreYrAmount
FROM b 
FULL OUTER JOIN d ON b.ID = d .ID
GROUP BY b.LOB, d .LOB, b.Account_Group, D .Account_Group, b.EFG_Rep, D .EFG_Rep, 
b.Dealer_Name, D .Dealer_Name, b.Super_Category, D .Super_Category, b.cprod, D .cprod

SELECT * FROM @x
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_Production_Variance_by_Count]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SSRS_SalesTier1_Production_Variance_by_Count] 
@AccountGroup varchar(255)=NULL
AS
DECLARE @x AS TABLE 
  ( 
     lob              VARCHAR(255), 
     account_group    VARCHAR(255), 
     efg_rep          VARCHAR(255), 
     dealer_name      VARCHAR(255), 
     product_category VARCHAR(255), 
     product          VARCHAR(255), 
     count            INT, 
     amount           FLOAT, 
     preyramount      FLOAT, 
     preyrcount       INT 
  ); 

WITH a 
     AS (SELECT Isnull(lob, 'No LOB')                                         AS
                 LOB, 
                efg_rep, 
                Isnull(account_group, 'No Group')                             AS
                    Account_Group, 
                dealer_name, 
                admtrntyp, 
                super_category, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS
                 Count, 
                Sum(disbursement_amount)                                      AS
                 Amount 
         FROM   dbo.sal002_tier1_sales 
         WHERE ISNULL(Account_Group, 'No Account_Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account_Group'))
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
                + Isnull(account_group, 'No Group') + efg_rep 
                + dealer_name + super_category + cprod AS ID 
         FROM   a 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Group') + efg_rep 
                   + dealer_name + super_category + cprod), 
     c 
     AS (SELECT Isnull(lob, 'No LOB')                                         AS
                 LOB, 
                efg_rep, 
                Isnull(account_group, 'No Group')                             AS
                    Account_Group, 
                dealer_name, 
                admtrntyp, 
                super_category, 
                cprod, 
                Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS
                 Count, 
                Sum(disbursement_amount)                                      AS
                 Amount, 
                Isnull(lob, 'No LOB') 
                + Isnull(account_group, 'No Group') + efg_rep 
                + dealer_name + super_category + cprod + admtrntyp            AS
                 ID 
         FROM   sal002_tier1_sales_ytd 
         WHERE  Substring(CONVERT(VARCHAR, admpstdat), 5, 2) = 
                Datepart(mm, Getdate()) 
                AND Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 
                    Datepart(yyyy, Getdate()) - 1 
             AND ISNULL(Account_Group, 'No Account_Group')=ISNULL(@AccountGroup, ISNULL(Account_Group, 'No Account_Group'))
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Group') + efg_rep 
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
                + Isnull(account_group, 'No Group') + efg_rep 
                + dealer_name + super_category + cprod AS ID 
         FROM   c 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   super_category, 
                   cprod, 
                   Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Group') + efg_rep 
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
                Sum(d .amount) AS PreYrAmount, 
                Sum(d .count)  AS PreyrCount 
FROM   b 
       FULL OUTER JOIN d 
                    ON b.id = d .id 
GROUP  BY b.lob, 
          d .lob, 
          b.account_group, 
          d .account_group, 
          b.efg_rep, 
          d .efg_rep, 
          b.dealer_name, 
          d .dealer_name, 
          b.super_category, 
          d .super_category, 
          b.cprod, 
          d .cprod 

SELECT * 
FROM   @x  
GO

/****** Object:  StoredProcedure [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SSRS_SalesTier1_RevenueDisbursementsByLOB]
AS
SELECT *, 
       Isnull ((SELECT Sum(disbursement_amount) 
                FROM   dbo.sal002_tier1_sales_ytd 
                WHERE  lob = tblreport.lob 
                       AND Substring(( CONVERT(VARCHAR(50), admpstdat) ), 5, 2) 
                           = 
                           Month(Getdate()) 
                       AND Substring(( CONVERT(VARCHAR(50), admpstdat) ), 0, 5) 
                           = ( 
                           Year( 
                           Getdate()) - 1 )), 0) AS 'PriorMonth', 
       Getdate()                                 AS 'CurrentDate' 
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
                       disbursement_amount 
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

/****** Object:  StoredProcedure [dbo].[Summary-MTD-Report]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Robert Green>
-- Create date: <07/24/2013>
-- Description:	<MTD Summary for Commission Report>
-- =============================================
CREATE PROCEDURE [dbo].[Summary-MTD-Report]
	-- Add the parameters for the stored procedure here
 @StartDate Datetime, @EndDate DateTime, @UserName varchar (50)
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



DECLARE @User varchar (35)
DECLARE @RptCode VARCHAR(10)
SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode;


WITH Forsum --Start of CTE to get cal numbers for output --R.Green designed 
AS (SELECT    EFG_Rep, LOB,   COUNT(DISTINCT ADMCLICOD + ADMACCCOD + ADMAGRCOD + ADMAGRSFX) AS Contract_Count,
ADMTRNTYP, NON_CANCELFEE_STATUS, CAST(NON_CANCELFEE_STATUS AS VARCHAR) AS RepGroupID,  SUM(Disbursement_Amount) 
                          AS amt
              FROM            [SAL001_GetDailyDataCommissions-UAT2]
              where ChangeST = 'current'
and Disbursement_Code NOT IN (SELECT FieldValue FROM @ExceptionsTbl)
and RptRunDT between (@StartDate) and (@EndDate) 
and efg_rep in (@UserName)
         GROUP BY LOB, efg_rep,   Dealer_Name, ADMTRNTYP, NON_CANCELFEE_STATUS) 
         
      
      
				 SELECT       SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN Contract_Count END) AS New_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CUR' THEN amt END) AS New_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN Contract_Count END) AS CB_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 1 AND ADMTRNTYP = 'CAN' THEN amt END) AS CB_Amt, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' THEN Contract_Count END) AS CF_Count, 
                              SUM(CASE WHEN NON_CANCELFEE_STATUS = 0 AND ADMTRNTYP = 'CAN' THEN amt END) AS CF_amt, 
                              SUM(CASE WHEN ADMTRNTYP = 'REN' THEN Contract_Count END) AS REN_Count, SUM(CASE WHEN ADMTRNTYP = 'REN' THEN amt END) AS REN_amt, 
                              SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN Contract_Count END) AS AMD_Count, SUM(CASE WHEN ADMTRNTYP = 'AMD' THEN amt END) AS AMD_Amt, 
                              LOB,
                              EFG_Rep,
                              COUNT(RepGroupID) [Number Of Accounts]

                              
                        
     FROM            FORSUM AS FORSUM_1
     
     group by LOB, EFG_Rep
     order by  EFG_Rep ASC END

GO

/****** Object:  StoredProcedure [dbo].[TestPull]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[TestPull]
-- testing  Robert Green for Type 2

AS






DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode

;

   with aag as   ( SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD as [Disbursement_Code] ,
                                          ADMDISAMT as [Disbursement_Amount], APVALPVAL , CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END as NON_CANCELFEE_STATUS 
                              ,t.[Product Category]
                              ,t.[Program Code]
                              ,t.[Super Category]
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                             inner join  [SV-SQL06].EFGCubeFactsDims.dbo.[DimProgramProductCategory] T
									on a.AGMPRGCOD =  T.[Program Code]
                              where ADMEFRTYN = 'Y'
                                   AND  ADMPSTDAT = @PstDat
                                    OR  ADMPSTDAT is null 
                                    OR  ADMPSTDAT IN (0) 
                                   AND  ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
								   AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
								   AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
								   


 ) 
                                    
                                    INSERT INTO [RptDataDaily].[dbo].[TestAS400Pull]
                                  ( [ADMACCCOD]
								  ,[APVALPVAL]
								  ,[ADMPSTDAT]
								  ,[ADMRECDAT]
								  ,[ADMEFFDAT]
								  ,[ADMENTDAT]
								  ,[APVPSTDAT]
								  ,[ADMCLICOD]
								  ,[ADMAGRCOD]
								  ,[ADMAGRSFX]
								  ,[ADMTRNTYP]
								  ,[ADMDISTYP]
								  ,[ADMEFRTYN]
								  ,[AGMPRGCOD]
								  ,[Disbursement_Code]
								  ,[Disbursement_Amount]
								  ,[NON_CANCELFEE_STATUS]
								  ,[Program_Code]
								  ,[Product_Category]
								  ,[Super_Category])
								  
								  select 
					               [ADMACCCOD]
								  ,[APVALPVAL]
								  ,[ADMPSTDAT]
								  ,[ADMRECDAT]
								  ,[ADMEFFDAT]
								  ,[ADMENTDAT]
								  ,[APVPSTDAT]
								  ,[ADMCLICOD]
								  ,[ADMAGRCOD]
								  ,[ADMAGRSFX]
								  ,[ADMTRNTYP]
								  ,[ADMDISTYP]
								  ,[ADMEFRTYN]
								  ,[AGMPRGCOD]
								  ,[Disbursement_Code]
								  ,[Disbursement_Amount]
								  ,[NON_CANCELFEE_STATUS]
								  ,aag.[Program Code]
								  ,aag.[Product Category]
								  ,aag.[Super Category]  
								  
								  from   aag    
								  ORDER BY APVALPVAL DESC,ADMAGRCOD,[Disbursement_Code]        
			                                    
GO

/****** Object:  StoredProcedure [dbo].[TestType2]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[TestType2]
-- testing  Robert Green for Type 2

AS


 
 
 
 
 
 select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as LOB
				, GETDATE() as RptRunDT
           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as RptRunDT
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A



GO

/****** Object:  StoredProcedure [dbo].[USP_MTDCommissionReportUAT]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[USP_MTDCommissionReportUAT]
--Test for MTD report changes Created by Robert Green 7/8/2013

AS
DECLARE @User varchar (35)
DECLARE @RptCode VARCHAR(10)
SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode


SELECT DISTINCT 
	   efg_rep, 
       account_group, 
       dealer_name, 
       non_cancelfee_status, 
       admtrntyp, 
       Sum(disbursement_amount)         AS amt, 
       Count(DISTINCT admclicod + admacccod + admagrcod + 
                                        admagrsfx 
                         )    AS contract_count 
        
FROM   SAL001_GetDailyDataCommissions F00
WHERE Disbursement_Code NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
--and Dealer_Name='Moritz Kia'
GROUP  BY efg_rep, 
          account_group, 
          dealer_name, 
          non_cancelfee_status, 
          F00.admtrntyp
ORDER  BY F00.efg_rep




GO

/****** Object:  StoredProcedure [dbo].[USP_TestGetDaily]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[USP_TestGetDaily]
--Test for MTD report changes Created by Robert Green 7/8/2013

AS
DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL001' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL001'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode




      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat




GO

/****** Object:  StoredProcedure [dbo].[Z_GetDailyDataTier1Sales_prior to 06_13_13]    Script Date: 10/11/2013 15:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Z_GetDailyDataTier1Sales_prior to 06_13_13]

AS

truncate table [RptDataDaily].[dbo].[SAL002_Tier1_Sales]


DECLARE @RptCode VARCHAR(10)
DECLARE @PstDat INT

select @PstDat = FieldValue 
from RptRulesMaster.dbo.RptRules 
where RptCode = 'SAL002' and FieldName = 'ADMPSTDAT'

SET @RptCode = 'SAL002'

DECLARE @ExceptionsTbl table (
      FieldName varchar(30),
      FieldValue varchar(200)
      )
      
      INSERT @ExceptionsTbl(FieldName, FieldValue)
      SELECT FieldName, FieldValue
      from RptRulesMaster.dbo.Exceptions 
      where RptCode = @RptCode
      --where RptCode = @RptCode and FieldName in ('Program_Code','Disbursement_Code')

;
WITH SEDisbData AS (
      SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
                              FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN i400dasql.efgas400.sescsefg.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND APVFLDCOD = '~MVPRDSTS' 
                              where ADMEFRTYN = 'Y'
                                    and ADMPSTDAT = @PstDat
                                    ),
CRMData AS (      
  select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit

           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A),
Final AS (
      SELECT se.*, c.*
      FROM SEDisbData se
      LEFT OUTER JOIN CRMData c ON se.ADMACCCOD = c.Account_Code
      )
      
--------------------------------------
-- INSERT SECTION:

INSERT INTO [RptDataDaily].[dbo].[SAL002_Tier1_Sales]
           ([APVALPVAL]
           ,[ADMPSTDAT]
           ,[ADMCLICOD]
           ,[ADMACCCOD]
           ,[ADMAGRCOD]
           ,[ADMAGRSFX]
           ,[EFG_Rep]
           ,[Account_Group]
           ,[Dealer_Name]
           ,[ADMTRNTYP]
           ,[ADMDISTYP]
           ,[AGMPRGCOD]
           ,[Disbursement_Code]
           ,[Disbursement_Amount]
           ,[NON_CANCELFEE_STATUS]
           ,[RptRunDT]
           ,[LOB])

------------------------------------------------------------------------------------      
SELECT      APVALPVAL,
			ADMPSTDAT,
			ADMCLICOD, 
			ADMACCCOD, 
			ADMAGRCOD, 
			ADMAGRSFX, 
            EFG_Rep, 
            Account_Group, 
            Dealer_Name,
            ADMTRNTYP,
            ADMDISTYP,
            AGMPRGCOD,
            Disbursement_Code = ADMDISCOD,
            Disbursement_Amount = ADMDISAMT,
            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
            getdate() as [RptRunDT],
            LOB = BusinessUnit
            --,ADMENTDAT,ADMRECDAT
                      
FROM Final

--CHECKING FOR EXCLUSIONS:
WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 
      AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl) 

			/* HARD CODING FIELD NAMES NOT NEEDED - ONE FILEDVALUE FIELD FOR ALL EXCLUSIONS
			WHERE ADMDISCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Disbursement_Code')
			AND AGMPRGCOD NOT IN (SELECT FieldValue FROM @ExceptionsTbl WHERE FieldName = 'Program_Code')*/

-- AGREEMENT/CONTRACT STATUS FOR THE CONTRACT COUNT:
AND APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
			 -- AND APVALPVAL NOT IN(,'SUSPENDED','VOID')
			/* ALL VALUES:	AND APVALPVAL IN('CANCELLED','EXPIRED','INFORCE','SUSPENDED','VOID') */

			-- EXAMPLE:   (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '26653000197' AND ADMCLICOD= 'EA' (NO SFX)
			--AND (ADMAGRCOD = '         26653000197' AND ADMACCCOD = '0000026653' AND ADMCLICOD = 'EA')      

order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD

-- ==========================================================================================================================================================



-- ==========================================================================================================================================================
-- UPDATE [Product Category] AND [Super Category] FIELDS	[KVT ADDED 05-17-13]: USE EFGCubeFactsDims

--SELECT DISTINCT DD.ADMACCCOD,DD.LOB, DD.AGMPRGCOD,DD.Program_Code,DD.Product_Category,DD.Super_Category, p.[Program Code],p.[Product Category],P.[Super Category]
UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [RptDataDaily].[dbo].[SAL002_Tier1_Sales] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]
--(9008 row(s) affected) UPDATE ON 05-15-13

-- ==========================================================================================================================================================

-- ==========================================================================================================================================================
--06-11-13 test 2:20 pm: 00:02:14

--(98 row(s) affected)
--(9008 row(s) affected)
--(9004 row(s) affected)

--06-11-13: MAY 2013 MONTH-END PROCESSING NOT YET COMPLETE FOR CUBE 30 / CUBE 40
--SELECT *
--  FROM [RptDataDaily].[dbo].[SAL002_Tier1_Sales]
--  where [Product_Category] is null or [Super_Category] is null 
  
--APVALPVAL	ADMPSTDAT	ADMCLICOD	ADMACCCOD	ADMAGRCOD				ADMAGRSFX	EFG_Rep	Account_Group	Dealer_Name	ADMTRNTYP	ADMDISTYP	AGMPRGCOD	Disbursement_Code	Disbursement_Amount	NON_CANCELFEE_STATUS	RptRunDT	LOB	cprog	cprod	cplan	Program_Code	Product_Category	Super_Category
--INFORCE	0			EFG			0000030958	         30958002174				Josh Rodriguez	Bob Moore Auto Group	Bob Moore Pontiac Buick GMC OK	CUR	ADMIN	SFD01	BASEADMIN	52.00	1	2013-06-11 14:20:35.917	Dealer Services	NULL	NULL	NULL	NULL	NULL	NULL
--INFORCE	0			EFG			0000030958	         30958002174				Josh Rodriguez	Bob Moore Auto Group	Bob Moore Pontiac Buick GMC OK	CUR	ADMIN	SFD01	BASEADMIN	41.00	1	2013-06-11 14:20:35.917	Dealer Services	NULL	NULL	NULL	NULL	NULL	NULL
--INFORCE	0			EFG			0000077804	         77804002369				Josh Rodriguez	Bob Moore Auto Group	Bob Moore Subaru	CUR	ADMIN	SFD01	BASEADMIN	58.00	1	2013-06-11 14:20:35.917	Dealer Services	NULL	NULL	NULL	NULL	NULL	NULL
--INFORCE	0			EFG			0000077804	         77804002369				Josh Rodriguez	Bob Moore Auto Group	Bob Moore Subaru	CUR	ADMIN	SFD01	BASEADMIN	67.00	1	2013-06-11 14:20:35.917	Dealer Services	NULL	NULL	NULL	NULL	NULL	NULL  

-- ==========================================================================================================================================================




-- ==========================================================================================================================================================
-- UPDATE LOB FIELD		[KVT ADDED 05-07-13]: USE EFGCubeFactsDims
-- [KVT 05-28-13: LOB IS NOW IN THE MAIN QUERY: EFG_MSCRM].[dbo].[BusinessUnitBase] BU on a.OwningBusinessUnit = BU.BusinessUnitId; LOB = BU.NAME]
--;
--WITH mycrmreplacement 
--     AS (SELECT DISTINCT dm.[account code], 
--                         CASE 
--                           WHEN c.dealership IS NOT NULL THEN c.dealership 
--                           ELSE [account name] 
--                         END                AS DealerName, 
--                         CASE 
--                           WHEN c2.groupname = '' THEN NULL 
--                           ELSE c2.groupname 
--                         END                AS GroupName, 
--                         CASE 
--                           WHEN c2.agent IS NOT NULL 
--                                AND c2.agent <> '' THEN c2.agent 
--                           ELSE NULL 
--                         END                AS Agent, 
--                         CASE 
--                           WHEN c2.efgrep IS NOT NULL THEN c2.efgrep 
--                           WHEN c2.efgrep IS NULL 
--                                AND c.repagent IS NOT NULL THEN c.repagent 
--                           ELSE NULL 
--                         END                AS EFGRep, 
--                         c2.lob AS crm_lob, 
--                         dm.[record status] AS AccountStatus 
--         FROM   efgdw.dbo.dealermaster AS dm 
--                LEFT OUTER JOIN efgdw.dbo.crmreplacement2 AS c2 
--                             ON dm.[account code] = c2.accountcode 
--                LEFT OUTER JOIN efgdw.dbo.crmdata AS c 
--                             ON dm.[account code] = c.billingaccountnumber 
--         WHERE  ( dm.[account type] = 'DL' ))
         
--, DailyData as
--(SELECT [APVALPVAL]
--      ,[ADMPSTDAT]
--      ,[ADMCLICOD]
--      ,[ADMACCCOD]
--      ,[ADMAGRCOD]
--      ,[ADMAGRSFX]
--      ,[EFG_Rep]
--      ,[Account_Group]
--      ,[Dealer_Name]
--      ,[ADMTRNTYP]
--      ,[ADMDISTYP]
--      ,[AGMPRGCOD]
--      ,[Disbursement_Code]
--      ,[Disbursement_Amount]
--      ,[NON_CANCELFEE_STATUS]
--      ,[RptRunDT]
--      ,[LOB]
--  FROM [RptDataDaily].[dbo].[SAL002_Tier1_Sales])
-- ,
--Final AS (
--      SELECT c.*,dd.*
--      FROM DailyData dd
--      LEFT OUTER JOIN mycrmreplacement c ON dd.ADMACCCOD = c.[Account Code]
--      )
                 
----SELECT ADMACCCOD,LOB,[Account Code],crm_lob                       
--UPDATE F SET LOB = crm_lob
--FROM Final F


-- ==========================================================================================================================================================


-- ==========================================================================================================================================================
-- sv-sql06
-- use [RptRulesMaster]
-- exec RptRulesMaster.dbo.GetDailyDataCommissions

-- 04-04-13 9:48 am started: stopped at 2:59 pm; runtime: 5:11:10; still not done
-- restarted 04-04-13 4:25 pm; total runtime 01:45:22

--EXEC RptRulesMaster.dbo.GetDailyDataCommissions_test_26653000197	-- testing one record only

-- ==========================================================================================================================================================
-- 04-05-13: INCORPORATING SHADAN'S C0UNT CHECK F0R CANCELFEE

--SELECT DISTINCT Disbursement_Code, STATUS
--FROM            EFGRepProductiontbl
--WHERE        (Disbursement_Code NOT LIKE '%CANCELFEE%')

--            NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END)


-- ==========================================================================================================================================================


GO


Select * from I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM


WHERE APVFLDCOD ='~MVPRDSTS'