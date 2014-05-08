


select 
       d.YYYYMMDD
       ,d.month_name
       , c.*
from [dbo].[FactReinsuranceReserves] frr
join DimDate d
on frr.datekey = d.date_key
join DimContract c
on c.ContractID = frr.ContractID
WHERE CedetoCompanyID = 31
and d.YYYYMM = '201309'
order by 1 desc

Select D.full_date, C.*, DC.*, R.* from DimContract C
JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID
JOIN DimDate D ON D.date_key=R.DateKey --AND D.full_date>'08/01/2013'
JOIN [dbo].DimDisbursementCode DC ON DC.DisbursementCodeID=R.DisbursementCodeID
Where CedeToCompanyID = 31 
Order by d.full_date desc




--Staging
Select * from sys.objects where object_id in (Select object_id from sys.columns where name like '%Reinsurance%')


select * from DimReinsuranceCompanies Where ID_Key in (1, 31,69)

select * from CessionReportProduct Where AccountCode='0000027356' 

Select * 
from EFGDW..Disbursements
where [account code] = '0000027356' AND [Disbursment Code] IN ('AUTO-SURCH','BASERESV')
and ADMPSTDAT = 20130930

select *
from efgdw..ReinsuranceMaster
where RMINSNAM like 'Moritz%'

Select distinct CedeFromCompany, CedeToCompany, CedeFromCompanyID, CedeToCompanyID 
from DimContract C
JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID
JOIN DimDate D ON D.date_key=R.DateKey --AND D.full_date>'09/01/2013'
Where d.YYYYMM=201309
and CedeToCompany='0000000623'


      select *
      from efgdw..vw_Reinsurance
      where AccountCode='0000027356' and CedeToCompany='0000000623'



select c.ID_Key, C.ClientCode, C.ReinsurerCode, c.ReinsurerName,
a.[Account Code], a.AGMENTDAT, a.AGMPSTDAT, a.[Agreement Code], a.[Agreement Suffix], a.[Client Code], a.ContractID
from [FactReinsuranceReserves] r
join EFGCubeFactsDims..DimDate d on r.DateKey=d.date_key
join efgdw..Agreements a on a.ContractID=a.ContractID
join DimReinsuranceCompanies c on c.ID_Key=CedeToCompanyID
where CedeFromCompanyID=69 and d.YYYYMM=201309

select r.CedeFromCompanyID, COUNT(Distinct CedeToCompanyID) from FactReinsuranceReserves r
join EFGCubeFactsDims..DimDate d on r.DateKey=d.date_key
Where r.CedeFromCompanyID=69
group by r.CedeFromCompanyID

select r.CedeToCompanyID, Count(Distinct r.CedeFromCompanyID) from FactReinsuranceReserves r
--Where r.CedeToCompanyID=4
group by r.CedeToCompanyID
having COUNT(Distinct r.CedeFromCompanyID) > 1


select *
from FactReinsuranceReserves r
Where r.CedefromCompanyID=69





select ct.ClientCode,ct.ID_Key, ct.ReinsurerCode, ct.ReinsurerName ToCompanay,cf.ReinsurerName FromCompnay, d.YYYYMM from [FactReinsuranceReserves] r
join DimReinsuranceCompanies CF on r.CedeFromCompanyID=cf.ID_Key
join DimReinsuranceCompanies ct on r.CedeToCompanyID=ct.ID_Key
join EFGCubeFactsDims..DimDate d on r.DateKey=d.date_key And d.YYYYMM>201300
Where r.CedefromCompanyID=69 and r.CedeToCompanyID<>31 And r.accountcode='0000025965' and ct.ReinsurerCode='0000000302'
Group by r.CedefromCompanyID, cf.ReinsurerName, ct.ReinsurerName, d.YYYYMM, ct.ClientCode,ct.ID_Key, ct.ReinsurerCode
Order by d.YYYYMM, r.CedefromCompanyID, cf.ReinsurerName, ct.ReinsurerName, ct.ClientCode,ct.ID_Key, ct.ReinsurerCode


SELECT ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMDISTYP, ADMDISCOD, SCA.ADMPSTDAT,  ADMDISAMT --COUNT(*) Records, Sum(ADMDISAMT) DisbursementAmount
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM SCA (NOLOCK)
JOIN efgdw..Agreements a on SCA.ADMAGRCOD=convert(bigint, a.ContractID)
JOIN EFGDW..Disbursements D on D.[Account Code]=ADMACCCOD AND D.[Agreement Code]=convert(bigint, A.ContractID) AND D.[Disbursment Code] IN ('AUTO-SURCH','BASERESV') AND D.ADMPSTDAT=SCA.ADMPSTDAT
WHERE SCA.ADMPSTDAT > 20130900 AND ADMACCCOD = '0000027356'
AND ADMDISCOD IN ('AUTO-SURCH','BASERESV')
ORDER BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMDISTYP, ADMDISCOD, SCA.ADMPSTDAT

select * from EFGDW..Disbursements 

--------------------------------------

SELECT APVCLICOD, APVACCCOD, APVAGRCOD, APVAGRSFX, APVPRDCOD, APVFLDDSC AS TERMS, APVNUMVAL AS MONTHS
select * from I400DASQL.EFGAS400.SESCSEFG.SCPAYRD


