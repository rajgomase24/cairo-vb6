if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SysDomainGetEmpresas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SysDomainGetEmpresas]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

  select * from basedatos

  sp_SysDomainGetEmpresas 7

sp_SysDomainGetEmpresas 
                        1,
                        'Cairo',
                        'souyirozeta',
                        'Cairo',
                        'sa',
                        0,
                        ''

sp_columns basedatos

*/
create procedure sp_SysDomainGetEmpresas

as
begin

  select bd_server,emp_nombre,basedatos.bd_id,bd_securitytype,bd_pwd,bd_login,emp_id 
  from basedatos left join empresa on basedatos.bd_id = empresa.bd_id
end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

