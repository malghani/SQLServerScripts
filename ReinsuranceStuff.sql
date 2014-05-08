Declare @AccountCode varchar(30)='0000025965'
Declare @ReinsuranceCode varchar(30)='0000000302'
Declare @Product varchar(100)='WRAP'

select ADMPRDCOD Product,ADMACCCOD Account, RDTINSCOD, p.APVALPVAL, convert(varchar, pv.APVNUMVAL) Term, Count(Distinct ltrim(rtrim(ADMAGRCOD))+ltrim(rtrim(ADMAGRSFX))) Contracts,  
SUM(ADMDISAMT*RDCLMPCT) NETReserves
--select ADMTRNTYP
from I400DASQL.EFGAS400.SESCSEFG.SCAGRDM s
inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
on agmclicod = admclicod  and agmacccod = admacccod and agmagrcod = admagrcod and agmagrsfx = admagrsfx --and AGMPRDCOD=ADMPRDCOD
inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
on ratblcod = rdtblcod and raseq  = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat

LEFT JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PV ON 
			PV.APVCLICOD=ADMCLICOD AND
			PV.APVACCCOD=ADMACCCOD AND
			PV.APVAGRCOD=ADMAGRCOD AND
			PV.APVAGRSFX=ADMAGRSFX AND
			PV.APVPRDCOD=ADMPRDCOD
			AND PV.APVFLDCOD='~MVTRMTIM' 
LEFT JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM P  ON 				
			P.APVCLICOD=ADMCLICOD AND
			P.APVACCCOD=ADMACCCOD AND
			P.APVAGRCOD=ADMAGRCOD AND
			P.APVAGRSFX=ADMAGRSFX AND
			P.APVPRDCOD=ADMPRDCOD
			AND P.APVFLDCOD='~MVNWUSNA'				 

		
WHERE
ADMPSTDAT <= 20130930 AND ADMPSTDAT > 0 
AND admACCCOD = @AccountCode
AND RDTINSCOD=@ReinsuranceCode
AND ADMDISTYP='RESV'
AND ADMPRDCOD = @Product
AND pv.apvnumval=120.0000000000
Group By ADMPRDCOD,ADMACCCOD, RDTINSCOD, p.APVALPVAL, convert(varchar, pv.APVNUMVAL)
Order By ADMPRDCOD,ADMACCCOD, RDTINSCOD, p.APVALPVAL, convert(varchar, pv.APVNUMVAL)


Select admclicod,  admacccod, ADMPRDCOD, apvnumval, SUM(ADMDISAMT) 
From (
	select distinct admclicod,  admacccod, admagrcod,  admagrsfx, ADMPRDCOD, pv.apvnumval, ADMDISAMT
	from I400DASQL.EFGAS400.SESCSEFG.SCAGRDM s
	inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
	on agmclicod = admclicod  and agmacccod = admacccod and agmagrcod = admagrcod and agmagrsfx = admagrsfx --and AGMPRDCOD=ADMPRDCOD
	inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
	on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
	inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
	on ratblcod = rdtblcod and raseq  = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat

	LEFT JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PV ON 
				PV.APVCLICOD=ADMCLICOD AND
				PV.APVACCCOD=ADMACCCOD AND
				PV.APVAGRCOD=ADMAGRCOD AND
				PV.APVAGRSFX=ADMAGRSFX AND
				PV.APVPRDCOD=ADMPRDCOD
				AND PV.APVFLDCOD='~MVTRMTIM' 
	LEFT JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM P  ON 				
				P.APVCLICOD=ADMCLICOD AND
				P.APVACCCOD=ADMACCCOD AND
				P.APVAGRCOD=ADMAGRCOD AND
				P.APVAGRSFX=ADMAGRSFX AND
				P.APVPRDCOD=ADMPRDCOD
				AND P.APVFLDCOD='~MVNWUSNA'				 
			
	WHERE
	ADMPSTDAT <= 20130930 AND ADMPSTDAT > 0 
	AND admACCCOD = '0000025965'
	AND RDTINSCOD='0000000302' 
	AND ADMDISTYP='RESV'
	AND ADMPRDCOD = 'WRAP'
	AND ADMDISAMT > 0 AND ADMTRNTYP='CAN' AND ADMTRNTYP='can'
) AS mn 

Group By admclicod,  admacccod, ADMPRDCOD, apvnumval




use RptDataDaily_Dev
sp_helptext SSRS_SalesTier1_Gross_Monthly_Account_Performance


select * from dbo.SAL002_Tier1_Sales_YTD