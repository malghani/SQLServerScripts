
GRANT VIEW Definition TO PUBLIC

SET NOCOUNT ON


TRUNCATE TABLE [dbo].[_Staging_LastPull_ClaimsHist]


		INSERT _Staging_LastPull_ClaimsHist (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID,
				PRDCHKAMT,	PRDPAYSTS, PRDPRTDAT)		

		SELECT  PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDCHKAMT=SUM(PRDCHKAMT),
				0, PRDPRTDAT=MIN(PRDPRTDAT)				
		From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD P
		WHERE PRDPRTDAT  > 0 AND PRDPRTDAT <= 20140331 
		AND PRDPAYTYP='CL' AND PRDCLMTID>0 AND PRDCHKAMT<>0
		AND PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPAYSTS = 'V' AND PRDPAYTYP='CL' AND PRDCLMTID>0 Group by PRDPAYTID)
		GROUP BY PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDCLMTID




UPDATE _Staging_LastPull_ClaimsHist 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
	PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
	PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
	PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
	PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

UPDATE ST SET PRDPRTDATMIN=C.DateID
From _Staging_LastPull_ClaimsHist St
INNER JOIN Calendar C ON C.Year=Left(St.PRDPRTDAT,4) AND C.Month=LEFT(RIGHT(Convert(Varchar, St.PRDPRTDAT),4),2)

--Crunch History to 20061231
UPDATE _Staging_LastPull_ClaimsHist Set PRDPRTDATMIN=20061231 WHERE PRDPRTDATMIN<20061231

UPDATE FactSales Set ClaimsCount=0, ClaimsPaidCount=0, CLMSrcAmt=0

UPDATE FS SET ClaimsCount=CLM.ClaimCount, ClaimsPaidCount=CLM.ClaimCount, CLMSrcAmt=ClaimAmount
From FactSales FS 
INNER JOIN 
(	
	Select Period=PRDPRTDATMIN, AgreementID, ClaimCount=count(*), ClaimAmount=Sum(ST.PRDCHKAMT) From _Staging_LastPull_ClaimsHist ST 
	INNER JOIN DimAgreement A ON ST.PRDCLICOD=A.SourceCLICOD AND ST.PRDACCCOD=A.SourceACCCOD AND ST.PRDAGRCOD=A.SourceAGRCOD AND ST.PRDAGRSFX=A.SourceAGRSFX AND ST.PRDPRDCOD=A.SourcePRDCOD
	Group by AgreementID, PRDPRTDATMIN
) As CLM ON CLM.AgreementID=FS.AgreementID AND CLM.Period=FS.Period




Select 	
	CH.PRDPRTDATMIN, BA.AccountID, BA.PartnerID, BA.NationalAccountID, BA.SalesManagerID, 
	BA.StateID, BA.ProductCategoryID, BA.ProductTypeID, BA.ProductNameID, BA.CoverageID, 
	BA.TermID, BA.VehicleStateID, BA.AgreementID, BA.PlanID, BA.FourPartKeyID, BA.AgreementPostedPeriod,	
	CancelCount=0, NetContractCount=0, GrossContractCount=0, 
	GrossReserves=0, NetReserves=0, NetWrittenReserves=0, GrossWrittenReserves=0, PremiumReserves=0, 
	AmenededReserves=0, CURCount=0, AMDCount=0, CANCount=0, RENCount=0, CURAmt=0, AMDAmt=0, CANAmt=0, RENAmt=0,
	ClaimsCount=count(*),
	ClaimsPaidCount=count(*),
	ClaimsPaid=0,
	ClaimsPaidITD=0,
	EarnedReserves=0,
	EarnedReservesITD=0,
	UnearnedReserves=0,
	CLMSrcAmt=SUM(PRDCHKAMT)
	
into #tmpFS	        	
From _Staging_LastPull_ClaimsHist CH 
	INNER JOIN DimAgreement A ON CH.PRDCLICOD=A.SourceCLICOD AND CH.PRDACCCOD=A.SourceACCCOD AND CH.PRDAGRCOD=A.SourceAGRCOD AND CH.PRDAGRSFX=A.SourceAGRSFX AND CH.PRDPRDCOD=A.SourcePRDCOD
	INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	LEFT JOIN FactSales FS ON FS.AgreementID=A.AgreementID AND FS.Period=CH.PRDPRTDATMIN
WHERE FS.AgreementID IS NULL
Group by CH.PRDPRTDATMIN,
	BA.AccountID, BA.PartnerID, BA.NationalAccountID, BA.SalesManagerID, 
	BA.StateID, BA.ProductCategoryID, BA.ProductTypeID, BA.ProductNameID, BA.CoverageID, 
	BA.TermID, BA.VehicleStateID, BA.AgreementID, BA.PlanID, BA.FourPartKeyID, BA.AgreementPostedPeriod

	
INSERT FactSales ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,	
	CancelCount, NetContractCount, GrossContractCount, 
	GrossReserves, NetReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt,
	ClaimsCount, ClaimsPaidCount,
	ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD,UnearnedReserves, CLMSrcAmt)
SELECT * From #tmpFS	



Declare @Periods TABLE (Period bigint)
INSERT @Periods (Period)
SELECT DateID From Calendar Where DateID Between 20061231 And 20140331 Group by DateID Order by DateID

Truncate Table FactSalesAggregate 


   DECLARE @Period bigint   
   DECLARE period_cursor CURSOR  STATIC LOCAL 
      FOR
       SELECT Period From @Periods Order by Period-- Order is very Important for ITD being sum of previous
	  
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @Period
   WHILE (@@fetch_status <> -1)
   BEGIN  
      EXEC _ETL_T2T3_AggregateFactSales @Period
      FETCH NEXT FROM period_cursor INTO @Period
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor
   
   
-- PROCESS PARAMETERS..
Truncate Table T2T3ReportsParameters
INSERT T2T3ReportsParameters
SELECT Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
From FactSalesAggregate (NOLOCK)
Group By Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID

