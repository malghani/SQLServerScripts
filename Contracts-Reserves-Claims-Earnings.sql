--GET Rinsurer information mappings

-------------------------
			-- Connect to sv-sql07 
			use EFGCubeFactsDims
			Select distinct cpt.ReinsurerName, cpt.ReinsurerCode, AccountCode=[Account Code], Dealership=CRM.BillingAccountName, Product=cprod
			from DimContract C (NOLOCK)
			JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID			
			join DimReinsuranceCompanies cpt (NOLOCK) on cpt.ID_Key=CedeToCompanyID
			join DimReinsuranceCompanies cpf (NOLOCK) on cpf.ID_Key=CedeFromCompanyID
			JOIN efgdw..CRMdata CRM (NOLOCK) ON  c.[Account Code] = crm.BillingAccountNumber 
			Order by cpt.ReinsurerName, cpt.ReinsurerCode, [Account Code], CRM.BillingAccountName, cprod
			
			
			--and Dealership like 'Davis-Moore Mazda%'
			----Where [Account Code] IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
			----AND cpt.ReinsurerName='Ray Reinsurance, Ltd.'
			Order by cpt.ReinsurerName, cpt.ReinsurerCode, [Account Code], CRM.BillingAccountName, cprod
select * from #Rins	--Where ltrim(rtrim(Product))=''

select *
from efgdw..ReinsuranceMaster
where RMINSNAM like 'JD%'

			
----------------------------------------			
			
			


SELECT Mapping.RN, Mapping.Dealership, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMDISCOD, Mapping.RN, SUM(ADMDISAMT) AS TotalReserved
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM 
JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PV ON 
			PV.APVCLICOD=ADMCLICOD AND
			PV.APVACCCOD=ADMACCCOD AND
			PV.APVAGRCOD=ADMAGRCOD AND
			PV.APVAGRSFX=ADMAGRSFX AND
			PV.APVPRDCOD=ADMPRDCOD
			--AND PV.APVFLDCOD='MVTRMTIM'
			

JOIN (
			Select distinct CRM.BillingAccountName Dealership, C.[Client Code] CC, [Account Code] AC, [Agreement Code] AGC, [Agreement Suffix] SFX, cpt.ReinsurerName RN,  C.cProd
			from DimContract C
			JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID			
			join DimReinsuranceCompanies cpt on cpt.ID_Key=CedeToCompanyID
			join DimReinsuranceCompanies cpf on cpf.ID_Key=CedeFromCompanyID
			JOIN efgdw..CRMdata CRM ON  c.[Account Code] = crm.BillingAccountNumber and Dealership like 'Davis-Moore Mazda%'
			Where [Account Code] IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
			AND cpt.ReinsurerName='Ray Reinsurance, Ltd.'
			AND cProd='WRAP'

	 ) AS Mapping on ltrim(rtrim(Mapping.CC))=ltrim(rtrim(APVCLICOD)) AND ltrim(rtrim(Mapping.AC))=ltrim(rtrim(APVACCCOD)) AND ltrim(rtrim(Mapping.AGC))=ltrim(rtrim(APVAGRCOD)) AND ltrim(rtrim(Mapping.SFX))=ltrim(rtrim(APVAGRSFX)) AND ltrim(rtrim(APVPRDCOD))=ltrim(rtrim(Mapping.cProd))

Where ADMACCCOD IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
AND ADMPSTDAT BETWEEN 20020201 AND 20130930 AND ADMDISTYP='RESV' AND ADMPRDCOD='WRAP'
GROUP BY Mapping.RN, Mapping.Dealership, ADMPSTDAT , ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
ORDER BY Mapping.RN, Mapping.Dealership, ADMPSTDAT desc, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD

/*

select * from efgdw..CRMdata where Dealership like 'Davis-Moore Mazda%'
Select * from [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber where efg_accountidname like 'Davis-Moore Mazda%'

      select *
      from efgdw..vw_Reinsurance
      where CedeToCompany='0000000302'
      And AccountCode='0000025965'


*/



