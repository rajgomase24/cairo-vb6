if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCuentaHelpCliente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCuentaHelpCliente]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

	spCuentaHelpCliente 1,1,1,'sp%',0,0

	spCuentaHelpCliente 1,1,0, '',0,0,'(cuec_id = 4 or cuec_id = 19)and (emp_id = 1 or emp_id is null)'

  select * from usuario where us_nombre like '%ahidal%'

*/
create procedure spCuentaHelpCliente (
	@@emp_id          int,
  @@us_id           int,
	@@bForAbm         tinyint,
	@@filter 					varchar(255)  = '',
  @@check  					smallint 			= 0,
  @@cue_id          int,
	@@filter2					varchar(5000) = ''
)
as
begin

	exec spCuentaHelpCairo  @@emp_id,
													@@us_id,
													@@bForAbm,
													@@filter,
													@@check,
													@@cue_id,
													@@filter2
end

GO
