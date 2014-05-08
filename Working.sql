IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name LIke '#Post%' and type='U')
					  Drop table #Post						

					  SELECT DISTINCT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, BMFPSTDAT
					  INTO #Post
					  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
														ON  a.AGMCLICOD = d.ADMCLICOD and
														  a.AGMACCCOD = d.ADMACCCOD and
														  a.AGMAGRCOD = d.ADMAGRCOD and
														  a.AGMAGRSFX = d.ADMAGRSFX
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCBCHM BATCH
									ON A.agmbchnbr = BATCH.bmfbchnbr AND BMFPSTDAT>20140430


						WHERE ADMEFRTYN = 'Y'
						AND ADMDISCOD IN (SELECT FieldValue
											FROM  ETL_SourceDataFilter 
											WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
											AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate()
										 )
						AND ADMPSTDAT=20140430
						
						--DELETE D 
						Select * From SAL002_Tier1_Sales D
						inner join #Post P ON P.ADMCLICOD=D.ADMCLICOD AND P.ADMACCCOD=D.ADMACCCOD AND P.ADMAGRCOD=D.ADMAGRCOD AND P.ADMAGRSFX=D.ADMAGRSFX



					  SELECT DISTINCT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, CANPSTDAT=CAN.APVDATVAL
					  INTO #Cancels
					  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
														ON  a.AGMCLICOD = d.ADMCLICOD and
														  a.AGMACCCOD = d.ADMACCCOD and
														  a.AGMAGRCOD = d.ADMAGRCOD and
														  a.AGMAGRSFX = d.ADMAGRSFX
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM CAN 
													ON a.AGMCLICOD = CAN .APVCLICOD and
													a.AGMACCCOD = CAN .APVACCCOD and
													a.AGMAGRCOD = CAN .APVAGRCOD and
													a.AGMAGRSFX = CAN .APVAGRSFX AND CAN .APVFLDCOD = '~MVCANPST'
													AND CAN.APVDATVAL > 20140430
						WHERE ADMEFRTYN = 'Y'
						AND ADMDISCOD IN (SELECT FieldValue
											FROM  ETL_SourceDataFilter 
											WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
											AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate()
										 )									 
						AND (ADMPSTDAT=20140430)


						--DELETE D 
						--Select * 
						From SAL002_Tier1_Sales D
						inner join #Cancels P ON P.ADMCLICOD=D.ADMCLICOD AND P.ADMACCCOD=D.ADMACCCOD AND P.ADMAGRCOD=D.ADMAGRCOD AND P.ADMAGRSFX=D.ADMAGRSFX
						left join SAL002_Tier1_Sales_YTD Y ON Y.ADMCLICOD=D.ADMCLICOD AND Y.ADMACCCOD=D.ADMACCCOD AND Y.ADMAGRCOD=D.ADMAGRCOD AND Y.ADMAGRSFX=D.ADMAGRSFX aND Y.ADMPSTDAT=20140330
						Where Y.ADMAGRCOD IS NULL



Select LOB, Client, PostDate, AgreementCount=count(*) From SuspendDetail Group by LOB, Client, PostDate
Order by LOB


Select * into SAL002_Tier1_Sales2 FROM EFGSales.dbo.[SAL002_Tier1_Sales_YTD] WHERE ADMPSTDAT=20140530

Truncate Table SAL002_Tier1_Sales
Select * into SAL002_Tier1_Sales1 FROM [SV-SQLPRODVM].EFGSales.dbo.[SAL002_Tier1_Sales]
Select count(*) FROM [SV-SQLPRODVM].EFGSales.dbo.[SAL002_Tier1_Sales]

INsERT SAL002_Tier1_Sales (APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory)
Select  APVALPVAL, 0, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory From SAL002_Tier1_Sales1


INSERT SAL002_Tier1_Sales_YTD
(APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory)
Select APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory From [SV-SQL06].EFGSales.dbo.SAL002_Tier1_Sales Y (NOLOCK) 

Select Max(ADMPSTDAT) From SAL002_Tier1_Sales_YTD

Delete from EFGSales.dbo.[SAL002_Tier1_Sales_YTD] WHERE ADMPSTDAT = 20140531