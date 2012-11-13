if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_VersionUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_VersionUpdate]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

sp_VersionUpdate '1.00.02'
sp_cfg_getvalor 'Base Datos','Version',0,1

*/
create procedure sp_VersionUpdate (
	@@cfg_valor varchar(255)
)
as
begin

	exec sp_Cfg_SetValor 'Base Datos','Version',@@cfg_valor

end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

