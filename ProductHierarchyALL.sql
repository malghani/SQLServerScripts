select identity(int) As [Seq No], [Client Code]=ISNULL(m.clicod, p.clicod), [Client Description]=ISNULL(m.ClientDesc, d.clidesc), 
Partner=ISNULL(m.Partner,''),  Category=ISNULL(m.Category, ''), Type=ISNULL(m.Type,''), Product=ISNULL(m.Product, ''),
[Program Code]= ISNULL(m.Cprog, p.prgcod), 
[Program Description]= ISNULL(m.ProgramDesc, d.prgdesc),
[Product Code]= ISNULL(m.cprod, p.prdcod),
[Product Description]= ISNULL(m.ProductDesc, d.prddesc),
[Plan Code]= ISNULL(m.cplan, p.plncod),
[Plan Description]= ISNULL(m.PlanDesc, d.plndesc),
Coverage = ISNULL(m.Coverage, '')
into #tmp
from EFGSales.dbo.PRDHIER p
LEFT join  efgdw.dbo.tbl_ms_product_looks d on 
  p.clicod=d.clicod and
  d.plncod=p.plncod and
  d.prgcod=p.prgcod and
  d.prdcod=p.prdcod
LEFT JOIN EFGSales.dbo.mpm m 
on m.CLICOD=rtrim(p.clicod)
and m.CProd=rtrim(p.prdcod)
and m.CProg=rtrim(p.prgcod) 
and m.CPlan=rtrim(p.plncod)
Order by m.CliCod
Select * From #tmp  Order by [Seq No]
Select * From mpm m
left join PRDHIER p on 
 p.clicod=m.clicod and
  p.plncod=m.CPlan and
  p.prgcod=m.Cprog and
  p.prdcod=m.Cprod
  
  Where p.clicod is null

Alter table mpm
Rem column F14

Drop Table dbo.tbl_ms_mtd_closedbo.TBL_MS_AS400_CLOSEdbo.SCPAYRDdbo.Trm .AGRTRMdbo.AGRPLNdbo.AGRTRMdbo.AGRSTS
  --select * from EFGSales.dbo.MasterProductMatrix
  
  --select mpm.partner, mpm.coverage, m.partner, m.coverage, m.Type, mpm.type from EFGSales.dbo.MasterProductMatrix m
  --inner join mpm on mpm.clicod=m.CLICOD and mpm.cprog=m.CProg and mpm.cprod=m.CProd and mpm.cplan=m.CPlan
  --where --m.Type<>mpm.type or m.Category<>mpm.category or m.ProductName<>mpm.product
  ----or 
  --m.Coverage<>mpm.coverage or m.Partner<>mpm.partner
  
