

Select U.UserID, FirstName, LastName, GroupName from ADUserGroup UG 
INNER JOIN ADGroup AG ON AG.GroupID=UG.GroupID
INNER JOIN ADUser U ON U.UserID=UG.UserID


GO
ALTER PROC SyncAD
AS
declare @sql varchar(max)
DECLARE @CN VARCHAR(128)
DECLARE @DN VARCHAR(1024)

SET NOCOUNT ON 
DECLARE @ReportGroups AS TABLE (GroupName varchar(100))
INSERT @ReportGroups
SELECT 'SalesRptExec' UNION
SELECT 'SalesRptMgr' UNION
SELECT 'SalesRptRep' UNION
SELECT 'SalesRptIT' UNION
SELECT 'SalesRptAdmin' UNION
SELECT 'SalesRptTier2' UNION
SELECT 'SalesRptTier3' UNION
SELECT 'SalesRptOther' 

SELECT TOP 1 @CN = CN, @DN = DN 
FROM EFGDW.dbo.AD_Groups 
Where CN IN (SELECT GroupName From @ReportGroups)
Order by DN


CREATE TABLE #ADUsers ( WhenCreated datetime, WhenChanged datetime, CommonName VARCHAR (max), UserAccountControl int,sAMAccountName varchar(max), objectCategory VARCHAR (max), DistributionGroup VARCHAR(128), FirstName VARCHAR(50), LastName VARCHAR(50), EmailAddress VARCHAR(128) );
WHILE EXISTS(SELECT TOP 1 DN
				FROM EFGDW.dbo.AD_Groups 
				Where CN IN (SELECT GroupName From @ReportGroups)
				AND DN > @DN Order by DN)
BEGIN
   SET @sql = ' 
