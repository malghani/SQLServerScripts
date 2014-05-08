
WITH a 
     AS (SELECT Isnull(lob, 'No LOB') AS LOB, 
            efg_rep, 
            Isnull(account_group, 'No Account_Group') AS Account_Group, 
            dealer_name, admtrntyp, 
            CASE  WHEN admpstdat = 0 
				  THEN CONVERT(INT, Datepart(mm, Getdate())) 
				  ELSE Substring(CONVERT(VARCHAR, admpstdat), 5, 2) 
				  END AS MonthDT, 
            CASE  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
				  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5) 
				  END  AS Year, 
            cprod, 
            Count(DISTINCT admclicod + admacccod + 
							admagrcod + admagrsfx) AS Count, 
            Sum(CASE WHEN disbursement_amount >= 0 
					THEN disbursement_amount 
				     ELSE 0 END) AS Amount 
         FROM   sal002_tier1_sales_ytd 
         GROUP  BY lob, 
                   efg_rep, 
                   account_group, 
                   dealer_name, 
                   admtrntyp, 
                   admpstdat, 
                   cprod), 
     b 
     AS (SELECT lob, efg_rep, account_group, dealer_name, 
				cprod, monthdt, Sum(count) AS Count, 
				Sum(amount) AS Amount, year, 
				Isnull(lob, 'No LOB') + Isnull(account_group, 'No Group')
				 + efg_rep + dealer_name + cprod + 
				 Cast(monthdt AS VARCHAR(100)) AS ID 
         FROM   a AS a_1 
         GROUP  BY lob, efg_rep, account_group, dealer_name, 
					cprod, monthdt, year, Isnull(lob, 'No LOB') 
                   + Isnull(account_group, 'No Group') + efg_rep 
                   + dealer_name + cprod, 
                   year) 
SELECT lob, efg_rep, account_group, dealer_name, cprod, monthdt, 
       count, CONVERT(FLOAT, amount) AS Amount, year, id 
FROM   b AS b_1 
WHERE  ( lob = 'EFG' )  

GO

SELECT Isnull(lob, 'No LOB') AS lob, 
		efg_rep, 
		Isnull(account_group, 'No Account_Group') AS account_group, 
		dealer_name, 
		cprod, 
		CASE 
		  WHEN admpstdat = 0 THEN CONVERT(INT, Datepart(mm, Getdate())) 
		  ELSE Substring(CONVERT(varchar, admpstdat), 5, 2) 			  
		END AS monthdt, 							   							   
		Count(DISTINCT admclicod + admacccod + admagrcod + admagrsfx) AS count,
		Sum(CASE WHEN disbursement_amount >= 0 
			THEN disbursement_amount ELSE 0 END) AS Amount,
		CASE 
		  WHEN admpstdat = 0 THEN Datepart(yyyy, Getdate()) 
		  ELSE Substring(CONVERT(VARCHAR, admpstdat), 0, 5)
		END  AS [year],
		Isnull(lob, 'No LOB') + Isnull(account_group, 'No Group')
		+ efg_rep + dealer_name + cprod			
 FROM   sal002_tier1_sales_ytd 
 Where ISNULL(lob,'No LOB')='EFG'
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
							   
							   
         
         
         