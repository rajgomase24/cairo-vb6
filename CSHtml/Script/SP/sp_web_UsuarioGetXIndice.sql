SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_UsuarioGetXIndice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_UsuarioGetXIndice]
GO

/*
select us_id from usuario where us_nombre = 'aortega'
sp_web_UsuarioGetXIndice 541,1

*/

create procedure sp_web_UsuarioGetXIndice
(
  @@us_id              int,
  @@us_id_login        int
)
as
begin

  /* select tbl_id,tbl_nombrefisico from tabla where tbl_nombrefisico like '%%'*/
  exec sp_HistoriaUpdate 3, @@us_id, @@us_id_login, 4

  select 
                u.us_id, 
                us_nombre, 
                us_clave, 
                sector.dpto_nombre as sector,
                d.dpto_nombre,
                prs_apellido,
                prs_nombre,
                prs_email,
                prs_cargo,
                prs_teltrab,
                prs_interno,
                prs_celular,
                suc_nombre


  from Usuario u inner join Persona p              on u.prs_id              = p.prs_id
                 inner join Departamento sector    on p.dpto_id             = sector.dpto_id
                 left  join Departamento d         on sector.dpto_id_padre  = d.dpto_id
                 left  join Sucursal s             on p.suc_id              = s.suc_id

  where u.us_id = @@us_id

end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