--NET Reserves
select s.ADMCLICOD,ADMACCCOD,ltrim(rtrim(ADMAGRCOD))ADMAGRCOD,ADMAGRSFX,ADMDISAMT,RDCLMPCT,ADMDISAMT*RDCLMPCT AS CEDECLAIMAMT
--select distinct RDTINSCOD
from I400DASQL.EFGAS400.SESCSEFG.SCAGRDM s
inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
on agmclicod = admclicod  and agmacccod = admacccod and agmagrcod = admagrcod and agmagrsfx = admagrsfx --and AGMPRDCOD=ADMPRDCOD
inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
on ratblcod = rdtblcod and raseq  = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat
--JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PV ON 
--			PV.APVCLICOD=ADMCLICOD AND
--			PV.APVACCCOD=ADMACCCOD AND
--			PV.APVAGRCOD=ADMAGRCOD AND
--			PV.APVAGRSFX=ADMAGRSFX AND
--			PV.APVPRDCOD=ADMPRDCOD 
-- APVFLDCOD='~MVTRMTIM' 
WHERE
ADMPSTDAT <= 20130930 AND ADMPSTDAT > 0 
AND admACCCOD = '0000025965'
AND RDTINSCOD='0000000302' 
AND ADMDISTYP='RESV'
AND s.ADMPRDCOD = 'WRAP'
AND s.ADMDISAMT > 0
Order by ADMDISAMT

------------------------ CONTRACTS AND RESERVES -------------------------------------------------------------------------------
--select pv.APVNUMVAL, s.ADMCLICOD,ADMACCCOD,ltrim(rtrim(ADMAGRCOD))ADMAGRCOD,ADMAGRSFX,ADMDISAMT,RDCLMPCT,ADMDISAMT*RDCLMPCT AS CEDECLAIMAMT
--select pv.APVNUMVAL, s.ADMCLICOD,ADMACCCOD,ltrim(rtrim(ADMAGRCOD))ADMAGRCOD,ADMAGRSFX,ADMDISAMT,RDCLMPCT,ADMDISAMT*RDCLMPCT AS CEDECLAIMAMT
select ADMPRDCOD Product,ADMACCCOD Account, RDTINSCOD, p.APVALPVAL, pv.APVNUMVAL Term, Count(Distinct ltrim(rtrim(ADMAGRCOD))+ltrim(rtrim(ADMAGRSFX))) Contracts,  SUM(Case When ADMDISAMT>0 Then ADMDISAMT else 0 End) Gross, SUM(ADMDISAMT) Net, SUM(ADMDISAMT*RDCLMPCT) Reserves,
Count(Distinct CASE WHEN (ADMTRNTYP='CAN' OR ADMTRNTYP='can') Then '0'+ltrim(rtrim(ADMAGRCOD))+ltrim(rtrim(ADMAGRSFX)) else '0' End)-1 as Canceled,
Count(Distinct CASE WHEN (ADMTRNTYP='REN' OR ADMTRNTYP='ren' OR 
				ADMTRNTYP='amd' OR ADMTRNTYP='AMD' OR 
				ADMTRNTYP='cur' OR ADMTRNTYP='CUR')
			Then '1'+ltrim(rtrim(ADMAGRCOD))+ltrim(rtrim(ADMAGRSFX)) else '0' End)-1 as CurrentClaims

     

from I400DASQL.EFGAS400.SESCSEFG.SCAGRDM s
inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
on agmclicod = admclicod  and agmacccod = admacccod and agmagrcod = admagrcod and agmagrsfx = admagrsfx --and AGMPRDCOD=ADMPRDCOD
inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
on ratblcod = rdtblcod and raseq  = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat
LEFT JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM PV ON 
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
--AND pv.apvnumval=60.0000000000
Group By ADMPRDCOD,ADMACCCOD, RDTINSCOD, p.APVALPVAL, pv.APVNUMVAL
With Rollup

