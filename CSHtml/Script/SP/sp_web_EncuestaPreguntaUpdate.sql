SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_EncuestaPreguntaUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_EncuestaPreguntaUpdate]
GO

/*

*/

create Procedure sp_web_EncuestaPreguntaUpdate (
     @@ec_id                int,
    @@ecp_id              int,
     @@ecp_texto           varchar(255),
     @@ecp_multiple        tinyint,
    @@ecp_orden            smallint
)
as

begin

  set nocount on

  if @@ecp_orden < 0 set @@ecp_orden = 0

  if @@ecp_id = 0 begin

    exec SP_DBGetNewId 'EncuestaPregunta', 'ecp_id', @@ecp_id out, 0

    insert into EncuestaPregunta (
                              ecp_id,
                              ecp_texto,
                              ecp_multiple,
                              ec_id,
                              ecp_orden
                            )
                    values  (
                              @@ecp_id,
                              @@ecp_texto,
                              @@ecp_multiple,
                              @@ec_id,
                              @@ecp_orden
                            )
  end else begin

    update EncuestaPregunta set
                            ecp_texto        = @@ecp_texto,
                            ecp_multiple    = @@ecp_multiple,
                            ec_id           = @@ec_id,
                            ecp_orden        = @@ecp_orden
    where ecp_id = @@ecp_id
  end

  select @@ecp_id as ecp_id

end

go
set quoted_identifier off 
go
set ansi_nulls on 
go

