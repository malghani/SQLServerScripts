USE [EFGSales]
GO
/****** Object:  StoredProcedure [dbo].[GetTier1Sales]    Script Date: 12/30/2013 16:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[GetTier1Sales]
@Period varchar(10) = NULL, --OP=OpenPeriod, CP=ClosedPeriods
@DateFrom DateTime = NULL ,
@DateTo DateTime = NULL


AS

-- EXEC GetTier1Sales 'Monthly', @DateFrom='01/01/2012', @DateTo='12/01/2013'
-- EXEC GetTier1Sales 'Daily'
-- EXEC GetTier1Sales 'Monthly'

SET NOCOUNT ON
SET XACT_ABORT ON


DECLARE @PSTDATE bigint
DECLARE @ClosedPeriodCount int=0
Declare @PostedPeriod DateTime
DECLARE @PSTDATES TABLE (PSTDATE bigint, PostDate DateTime) 
DECLARE @CurrentPeriod DateTime
DECLARE @OpenPeriod DateTime
DECLARE @ETLDateTime DateTime = GetDate()
DECLARE @ProcessingPeriod DateTime
DECLARE @RecCountPerPeriod bigint
DECLARE @ErrMsg Varchar(4000)


BEGIN TRY
SELECT @PSTDATE=MAX(ADMPSTDAT) FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM
SET @CurrentPeriod = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @PSTDATE),6),2)+'/' + RIGHT(Convert(Varchar(8), @PSTDATE),2)+'/'+ LEFT(Convert(Varchar(8), @PSTDATE),4))
SET @OpenPeriod=DateAdd(m, 1, @CurrentPeriod)
SET @OpenPeriod = Convert(DateTime, Convert(Varchar(2), DatePart(m, @OpenPeriod))+'/01/'+Convert(Varchar(4), DatePart(yy, @OpenPeriod)))
SET @OpenPeriod = DateAdd(m, 1, @OpenPeriod )
SET @OpenPeriod = DateAdd(d, -1, @OpenPeriod )
SET @CurrentPeriod = @OpenPeriod

   
If (@Period='Daily')
	INSERT @PSTDATES
	VALUES(0, @CurrentPeriod)
Else If (@Period = 'Monthly')
Begin
	IF @DateFrom IS NULL
	Begin		
		SET @DateFrom = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @PSTDATE),6),2)+'/' + RIGHT(Convert(Varchar(8), @PSTDATE),2)+'/'+ LEFT(Convert(Varchar(8), @PSTDATE),4))
		SET @DateTo = @DateFrom
		
		IF NOT (SELECT MAX(ADMPSTDAT) FROM dbo.SAL002_Tier1_Sales_YTD WHERE ADMPSTDAT>0 AND ADMPSTDAT=@PSTDATE) IS NULL
		Begin
			PRINT 'No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.'
			RETURN(0)  --No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.
		End			
    End				
		SET @PostedPeriod  = Convert(DateTime, Convert(Varchar(2), DatePart(Month, @DateFrom))+'/01/'+Convert(Varchar(4), DatePart(yy, @DateFrom)))
		SET @PostedPeriod  = DateAdd(Day, -1, DateAdd(Month, 1, @PostedPeriod))				
		SELECT @DateTo = ISNULL(@DateTo, @DateFrom)
		SELECT @ClosedPeriodCount=DATEDIFF(Month, @DateFrom, @DateTo)		
		WHILE @ClosedPeriodCount>=0
		Begin						
			INSERT @PSTDATES
			SELECT Convert(Varchar(4), DatePart(yy,@PostedPeriod ))+RIGHT('00'+Convert(Varchar(2), DatePart(Month,@PostedPeriod )),2)+Convert(Varchar(2), DatePart(d,@PostedPeriod )), @PostedPeriod				
			SET @DateFrom = DateAdd(Month, 1,@DateFrom)			
			SET @PostedPeriod  = Convert(DateTime, Convert(Varchar(2), DatePart(Month, @DateFrom))+'/01/'+Convert(Varchar(4), DatePart(yy, @DateFrom)))
			SET @PostedPeriod  = DateAdd(Day, -1, DateAdd(Month, 1, @PostedPeriod))				
			SET @ClosedPeriodCount = @ClosedPeriodCount - 1
		End			
End 
Else 
   Begin
		PRINT 'Parameter @Period has two possible values "Daily" Or "Monthly"'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Daily'' -- Will Run for the current Open Period'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'' -- Will Check if new period is available and '
		PRINT '                                                -- has no data in target then will Run for the new recently closed period'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'', @DateFrom=''11/15/2013'' -- Will Refresh(Replace the target) the Data for 11/2013 Posted Period  '
		PRINT '                                                                          -- Any Date for 11/2013 is acceptable.'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'', @DateFrom=''11/15/2012'' @DateTo=''11/15/2013'' -- Will Refresh (Replace the Target) the Data for all the Posted Periods falling in the  '
		PRINT '                                                                                                 -- Given Date Range. '				
		PRINT 'NOTE:Dates only help determine the posted periods and has no affect for the given day part.'
		RETURN(0)  --No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.  
   End
--IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name like '#CRMData%' and type='U')
--	DROP TABLE #CRMData
SELECT DISTINCT   EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
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

	



DECLARE period_cursor CURSOR
      FOR
      SELECT PSTDATE, PostDate FROM @PSTDATES	  
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @PSTDATE, @ProcessingPeriod
   WHILE (@@fetch_status <> -1)
   BEGIN  
				      
				IF (@Period = 'Monthly' OR @Period = 'History')
				BEGIN 
				
				
						--IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name = '#SalesDisbData' and type='U')
						--	drop table #SalesDisbData      
						SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMEFRTYN, 
								D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD, D.ADMDISAMT,
								A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL,
								A.AGMPSTDAT, D.ADMPSTDAT,D.ADMENTDAT, D.ADMEFFDAT, D.ADMRECDAT
						--Drop table #tmp
						INTO #SalesDisbData      
							  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
																ON  a.AGMCLICOD = d.ADMCLICOD and
																  a.AGMACCCOD = d.ADMACCCOD and
																  a.AGMAGRCOD = d.ADMAGRCOD and
																  a.AGMAGRSFX = d.ADMAGRSFX
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
															ON a.AGMCLICOD = p.APVCLICOD and
																  a.AGMACCCOD = p.APVACCCOD and
																  a.AGMAGRCOD = p.APVAGRCOD and
																  a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS'
																  AND p.APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PLN
															ON a.AGMCLICOD = PLN.APVCLICOD and
																  a.AGMACCCOD = PLN.APVACCCOD and
																  a.AGMAGRCOD = PLN.APVAGRCOD and
																  a.AGMAGRSFX = PLN.APVAGRSFX AND PLN.APVFLDCOD = '~MVPLNCOD'                                          
							  
							  WHERE ADMEFRTYN = 'Y' 
							 AND ADMPSTDAT=@PSTDATE

							DELETE #SalesDisbData WHERE ADMDISCOD NOT IN (SELECT FieldValue
							FROM  ETL_SourceDataFilter 
							WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
							AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate())
				
						BEGIN TRANSACTION				 
						DELETE [dbo].[SAL002_Tier1_Sales_YTD] WHERE ADMPSTDAT=@PSTDATE 
						INSERT [dbo].[SAL002_Tier1_Sales_YTD]
							([APVALPVAL],[ADMPSTDAT],[ADMCLICOD],[ADMACCCOD],[ADMAGRCOD],[ADMAGRSFX]
							  ,[EFG_Rep],[Account_Group],[Dealer_Name],[ADMTRNTYP]
							  ,[ADMDISTYP],[AGMPRGCOD],[Disbursement_Code]
							  ,[Disbursement_Amount],CPROG, CPROD, CPLAN,[NON_CANCELFEE_STATUS]
							  ,[ETLDateTime],[LOB], AGMPSTDAT,ADMENTDAT , ADMEFFDAT, ADMRECDAT)
								   
						SELECT  APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
								EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD,								
								ADMDISCOD, ADMDISAMT,AGMPRGCOD,ADMPRDCOD,AGDPLNCOD,
								NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
								@ETLDateTime, BusinessUnit, AGMPSTDAT, ADMENTDAT , ADMEFFDAT, ADMRECDAT
						FROM #SalesDisbData se
						LEFT OUTER JOIN #CRMData c ON se.ADMACCCOD = c.Account_Code
		      

		      

						UPDATE SAL002_Tier1_Sales_YTD SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep,						
						TXPostDate= CASE WHEN ISNULL(ADMPSTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMPSTDAT),4)) END,
						AGRPostDate= CASE WHEN ISNULL(AGMPSTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), AGMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), AGMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), AGMPSTDAT),4)) END,
						TXEntryDate= CASE WHEN ISNULL(ADMENTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMENTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMENTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMENTDAT),4)) END,
						TXRecordDate= CASE WHEN ISNULL(ADMRECDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMRECDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMRECDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMRECDAT),4)) END						
						WHERE ADMPSTDAT=@PSTDATE

						UPDATE SAL002_Tier1_Sales_YTD
						SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
						Where cprog like 'SAN%' AND ADMPSTDAT=@PSTDATE


						UPDATE SAL002_Tier1_Sales_YTD
						SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Disbursement_Amount ELSE 0 END,
							GrossCount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 1 ELSE 0 END,
							NetAmount=Disbursement_Amount,
							NetCount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 1 ELSE 
							CASE WHEN (ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
							WHERE ADMPSTDAT=@PSTDATE


							UPDATE S Set Product_Category=[Type], Super_Category=Category
							from SAL002_Tier1_Sales_YTD S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							WHERE ADMPSTDAT=@PSTDATE

							UPDATE S Set Product_Category=[Type], Super_Category=Category
							from SAL002_Tier1_Sales_YTD S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD
							WHERE Product_Category IS NULL AND ADMPSTDAT=@PSTDATE

							UPDATE S Set Product_Category='UNKNOWN', Super_Category='UNKNOWN'
							from SAL002_Tier1_Sales_YTD S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD))
							WHERE Product_Category IS NULL and M.CPROG is null AND ADMPSTDAT=@PSTDATE

							UPDATE S Set Product_Category='UNKNOWN', Super_Category='UNKNOWN'
							from SAL002_Tier1_Sales_YTD S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD))
							WHERE Product_Category IS NULL AND ADMPSTDAT=@PSTDATE
						
						COMMIT TRANSACTION
						SELECT @RecCountPerPeriod=count(*) From #SalesDisbData
						DROP TABLE #SalesDisbData
						INSERT dbo.ETL_Log
						         (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
						SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 1, NULL, @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales'
						
			  END
				IF @Period = 'Daily' 
				BEGIN 
				  
				  
				IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name LIke '#SalesDailyData%' and type='U')
					drop table #SalesDailyData      
				SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMEFRTYN, 
						D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD, D.ADMDISAMT,
						A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL,
						A.AGMPSTDAT, D.ADMPSTDAT,D.ADMENTDAT, D.ADMEFFDAT, D.ADMRECDAT
				
				INTO #SalesDailyData      
					  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
														ON  a.AGMCLICOD = d.ADMCLICOD and
														  a.AGMACCCOD = d.ADMACCCOD and
														  a.AGMAGRCOD = d.ADMAGRCOD and
														  a.AGMAGRSFX = d.ADMAGRSFX
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
													ON a.AGMCLICOD = p.APVCLICOD and
														  a.AGMACCCOD = p.APVACCCOD and
														  a.AGMAGRCOD = p.APVAGRCOD and
														  a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS'
														  AND p.APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PLN
													ON a.AGMCLICOD = PLN.APVCLICOD and
														  a.AGMACCCOD = PLN.APVACCCOD and
														  a.AGMAGRCOD = PLN.APVAGRCOD and
														  a.AGMAGRSFX = PLN.APVAGRSFX AND PLN.APVFLDCOD = '~MVPLNCOD'                                          
					  
					  WHERE ADMEFRTYN = 'Y' 
					 AND ADMPSTDAT=@PSTDATE

					DELETE #SalesDailyData WHERE ADMDISCOD NOT IN (SELECT FieldValue
					FROM  ETL_SourceDataFilter 
					WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
					AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate())
				
				
					BEGIN TRANSACTION
						DELETE [dbo].[SAL002_Tier1_Sales]
						INSERT INTO [dbo].[SAL002_Tier1_Sales]
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
								   ,[ETLDateTime]
								   ,[LOB]
								   ,CPROG
								   ,CPROD
								   ,CPLAN
								   ,AGMPSTDAT
								   ,ADMENTDAT 
								   ,ADMEFFDAT
								   ,ADMRECDAT)
						SELECT      APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
								EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD,
								ADMDISCOD, ADMDISAMT,
								NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
								@ETLDateTime, BusinessUnit, AGMPRGCOD,ADMPRDCOD,AGDPLNCOD, AGMPSTDAT, ADMENTDAT , ADMEFFDAT, ADMRECDAT

								
					FROM #SalesDailyData se
					LEFT OUTER JOIN #CRMData c ON se.ADMACCCOD = c.Account_Code
					
			
						UPDATE SAL002_Tier1_Sales SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep, 
						TXPostDate= CASE WHEN ISNULL(ADMPSTDAT,0)=0 THEN @ProcessingPeriod ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMPSTDAT),4)) END,
						AGRPostDate= CASE WHEN ISNULL(AGMPSTDAT,0)=0 THEN @ProcessingPeriod ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), AGMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), AGMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), AGMPSTDAT),4)) END,
						TXEntryDate= CASE WHEN ISNULL(ADMENTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMENTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMENTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMENTDAT),4)) END,
						TXRecordDate= CASE WHEN ISNULL(ADMRECDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMRECDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMRECDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMRECDAT),4)) END
						From SAL002_Tier1_Sales 
			
						

						UPDATE SAL002_Tier1_Sales
						SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
						Where cprog like 'SAN%' 

						UPDATE SAL002_Tier1_Sales 
						SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Disbursement_Amount ELSE 0 END,
							GrossCount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 1 ELSE 0 END,
							NetAmount=Disbursement_Amount,
							NetCount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN 1 ELSE 
							CASE WHEN (ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END

							UPDATE S Set Product_Category=[Type], Super_Category=Category
							from SAL002_Tier1_Sales S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN

							UPDATE S Set Product_Category=[Type], Super_Category=Category
							from SAL002_Tier1_Sales S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD
							WHERE Product_Category IS NULL

							UPDATE S Set Product_Category='UNKNOWN', Super_Category='UNKNOWN'
							from SAL002_Tier1_Sales S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD))
							WHERE Product_Category IS NULL and M.CPROG is null
							
							UPDATE S Set Product_Category='UNKNOWN', Super_Category='UNKNOWN'
							from SAL002_Tier1_Sales S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD))
							WHERE Product_Category IS NULL

						DELETE SAL002_Tier1_Sales_YTD WHERE ADMPSTDAT = 0
						INSERT SAL002_Tier1_Sales_YTD
						SELECT * FROM SAL002_Tier1_Sales
						COMMIT TRANSACTION
						
						SELECT @RecCountPerPeriod=count(*) From #SalesDailyData
						INSERT dbo.ETL_Log
						         (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
						SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 1, NULL, @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales' 					

				DROP TABLE #SalesDailyData
				
			  END			  
      
   FETCH NEXT FROM period_cursor INTO @PSTDATE, @ProcessingPeriod
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor

  DROP TABLE #CRMData   
END TRY	


BEGIN CATCH
IF @@TRANCOUNT > 1
   ROLLBACK TRANSACTION
SET	@ErrMsg=ERROR_MESSAGE()
PRINT @ErrMsg
	INSERT dbo.ETL_Log
	(ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage , RecordCount, [Parameters], ProcedureName)
	SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 0, convert(varchar(4000), ltrim(rtrim(@ErrMsg))) , @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales'
END CATCH

