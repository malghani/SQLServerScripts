SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

GO
USE RptDataDaily_Dev
GO
IF EXISTS(Select * from sys.objects where name = 'YDT0')
	drop table YDT0

IF EXISTS(Select * from sys.objects where name = 'YDT1')
  drop table YDT1
  
IF EXISTS(Select * from sys.objects where name = 'YDT2')
  drop table YDT2

IF EXISTS(Select * from sys.objects where name = 'YDT3')
  drop table YDT3

IF EXISTS(Select * from sys.objects where name = 'YDT4')
  drop table YDT4
  
IF EXISTS(Select * from sys.objects where name = 'YDTCombined')
  drop table YDTCombined

IF EXISTS(Select * from sys.objects where name = 'YFinal')
  drop table YFinal
  
IF EXISTS(Select * from sys.objects where name = 'YETLResults')
  drop table YETLResults

--Create DT0
--Select A.*, D.* INTO DT0 FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRM A (NOLOCK)
--LEFT OUTER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM D (NOLOCK)
--      ON  a.AGMCLICOD = d.ADMCLICOD and
--          a.AGMACCCOD = d.ADMACCCOD and
--          a.AGMAGRCOD = d.ADMAGRCOD and
--          a.AGMAGRSFX = d.ADMAGRSFX                              
--LEFT OUTER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM p (NOLOCK)
--     ON a.AGMCLICOD = p.APVCLICOD and
--     a.AGMACCCOD = p.APVACCCOD and
--     a.AGMAGRCOD = p.APVAGRCOD and
--     a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS' 
--WHERE D.ADMPSTDAT = 0  AND D.ADMEFRTYN = 'Y'
--AND (P.APVFLDCOD IS NULL)

-- Create DT1
SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL, AGMPSTDAT
Into YDT1 FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRM A                                     
                              inner join I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS' 
                              INNER JOIN TestAccounts TA ON TA.ADMACCOD = D.ADMACCCOD
                              where d.ADMEFRTYN = 'Y' and (d.ADMPSTDAT > 20120101 OR d.ADMPSTDAT =0)
                              
--SELECT count(*) 
----A.* Into SCAGRM 
--FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRM A 
--INNER JOIN TestAccounts TA ON TA.ADMACCOD = A.AGMACCCOD

SELECT count(*) --GOOD
-- D.* Into SCAGRDM_YTD 
FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM D 
INNER JOIN TestAccounts TA ON TA.ADMACCOD = D.ADMACCCOD
WHERE d.ADMEFRTYN = 'Y' and (d.ADMPSTDAT > 20120101 OR d.ADMPSTDAT =0)

--SELECT count(*) 
---- P.* Into SCAGRPVM 
--FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM P
--INNER JOIN TestAccounts TA ON TA.ADMACCOD = P.APVACCCOD
--WHERE p.APVFLDCOD = '~MVPRDSTS' 


---- Create DT2  
--Select a.accountID
--      ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber               
--   ,a.Address1_City AS City
--   ,a.Address1_StateOrProvince AS StateProvince
--   ,a.Address1_PostalCode AS PostalCode
--   ,a.Address1_Country AS Country                                             
--   ,a.EFG_CustomerEffectiveDate AS EffectiveDate
--   ,a.EFG_CustomerTerminationDate AS TerminationDate
--   ,a.owneridyominame AS EFGRep
--   ,a.[name] AS Dealership               
--   ,efg_billingname as BillingAccountName
--   ,a.EFG_SGuardVendornumber   
--   ,a.OwningBusinessUnit
--   ,a.parentaccountid
--   ,a.EFG_AccountType
--   ,a.EFG_PrimaryMarket
--   ,a.AccountCategoryCode
--   ,a.StateCode
--   ,a.EFG_Channel
--INTO YDT2  
-- FROM [SV-SQL02].EFG_MSCRM.dbo.Account a
--	inner join [SV-SQL02].EFG_MSCRM_Dev.dbo.EFG_accountnumber an
--	ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL  
				


