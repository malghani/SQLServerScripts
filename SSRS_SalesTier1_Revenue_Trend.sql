ALTER PROC [dbo].[SSRS_SalesTier1_Revenue_Trend]
@LOB varchar(255)=NULL,
@EFGRep varchar(255)=NULL,
@AccountGroup varchar(255)=NULL,
@Account varchar(255)=NULL,
@Product varchar(255)=NULL
/*
SSRS_SalesTier1_Revenue_Trend 'Dealer Services', 'Bryan Durant', 'Davis-Moore Group', 'Davis-Moore Chevrolet', 'CHOICE'
SSRS_SalesTier1_Revenue_Trend 'No LOB'
SSRS_SalesTier1_Revenue_Trend @EFGRep='No Rep'
SSRS_SalesTier1_Revenue_Trend @AccountGroup='No Account_Group'
SSRS_SalesTier1_Revenue_Trend @Account='No Account'
SSRS_SalesTier1_Revenue_Trend @Product = 'No Product'

*/
AS

Declare @Month int
Declare @Year int

Select @Year=CAST(LEFT(ClosedPeriod,4) as int), @Month=CAST(SUBSTRING(closedPeriod,5,2) as int)+1
From (SELECT ClosedPeriod=Convert(Varchar, MAX(ADMPSTDAT)) FROM dbo.SAL002_Tier1_Sales_YTD) AS ClosedMonth


 SELECT Isnull(lob, 'No LOB') AS lob, isnull(efg_rep, 'No Rep') as efg_rep, Isnull(account_group, 'No Account_Group') AS  account_group, 
            ISNULL(Dealer_Name, 'No Account') as dealer_name, 
            ISNULL(cprod, 'No Product') as Product,
            CASE admtrntyp 
				 WHEN 'CAN' THEN 
				 CASE WHEN Disbursement_Code='CANCELFEE' THEN 
					Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) 
					ELSE
					Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) * -1
				 WHEN 'AMD' THEN 0
				 ELSE 
				    Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) 
				 END AS Count,
            Sum(Convert(float, ISNULL(disbursement_amount,0))) AS Amount,             
            MONTHDT=CASE 
                      WHEN admpstdat = 0 THEN @Month
                      ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
                    END,             
            CASE admtrntyp 
				 WHEN 'CAN' THEN CASE WHEN Disbursement_Code='CANCELFEE' THEN 'Cancel fee' Else 'Cancellations' END
				 WHEN 'CUR' THEN 'Current' 
				 WHEN 'REN' THEN 'Reinstatements' 
				 WHEN 'AMD' THEN 'Amendments' 
	       END AS ADMTRNTYP
	       
     FROM   [sal002_tier1_sales_ytd] D
		LEFT JOIN (SELECT y.admclicod, y.admacccod, y.admagrcod, y.admagrsfx 
					from [sal002_tier1_sales_ytd] Y
					INNER JOIN (
								select admclicod, admacccod, admagrcod, admagrsfx, ADMTRNTYP, COUNT(*) ct from [sal002_tier1_sales_ytd] 
								Where ADMTRNTYP='CAN' And (non_cancelfee_Status=0 OR Disbursement_Code='CANCELFEE')
								Group By admclicod, admacccod, admagrcod, admagrsfx, ADMTRNTYP
								Having COUNT(*) > 1
							  ) AS M on M.admclicod=Y.admclicod and M.admacccod=Y.admacccod and M.admagrcod=Y.admagrcod and  M.admagrsfx=Y.admagrsfx and M.ADMTRNTYP=Y.ADMTRNTYP
					Where y.Disbursement_Code<>'CANCELFEE' 
					Group by y.admclicod, y.admacccod, y.admagrcod, y.admagrsfx
				) AS CancelFeeWithOther ON CancelFeeWithOther.admclicod=D.admclicod 
									   AND CancelFeeWithOther.admacccod=D.admacccod 
									   AND CancelFeeWithOther.admagrcod=D.admagrcod 
									   AND CancelFeeWithOther.admagrsfx=D.admagrsfx
     WHERE  (Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = @Year 
			OR Substring(CONVERT(VARCHAR, admpstdat), 0, 5) = 0 )
		AND isnull(lob, 'No LOB') = ISNULL(@LOB, isnull(lob, 'No LOB'))				
		AND Isnull(EFG_Rep, 'No Rep') = ISNULL(@EFGRep, isnull(EFG_Rep, 'No Rep'))
		AND Isnull(Account_Group, 'No Account_Group') = ISNULL(@AccountGroup, isnull(Account_Group, 'No Account_Group'))
		AND Isnull(Dealer_Name, 'No Account') = ISNULL(@Account, isnull(Dealer_Name, 'No Account'))
		AND Isnull(cprod, 'No Product') = ISNULL(@Product, isnull(cprod, 'No Product'))						
     GROUP  BY lob, efg_rep, account_group, dealer_name, cprod, admpstdat,admtrntyp
     ORDER BY lob, efg_rep, account_group, dealer_name, cprod, admtrntyp,monthdt
     


		  
Select non_cancelfee_Status, admclicod, admacccod, admagrcod, admagrsfx, ADMTRNTYP
from sal002_tier1_sales_ytd 
group by non_cancelfee_Status, admclicod, admacccod, admagrcod, admagrsfx, ADMTRNTYP
having COUNT(*) > 1
		  
		  1	MEP	0000031013	         31013007941		CAN	3

