USE [RptDataDaily_Dev]
GO
/****** Object:  StoredProcedure [dbo].[GetDailyDataTier1Sales]    Script Date: 10/17/2013 17:31:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[GetDailyDataTier1Sales]

AS

truncate table [RptDataDaily_Dev].[dbo].[SAL002_Tier1_Sales]


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
                              FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRM A                                     
                              inner join I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM p
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

INSERT INTO [RptDataDaily_Dev].[dbo].[SAL002_Tier1_Sales]
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
-- UPDATE CPROG / CPROD / CPLAN				-- [KVT ADDED 06-11-13]: USE  I400DASQL_TEST.EFGAS400.SESCSSIS.AGDTA00 Q 
-- --[KVT UPDATED 06-11-13 FROM CHARLIE'S SAVED QRY]

-- Select * FROM  I400DASQL_TEST.EFGAS400.SESCSSIS.AGDTA00 Q  
-- SELECT * FROM RptDataDaily.dbo.SAL002_Tier1_Sales T WHERE T.cprod IS NULL OR T.cplan IS NULL 

-- RptDataDaily.dbo.SAL002_Tier1_Sales T

--SELECT	Q.AGDCLICOD,Q.AGDACCCOD,Q.AGDAGRCOD,Q.AGDAGRSFX,Q.AGDPRDSTS,T.APVALPVAL,
--		T.ADMPSTDAT,T.[ADMCLICOD],T.[ADMACCCOD],T.[ADMAGRCOD],T.[ADMAGRSFX],
--		Q.AGDPRGCOD,Q.AGDPRDCOD,Q.AGDPLNCOD,								
--	    T.AGMPRGCOD,T.cprog, T.cprod, T.cplan				

	UPDATE T SET T.cprog = Q.AGDPRGCOD, T.cprod = Q.AGDPRDCOD, T.cplan = Q.AGDPLNCOD

FROM RptDataDaily.dbo.SAL002_Tier1_Sales T
LEFT JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.AGDTA00 Q                                    
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
FROM [RptDataDaily_Dev].[dbo].[SAL002_Tier1_Sales] T
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on T.AGMPRGCOD =  p.[Program Code]
where T.Product_Category is null or  T.Super_Category is null

UPDATE SAL002_Tier1_Sales SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep
UPDATE SAL002_Tier1_Sales 
SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
Where cprog like 'SAN%'


-- ==========================================================================================================================================================
