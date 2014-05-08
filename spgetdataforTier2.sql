Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc [dbo].[spgetdataforTier2]
as
--(select PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,SUM(PRDCHKAMT) AS CLAIM_AMOUNT,PRDPRDCOD INTO #CLAIM_AMT from I400DASQL.EFGAS400.SESCSEFG.SCPAYRD
--WHERE PRDPAYTYP = 'CL' AND PRDCRTDAT BETWEEN 20120101 AND 20120131 
--group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDACCCOD,PRDPRDCOD);
SELECT CIMCLICOD,CIMACCCOD,CIMAGRCOD,CIMAGRSFX,CIMPRDCOD,COUNT(CIMCLMTID) AS CLAIM_COUNT,SUM(CIMATHAMT) AS CLAIM_AMOUNT INTO #CLAIM_AMT FROM i400dasql.efgas400.SESCSEFG.SCCLM
WHERE CIMENTDAT BETWEEN 20120101 AND 20120131
GROUP BY CIMCLICOD,CIMACCCOD,CIMAGRCOD,CIMAGRSFX,CIMPRDCOD ORDER BY 2;


(select AEPCLICOD, AEPACCCOD,AEPAGRCOD,AEPAGRSFX,AEPPRDCOD,SUM(AEPERNCM) as EarnedReserves INTO #EARNED_DATA from I400DASQL.EFGAS400.SESCSEFG.SCAGREP where  AEPPSTDAT BETWEEN 20120101 AND 20120131
group by AEPCLICOD, AEPACCCOD,AEPAGRCOD,AEPAGRSFX,AEPPRDCOD);


(select * INTO #Total_Reserves_Trantyp from openquery(I400dasql,
      'SELECT ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX, SUM(ADMDISAMT) as Total_Reserves,ADMTRNTYP,ADMPRDCOD 
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
                              where ADMEFRTYN = ''Y'' and ADMPSTDAT = 20120131
                                    group by ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX,ADMPRDCOD,ADMTRNTYP'));
                                    
                              
--( select * INTO  #TRN_TYP  from openquery(I400dasql,
--      'SELECT ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX, ADMPRDCOD,ADMTRNTYP 
--                              FROM SESCSEFG.SCAGRM A                                     
--                              inner join SESCSEFG.SCAGRDM D
--                                    ON  a.AGMCLICOD = d.ADMCLICOD and
--                                          a.AGMACCCOD = d.ADMACCCOD and
--                                          a.AGMAGRCOD = d.ADMAGRCOD and
--                                          a.AGMAGRSFX = d.ADMAGRSFX
--                              INNER JOIN sescsefg.SCAGRPVM p
--                                    ON a.AGMCLICOD = p.APVCLICOD and
--                                          a.AGMACCCOD = p.APVACCCOD and
--                                          a.AGMAGRCOD = p.APVAGRCOD and
--                                          a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = ''~MVPRDSTS''
--                              where ADMEFRTYN = ''Y'' and ADMPSTDAT = 20120131
                                    
--                                    group by ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX,ADMPRDCOD,ADMTRNTYP
--                                    ORDER BY 2
--                                    ')      
--                                    );

                        
   SELECT   COALESCE(CMT.CIMCLICOD,ED.AEPCLICOD,TR.ADMCLICOD) AS CLIENTCODE,COALESCE(CMT.CIMACCCOD,ED.AEPACCCOD,TR.ADMACCCOD) AS ACCOUNTCODE,COALESCE(CMT.CIMAGRCOD,ED.AEPAGRCOD,TR.ADMAGRCOD) AS AGRCODE,
   COALESCE(CMT.CIMAGRSFX,ED.AEPAGRSFX,TR.ADMAGRSFX)AS AGRSFXCODE,COALESCE(CMT.CIMPRDCOD,ED.AEPPRDCOD,TR.ADMPRDCOD)AS PRDCODE,ISNULL(CLAIM_AMOUNT,0) AS CLAIM_AMT,ISNULL(ED.EarnedReserves,0)AS EARNED_RESERVES,
    ISNULL(TR.Total_Reserves,0)AS TOTAL_RESERVES,TR.ADMTRNTYP,CMT.CLAIM_COUNT INTO #FINAL
   FROM  #CLAIM_AMT CMT  FULL OUTER JOIN 
    #EARNED_DATA ED ON      CMT.CIMCLICOD=ED.AEPCLICOD AND  
                         CMT.CIMACCCOD=ED.AEPACCCOD AND
                         CMT.CIMAGRCOD=ED.AEPAGRCOD AND
                         CMT.CIMAGRSFX=ED.AEPAGRSFX AND
                         CMT.CIMPRDCOD=ED.AEPPRDCOD          
    
    FULL OUTER JOIN  #Total_Reserves_Trantyp TR ON 
      CMT.CIMCLICOD=TR.ADMCLICOD AND
                         CMT.CIMACCCOD=TR.ADMACCCOD AND
                         CMT.CIMAGRCOD=TR.ADMAGRCOD AND
                         CMT.CIMAGRSFX=TR.ADMAGRSFX AND
                         CMT.CIMPRDCOD=TR.ADMPRDCOD ;
                            
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
            WHERE an.EFG_AccountNumberName IS NOT null   )  A)
            
            SELECT *,#FINAL.* FROM CRMData LEFT OUTER JOIN #FINAL ON CRMData.Account_Code=#FINAL.ACCOUNTCODE

select * from [SV-SQL05].sguard_portal.dbo.tblVendorsUpdated