----CREATE DT3
--SELECT
--                  a.accountID
--                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
--               ,EFG_AccountTypePLTable.value AS AccountType
--               ,a.Address1_City AS City
--               ,a.Address1_StateOrProvince AS StateProvince
--               ,a.Address1_PostalCode AS PostalCode
--               ,a.Address1_Country AS Country
--               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
--               ,AccountCategoryCodePLTable.value AS ServiceApproach
--               ,StateCodePLTable.value AS StatusReason
--               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
--               ,a.EFG_CustomerTerminationDate AS TerminationDate
--               ,pa.[Name] AS Parent1Name
--               ,a.owneridyominame AS EFGRep
--               ,a.[name] AS Dealership
--               ,EFG_ChannelPLTable.value AS Channel
--               ,getdate() as InsertDt
--               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
--               ,efg_billingname as BillingAccountName
--               ,a.EFG_SGuardVendornumber
--               ,BU.[NAME] AS BusinessUnit
--			   ,a.OwningBusinessUnit
--			   ,a.parentaccountid
--			   ,a.EFG_AccountType
--			   ,a.EFG_PrimaryMarket
--			   ,a.AccountCategoryCode
--			   ,a.StateCode
--			   ,a.EFG_Channel
               
--INTO YDT3
--            FROM
--                  [SV-SQL02].EFG_MSCRM_Dev.dbo.Account a
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_AccountTypePLTable
--            ON  (
--                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
--                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
--                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
--                    AND EFG_AccountTypePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_PrimaryMarketPLTable
--            ON  (
--                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
--                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
--                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
--                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap AccountCategoryCodePLTable
--            ON  (
--                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
--                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
--                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
--                    AND AccountCategoryCodePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap StateCodePLTable
--            ON  (
--                    StateCodePLTable.AttributeName = 'statecode'
--                    AND StateCodePLTable.ObjectTypeCode = 1
--                    AND StateCodePLTable.AttributeValue = a.StateCode
--                    AND StateCodePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_ChannelPLTable
--                    ON  (
--                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
--                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
--                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
--                    AND EFG_ChannelPLTable.LangId = 1033 )
--            LEFT JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.EFG_accountnumber an
--                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
--            LEFT JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.Account pa
--                    ON  a.parentaccountid = pa.AccountId
--            left join [SV-SQL02].EFG_MSCRM_Dev.dbo.CustomerRelationship cr
--                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
--            WHERE an.EFG_AccountNumberName IS NOT null
---- CREATE DT4
--select distinct EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
--                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
--                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
--                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
--                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit
--INTO YDT4 FROM
--            (
--              SELECT
--                  a.accountID
--                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
--               ,EFG_AccountTypePLTable.value AS AccountType
--               ,a.Address1_City AS City
--               ,a.Address1_StateOrProvince AS StateProvince
--               ,a.Address1_PostalCode AS PostalCode
--               ,a.Address1_Country AS Country
--               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
--               ,AccountCategoryCodePLTable.value AS ServiceApproach
--               ,StateCodePLTable.value AS StatusReason
--               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
--               ,a.EFG_CustomerTerminationDate AS TerminationDate
--               ,pa.[Name] AS Parent1Name
--               ,a.owneridyominame AS EFGRep
--               ,a.[name] AS Dealership
--               ,EFG_ChannelPLTable.value AS Channel
--               ,getdate() as InsertDt
--               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
--               ,efg_billingname as BillingAccountName
--               ,a.EFG_SGuardVendornumber
--               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

--            FROM
--                  [SV-SQL02].EFG_MSCRM_Dev.dbo.Account a
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_AccountTypePLTable
--            ON  (
--                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
--                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
--                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
--                    AND EFG_AccountTypePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_PrimaryMarketPLTable
--            ON  (
--                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
--                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
--                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
--                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap AccountCategoryCodePLTable
--            ON  (
--                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
--                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
--                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
--                    AND AccountCategoryCodePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap StateCodePLTable
--            ON  (
--                    StateCodePLTable.AttributeName = 'statecode'
--                    AND StateCodePLTable.ObjectTypeCode = 1
--                    AND StateCodePLTable.AttributeValue = a.StateCode
--                    AND StateCodePLTable.LangId = 1033 )
--            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_ChannelPLTable
--                    ON  (
--                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
--                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
--                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
--                    AND EFG_ChannelPLTable.LangId = 1033 )
--            LEFT JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.EFG_accountnumber an
--                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
--            LEFT JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.Account pa
--                    ON  a.parentaccountid = pa.AccountId
--            left join [SV-SQL02].EFG_MSCRM_Dev.dbo.CustomerRelationship cr
--                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
--            WHERE an.EFG_AccountNumberName IS NOT null   )  A


--Create DTCombined
  SELECT se.*, c.*
  INTO YDTCombined FROM YDT1 se
  LEFT OUTER JOIN DT4 c ON se.ADMACCCOD = c.Account_Code

-- Create Final
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
            LOB = BusinessUnit,
            AGMPSTDAT
INTO YFinal            
FROM YDTCombined
LEFT JOIN (      SELECT FieldName, FieldValue
					from RptRulesMaster.dbo.Exceptions 
					where RptCode = 'SAL002'
			) Exceptions on Exceptions.FieldValue = ADMDISCOD OR Exceptions.FieldValue=AGMPRGCOD
WHERE APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
	  AND Exceptions.FieldValue IS NULL	  
order by APVALPVAL DESC,ADMAGRCOD,ADMDISCOD




-- Create ETLResults
 Select * INTO YETLResults
 
 from	(Select count(*) SCAGRPVM FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM)a,
				(Select count(*) SCAGRPVM_Filtered FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM  WHERE APVFLDCOD = '~MVPRDSTS') b,
				(Select count(*) SCAGRM FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRM) c,
				(Select count(*) SCAGRDM FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM)d,
				(Select count(*) SCAGRDM_Filtered FROM I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRDM Where ADMEFRTYN = 'Y' AND ADMPSTDAT=0)e,
				(Select COUNT(*) DT1 from Dt1) f,
				(Select COUNT(*) Account from [SV-SQL02].EFG_MSCRM.dbo.Account) g,
				(Select count(*) EFG_AccountNumber  from  [SV-SQL02].EFG_MSCRM_Dev.dbo.EFG_accountnumber) h,
				(Select count(*) EFG_AccountNumber_Filtered from  [SV-SQL02].EFG_MSCRM_Dev.dbo.EFG_accountnumber 
					WHERE EFG_AccountNumberName IS NOT NULL ) i,					
				(Select COUNT(*) DT2 from DT2) j,
				(Select COUNT(*) BusinessUnitBase from [SV-SQL02].EFG_MSCRM_Dev.dbo.BusinessUnitBase) k,
				(Select COUNT(distinct BillingAccountNumber) BusinessUnitBase_Qualified from DT2 A
						INNER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId) k1,
						
				(Select COUNT(*) ParentAccount from [SV-SQL02].EFG_MSCRM_Dev.dbo.Account pa where not pa.parentaccountid is null) l,
				(Select COUNT(BillingAccountNumber) ParentAccount_Qualified FROM DT2 A 
					INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId) l1,                    				
				(Select COUNT(*) CustomerRelationship from [SV-SQL02].EFG_MSCRM_Dev.dbo.CustomerRelationship ) m,
				(Select COUNT(*) CustomerRelationship_Filterd from [SV-SQL02].EFG_MSCRM_Dev.dbo.CustomerRelationship Where partnerroleidname = 'Servicing Agent') n,
				(Select COUNT(*) CustomerRelationship_Qualified from [SV-SQL02].EFG_MSCRM_Dev.dbo.CustomerRelationship cr
						INNER JOIN DT2 a ON  a.accountid = cr.customerid and partnerroleidname = 'Servicing Agent')	n1,
				(Select COUNT(*) AccountTypes from [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_AccountTypePLTable 
						WHERE EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
						AND EFG_AccountTypePLTable.ObjectTypeCode = 1
						AND EFG_AccountTypePLTable.LangId = 1033 ) o,
				(Select count(*) AccountType_Qualified from DT2 a
				 INNER JOIN [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap b 
								 ON b.AttributeName = 'efg_accounttype'
									AND b.ObjectTypeCode = 1
									AND b.AttributeValue = a.EFG_AccountType
									AND b.LangId = 1033 ) o1,
						
				(Select COUNT(*) PrimaryMarkets from [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_PrimaryMarketPLTable
						WHERE EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
						AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
						AND EFG_PrimaryMarketPLTable.LangId = 1033) p,
				(Select count(*) PrimaryMarket_Qualified from DT2 a                    
				INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap b
							ON b.AttributeName = 'efg_primarymarket'
							   AND b.ObjectTypeCode = 1
							   AND b.AttributeValue = a.EFG_PrimaryMarket
							   AND b.LangId = 1033) p1,
				(Select COUNT(*) as AccountCategories from [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap AccountCategoryCodePLTable
						WHERE AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
						AND AccountCategoryCodePLTable.ObjectTypeCode = 1
						AND AccountCategoryCodePLTable.LangId = 1033 )q,
				(Select count(*) CategoryCode_Qualified from DT2 a                                        
				INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap b
							ON  b.AttributeName = 'accountcategorycode'
								AND b.ObjectTypeCode = 1
								AND b.AttributeValue = a.AccountCategoryCode
								AND b.LangId = 1033) q1,

				(Select COUNT(*) AccountStateCodes from [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap StateCodePLTable
						WHERE StateCodePLTable.AttributeName = 'statecode'
						AND StateCodePLTable.ObjectTypeCode = 1
						AND StateCodePLTable.LangId = 1033) r,
				(Select count(*) AcctStateCode_Qualified from DT2 a
				INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap b
							ON b.AttributeName = 'statecode'
								AND b.ObjectTypeCode = 1
								AND b.AttributeValue = a.StateCode
								AND b.LangId = 1033) r1,
						
				(Select COUNT(*) EFGChannels from [SV-SQL02].EFG_MSCRM_Dev.dbo.StringMap EFG_ChannelPLTable
						WHERE EFG_ChannelPLTable.AttributeName = 'efg_channel'
						AND EFG_ChannelPLTable.ObjectTypeCode = 1
						AND EFG_ChannelPLTable.LangId = 1033) s,

				(Select count(*) Channels_Qualified from DT2 a
				INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap b
						ON b.AttributeName = 'efg_channel'
						AND b.ObjectTypeCode = 1
						AND b.AttributeValue = a.EFG_Channel
						AND b.LangId = 1033 ) s1,
				(Select COUNT(*) DT3 From DT3) t,
				(Select COUNT(*) DT4 From DT4) u,
				(Select COUNT(*) DTCombined From DTCombined) v,
				(Select COUNT(*) Final From Final) w
				


truncate table SAL002_Tier1_Sales_YTD
INSERT INTO [dbo].[SAL002_Tier1_Sales_YTD]
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
           ,[LOB],
           ,AGMPSTDAT)
SELECT * FROM YFinal




UPDATE T SET T.cprog = Q.AGDPRGCOD, T.cprod = Q.AGDPRDCOD, T.cplan = Q.AGDPLNCOD
-- Select T.cprog, Q.AGDPRGCOD, T.cprod, Q.AGDPRDCOD, T.cplan, Q.AGDPLNCOD
FROM SAL002_Tier1_Sales_YTD T
LEFT JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.AGDTA00 Q                                    
	ON  Q.AGDCLICOD = T.ADMCLICOD and
	Q.AGDACCCOD = T.ADMACCCOD and
	Q.AGDAGRCOD = T.ADMAGRCOD and
	Q.AGDAGRSFX = T.ADMAGRSFX and
	Q.AGDPRGCOD = T.AGMPRGCOD
		WHERE T.cprod IS NULL OR T.cplan IS NULL 



UPDATE DD SET DD.Program_Code = p.[Program Code],DD.Product_Category = p.[Product Category], DD.Super_Category = P.[Super Category]
FROM [dbo].[SAL002_Tier1_Sales_YTD] DD
inner join  EFGCubeFactsDims.dbo.DimProgramProductCategory P
on DD.AGMPRGCOD =  p.[Program Code]						

--Select [Table]='DT0',* From DT0  (Takes too long)
Select [Table]='YDT1',* From YDT1
Select [Table]='DT2',* From DT2
Select [Table]='DT3',* From DT3
Select [Table]='DT4',* From DT4
Select [Table]='YDTCombined',* From YDTCombined
Select [Table]='ETLResults',* From ETLResults
Select [Table]='YFinal',* From YFinal
Select [Table]='SAL002_Tier1_Sales_YTD', * From SAL002_Tier1_Sales_YTD

UPDATE SAL002_Tier1_Sales_YTD SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep

UPDATE SAL002_Tier1_Sales_YTD
SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
Where cprog like 'SAN%'



