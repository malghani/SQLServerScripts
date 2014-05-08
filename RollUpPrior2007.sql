Select ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, 
NationalAccountID, TermID, AgreementID,PlanID, FourPartKeyID,
Period=MAX(Period),AgreementPostedPeriod=MAX(AgreementPostedPeriod),CancelCount=Sum(CancelCount), ClaimsCount=Sum(ClaimsCount), 
ClaimsPaidCount=Sum(ClaimsPaidCount), NetContractCount=Sum(NetContractCount),GrossContractCount=Sum(GrossContractCount), CURCount=Sum(CURCount), 
AMDCount=Sum(AMDCount), CANCount=Sum(CANCount), RENCount=Sum(RENCount), CURAmt=Sum(CURAmt), CANAmt=Sum(CANAmt), AMDAmt=Sum(AMDAmt), RENAmt=Sum(RENAmt), 
ClaimsPaid=Sum(ClaimsPaid), EarnedReserves=Sum(EarnedReserves), NetReserves=Sum(NetReserves), GrossReserves=Sum(GrossReserves), 
UnearnedReserves=Sum(UnearnedReserves), NetWrittenReserves=Sum(NetWrittenReserves), GrossWrittenReserves=Sum(GrossWrittenReserves), 
PremiumReserves=Sum(PremiumReserves), AmendedReserves=Sum(AmendedReserves), ClaimsPaidITD=99999999, EarnedReservesITD=99999999, LastPostedPeriod=MAX(Period), ETLExtractDateTime=MAX(ETLExtractDateTime), ETLUpdateDateTime=MAX(ETLUpdateDateTime)
Into #tmp From FactSales2006 
Group by  ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, 
TermID, AgreementID,PlanID, FourPartKeyID

--Select * From FactSales2006(nolock) WHERE Period <= 20061231  782434--59081
UPDATE t Set ClaimsPaidITD=FS.ClaimsPaidITD, EarnedReservesITD=FS.EarnedReservesITD, LastPostedPeriod=t.Period
From #tmp t
INNER JOIN FactSales2006 FS ON FS.Period=t.Period AND FS.AgreementID=t.AgreementID

Select * INTO PRIOR2007 FROM FactSales2006

--Select count(*) From PRIOR2007 

INSERT FactSales2006 (
Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, 
TermID, AgreementID,PlanID, FourPartKeyID,AgreementPostedPeriod,CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount,
GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, EarnedReserves, NetReserves, 
GrossReserves, UnearnedReserves, NetWrittenReserves,GrossWrittenReserves, PremiumReserves, AmendedReserves,FS.ClaimsPaidITD,FS.EarnedReservesITD, LastPostedPeriod, ETLExtractDateTime, ETLUpdateDateTime
  )
Select 
20061231, t.ProductNameID, t.ProductTypeID, t.ProductCategoryID, t.CoverageID, t.PartnerID, t.AccountID, t.SalesManagerID, t.StateID, t.VehicleStateID, t.NationalAccountID, 
t.TermID, t.AgreementID,t.PlanID, t.FourPartKeyID,t.AgreementPostedPeriod,t.CancelCount, t.ClaimsCount, t.ClaimsPaidCount, t.NetContractCount,
t.GrossContractCount, t.CURCount, t.AMDCount, t.CANCount, t.RENCount, t.CURAmt, t.CANAmt, t.AMDAmt, t.RENAmt, t.ClaimsPaid, t.EarnedReserves, t.NetReserves, 
t.GrossReserves, t.UnearnedReserves, t.NetWrittenReserves,t.GrossWrittenReserves, t.PremiumReserves, t.AmendedReserves,t.ClaimsPaidITD,t.EarnedReservesITD, LastPostedPeriod, ETLExtractDateTime, ETLUpdateDateTime
From #tmp t





