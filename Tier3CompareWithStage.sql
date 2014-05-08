

Select  
CancelCount=Sum(CancelCount), 
ClaimsCount=Sum(ClaimsCount), 
ClaimsPaidCount=Sum(ClaimsPaidCount), 
NetContractCount=Sum(NetContractCount), 
GrossContractCount=Sum(GrossContractCount), 
CURCount=Sum(CURCount), 
AMDCount=Sum(AMDCount), 
CANCount=Sum(CANCount), 
RENCount=Sum(RENCount), 
CURAmt=Sum(CURAmt), 
CANAmt=Sum(CANAmt), 
AMDAmt=Sum(AMDAmt), 
RENAmt=Sum(RENAmt), 
ClaimsPaid=Sum(ClaimsPaid), 
ClaimsPaidITD=Sum(ClaimsPaidITD), 
EarnedReserves=Sum(EarnedReserves), 
EarnedReservesITD=Sum(EarnedReservesITD), 
NetReserves=Sum(NetReserves), 
GrossReserves=Sum(GrossReserves), 
UnearnedReserves=Sum(UnearnedReserves), 
GrossUnearnedReserves=Sum(GrossReserves)-Sum(EarnedReserves),
NetUnearnedReserves=Sum(NetReserves)-Sum(EarnedReserves),
NetWrittenReserves=Sum(NetWrittenReserves), 
GrossWrittenReserves=Sum(GrossWrittenReserves), 
PremiumReserves=Sum(PremiumReserves), 
AmendedReserves=Sum(AmendedReserves)
 From FactSales2006(nolock)

Select 
CancelCount=Sum(CancelCount), 
ClaimsCount=Sum(ClaimsCount), 
ClaimsPaidCount=Sum(ClaimsPaidCount), 
NetContractCount=Sum(NetContractCount), 
GrossContractCount=Sum(GrossContractCount), 
CURCount=Sum(CURCount), 
AMDCount=Sum(AMDCount), 
CANCount=Sum(CANCount), 
RENCount=Sum(RENCount), 
CURAmt=Sum(CURAmt), 
CANAmt=Sum(CANAmt), 
AMDAmt=Sum(AMDAmt), 
RENAmt=Sum(RENAmt), 
ClaimsPaid=Sum(ClaimsPaid), 
ClaimsPaidITD=Sum(ClaimsPaidITD), 
EarnedReserves=Sum(EarnedReserves), 
EarnedReservesITD=Sum(EarnedReservesITD), 
NetReserves=Sum(NetReserves), 
GrossReserves=Sum(GrossReserves), 
UnearnedReserves=Sum(UnearnedReserves), 
GrossUnearnedReserves=Sum(GrossReserves)-Sum(EarnedReserves),
NetUnearnedReserves=Sum(NetReserves)-Sum(EarnedReserves),
NetWrittenReserves=Sum(NetWrittenReserves), 
GrossWrittenReserves=Sum(GrossWrittenReserves), 
PremiumReserves=Sum(PremiumReserves), 
AmendedReserves=Sum(AmendedReserves)
 From efgsales.dbo.FactSales(nolock) Where AccountID=35


--Select * FROM (Select * FRom efgsales.dbo.ClaimsHist Where PRDACCCOD='0000026514' AND PRDPRTDAT=201401) AS pre
--LEFT JOIN (Select * FRom ClaimsHist2006 WHERE PRDPRTDAT=201401) AS SP on 
--sp.PRDCLICOD=pre.PRDCLICOD AND sp.PRDACCCOD=pre.PRDACCCOD AND
--sp.prdagrcod=pre.prdagrcod AND sp.PRDAGRSFX=pre.PRDAGRSFX
--AND sp.prdprdcod=pre.prdprdcod

--Select * FRom ClaimsHist2006 WHERE --PRDPRTDAT=201401 And 
--PRDAGRCOD IN ('26514000738','9766399','9781165')
--Order by PRDCLMTID

--Select * FRom efgsales.dbo.ClaimsHist WHERE --PRDPRTDAT=201401 And 
--PRDAGRCOD IN ('26514000738','9766399','9781165')
--Order by PRDCLMTID

--SELECT  PRDCLICOD,
--		PRDACCCOD,
--		PRDAGRCOD,
--		PRDAGRSFX,
--		PRDPRDCOD,
--		PRDCLMTID,
--		PRDPAYSTS,		
--		PRDPRTDAT=MIN(PRDPRTDAT)
--FROM I400DASQL.EFGAS400.SESCSEFG.SCPAYRD 
--WHERE --PRDPRTDAT BETWEEN 20140101 AND 20140131 
--PRDACCCOD='0000026514'
--AND PRDAGRCOD IN ('         26514000738', '             9766399','             9781165')
----AND PRDAGRCOD LIKE '%9766399'
--GROUP BY 
--PRDCLICOD,
--PRDACCCOD,
--PRDAGRCOD,
--PRDAGRSFX,
--PRDPRDCOD,
--PRDCLMTID,
--PRDPAYSTS
--Order by PRDCLMTID



