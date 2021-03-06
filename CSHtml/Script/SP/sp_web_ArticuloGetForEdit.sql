SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_ArticuloGetForEdit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_ArticuloGetForEdit]
GO

/*

sp_web_ArticuloGetForEdit 2,0,'20040101','20041231','%manual%',' ','',1

select * from Articulo

*/

create procedure sp_web_ArticuloGetForEdit (

  @@wartt_id              int,
  @@warte_id              int,
  @@wart_fechaDesde        datetime,
  @@wart_fechaHasta        datetime,
  @@wart_titulo           varchar(100),
  @@wart_copete           varchar(255),
  @@wart_texto            varchar(255),
  @@us_id                  int

)as
begin

  set @@wart_titulo = IsNull(@@wart_titulo,'')
  set @@wart_texto  = IsNull(@@wart_texto,'')
  set @@wart_copete = IsNull(@@wart_copete,'')

  select 
      wart_id,
      wart_titulo               as [Titulo], 
      wart_copete               as [Copete],
      wart_origen               as [Origen],
      wart_texto                as [Texto],
      wart_origenurl            as [Origen URL],
      wart_imagen                as [Imagen],
      wart_fecha                as [Fecha],
      t.wartt_nombre             as [Tipo],
      e.warte_nombre             as [Estado]

  from webArticulo a inner join webArticuloTipo  t            on a.wartt_id = t.wartt_id
                     inner join webArticuloEstado  e          on a.warte_id = e.warte_id
  where 

 (t.wartt_id = @@wartt_id or @@wartt_id = 0)
  and (e.warte_id = @@warte_id or @@warte_id = 0)
   and (a.wart_texto like @@wart_texto or @@wart_texto='')
   and (a.wart_titulo like @@wart_titulo or @@wart_titulo='')
   and (a.wart_copete like @@wart_copete or @@wart_copete='')
   and wart_fecha >= @@wart_fechaDesde
    and wart_fecha <= @@wart_fechaHasta

  order by wart_fecha

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

