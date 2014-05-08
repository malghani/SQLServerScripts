------------Program Level and Disbursement Code Level
Select  Dealer_Name As Dealer, admacccod as Account, Program, Disbursement_Code, SalesDataAmount, PremimiumSummaryAmount from (
Select Dealer_Name, admacccod, AGMPRGCOD, Disbursement_Code, Sum(Disbursement_Amount) SalesDataAmount From dbo.SAL002_Tier1_Sales_YTD
WHERE ADMPSTDAT=0 and dealer_name='Auto Assure, LLC.'
Group by Dealer_Name, admacccod, AGMPRGCOD, Disbursement_Code
with rollup
) As A
left join (
Select Account, Program, [Disbursement Type], Sum([Disbursement Amount]) PremimiumSummaryAmount from PS
Group by Account, Program, [Disbursement Type] 
) as b on A.ADMACCCOD=b.Account And A.AGMPRGCOD=B.Program And A.Disbursement_Code=B.[Disbursement Type]
Where b.account is null

select * from SAL002_Tier1_Sales_YTD where admacccod like '%91997'

Select  Dealer_Name Dealer, admacccod Account, Program, ADMTRNTYP, DistinctAgreements SalesDataCount, PSCount PremiumSummaryCount  from (
Select Dealer_Name, admacccod, AGMPRGCOD, ADMTRNTYP,  DistinctAgreements=Count(distinct admclicod + admacccod + admagrcod + admagrsfx)
From dbo.SAL002_Tier1_Sales_YTD
--select * from SAL002_Tier1_Sales_YTD
WHERE ADMPSTDAT=0 --and ADMACCCOD='0000090128' --and AGMPRGCOD='WLK26'
Group by Dealer_Name, admacccod, AGMPRGCOD, ADMTRNTYP

) As A
left join (
Select Account, Program, TRNTYPE, Counttype, min(COUNT) pscount from PSCount 
--where Account='0000090128' --and program='WLK26'
Group by Account, Program, TRNTYPE, Counttype 
) as c on A.ADMACCCOD=c.Account And A.AGMPRGCOD=C.Program AND ADMTRNTYP=TRNTYPE
Where C.Account is null
Order by ADMTRNTYP


Where convert(float, ltrim(rtrim(A.Amount)))<>Convert(float, ltrim(rtrim(B.Amount)))

SELECT ADMPSTDAT,APVPSTDAT,ADMENTDAT, ADMEFFDAT, ADMRECDAT, ADMEFRTYN, ADMACCCOD, ADMAGRCOD,
                                          ADMAGRSFX, ADMCLICOD, AGMPRGCOD, ADMTRNTYP,ADMDISTYP, ADMDISCOD,
                                          ADMDISAMT, APVALPVAL
 SELECT DISTINCT ltrim(rtrim(ADMCLICOD)), ltrim(rtrim(ADMACCCOD)), ltrim(rtrim(ADMAGRCOD)), ltrim(rtrim(ADMAGRSFX))
--Select A.*
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A                                     
                              inner join I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
                                    ON  a.AGMCLICOD = d.ADMCLICOD and
                                          a.AGMACCCOD = d.ADMACCCOD and
                                          a.AGMAGRCOD = d.ADMAGRCOD and
                                          a.AGMAGRSFX = d.ADMAGRSFX
                              INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
                                    ON a.AGMCLICOD = p.APVCLICOD and
                                          a.AGMACCCOD = p.APVACCCOD and
                                          a.AGMAGRCOD = p.APVAGRCOD and
                                          a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS' 
                              
                              WHERE d.ADMEFRTYN = 'Y' AND ADMPSTDAT=20130930 AND D.ADMACCCOD='0000026939' AND AGMPRGCOD='WLK26' AND ADMDISCOD='BASEADMIN'
                               AND ADMTRNTYP='CUR'

select * from SAL002_Tier1_Sales_YTD
WHERE ADMPSTDAT=0 and ADMACCCOD='0000026939' and AGMPRGCOD='WLK26' AND ADMTRNTYP='CUR'
order by admagrcod


----------------------------- Sept. 2012


ALTER TABLE PSCount2
ADD TRNTYPE varchar(50)

Select distinct trntype from PSCount2
update pscOUNT2 sET trntype='CAN' Where CountType='Cancel'
update pscOUNT2 sET trntype='AMD' Where CountType='Amend'
update pscOUNT2 sET trntype='REN' Where CountType='Reinstate'
update pscOUNT2 sET trntype='CUR' Where CountType='Issue'

Select  * from (
Select dealer_name, admacccod, AGMPRGCOD, ADMTRNTYP,  DistinctAgreements=Count(distinct admclicod + admacccod + admagrcod + admagrsfx) From dbo.SAL002_Tier1_Sales_YTD
--select * from SAL002_Tier1_Sales_YTD
WHERE ADMPSTDAT=20120930 --and ADMACCCOD='0000090128' --and AGMPRGCOD='WLK26'
Group by dealer_name, admacccod, AGMPRGCOD, ADMTRNTYP

) As A
LEft join (
Select Account, Program, TRNTYPE, min(COUNT) pscount from PSCount2
--where Account='0000090128' --and program='WLK26'
Group by Account, Program, TRNTYPE
) as c on A.ADMACCCOD=c.Account And A.AGMPRGCOD=C.Program AND ADMTRNTYP=TRNTYPE
--WHERE PSCount<>DistinctAgreements
Where c.Account is null

order by dealer_name, admacccod, AGMPRGCOD, ADMTRNTYP

-----AMOUNT

Select  dealer_name, admacccod, Disbursement_Code, A.Amount [SalesReportingAmount], B.Amount [PremiumSummaryAmount] from (
Select dealer_name, admacccod, AGMPRGCOD, Disbursement_Code, DistinctAgreements=Count(distinct admclicod + admacccod + admagrcod + admagrsfx), Sum(Disbursement_Amount) Amount From dbo.SAL002_Tier1_Sales_YTD
WHERE ADMPSTDAT=20120930 --and ADMACCCOD='0000090128'
Group by dealer_name, admacccod, AGMPRGCOD, Disbursement_Code
) As A
left join (
Select Account, Program, [DisType], Sum([Amount]) Amount from PSAmount
Group by Account, Program, [DisType] 
) as b on A.ADMACCCOD=b.Account And A.AGMPRGCOD=B.Program And A.Disbursement_Code=B.[DisType]
Where b.Account is null
Where convert(float, ltrim(rtrim(A.Amount)))<>Convert(float, ltrim(rtrim(B.Amount)))





select distinct ADMTRNTYP from SAL002_Tier1_Sales_YTD Where ADMTRNTYP='amd' and admacccod='0000026939' and ADMPSTDAT=0

