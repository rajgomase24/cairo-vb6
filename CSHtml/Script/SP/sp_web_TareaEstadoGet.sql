SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_web_TareaEstadoGet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_web_TareaEstadoGet]
GO

/*

sp_web_TareaEstadoGet 7

*/

create Procedure sp_web_TareaEstadoGet
(
	@@us_id int  
) 
as
begin

	select tarest_id, 
				 tarest_nombre as [Tarea Estado]

	from TareaEstado

	order by tarest_nombre

end
go
set quoted_identifier off 
go
set ansi_nulls on 
go

