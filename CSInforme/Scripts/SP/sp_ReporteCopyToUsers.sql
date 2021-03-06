if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ReporteCopyToUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ReporteCopyToUsers]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

select * from rama where ram_nombre ='recaudaciones'
select * from reporte where us_id <> 1
select * from reporteparametro where rpt_id >= 192
--delete reporte where us_id not in (1,5)

begin tran
select * from reporte where us_id <> 1
exec sp_ReporteCopyToUsers 192,'N83444'
select * from reporte where us_id <> 1
select * from reporteparametro where rpt_id > 195
rollback tran

*/

create procedure sp_ReporteCopyToUsers (
  @@rpt_id          int,
  @@us_id           varchar(255)
)
as
begin

set nocount on

declare @us_id_reporte int
declare @us_id int
declare @ram_id_usuario int

declare @clienteID int
declare @IsRaiz    tinyint

exec sp_ArbConvertId @@us_id, @us_id out, @ram_id_usuario out

exec sp_GetRptId @clienteID out

if @ram_id_usuario <> 0 begin

  -- exec sp_ArbGetGroups @ram_id_usuario, @clienteID, @@us_id

  exec sp_ArbIsRaiz @ram_id_usuario, @IsRaiz out
  if @IsRaiz = 0 begin
    exec sp_ArbGetAllHojas @ram_id_usuario, @clienteID 
  end else 
    set @ram_id_usuario = 0
end

/*- ///////////////////////////////////////////////////////////////////////

FIN PRIMERA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

select @us_id_reporte = us_id from Reporte where rpt_id = @@rpt_id

declare c_usuarios insensitive cursor for 

    select us_id from Usuario u
    where

          (u.us_id = @us_id or @us_id=0)

      and   (
                (exists(select rptarb_hojaid 
                        from rptArbolRamaHoja 
                        where
                             rptarb_cliente = @clienteID
                        and  tbl_id = 3 
                        and  rptarb_hojaid = u.us_id
                       ) 
                 )
              or 
                 (@ram_id_usuario = 0)
             )

open c_usuarios

fetch next from c_usuarios into @us_id
while @@fetch_status=0
begin

  if @us_id_reporte <> @us_id begin

    exec sp_ReporteCopyToUser @@rpt_id, @us_id

  end

  fetch next from c_usuarios into @us_id
end

close c_usuarios
deallocate c_usuarios

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

