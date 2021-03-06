
Declare @Delta bit=0
Declare @PeriodFrom int=19000000
Declare @PeriodTo int=20140331

Truncate Table _Staging_LastPull_ClaimsHist

IF @Delta=0
Begin
		INSERT _Staging_LastPull_ClaimsHist
				(PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID,
				PRDCHKAMT,	PRDPAYSTS, PRDPRTDAT)
		SELECT  PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDCHKAMT=SUM(PRDCHKAMT),
				PRDPAYSTS='1', PRDPRTDAT=MIN(PRDPRTDAT)		
		
		From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD P


		WHERE PRDPRTDAT BETWEEN @PeriodFrom AND @PeriodTo
		AND PRDPAYTYP='CL' AND PRDCLMTID>0 AND 
		PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPAYSTS = 'V' AND PRDPAYTYP='CL' AND PRDCLMTID>0 Group by PRDPAYTID)
		GROUP BY PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDCLMTID
End
-------------------------------OLD CLAIMS PAID THIS PERIOD -------------------------------------------------------
ELSE
Begin
		INSERT _Staging_LastPull_ClaimsHist (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID,
				PRDCHKAMT,	PRDPAYSTS, PRDPRTDAT)		
		SELECT  PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDCHKAMT=SUM(PRDCHKAMT),
				PRDPAYSTS, PRDPRTDAT=MIN(PRDPRTDAT)				
		From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD P
		WHERE PRDPRTDAT  BETWEEN @PeriodFrom AND @PeriodTo 
		AND PRDPAYTYP='CL' AND PRDCLMTID>0 AND PRDPRTDAT>0
		AND PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPAYSTS = 'V' AND PRDPAYTYP='CL' AND PRDCLMTID>0 Group by PRDPAYTID)
		AND PRDCLMTID NOT IN (SELECT PRDCLMTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPRTDAT < @PeriodFrom AND PRDPAYTYP='CL' AND PRDCLMTID>0 GROUP BY PRDCLMTID )
		GROUP BY PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDCLMTID,PRDPAYSTS
End



UPDATE _Staging_LastPull_ClaimsHist 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
	PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
	PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
	PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
	PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

UPDATE ST SET PRDPRTDATMIN=C.DateID
--SELECT ST.*, C.DateID, Convert(Varchar, RIGHT(Convert(Varchar, St.PRDPRTDAT),4)), LEFT(RIGHT(Convert(Varchar, St.PRDPRTDAT),4),2)
From _Staging_LastPull_ClaimsHist St
INNER JOIN Calendar C ON C.Year=Left(St.PRDPRTDAT,4) AND C.Month=LEFT(RIGHT(Convert(Varchar, St.PRDPRTDAT),4),2)

--Crunch History to 20061231
UPDATE _Staging_LastPull_ClaimsHist Set PRDPRTDATMIN=20061231 WHERE PRDPRTDATMIN<20061231

Select Period=PRDPRTDATMIN, AgreementID, ClaimCount=count(*) From _Staging_LastPull_ClaimsHist ST --987665 --986919
INNER JOIN DimAgreement A ON ST.PRDCLICOD=A.SourceCLICOD AND ST.PRDACCCOD=A.SourceACCCOD AND ST.PRDAGRCOD=A.SourceAGRCOD AND ST.PRDAGRSFX=A.SourceAGRSFX AND ST.PRDPRDCOD=A.SourcePRDCOD
Group by AgreementID, PRDPRTDATMIN

Select count(*) 

UPDATE FS SET ClaimsCount=CLM.ClaimCount, ClaimsPaidCount=CLM.ClaimCount
--Select count(*)
From FactSales FS --48973643--48973643--16207591--358936
INNER JOIN 
(	
	Select Period=PRDPRTDATMIN, AgreementID, ClaimCount=count(*) From _Staging_LastPull_ClaimsHist ST --987665 --986919
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
	UnearnedReserves=0
    into #tmpFS	        	
	From _Staging_LastPull_ClaimsHist CH --987665 --986919
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
	ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD,UnearnedReserves)
SELECT * From #tmpFS	

Drop table #tmpFS


Declare @PeriodFrom bigint=20061231,
@PeriodTo bigint=20140331


Declare @Periods TABLE (Period bigint)
Declare @MaxPeriod bigint

Select @MaxPeriod = Max(period) From FactSalesAggregate
If @MaxPeriod > @PeriodTo
   SET @PeriodTo = @MaxPeriod


