-----MOVE DIMENSIONS
-- use StagingSales
Truncate Table BaseAgreementData
INSERT BaseAgreementData
SELECT * FROM EfgSales.[dbo].[BaseAgreementData]

INSERT Calendar
Select * From EfgSales.[dbo].[Calendar]

SET IDENTITY_INSERT ETL_Log ON;
Select * From EfgSales.[dbo].[ETL_Log]
SET IDENTITY_INSERT ETL_Log OFF;



SET IDENTITY_INSERT DimAccount ON;
INSERT DimAccount (AccountID, AccountName, EFGAccountCode, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimAccount]
SET IDENTITY_INSERT DimAccount OFF;

SET IDENTITY_INSERT [DimAgreement]  ON
INSERT [dbo].[DimAgreement] (AgreementID, CustomerName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, CustomerFirstName, CustomerLastName, SourcePLNCOD, AgreementStatusID)
Select * From EfgSales.[dbo].[DimAgreement] 
SET IDENTITY_INSERT [DimAgreement]  OFF

SET IDENTITY_INSERT [dbo].[DimAgreementStatus] ON
INSERT [dbo].[DimAgreementStatus] (AgreementStatusID, StatusName, StatusCode, dimType, Active, FromDate, ThruDate, UPdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimAgreementStatus]
SET IDENTITY_INSERT [dbo].[DimAgreementStatus] OFF

SET IDENTITY_INSERT [dbo].[DimContractStatus] ON
INSERT [dbo].[DimContractStatus] (ContractStatusID, ContractStatus, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimContractStatus]
SET IDENTITY_INSERT [dbo].[DimContractStatus] OFF

SET IDENTITY_INSERT [dbo].[DimCoverage] ON
INSERT [dbo].[DimCoverage] (CoverageID, CoverageName, dimType, Active, FromDate, ThruDate, UPdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimCoverage]
SET IDENTITY_INSERT [dbo].[DimCoverage] OFF

SET IDENTITY_INSERT [dbo].[DimFourPartProductKey] ON
INSERT [dbo].[DimFourPartProductKey] ( KeyID, Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, ThruDate, UPdateDate, SourceKey, ProductNameID)
Select * From EfgSales.[dbo].[DimFourPartProductKey]
SET IDENTITY_INSERT [dbo].[DimFourPartProductKey] OFF

SET IDENTITY_INSERT [dbo].[DimNationalAccount] ON
INSERT  [dbo].[DimNationalAccount](NationalAccountID, PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimNationalAccount]
SET IDENTITY_INSERT [dbo].[DimNationalAccount] OFF


SET IDENTITY_INSERT [dbo].[DimPartner] ON
INSERT [dbo].[DimPartner] (PartnerID, PartnerName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimPartner]
SET IDENTITY_INSERT [dbo].[DimPartner] OFF

SET IDENTITY_INSERT [dbo].[DimPlan] ON
INSERT  [dbo].[DimPlan]( PlanID, PlanName, PlanDesc, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimPlan]
SET IDENTITY_INSERT [dbo].[DimPlan] OFF

SET IDENTITY_INSERT [dbo].[DimProductCategory] ON
INSERT [dbo].[DimProductCategory](ProductCategoryID, ProductCategoryName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimProductCategory]
SET IDENTITY_INSERT [dbo].[DimProductCategory] OFF

SET IDENTITY_INSERT [dbo].[DimProductName] ON
INSERT [dbo].[DimProductName] ( ProductNameID, ProductTypeID, ProductName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimProductName]
SET IDENTITY_INSERT [dbo].[DimProductName] OFF

SET IDENTITY_INSERT [dbo].[DimProductStatus] ON
INSERT  [dbo].[DimProductStatus]( ProductStatusID, ProductStatusName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimProductStatus]
SET IDENTITY_INSERT [dbo].[DimProductStatus] OFF

SET IDENTITY_INSERT [dbo].[DimProductType] ON
INSERT [dbo].[DimProductType] (ProductTypeID, ProductCategoryID, ProductTypeName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimProductType]
SET IDENTITY_INSERT [dbo].[DimProductType]  OFF

SET IDENTITY_INSERT [dbo].[DimSalesManager] ON
INSERT  [dbo].[DimSalesManager](SalesManagerID, SalesManagerName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey, NationalAccountID )
Select * From EfgSales.[dbo].[DimSalesManager]
SET IDENTITY_INSERT [dbo].[DimSalesManager] OFF

SET IDENTITY_INSERT [dbo].[DimState] ON
INSERT  [dbo].[DimState](StateID, StateCode, StateName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey )
Select * From EfgSales.[dbo].[DimState]
SET IDENTITY_INSERT [dbo].[DimState] OFF

SET IDENTITY_INSERT [dbo].[DimTerms] ON
INSERT [dbo].[DimTerms] ( TermID, TermName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimTerms]
SET IDENTITY_INSERT [dbo].[DimTerms] OFF

SET IDENTITY_INSERT [dbo].[DimVehicleState] ON
INSERT [dbo].[DimVehicleState] ( VehicleStateID, VehicleStateName, dimType, Active, FromDate, ThruDate, UpdateDate, SourceKey)
Select * From EfgSales.[dbo].[DimVehicleState]
SET IDENTITY_INSERT [dbo].[DimVehicleState] OFF