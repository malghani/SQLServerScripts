Select  admagrcod, cprod, admpstdat, disbursement_code, count(*) 
from (
Select admagrcod, cprod, admpstdat,disbursement_code, admtrntyp from
	(
	Select lob, efg_rep, account_group, dealer_name, admacccod,admagrcod, cprod, admpstdat,admtrntyp,disbursement_code
	from [sal002_tier1_sales_ytd] y
	inner join (
			Select admacccod acct, cprod prod, admpstdat dt, admagrcod agr
			from [sal002_tier1_sales_ytd] 
			WHERE Disbursement_Code='CANCELFEE' AND ADMTRNTYP='CAN'
			Group by admacccod, admagrcod, cprod, admpstdat
	) as acctcan on acctcan.acct=y.ADMACCCOD and acctcan.dt=y.ADMPSTDAT and acctcan.prod=y.cprod and acctcan.agr=y.ADMAGRCOD
	Group by lob, efg_rep, account_group, dealer_name, admacccod, cprod, admagrcod, admpstdat,admtrntyp,disbursement_code
	--Order by admacccod, admagrcod, admpstdat, disbursement_code, cprod, admtrntyp
	) as sing
group by admagrcod, cprod, admpstdat,disbursement_code,admtrntyp  having COUNT(*) = 1
) as final 
Where ADMTRNTYP<>'REN'
group by admagrcod, cprod, admpstdat,disbursement_code having COUNT(*) = 1


