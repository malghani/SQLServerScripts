
Truncate table MasterProductMatrix
go
INSERT MasterProductMatrix
(Partner,
Category,
Type,
ProductName,
CLICOD,
ClientDesc,
CProg,
ProgramDesc,
CProd,
ProductDesc,
CPlan,
PlanDesc,
Coverage)
Select 
[Partner],
[Category],
[Type],
[Product],
[ClientCode],
[ClentDesc],
[CProg],
[ProgDesc],
[CProd],
[ProdDesc],
[CPlan],
[PlanDesc],
[Coverage]
From efgsales.dbo.PM
go

							UPDATE S Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
							from SAL002_Tier1_Sales_YTD S
go					


							UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
							from SAL002_Tier1_Sales_YTD S
							INNER JOIN MasterProductMatrix M ON ltrim(rtrim(S.ADMCLICOD))=ltrim(rtrim(M.CLICOD)) AND ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD)) AND ltrim(rtrim(S.CPLAN))=ltrim(rtrim(M.CPLAN))
go
							
							UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
							-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales_YTD S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.ADMCLICOD))=ltrim(rtrim(M.CLICOD)) AND ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD)) AND ltrim(rtrim(S.CPLAN))=ltrim(rtrim(M.CPLAN))
							WHERE ProductCategory IS NULL
go


							UPDATE S Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
							from SAL002_Tier1_Sales S
go							


							UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
							from SAL002_Tier1_Sales S
							INNER JOIN MasterProductMatrix M ON ltrim(rtrim(S.ADMCLICOD))=ltrim(rtrim(M.CLICOD)) AND ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD)) AND ltrim(rtrim(S.CPLAN))=ltrim(rtrim(M.CPLAN))
go
							
							UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
							-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.ADMCLICOD))=ltrim(rtrim(M.CLICOD)) AND ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD)) AND ltrim(rtrim(S.CPLAN))=ltrim(rtrim(M.CPLAN))
							WHERE ProductCategory IS NULL
go


--Select PRoductType, Sum(NetAmount) from SAL002_Tier1_Sales group by PRoductType



Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales S
							LEFT JOIN MasterProductMatrix M ON ltrim(rtrim(S.ADMCLICOD))=ltrim(rtrim(M.CLICOD)) AND ltrim(rtrim(S.CPROG))=ltrim(rtrim(M.CPROG)) AND ltrim(rtrim(S.CPROD))=ltrim(rtrim(M.CPROD)) AND ltrim(rtrim(S.CPLAN))=ltrim(rtrim(M.CPLAN))
							WHERE ProductCategory='UNKNOWN'