SELECT PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, [Claim Counts]=COUNT(distinct PRDCLMTID), [Claim Payments]=SUM(PRDCHKAMT),YearMonth=LEFT(PRDPRTDAT,6)
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM P (NOLOCK)
INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCPAYRD ON  
APVCLICOD=PRDCLICOD AND
APVACCCOD=PRDACCCOD AND
APVAGRCOD=PRDAGRCOD AND
APVAGRSFX=PRDAGRSFX AND
APVPRDCOD=PRDPRDCOD
WHERE APVFLDCOD='~MVTRMTIM' --AND APVNUMVAL=120 --
AND PRDPRTDAT BETWEEN 20130901 AND 20130930
AND PRDACCCOD IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
GROUP BY PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, LEFT(PRDPRTDAT,6)
--HAVING SUM(PRDCHKAMT)=33.23
ORDER BY LEFT(PRDPRTDAT,6)


--Claims
--Account, Claim Counts, Claim Payments
select PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, [Claim Counts]=COUNT(distinct PRDCLMTID), [Claim Payments]=SUM(PRDCHKAMT), Contracts=count(Distinct PRDAGRCOD)
--INTO #Claims
FROM I400DASQL.EFGAS400.SESCSEFG.SCPAYRD
Where PRDACCCOD IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
AND PRDPRTDAT BETWEEN 20130000 AND 20130131
GROUP BY PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD


--Reserve Amount
SELECT Mapping.RN, Mapping.Dealership, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, Mapping.RN, SUM(ADMDISAMT) AS TotalReserved
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM 
JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM ON 
			APVCLICOD=ADMCLICOD AND
			APVACCCOD=ADMACCCOD AND
			APVAGRCOD=ADMAGRCOD AND
			APVAGRSFX=ADMAGRSFX AND
			APVPRDCOD=ADMPRDCOD

JOIN (
			Select distinct cpt.ReinsurerCode, 
			CRM.BillingAccountName Dealership, C.[Client Code] CC, [Account Code] AC, [Agreement Code] AGC, [Agreement Suffix] SFX, cpt.ReinsurerName RN,  C.cProd
			-- Select distinct cpt.ReinsurerCode, [Account Code], CRM.BillingAccountName Dealership, cprod
			from DimContract C
			JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID			
			join DimReinsuranceCompanies cpt on cpt.ID_Key=CedeToCompanyID
			join DimReinsuranceCompanies cpf on cpf.ID_Key=CedeFromCompanyID
			JOIN efgdw..CRMdata CRM ON  c.[Account Code] = crm.BillingAccountNumber --and Dealership like 'Davis-Moore Mazda%'
			Where [Account Code] IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
			AND cpt.ReinsurerName='Ray Reinsurance, Ltd.'
			--AND cProd='WRAP'

	 ) AS Mapping on Mapping.CC=APVCLICOD AND Mapping.AC=APVACCCOD AND Mapping.AGC=APVAGRCOD AND Mapping.SFX=APVAGRSFX AND APVPRDCOD=Mapping.cProd

Where ADMACCCOD IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
AND ADMPSTDAT BETWEEN 20130000 AND 20131031 AND ADMDISTYP='RESV' AND ADMPRDCOD='WRAP'
GROUP BY Mapping.RN, Mapping.Dealership, ADMPSTDAT , ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
ORDER BY Mapping.RN, Mapping.Dealership, ADMPSTDAT desc, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD

select * from efgdw..CRMdata


APVFLDCOD='~MVTRMTIM' --AND APVNUMVAL=120





SELECT ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMDISCOD, SUM(ADMDISAMT) AS TotalReserved
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM 
JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM ON 
			APVCLICOD=ADMCLICOD AND
			APVACCCOD=ADMACCCOD AND
			APVAGRCOD=ADMAGRCOD AND
			APVAGRSFX=ADMAGRSFX AND
			APVPRDCOD=ADMPRDCOD

--JOIN (
--			Select distinct CRM.BillingAccountName Dealership, C.[Client Code] CC, [Account Code] AC, [Agreement Code] AGC, [Agreement Suffix] SFX, cpt.ReinsurerName RN,  C.cProd
--			Select distinct CRM.*
--			from DimContract C
--			JOIN [dbo].[FactReinsuranceReserves] R (NOLOCK) on C.ContractID=R.ContractID			
--			join DimReinsuranceCompanies cpt on cpt.ID_Key=CedeToCompanyID
--			join DimReinsuranceCompanies cpf on cpf.ID_Key=CedeFromCompanyID
--			JOIN efgdw..CRMdata CRM ON  c.[Account Code] = crm.BillingAccountNumber and Dealership like 'Davis-Moore Mazda%'
--			Where [Account Code] IN ('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
--			--AND cpt.ReinsurerName='Ray Reinsurance, Ltd.'
--			AND cProd='WRAP'

--	 ) AS Mapping on Mapping.CC=APVCLICOD AND Mapping.AC=APVACCCOD AND Mapping.AGC=APVAGRCOD AND Mapping.SFX=APVAGRSFX AND APVPRDCOD=Mapping.cProd

Where ADMACCCOD ='0000025965' --('0000025960', '0000025961', '0000025962', '0000025964', '0000025965', '0000025966', '0000026264', '0000026441',  '0000026499','0000027170', '0000027831', '0000027834', '0000028330','0000090773', '0000092395')
AND ADMPSTDAT BETWEEN 20020200 AND 20131031 AND ADMDISTYP='RESV' AND ADMPRDCOD='WRAP' AND ADMDISCOD='BASERESV'
GROUP BY ADMPSTDAT , ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMDISCOD
ORDER BY ADMPSTDAT desc, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMDISCOD





Select count(*) from 
(Select distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX
from I400DASQL.EFGAS400.SESCSEFG.SCAGRDM
group by ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX ) As tab