Select distinct ADMPRDCOD From I400DASQL.EFGAS400.SESCSEFG.SCAGRM where admACCCOD = '0000085401'
------------------------ CLAIMS -------------------------------------------------------------------------------


--select s.PRDCLICOD,PRDACCCOD,ltrim(rtrim(PRDAGRCOD))PRDAGRCOD,PRDAGRSFX,sum(PRDCHKAMT)PRDCHKAMT
--,PRDCLMTID,sum(PRDCHKAMT*RDCLMPCT) AS CEDECLAIMAMT,
--RDTINSCOD,AGMPURDAT,RDEFFDAT,RDEXPDAT
--select s.*
Select  PRDPRDCOD Product,PRDACCCOD Account, RDTINSCOD, pv.APVNUMVAL Term, count(Distinct PRDCLMTID) Claims, sum(PRDCHKAMT*RDCLMPCT) AS CEDECLAIMAMT
from I400DASQL.EFGAS400.SESCSEFG.SCPAYRD05 s
inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
on agmclicod = prdclicod  and agmacccod = prdacccod and agmagrcod = prdagrcod and agmagrsfx = prdagrsfx
inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
on ratblcod = rdtblcod and raseq  = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat
INNER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM PV ON 
			PV.APVCLICOD=PRDCLICOD AND
			PV.APVACCCOD=PRDACCCOD AND
			PV.APVAGRCOD=PRDAGRCOD AND
			PV.APVAGRSFX=PRDAGRSFX AND
			PV.APVPRDCOD=PRDPRDCOD AND PV.APVFLDCOD='~MVTRMTIM'
where 
PRDPAYTYP = 'CL' 
AND PRDPRTDAT <= 20130930 AND PRDPRTDAT>0 
AND PRDACCCOD = '0000025965'
AND PRDPRTDAT > 0 
AND RDTINSCOD='0000000302'
AND s.PRDPRDCOD = 'WRAP'
group by s.PRDCLICOD,PRDACCCOD,PRDPRDCOD,RDTINSCOD,APVNUMVAL

-----------------------------------------------------------            EARNINGS -------------------

SELECT aepclicod,aepacccod, AEPPRDCOD, RDTINSCOD, SUM(aeperncm) EARNINGS --, AGMPURDAT,RDEFFDAT,RDEXPDAT
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRM
on agmclicod = aepclicod  and agmacccod = aepacccod and agmagrcod = aepagrcod and agmagrsfx = aepagrsfx
inner join I400DASQL.EFGAS400.SESCSREIN.SCREINA
on raclicod = agmclicod and raacccod = agmacccod and raprgcod = agmprgcod and agmpurdat between raeffdat and raexpdat
inner join I400DASQL.EFGAS400.SESCSREIN.SCREIND
on ratblcod = rdtblcod and raseq = rdseq and raclicod = rdclicod and agmpurdat between rdeffdat and rdexpdat
INNER JOIN I400DASQL_TEST.EFGAS400.SESCSSIS.SCAGRPVM PV ON 
			PV.APVCLICOD=AEPCLICOD AND
			PV.APVACCCOD=AEPACCCOD AND
			PV.APVAGRCOD=AEPAGRCOD AND
			PV.APVAGRSFX=AEPAGRSFX AND
			PV.APVPRDCOD=AEPPRDCOD AND PV.APVFLDCOD='~MVTRMTIM'
where  
AEPACCCOD= '0000025965'
AND rdtinscod='0000000302'
AND AEPPRDCOD = 'WRAP'
AND AEPYRMON BETWEEN 200202 AND 201309
group by aepclicod,aepacccod,AEPPRDCOD,RDTINSCOD,APVNUMVAL
--group by aepclicod,aepacccod,aepagrcod,aepagrsfx,rdtinscod,agmpurdat,RDTINSCOD,AGMPURDAT,RDEFFDAT,RDEXPDAT
--order by aepclicod,aepacccod,aepagrcod,aepagrsfx,aeperncm
