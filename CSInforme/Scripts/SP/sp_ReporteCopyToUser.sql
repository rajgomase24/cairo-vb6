if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ReporteCopyToUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ReporteCopyToUser]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

select * from rama where ram_nombre ='recaudaciones'
select * from reporte where us_id <> 1

begin tran
exec sp_ReporteCopyToUsers 192,'N83444'
rollback tran


*/

create procedure sp_ReporteCopyToUser (
  @@rpt_id         int,
  @@us_id          int
)
as
begin

set nocount on

  declare @rpt_id_new int

  exec sp_dbgetnewid 'Reporte','rpt_id',@rpt_id_new out,0

  insert into Reporte (
                        rpt_id,
                        rpt_nombre,
                        rpt_descrip,
                        inf_id,
                        us_id,
                        modificado,
                        creado,
                        modifico,
                        activo
                      )
              select
                        @rpt_id_new,
                        rpt_nombre,
                        rpt_descrip,
                        inf_id,
                        @@us_id,
                        modificado,
                        creado,
                        modifico,
                        activo

              from Reporte

              where rpt_id = @@rpt_id

  declare @rptp_id       int
  declare @rptp_id_new   int

  declare c_parametros insensitive cursor for 

              select  rptp_id
              from ReporteParametro
              where rpt_id = @@rpt_id

  open c_parametros

  fetch next from c_parametros into @rptp_id
  while @@fetch_status=0
  begin

    set @rptp_id_new = null

    exec sp_dbgetnewid 'ReporteParametro','rptp_id',@rptp_id_new out,0

    insert into ReporteParametro (
                                  rptp_id,
                                  rptp_valor,
                                  rptp_visible,
                                  rpt_id,
                                  infp_id,
                                  creado,
                                  modificado,
                                  modifico
                                )
                      select
                                  @rptp_id_new,
                                  rptp_valor,
                                  rptp_visible,
                                  @rpt_id_new,
                                  infp_id,
                                  creado,
                                  modificado,
                                  modifico

                      from ReporteParametro
                      where rptp_id = @rptp_id

    fetch next from c_parametros into @rptp_id
  end

  close c_parametros
  deallocate c_parametros

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

