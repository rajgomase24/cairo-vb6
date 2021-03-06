SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Web_ReportsGetHiperLinks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Web_ReportsGetHiperLinks]
GO

/*

select * from reporte

sp_Web_ReportsGetHiperLinks 10

*/

create procedure sp_Web_ReportsGetHiperLinks
(
  @@rpt_id           int
) 
as
begin

  declare @inf_id int

  select @inf_id = inf_id from Reporte where rpt_id = @@rpt_id

  select 
              winfh_nombre,
              winfh_columna,
              winfh_url
  from 
        InformeHiperlinks
  where 
        inf_id = @inf_id

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

