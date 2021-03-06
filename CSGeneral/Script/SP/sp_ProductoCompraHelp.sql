if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ProductoCompraHelp ]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ProductoCompraHelp ]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

 sp_ProductoCompraHelp  1,1,1,'sp%',0,0

 sp_ProductoCompraHelp  3,'',0,0,1 

  select * from usuario where us_nombre like '%ahidal%'

*/
create procedure sp_ProductoCompraHelp  (
  @@emp_id          int,
  @@us_id           int,
  @@bForAbm         tinyint,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0,
  @@pr_id           int,
  @@filter2          varchar(5000)  = '',
  @@prhc_id         int = 0
)
as
begin

  set nocount on


  if @@check <> 0 begin
  
    select   pr_id,
            pr_nombrecompra  as [Nombre],
            pr_codigo       as [Codigo]

    from Producto

    where (pr_nombrecompra = @@filter or pr_codigo = @@filter)
      and (activo <> 0 or @@bForAbm <> 0)
      and (pr_id = @@pr_id or @@pr_id=0)
      and pr_secompra <> 0

  end else begin

    select top 50
           pr_id,
           pr_nombrecompra  as Nombre,
           pr_descripcompra as [Observaciones],
           pr_codigo        as Codigo
    from Producto 

    where (pr_codigo like '%'+@@filter+'%' or pr_nombrecompra like '%'+@@filter+'%' 
            or pr_descripcompra like '%'+@@filter+'%' 
            or @@filter = '')
      and (activo <> 0 or @@bForAbm <> 0)
      and pr_secompra <> 0

  end    

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

