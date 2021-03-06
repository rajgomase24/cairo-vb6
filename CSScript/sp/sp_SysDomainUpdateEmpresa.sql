if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SysDomainUpdateEmpresa]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SysDomainUpdateEmpresa]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

  select * from basedatos

  sp_SysDomainUpdateEmpresa 7

sp_SysDomainUpdateEmpresa 
                        1,
                        'Cairo',
                        'souyirozeta',
                        'Cairo',
                        'sa',
                        0,
                        ''

sp_columns basedatos

*/
create procedure sp_SysDomainUpdateEmpresa (
  @@bd_id         int,
  @@emp_id        int,
  @@empresa       varchar(255)
)
as
begin
  set nocount on

  if not exists(select * from Empresa where bd_id = @@bd_id and emp_id = @@emp_id) begin

    insert into Empresa (bd_id,emp_id,emp_nombre)
        values (@@bd_id,@@emp_id,@@empresa)

  end else begin

    update Empresa set 

      emp_nombre  = @@empresa

    where bd_id   = @@bd_id
      and emp_id  = @@emp_id

  end

end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

