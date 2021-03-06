USE [EFGDW]
GO
/****** Object:  StoredProcedure [dbo].[usp_get_activedirectory_list]    Script Date: 12/05/2013 09:40:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_get_activedirectory_list]
AS
BEGIN
	SET NOCOUNT ON;

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AD_Groups]') AND TYPE IN (N'U'))
DROP TABLE [dbo].[AD_Groups]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AD_Group_Members]') AND TYPE IN (N'U'))
DROP TABLE [dbo].[AD_Group_Members]

CREATE TABLE AD_Groups ( CN VARCHAR(128), DN VARCHAR(1024), Email VARCHAR(128), ADSPath VARCHAR(1024) );
CREATE TABLE AD_Group_Members ( CommonName VARCHAR (max), objectCategory VARCHAR (max), DistributionGroup VARCHAR(128), FirstName VARCHAR(50), LastName VARCHAR(50), EmailAddress VARCHAR(128) );
DECLARE @sql VARCHAR(1024)
SET @sql = 'INSERT INTO AD_Groups (CN, DN, Email, ADSPath) 
SELECT CN, distinguishedName DN, mail Email, ADSPath 
FROM OpenQuery(ADSI, ''<LDAP://sv-efgdc01>;(&(objectClass=Group));cn, 
distinguishedName, mail, ADSPath;subtree'') ORDER BY distinguishedName';
EXEC(@sql);
--------------------
DECLARE @CN VARCHAR(128)
DECLARE @DN VARCHAR(1024)
SELECT TOP 1 @CN = CN, @DN = DN FROM AD_Groups
WHILE EXISTS(SELECT DN FROM AD_Groups WHERE DN > @DN)
BEGIN
   SET @sql = 'INSERT INTO AD_Group_Members (DistributionGroup, Firstname, LastName, EmailAddress, objectCategory, CommonName) 
SELECT '''+@CN+'''[Distribution Group], ISNULL(givenName, '''') FirstName, ISNULL(sn, '''') LastName, mail EmailAddress,objectCategory, cn CommonName FROM OpenQuery
(ADSI, ''<LDAP://sv-efgdc01>;(&(objectClass=*)(memberOf='+@DN+')); givenName, sn, mail, objectCategory, cn;subtree'')'; 
   EXEC(@sql)
   SELECT TOP 1 @CN = CN, @DN = DN FROM AD_Groups WHERE DN > @DN
END
/* 
SELECT 
    'Group' as [Category]
 ,[DistributionGroup] as [Group Name]
 ,[CommonName] as [Member]
 ,[EmailAddress] as [Email Address]
FROM AD_Group_Members
where ObjectCategory like '%Group%'
UNION
SELECT 
 'Person' as [Category]
 ,[DistributionGroup] as [Group Name]
 ,[CommonName] as [Member]
 ,[EmailAddress] as [Email Address]
FROM AD_Group_Members
where ObjectCategory like '%Person%'



declare @sql varchar(max)
DECLARE @CN VARCHAR(128)
DECLARE @DN VARCHAR(1024)

SELECT TOP 1 @CN = CN, @DN = DN FROM AD_Groups Order by DN
--SELECT * FROM AD_Group_Members
DECLARE @ReportGroups AS TABLE (GroupName varchar(100))
INSERT @ReportGroups
SELECT 'SalesRptExec' UNION
SELECT 'SalesRptMgr' UNION
SELECT 'SalesRptRep' UNION
SELECT 'SalesRptIT'
Drop Table #ADUsers
CREATE TABLE #ADUsers ( WhenCreated datetime, WhenChanged datetime, CommonName VARCHAR (max), UserAccountControl int,sAMAccountName varchar(max), objectCategory VARCHAR (max), DistributionGroup VARCHAR(128), FirstName VARCHAR(50), LastName VARCHAR(50), EmailAddress VARCHAR(128) );
WHILE EXISTS(SELECT Top 1 DN FROM AD_Groups WHERE DN > @DN Order by DN)
BEGIN
   SET @sql = ' 
SELECT '''+@CN+'''[Distribution Group],  Whencreated, whenchanged, userAccountControl, sAMAccountName, ISNULL(givenName, '''') FirstName, ISNULL(sn, '''') LastName, mail EmailAddress,objectCategory, cn CommonName FROM OpenQuery
(ADSI, ''<LDAP://sv-efgdc01>;(&(objectClass=*)(memberOf='+@DN+')); Whencreated, whenchanged, userAccountControl, sAMAccountName, givenName, sn, mail, objectCategory, cn;subtree'')'; 

IF EXISTS( SELECT * FROM @ReportGroups Where GroupName = @CN)
	INSERT #ADUsers (DistributionGroup, whencreated, whenchanged, UserAccountControl, sAMAccountName, Firstname, LastName, EmailAddress, objectCategory, CommonName)
	EXEC(@sql)
SELECT TOP 1 @CN = CN, @DN = DN FROM AD_Groups WHERE DN > @DN Order by DN
   
END

/*

select distinct commonName, whencreated, whenchanged from #ADUsers
Where 2&UserAccountControl =2
order by Whenchanged desc

Select * from #ADUsers
-- Drop Table #ADUsers



SELECT *
FROM AD_Group_Members
WHERE DistributionGroup in ('SalesRptIT', 'SalesRptExec' , 'SalesRptMgr' , 'SalesRptRep',  'SalesRptIT')



*/

*/
END




