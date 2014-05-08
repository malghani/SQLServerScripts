use efgsales


Select * From SecSalesRole
Select * From SalesLOB
  dbo.GetADUsers @firstName='Dennis'
  EXEC dbo.SecGetUserProfile 'BRC'
  EXEC dbo.SecUnProvision_User @UserID='BJJ', @Caller='amaqsood', @RoleID=6,  @LOBID=8
  EXEC dbo.SecProvision_User @UserID='BJJ', @RoleID=4, @Caller='amaqsood', @LOBID=8, @FullAccessLOB=1
--Provision a Rep
  EXEC dbo.SecProvision_User @UserID='salesreptestuser', @RoleID=6, @Caller='amaqsood', @LOBID=2, @FullAccessLOB=0, @RepIDList='1'
 EXEC dbo.SecGetUserProfile 'salesreptestuser' 
  EXEC dbo.SecUnProvision_User @UserID='salesreptestuser', @Caller='amaqsood', @RoleID=6,  @LOBID=2

  --Provision a Mgr
  EXEC dbo.SecGetUserProfile 'salesmgrtestuser'
  EXEC dbo.SecProvision_User @UserID='salesmgrtestuser', @RoleID=4, @Caller='amaqsood', @LOBID=2, @FullAccessLOB=0, @RepIDList='1,8'  
  EXEC dbo.SecUnProvision_User @UserID='salesmgrtestuser', @Caller='amaqsood', @RoleID=4,  @LOBID=2
  
  --Provision a Mgr
  EXEC dbo.SecGetUserProfile 'salesmgrtestuser'
  EXEC dbo.SecProvision_User @UserID='salesmgrtestuser', @RoleID=4, @Caller='amaqsood', @LOBID=4, @FullAccessLOB=0, @RepIDList='10,11'    
  EXEC dbo.SecUnProvision_User @UserID='salesmgrtestuser', @Caller='amaqsood', @RoleID=4,  @LOBID=4


  --Provision a Exec
  EXEC dbo.SecProvision_User @UserID='salesexectestuser', @RoleID=2, @Caller='amaqsood'
  EXEC dbo.SecGetUserProfile 'salesexectestuser'  
  EXEC dbo.SecUnProvision_User @UserID='salesexectestuser', @Caller='amaqsood', @RoleID=2
  
  EXEC dbo.SecUnProvision_User @UserID='Veronica', @Caller='amaqsood', @RoleID=2
  
    EXEC dbo.SecProvision_User @UserID='vrenteria', @RoleID=2, @Caller='amaqsood'
  EXEC dbo.SecGetUserProfile 'vrenteria'  
  
  vrenteria
  
  --Provision a IT
  EXEC dbo.SecGetUserProfile 'SPentakota'  
  EXEC dbo.SecProvision_User @UserID='SPentakota', @RoleID=3, @Caller='amaqsood'  
  EXEC dbo.SecUnProvision_User @UserID='SPentakota', @Caller='amaqsood', @RoleID=3
  
  Select * From SecSalesRole
  
  
  
  Select * from SalesLOBRep Where Deleted=0 Order by LOBID, RepID 
  Select * from SecSalesRole
  
  
    EXEC dbo.SecProvision_User @UserID='salesmgrtestuser', @RoleID=4, @Caller='amaqsood', @LOBID=4, @FullAccessLOB=0
    EXEC dbo.SecGetUserProfile 'amaqsood'
      EXEC dbo.SecUnProvision_User @UserID='salesmgrtestuser', @Caller='amaqsood', @RoleID=4,  @LOBID=4





   CREATE PROC GetAllUserProfile
   AS
   SELECT DISTINCT 'DataAssignment' AS Container, U.UserID SalesAccount, U.FirstName, U.LastName, 
   LOB=CASE WHEN LOB.LOB IS NULL OR SR.RoleName IN ('Executive', 'IT Personnel') THEN 'ALL LOBs' ELSE LOB.LOB END,
   FullAccessLOB=CASE WHEN Rep.Rep IS NULL OR LOB.LOB IS NULL OR SR.RoleName IN ('Executive', 'IT Personnel') THEN 'Yes' ELSE 'No' END,
   
   Rep=CASE WHEN Rep.Rep IS NULL OR SR.RoleName IN ('Executive', 'IT Personnel') THEN 'All Reps' ELSE Rep.Rep END,
   ReportingRole=ISNULL(SR.RoleName, ISNULL(ULR.RoleName, 'Exec')),
   ADG.GroupName
   
   FROM ADUser U
   INNER JOIN SecSalesUser SU ON SU.SalesUserID=U.UserID --And SU.Deleted=0   
   LEFT JOIN SecSalesUserDataAccess SDA ON SDA.SalesUserID=SU.SalesUserID --AND SDA.Deleted=0
   LEFT JOIN SalesLOB LOB ON LOB.LOBID=SDA.LOBID AND LOB.Deleted=0
   LEFT JOIN SalesRep Rep ON Rep.RepID=SDA.RepID AND Rep.Deleted=0
   LEFT JOIN SalesLOBRep LR ON LR.LOBID=LOB.LOBID AND LR.RepID=Rep.RepID AND LR.Deleted=0     
   LEFT JOIN SecSalesRole SR ON SR.RoleID=SDA.RoleID
   LEFT JOIN SecSalesUserRole R ON R.SalesUserID=U.UserID
   LEFT JOIN SecSalesRole ULR ON ULR.RoleID=R.RoleID
   LEFT JOIN ADUserGroup GM ON GM.UserID=U.UserID 
   LEFT JOIN ADGroup ADG ON ADG.GroupID=GM.GroupID
   Order by U.FirstName

    
   

Dennis Epping
Dara Prince
Myra Brown
dbo.GetADUsers @firstName='Dennis'
dbo.GetADUsers @firstName='Dara'
dbo.GetADUsers @firstName='Myra'


EXEC dbo.SecProvision_User @UserID='DME', @RoleID=2, @Caller='amaqsood'
EXEC dbo.SecGetUserProfile 'DME'  
EXEC dbo.SecUnProvision_User @UserID='mbrown', @Caller='amaqsood', @RoleID=2



