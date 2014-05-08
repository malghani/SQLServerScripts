ALTER PROCEDURE SSRS_SalesTier1_Gross_Monthly_Account_Performance
@LOB nvarchar(320),
@EFG_Rep nvarchar(320)=NULL,
@AccountGroup nvarchar(320)=NULL,
@Account nvarchar(320)=NULL
/*
        Reports Consuming  :  
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services' -- NO CASE OF RUNNING THIS 
				
				Gross Monthly Account Performance by Rep
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts'
				
				Gross Monthly Account Performance by AccountGroup
				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='Billion Auto Group'				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group'														Gross Monthly Account Performance by Account				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group', @Account='Aristocrat Motors' 								Gross Monthly Account Performance by Product				exec SSRS_SalesTier1_Gross_Monthly_Account_Performance @LOB='Agency Services', @EFG_Rep='Paul Roberts', @AccountGroup='No Account_Group', @Account='Aristocrat Motors' 								
*/

AS 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

SELECT	lob=ISNULL(lob, 'No LOB'),
		efg_rep=ISNULL(efg_rep, 'NO Rep'), 
		account_group=ISNULL(Account_Group, 'No Account_Group'), 
		dealer_name=ISNULL(dealer_name, 'No Account'), 
		cprod=ISNULL(cprod, 'No Product'), 
		monthdt= CASE 
				WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
				ELSE Substring(CONVERT(varchar, admpstdat), 5, 2)
				END,								   
		[count]=Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx),
		Amount=Sum(CASE WHEN disbursement_amount >= 0 
					THEN disbursement_amount ELSE 0 END),
		[year]=CASE 
			  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
				ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
				END
				,
		id=Isnull(lob, 'No LOB') + '-' + Isnull(account_group, 'No Account Group')
		+ '-' + Isnull(efg_rep,'No Rep') +  '-' + Isnull(dealer_name, 'No Account') + '-' + Isnull(cprod, 'No Product')
 FROM   sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')=ISNULL(@LOB, ISNULL(lob, 'No LOB'))
 AND ISNULL(efg_rep, 'No Rep')= ISNULL(@EFG_Rep, ISNULL(efg_rep, 'No Rep')) 
 AND ISNULL(account_group, 'No Account_Group') = ISNULL(@AccountGroup, ISNULL(account_group, 'No Account_Group'))
 AND ISNULL(Dealer_Name, 'No Account') = ISNULL(@Account, ISNULL(Dealer_Name, 'No Account'))
 GROUP  BY lob, 
		   efg_rep, 
		   account_group, 
		   dealer_name, 
		   cprod,
		   CASE 
			WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
			ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
			END,
			CASE 
		  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
		END  ,
		admpstdat