INSERT @Periods (Period)
SELECT DateID From Calendar Where DateID Between @PeriodFrom And @PeriodTo Group by DateID Order by DateID

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
	  --SELECT 'Processed ' + Convert(Varchar, @Period)
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



---------- MISSING AGREEMENTS ---------------------

		Select AgreementCount=count(DISTINCT CH.prdcliCOD+cH.PRDACCCOD+CH.PRDAGRCOD+CH.PRDAGRSFX+CH.PRDPRDCOD), ClaimCount=COUNT(dISTINCT CH.PRDCLMTID), ClaimPayment=sUM(CH.PRDCHKAMT) 
		From _Staging_LastPull_ClaimsHist CH with (NOLOCK)
		LEFT JOIN [SV-SQLPRODVM].ReinsuranceData.dbo.SCAGRDM A with (NOLOCK)
						ON ltrim(rtrim(A.ADMCLICOD))=PRDCLICOD AND
						   ltrim(rtrim(A.ADMACCCOD))=PRDACCCOD AND
						   ltrim(rtrim(A.ADMAGRCOD))=PRDAGRCOD AND
						   ltrim(rtrim(A.ADMAGRSFX))=PRDAGRSFX AND
						   ltrim(rtrim(A.ADMPRDCOD))=PRDPRDCOD 

		WHERE A.ADMAGRCOD IS NULL



		

Select AgreementCount=count(DISTINCT CH.prdcliCOD+cH.PRDACCCOD+CH.PRDAGRCOD+CH.PRDAGRSFX+CH.PRDPRDCOD), ClaimCount=COUNT(dISTINCT CH.PRDCLMTID), ClaimPayment=sUM(CH.PRDCHKAMT) 
FROM _Staging_LastPull_ClaimsHist ch
INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM SA 
		ON SA.AGMCLICOD=PRDCLICOD AND
		   SA.AGMACCCOD=PRDACCCOD AND
		   SA.AGMAGRCOD=PRDAGRCOD AND
		   SA.AGMAGRSFX=PRDAGRSFX 
left join  DimAgreement A
			ON  CH.PRDCLICOD=A.SourceCLICOD AND
				CH.PRDACCCOD=A.SourceACCCOD AND
				CH.PRDAGRCOD=A.SourceAGRCOD AND
				CH.PRDAGRSFX=A.SourceAGRSFX AND
				CH.PRDPRDCOD=A.SourcePRDCOD 
Where A.AgreementID is null 

SELECT * 
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A							  
LEFT OUTER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
				ON  a.AGMCLICOD = D.ADMCLICOD AND
					a.AGMACCCOD = D.ADMACCCOD AND
					a.AGMAGRCOD = D.ADMAGRCOD AND
					a.AGMAGRSFX = D.ADMAGRSFX
WHERE A.AGMPSTDAT=20140331 AND D.ADMAGRCOD IS NULL






Select * From _Staging_LastPull_ClaimsHist








kill 59
sp_whoisactive


Select a.Agreementid, a.SourceAGRCOD, earnedreserves, claimscount, claimspaid, CLMSrcAmt 
From FactSales FS (nolock) 
inner join dimagreement a on a.AgreementID=fs.AgreementID
Where CLMSrcAmt <> 0 and period=20140331 and claimspaid<>clmsrcamt and claimspaid>0



Select * From dimAGreement Where Agreementid=2938537
Select * From factSales(nolock) Where Agreementid=2938537

Select * From 
Where 


SELECT  OldClaimCount=Count(Distinct PRDCLMTID), Payment=SUM(PRDCHKAMT)

Select * 
SELECT PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCHKAMT=SUM(PRDCHKAMT),
				 PRDPAYTYP, PRDPRTDAT=MIN(PRDPRTDAT)		
into #tmp From  I400DASQL.EFGAS400.SESCSEFG.SCPAYRD 
WHERE PRDPRTDAT  BETWEEN 20140300 AND 20140331 AND PRDPAYTYP in ('CN' , 'CL')
--AND PRDCLMTID>0
--AND PRDACCCOD='0000030561' 
--AND PRDAGRCOD='         30561034285' 
AND PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPAYSTS = 'V' AND  PRDPRTDAT  BETWEEN 20140300 AND 20140331  Group by PRDPAYTID)

AND ltrim(rtrim(PRDAGRCOD)) IN 
(
Select distinct SourceAGRCOD
From FactSales FS (nolock) 
inner join dimagreement a on a.AgreementID=fs.AgreementID
Where CLMSrcAmt <> 0 and period=20140331 and claimspaid<>clmsrcamt and claimspaid>0
)
GROUP BY PRDPAYTYP, PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD
ORDER BY PRDAGRCOD



