if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IdDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IdDelete]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

select * from id

*/

create procedure sp_IdDelete 
as
begin

  delete Id where Id_Tabla not in ('DepositoFisico','DepositoLogico','TasaImpositiva')
  delete IdAsiento
  delete IdStock
  delete rptArbolRamaHoja

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