SELECT '''+@CN+'''[Distribution Group],  Whencreated, whenchanged, userAccountControl, sAMAccountName, ISNULL(givenName, '''') FirstName, ISNULL(sn, '''') LastName, mail EmailAddress,objectCategory, cn CommonName FROM OpenQuery
(ADSI, ''<LDAP://sv-efgdc01>;(&(objectClass=*)(memberOf='+@DN+')); Whencreated, whenchanged, userAccountControl, sAMAccountName, givenName, sn, mail, objectCategory, cn;subtree'')'; 

IF EXISTS( SELECT * FROM @ReportGroups Where GroupName = @CN)
	INSERT #ADUsers (DistributionGroup, whencreated, whenchanged, UserAccountControl, sAMAccountName, Firstname, LastName, EmailAddress, objectCategory, CommonName)
	EXEC(@sql)
SELECT TOP 1 @CN = CN, @DN = DN 
FROM EFGDW.dbo.AD_Groups 
Where DN>@DN AND CN IN (SELECT GroupName From @ReportGroups)
Order by DN   
Domain SQL Developers
END

Select * from adgroup

INSERT ADUser(UserID, Domain, FirstName, LastName, Email, AccessControl, ImportedDate, ADWhenChanged, ADWhenCreated)
Select Distinct sAMAccountName, 'EFG-DOMAIN', T.FirstName, T.LastName, EmailAddress, UserAccountControl, GETDATE(), WhenChanged, WhenCreated from #ADUsers T
LEFT JOIN ADUser A on A.UserID=T.sAMAccountName
WHERE A.UserID IS NULL

/*
INSERT ADGroup (GroupName, DateCreated)
SELECT Groups.* FROM (Select Distinct DistributionGroup, Date=GETDATE() from #ADUsers T
  UNION
SELECT 'SalesRptExec' DistributionGroup, Date=GetDate() UNION
SELECT 'SalesRptMgr' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptRep' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptIT' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptAdmin' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptTier2' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptTier3' DistributionGroup, Date=GetDate()  UNION
SELECT 'SalesRptOther' DistributionGroup, Date=GetDate() ) AS Groups
LEFT JOIN ADGroup on ADGroup.GroupName=Groups.DistributionGroup
WHERE ADGroup.GroupName IS NULL
*/

INSERT ADUserGroup (GroupID, UserID)
Select G.GroupID, U.UserID from #ADUsers T
INNER JOIN ADUser U ON U.UserID=T.sAMAccountName 
INNER JOIN ADGroup G ON G.GroupName=T.DistributionGroup
LEFT JOIN ADUserGroup AG ON AG.UserID=U.UserID AND AG.GroupID=G.GroupID
WHERE AG.GroupID IS NULL

Drop Table #ADUsers

GO



INSERT SecSalesUser (SalesUserID, Email, isActive, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
Select UserID, Email, 1, 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE()  from ADUser



INSERT SecSalesRole (RoleName, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
SELECT 'Executive', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() UNION
SELECT 'Manager', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() UNION
SELECT 'Rep', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() UNION
SELECT 'Other', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() UNION
SELECT 'IT Personnel', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() UNION
SELECT 'Data Control Admin', 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE() 


UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptExec') WHERE RoleName='Executive'
UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptMgr') WHERE RoleName='Manager'
UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptRep') WHERE RoleName='Rep'
UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptIT') WHERE RoleName='IT Personnel'
UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptOther') WHERE RoleName='Other'
UPDATE SecSalesRole Set GroupID=(Select GroupID From ADGroup Where GroupName='SalesRptAdmin') WHERE RoleName='Data Control Admin'\\\\\


INSERT SecSalesUserRole (RoleID, SalesUserID, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
SELECT SR.RoleID, U.SalesUserID, 'amaqsood', 'amaqsood', 0, GETDATE(), GETDATE()  FROM SecSalesUser U
INNER JOIN ADUserGroup AG ON AG.UserID=U.SalesUserID
INNER JOIN SecSalesRole SR ON SR.GroupID=AG.GroupID AND SR.RoleName IN ('Executive', 'IT Personnel')


--drop table #rpt
CREATE TABLE #Rpt (ReportName varchar(255), SecurityRole varchar(255), ReportGroup varchar(255))
INSERT #Rpt
SELECT 'Channel Revenue by product','Post','Channel Revenue by Product Category' UNION 
SELECT 'Channel Revenue by Product Category','Rep','Channel Revenue by Product Category' UNION 
SELECT 'Gross Monthly Account Performance by Account','Rep','Gross Monthly Account Performance by Rep  ' UNION 
SELECT 'Gross Monthly Account Performance by Account Group  ','Post','Gross Monthly Account Performance by Rep  ' UNION 
SELECT 'Gross Monthly Account Performance by Product  ','Mgr','Gross Monthly Account Performance by Rep  ' UNION 
SELECT 'Gross Monthly Account Performance by Rep  ','Mgr','Gross Monthly Account Performance by Rep  ' UNION 
SELECT 'LOB Production Report by Product  ','Mgr','LOB Production Report by Product  ' UNION 
SELECT 'LOB Production Variance by Counts  ','Exec','LOB Production Variance by Counts  ' UNION 
SELECT 'LOB Production Variance by Revenue  ','Post','LOB Production Variance by Revenue  ' UNION 
SELECT 'LOB Revenue by Category  ','Post','LOB Revenue by Category  ' UNION 
SELECT 'LOB Revenue Pacing  ','Post','LOB Revenue Pacing  ' UNION 
SELECT 'LOB Revenue Trend  ','Post','LOB Revenue Trend  ' UNION 
SELECT 'LOB Revenue Trend By Account  ','Post','LOB Revenue Trend  ' UNION 
SELECT 'LOB Revenue Trend By Account Group  ','Post','LOB Revenue Trend  ' UNION 
SELECT 'Month Account Performance to Plan by Account  ','Post','Month Account Performance to Plan by Rep  ' UNION 
SELECT 'Month Account Performance to Plan by Account Group  ','Post','Month Account Performance to Plan by Rep  ' UNION 
SELECT 'Month Account Performance to Plan by Product  ','Post','Month Account Performance to Plan by Rep  ' UNION 
SELECT 'Month Account Performance to Plan by Rep  ','Exec','Month Account Performance to Plan by Rep  ' UNION 
SELECT 'Net Monthly Account Performance by Account  ','Rep','Net Monthly Account Performance by Rep  ' UNION 
SELECT 'Net Monthly Account Performance by Account Group  ','Mgr','Net Monthly Account Performance by Rep  ' UNION 
SELECT 'Net Monthly Account Performance by Product  ','Rep','Net Monthly Account Performance by Rep  ' UNION 
SELECT 'Net Monthly Account Performance by Rep  ','Rep','Net Monthly Account Performance by Rep  ' UNION 
SELECT 'Product Contract Counts  ','Mgr','Product Contract Counts  ' UNION 
SELECT 'Production Report by Account  ','Rep','LOB Production Report by Product  ' UNION 
SELECT 'Production Report by Account Group  ','Rep','LOB Production Report by Product  ' UNION 
SELECT 'Production Variance by Counts by Account  ','Mgr','LOB Production Variance by Counts  ' UNION 
SELECT 'Production Variance by Counts by Account Group  ','Rep','LOB Production Variance by Counts  ' UNION 
SELECT 'Production Variance by Revenue by Account  ','Rep','LOB Production Variance by Revenue  ' UNION 
SELECT 'Production Variance by Revenue by Account Group  ','Post','LOB Production Variance by Revenue  ' UNION 
SELECT 'Revenue by Channel  ','Mgr','Revenue by Channel  ' UNION 
SELECT 'Revenue by product  ','Post','LOB Revenue by Category  ' UNION 
SELECT 'Revenue Disbursements By LOB  ','Post','Revenue Disbursements By LOB  ' UNION 
SELECT 'Revenue Trend by Account  ','Post','Revenue Trend by Representative  ' UNION 
SELECT 'Revenue Trend by Account Group  ','Exec','Revenue Trend by Representative  ' UNION 
SELECT 'Revenue Trend by Product  ','Post','Revenue Trend by Representative  ' UNION 
SELECT 'Revenue Trend by Representative  ','Post','Revenue Trend by Representative  ' UNION 
SELECT 'Revenue Trend by TransactionType  ','Post','Revenue Trend by Representative  ' 

Update #Rpt Set ReportName=LTRIM(rtrim(ReportName)), SecurityRole=LTRIM(rtrim(SecurityRole)), ReportGroup=LTRIM(rtrim(ReportGroup))

-- delete secsalesreport
-- DBCC CHECKIDENT(secsalesreport, RESEED, 0)

INSERT SecSalesReport(ReportName, ReportGroup, Tier, TopLevel, Emailed, Posted, PostedRootFolder, PostingInterval, PostingStartDate, PostingEndDate, IsPostedExecutiveRepository, IsPostedLOBRepository, IsPostedRepRepository, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
SELECT ReportName, ReportGroup, 1, 1, 1, 1, '\\server\folder\', 'DAILY', Convert(Varchar, GetDate(), 101),NULL,1,1,1,'amaqsood',0,GETDATE(), GETDATE()  From #Rpt 

UPDATE SecSalesReport Set TopLevel=1 Where ReportName=ReportGroup

INSERT dbo.SecSalesRoleReport (ReportID, RoleID)
SELECT ReportID, RoleID  FROM SecSalesReport,SecSalesRole 
WHERE TopLevel=1 AND RoleName IN ('Executive', 'IT Personnel')

INSERT dbo.SecSalesRoleReport (ReportID, RoleID)
SELECT ReportID, RoleID  FROM SecSalesReport,SecSalesRole 
WHERE TopLevel=1 AND RoleName IN ('Manager')
AND ReportName IN 
('Gross Monthly Account Performance by Rep'  ,
'LOB Production Report by Product',
'LOB Revenue Trend',
'Month Account Performance to Plan by Rep',
'Net Monthly Account Performance by Rep'  ,
'Revenue Trend by Representative')


INSERT dbo.SecSalesRoleReport (ReportID, RoleID)
SELECT ReportID, RoleID  FROM SecSalesReport,SecSalesRole 
WHERE TopLevel=1 AND RoleName IN ('Manager')
AND ReportName IN 
('Gross Monthly Account Performance by Rep'  ,
'LOB Production Report by Product',
'LOB Revenue Trend',
'Month Account Performance to Plan by Rep',
'Net Monthly Account Performance by Rep'  ,
'Revenue Trend by Representative')


INSERT dbo.SecSalesRoleReport (ReportID, RoleID)
SELECT ReportID, RoleID  FROM SecSalesReport,SecSalesRole 
WHERE TopLevel=1 AND RoleName IN ('Rep')
AND ReportName IN 
('Gross Monthly Account Performance by Rep'  ,
'LOB Production Report by Product',
'LOB Revenue Trend',
'Month Account Performance to Plan by Rep',
'Net Monthly Account Performance by Rep')



 ---------------------   PROVISION A USER 
 
-- select * from SecSalesRole
-- select * from SalesLOBRep Where LOBID=2
--  Provision_User @UserID='spk', @RoleID=4, @Caller='admin', @LOBID=2, @FullAccessLOB=0, @RepIDList='1,8'
 
 
 ALTER PROC Provision_User 
 
 @UserID Varchar(255),
 @RoleID int,
 @Caller varchar(255),
 @LOBID  int=0,
 @FullAccessLOB bit=0,
 @RepIDList Varchar(500)=NULL
 AS
 
 SET XACT_ABORT ON
 SET NOCOUNT ON
 SET IMPLICIT_TRANSACTIONS ON
 
 
 DECLARE @Now DateTime=GetDate()
 
 BEGIN TRY
 EXEC SyncAD

 
 BEGIN TRANSACTION 
	 IF EXISTS(SELECT * FROM SecSalesUser(NOLOCK) Where SalesUserID=@UserID)
	 Begin
	 --SELECT 'Exists' as block, * FROM SecSalesUser (NOLOCK) Where SalesUserID=@UserID
	 UPDATE SecSalesUser SET Deleted=0, UpdatedBy=@Caller, UpdatedDate=@Now Where SalesUserID=@UserID			 	 
	 End
	
	 ELSE
		Begin
			
		   IF NOT EXISTS(SELECT * FROM ADUser(NOLOCK) WHERE UserID=@UserID)       
			  RAISERROR (N'User %s is not in the Active Directory. Contact System Administrator.', 10,1, @UserID ); 
		   INSERT SecSalesUser (  SalesUserID, Email, isActive, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
		   SELECT UserID, Email, 1, @Caller, @Caller, 0, @Now, @Now FROM ADUser (NOLOCK) WHERE UserID=@UserID       
		End

	IF EXISTS(SELECT * FROM SecSalesUserRole(NOLOCK) Where SalesUserID=@UserID)
		UPDATE SecSalesUserRole SET Deleted=1, UpdatedBy=@Caller, UpdatedDate=@Now Where SalesUserID=@UserID
	IF EXISTS(SELECT * FROM SecSalesUserRole(NOLOCK) Where SalesUserID=@UserID AND RoleID=@RoleID)    
		UPDATE SecSalesUserRole SET Deleted=0, UpdatedBy=@Caller, UpdatedDate=@Now Where SalesUserID=@UserID AND RoleID=@RoleID
	ELSE
		INSERT  SecSalesUserRole (RoleID, SalesUserID, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
		SELECT @RoleID, @UserID, @Caller, @Caller, 0, @Now, @Now


		
   IF NOT EXISTS(SELECT * FROM SecSalesUserRole(NOLOCK) Where SalesUserID=@UserID AND RoleID=@RoleID AND Deleted=0
		  AND RoleID IN (SELECT RoleID FROM SecSalesRole Where RoleName IN ('Executive', 'IT Personnel') AND Deleted=0))
		  Begin
		    IF @LOBID=0
				RAISERROR (N'User %s is being assigned role that is neither Exective nor IT-Personnel.  LOB must be provided. Please Provide LOB.', 10,1, @UserID ); 
		  END
  IF EXISTS(SELECT RoleID FROM SecSalesRole Where RoleName IN ('Executive', 'IT Personnel') AND RoleID=@RoleID AND Deleted=0)
		GOTO EXIT_SP	
  
  IF EXISTS(SELECT RoleID FROM SecSalesRole(NOLOCK) Where RoleName In ('Manager','Rep') AND RoleID=@RoleID)
  Begin  
    IF @FullAccessLOB=1 
    Begin
		IF EXISTS(SELECT * FROM SecSalesUserDataAccess(NOLOCK) WHERE LOBID=@LOBID AND SalesUserID=@UserID)					
			UPDATE SecSalesUserDataAccess SET FullAccessLOB=@FullAccessLOB, Deleted=1, UpdatedBy=@Caller, UpdatedDate=@Now, LOBID=@LOBID, SalesUserID=@UserID
		IF EXISTS(SELECT * FROM SecSalesUserDataAccess(NOLOCK) WHERE LOBID=@LOBID AND SalesUserID=@UserID AND RepID IS NULL)					
			UPDATE SecSalesUserDataAccess SET FullAccessLOB=@FullAccessLOB, Deleted=0, UpdatedBy=@Caller, UpdatedDate=@Now, LOBID=@LOBID, SalesUserID=@UserID			
		ELSE 
		INSERT SecSalesUserDataAccess (SalesUserID, LOBID, RepID, FullAccessLOB, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
		SELECT @UserID, @LOBID, NULL, @FullAccessLOB, @Caller, @Caller, 0, @Now, @Now
    END
    ELSE
    Begin					
		IF EXISTS(SELECT * FROM SecSalesUserDataAccess(NOLOCK) WHERE LOBID=@LOBID AND SalesUserID=@UserID)
			UPDATE SecSalesUserDataAccess SET Deleted=1, UpdatedBy=@Caller, UpdatedDate=@Now, LOBID=@LOBID , SalesUserID=@UserID
		
		 INSERT SecSalesUserDataAccess (SalesUserID, LOBID, RepID, FullAccessLOB, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)		 		 
		 SELECT SalesUserID, LOBID, RepID, @FullAccessLOB, @Caller, @Caller, 0, @Now, @Now
		 FROM SecSalesUser(NOLOCK), SalesLOBRep(NOLOCK)
		 WHERE SalesUserID=@UserID AND LOBID=@LOBID AND RepID in (Select item_int from [dbo].[FN_SPLIT] (ISNULL(@RepIDList,''),','))
		 		    					
	End
  End		  
  ELSE  
		  RAISERROR (N'This Role is not supported.', 10,1); 
  
EXIT_SP:
WHILE (@@TRANCOUNT >= 1)
Begin
	COMMIT TRANSACTION;
End
--	SELECT @@TRANCOUNT
END TRY	    
BEGIN CATCH
WHILE (@@TRANCOUNT >= 1)
Begin
   ROLLBACK TRANSACTION;      
End   
END CATCH
GO




Select * From DimAccount Where EFGAccountCode='0000078153'



Select count(*) From FactSalesAggregate FS
INNER JOIN 
(Select AccountID=Max(AccountID) From DimAccount Group by EFGAccountCode Having count(*) > 1) A
ON FS.AccountID=A.AccountID

Select count(*) From FactSalesAggregate FS
INNER JOIN 
(Select AccountID=Min(AccountID) From DimAccount Group by EFGAccountCode Having count(*) > 1) A
ON FS.AccountID=A.AccountID

Select * From Syscolumns where name like 'AccountID%'



Select NationalAccountSrcID, count(*) 
From 
DimNationalAccount Group by NationalAccountSrcID Having count(*) > 1


Select * From DimNationalAccount
Where NationalAccountSrcID in 
(103962,
119511,
119643,
119944,
120003)

Select * From DimSalesManager
Where NationalAccountSrcID in 
(103962,
119511,
119643,
119944,
120003)


Select count(*) From [dbo].[DimCoverage] Group by SourceKey Having count(*) > 1



Select count(*) From [dbo].[DimFourPartProductKey] Group by [ClientCode],[ProgramCode] ,[ProductCode] , [PlanCode] Having count(*) > 1




Select count(*) From [dbo].[DimPlan] Group by PlanName Having count(*) > 1


Select * From [dbo].[DimProductCategory]



Select * From [dbo].[DimState]

Select * From [dbo].[DimTerms]










 
 