Select * From #tmp t

Select Period, a.sourceagrcod, FS.claimspaid, CLMSrcAmt, PRDCHKAMT, t.PRDPAYTYP, FS.ClaimsCount
From FactSales FS (nolock) 
inner join dimagreement a on a.AgreementID=fs.AgreementID
inner join #tmp t on rtrim(ltrim(t.prdagrcod))=a.sourceagrcod AND a.SourceAGRCOD='56889150506'
--Where CLMSrcAmt <> 0 and period<=20140331 --and claimspaid<>clmsrcamt and claimspaid<>0
order by a.SourceAGRCOD


Select Period, a.sourceagrcod, FS.claimspaid, FS.ClaimsPaidITD, CLMSrcAmt,  FS.ClaimsCount
From FactSales FS (nolock) 
inner join dimagreement a on a.AgreementID=fs.AgreementID
WHERE a.SourceAGRCOD='56889150506'
order by Period

Select PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCHKAMT,
				 PRDPAYTYP, PRDPRTDAT,PRDPAYSTS,PRDCLMTID
From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD 
WHERE PRDAGRCOD='         56889150506' 



Select AEPCLICOD,
		AEPACCCOD,
		AEPAGRCOD,
		AEPAGRSFX,
		AEPPRDCOD,
		AEPYRMON,
		AEPCLMCM=SUM(AEPCLMCM) ,
		AEPCLMITD=SUM(AEPCLMITD),
		AEPERNITD=SUM(AEPERNITD),
		AEPERNCM=SUM(AEPERNCM)
From I400DASQL.EFGAS400.SESCSEFG.SCAGREP 
WHERE AEPAGRCOD='         56889150506' 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON






Select *  From _Staging_LastPull_ClaimsHist with (nolock) Where PRDAGRCOD='         56889150506' 




select top 1 * into _Staging_LastPull_ClaimsHist3 from [_Staging_LastPull_ClaimsHist2]
TRUNCATE TABLE [dbo].[_Staging_LastPull_ClaimsHist3]


		Declare @PreFromPeriod int, @Period int=20140331
		Select @PreFromPeriod=CP.DateID From Calendar C
		INNER JOIN Calendar CP ON CP.Year=C.Year And CP.Month=C.Month-1
		Where C.DateID=@Period
		

		INSERT _Staging_LastPull_ClaimsHist3 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID,
				PRDCHKAMT,	PRDPAYSTS, PRDPRTDAT)		

		SELECT  PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDCHKAMT=SUM(PRDCHKAMT),
				MAX(PRDPAYSTS), PRDPRTDAT=MIN(PRDPRTDAT)				
		From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD P
		WHERE PRDPRTDAT  > 0 AND PRDPRTDAT <= @Period AND PRDPRTDAT>@PreFromPeriod
		AND PRDPAYTYP='CL' AND PRDCLMTID>0 AND PRDCHKAMT<>0 --AND  PRDCLMTID=93087008
		AND PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
							  WHERE PRDPAYSTS = 'V' AND PRDPAYTYP='CL' AND PRDCLMTID>0 Group by PRDPAYTID)
		AND PRDCLMTID NOT IN (
								SELECT Distinct PRDCLMTID FROM I400DASQL.EFGAS400.SESCSEFG.SCPAYRD 
								WHERE 	PRDPRTDAT<=	@PreFromPeriod 
								AND PRDPAYTYP='CL' AND PRDCLMTID>0 AND  PRDCHKAMT<>0
								AND PRDPAYTID NOT IN (SELECT PRDPAYTID From I400DASQL.EFGAS400.SESCSEFG.SCPAYRD  
								WHERE PRDPAYSTS = 'V' AND PRDPAYTYP='CL' AND PRDCLMTID>0 Group by PRDPAYTID)
							 )	  		
		GROUP BY PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDCLMTID



UPDATE _Staging_LastPull_ClaimsHist3
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
	PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
	PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
	PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
	PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

UPDATE ST SET PRDPRTDATMIN=C.DateID
From _Staging_LastPull_ClaimsHist3 St
INNER JOIN Calendar C ON C.Year=Left(St.PRDPRTDAT,4) AND C.Month=LEFT(RIGHT(Convert(Varchar, St.PRDPRTDAT),4),2)
