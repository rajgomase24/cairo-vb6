/*---------------------------------------------------------------------
Nombre: Cuenta Corriente de Ventas
---------------------------------------------------------------------*/
/*  

Para testear:

DC_CSC_VEN_0216 1, '20000201','0', '0','0','0','0','0','0','0','0','0','0','0','0'

*/
if exists (select * from sysobjects where id = object_id(N'[dbo].[DC_CSC_VEN_0216]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DC_CSC_VEN_0216]

go
create procedure DC_CSC_VEN_0216 (

  @@us_id    		int,
	@@Fini 		 		datetime,

  @@pro_id   				varchar(255),
  @@cli_id   				varchar(255),
  @@ven_id	 				varchar(255),
  @@cico_id	 				varchar(255),
  @@ccos_id	   			varchar(255),
  @@cpg_id	 				varchar(255),
  @@lp_id	   				varchar(255),
  @@ld_id  	 				varchar(255),
  @@suc_id	 				varchar(255),
  @@doct_id	 				int,
  @@doc_id	 				varchar(255),
  @@mon_id	 				varchar(255),
  @@emp_id	 				varchar(255)

)as 
begin

set nocount on

/*- ///////////////////////////////////////////////////////////////////////

SEGURIDAD SOBRE USUARIOS EXTERNOS

/////////////////////////////////////////////////////////////////////// */

declare @us_empresaEx tinyint
select @us_empresaEx = us_empresaEx from usuario where us_id = @@us_id

/*- ///////////////////////////////////////////////////////////////////////

INICIO PRIMERA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

declare @Ffin datetime set @Ffin = getdate()

declare @pro_id   		int
declare @cli_id   		int
declare @ven_id   		int
declare @cico_id  		int
declare @doc_id   		int
declare @mon_id   		int
declare @emp_id   		int

declare @ccos_id	    int
declare @cpg_id	  		int
declare @lp_id	  		int
declare @ld_id  			int
declare @suc_id	  		int

declare @ram_id_provincia        int
declare @ram_id_cliente          int
declare @ram_id_vendedor         int
declare @ram_id_circuitoContable int
declare @ram_id_documento        int
declare @ram_id_moneda           int
declare @ram_id_empresa          int
declare @ram_id_centroCosto      int
declare @ram_id_centroCostoItem  int
declare @ram_id_condicionPago    int
declare @ram_id_listaPrecio      int
declare @ram_id_listaDescuento   int
declare @ram_id_sucursal         int

declare @clienteID int
declare @IsRaiz    tinyint

exec sp_ArbConvertId @@pro_id,  		 @pro_id out,  			@ram_id_provincia out
exec sp_ArbConvertId @@cli_id,  		 @cli_id out,  			@ram_id_cliente out
exec sp_ArbConvertId @@ven_id,  		 @ven_id out,  			@ram_id_vendedor out
exec sp_ArbConvertId @@cico_id, 		 @cico_id out, 			@ram_id_circuitoContable out
exec sp_ArbConvertId @@doc_id,  		 @doc_id out,  			@ram_id_documento out
exec sp_ArbConvertId @@mon_id,  		 @mon_id out,  			@ram_id_moneda out
exec sp_ArbConvertId @@emp_id,  		 @emp_id out,  			@ram_id_empresa out
exec sp_ArbConvertId @@ccos_id, 		 @ccos_id out, 			@ram_id_centroCosto out
exec sp_ArbConvertId @@cpg_id, 			 @cpg_id out, 			@ram_id_condicionPago out
exec sp_ArbConvertId @@lp_id,        @lp_id out, 				@ram_id_listaPrecio out
exec sp_ArbConvertId @@ld_id,        @ld_id out, 				@ram_id_listaDescuento out
exec sp_ArbConvertId @@suc_id,       @suc_id out, 			@ram_id_sucursal out

exec sp_GetRptId @clienteID out

if @ram_id_provincia <> 0 begin

--	exec sp_ArbGetGroups @ram_id_provincia, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_provincia, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_provincia, @clienteID 
	end else 
		set @ram_id_provincia = 0
end

if @ram_id_cliente <> 0 begin

--	exec sp_ArbGetGroups @ram_id_cliente, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_cliente, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_cliente, @clienteID 
	end else 
		set @ram_id_cliente = 0
end

if @ram_id_vendedor <> 0 begin

--	exec sp_ArbGetGroups @ram_id_vendedor, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_vendedor, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_vendedor, @clienteID 
	end else 
		set @ram_id_vendedor = 0
end

if @ram_id_circuitoContable <> 0 begin

--	exec sp_ArbGetGroups @ram_id_circuitoContable, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_circuitoContable, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_circuitoContable, @clienteID 
	end else 
		set @ram_id_circuitoContable = 0
end

if @ram_id_documento <> 0 begin

--	exec sp_ArbGetGroups @ram_id_documento, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_documento, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_documento, @clienteID 
	end else 
		set @ram_id_documento = 0
end

if @ram_id_moneda <> 0 begin

--	exec sp_ArbGetGroups @ram_id_moneda, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_moneda, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_moneda, @clienteID 
	end else 
		set @ram_id_moneda = 0
end

if @ram_id_empresa <> 0 begin

--	exec sp_ArbGetGroups @ram_id_empresa, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_empresa, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_empresa, @clienteID 
	end else 
		set @ram_id_empresa = 0
end

if @ram_id_centroCosto <> 0 begin

--	exec sp_ArbGetGroups @ram_id_centroCosto, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_centroCosto, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_centroCosto, @clienteID 
	end else 
		set @ram_id_centroCosto = 0
end

if @ram_id_condicionPago <> 0 begin

--	exec sp_ArbGetGroups @ram_id_condicionPago, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_condicionPago, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_condicionPago, @clienteID 
	end else 
		set @ram_id_condicionPago = 0
end

if @ram_id_listaPrecio <> 0 begin

--	exec sp_ArbGetGroups @ram_id_listaPrecio, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_listaPrecio, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_listaPrecio, @clienteID 
	end else 
		set @ram_id_listaPrecio = 0
end

if @ram_id_listaDescuento <> 0 begin

--	exec sp_ArbGetGroups @ram_id_listaDescuento, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_listaPrecio, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_listaDescuento, @clienteID 
	end else 
		set @ram_id_listaDescuento = 0
end

if @ram_id_sucursal <> 0 begin

--	exec sp_ArbGetGroups @ram_id_sucursal, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_sucursal, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_sucursal, @clienteID 
	end else 
		set @ram_id_sucursal = 0
end


/*- ///////////////////////////////////////////////////////////////////////

FIN PRIMERA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

create table #t_fv_DC_CSC_VEN_0216 (fv_id int not null)

		insert into #t_fv_DC_CSC_VEN_0216 (fv_id)

		select 
			fv.fv_id

		from 

			facturaventa fv inner join documento doc on fv.doc_id = doc.doc_id
											inner join cliente   cli on fv.cli_id = cli.cli_id

		where 
		
						  fv_fecha >= @@Fini
					and	fv_fecha <= @Ffin 
		
					and fv.est_id <> 7
		
					and (
								exists(select * from EmpresaUsuario where emp_id = fv.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)
    			and (
								exists(select * from UsuarioEmpresa where cli_id = fv.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)
		
		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (cli.pro_id = @pro_id or @pro_id=0)
		and   (fv.cli_id = @cli_id or @cli_id=0)
		and   (		IsNull(fv.ven_id,0) 	= @ven_id
					 or	IsNull(cli.ven_id,0) 	= @ven_id
					 or @ven_id	=0
					)
		and   (doc.cico_id = @cico_id or @cico_id=0)
		and   (fv.doc_id = @doc_id or @doc_id=0)
		and   (fv.mon_id = @mon_id or @mon_id=0)
		and   (fv.emp_id = @emp_id or @emp_id=0)
		
		and   (fv.ccos_id = @ccos_id or @ccos_id=0)
		and   (fv.cpg_id = @cpg_id or @cpg_id=0)
		and   (fv.lp_id = @lp_id or @lp_id=0)
		
		and   (fv.ld_id = @ld_id or @ld_id=0)
		and   (fv.suc_id = @suc_id or @suc_id=0)
		
		-- Arboles
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 6 
		                  and  rptarb_hojaid = cli.pro_id
									   ) 
		           )
		        or 
							 (@ram_id_provincia = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 28 
		                  and  rptarb_hojaid = fv.cli_id
									   ) 
		           )
		        or 
							 (@ram_id_cliente = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 15 
                  and  (		rptarb_hojaid = isnull(fv.ven_id,0)
												or	rptarb_hojaid = isnull(cli.ven_id,0)
												)
									   ) 
		           )
		        or 
							 (@ram_id_vendedor = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1016 
		                  and  rptarb_hojaid = doc.cico_id
									   ) 
		           )
		        or 
							 (@ram_id_circuitoContable = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 4001 
		                  and  rptarb_hojaid = fv.doc_id
									   ) 
		           )
		        or 
							 (@ram_id_documento = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 12 
		                  and  rptarb_hojaid = fv.mon_id
									   ) 
		           )
		        or 
							 (@ram_id_moneda = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1018 
		                  and  rptarb_hojaid = fv.emp_id
									   ) 
		           )
		        or 
							 (@ram_id_empresa = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 21 
		                  and  rptarb_hojaid = fv.ccos_id
									   ) 
		           )
		        or 
							 (@ram_id_centroCosto = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1005 
		                  and  rptarb_hojaid = fv.cpg_id
									   ) 
		           )
		        or 
							 (@ram_id_condicionPago = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 27 
		                  and  rptarb_hojaid = fv.lp_id
									   ) 
		           )
		        or 
							 (@ram_id_listaPrecio = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1006 
		                  and  rptarb_hojaid = fv.ld_id
									   ) 
		           )
		        or 
							 (@ram_id_listaDescuento = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1007 
		                  and  rptarb_hojaid = fv.suc_id
									   ) 
		           )
		        or 
							 (@ram_id_sucursal = 0)
					 )

/*- ///////////////////////////////////////////////////////////////////////

FACTURAS, NC Y ND DE CONTADO

/////////////////////////////////////////////////////////////////////// */

		select 
			fv_id        as comp_id,
			fv.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
		  cli_nombre	 as Cliente,
			fv_fecha		 as Fecha,
			doc_nombre	 as Documento,
			fv_nrodoc    as NroDoc,
			cpg_nombre   as [Cond. Pago],
			case 
				when fv.doct_id = 7  then    0
				else 												 fv_totalcomercial
			end 				 as Debe,
			case 
				when fv.doct_id = 7  then    fv_totalcomercial
				else 												 0
			end 				 as Haber,
			case 
				when fv.doct_id = 7  then    -fv_totalcomercial
				else 												 +fv_totalcomercial
			end 				 as Saldo,
		  fv_descrip   as Observaciones
		
		from 
			facturaventa fv inner join condicionPago    cpg  on fv.cpg_id   = cpg.cpg_id 
																												and cpg_escontado <> 0
		
											inner join cliente       		cli	 on fv.cli_id    = cli.cli_id
		                  inner join documento 				doc  on fv.doc_id   = doc.doc_id
		                  inner join moneda    				mon  on fv.mon_id   = mon.mon_id
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   				emp  on doc.emp_id  = emp.emp_id
		
											left join centroCosto 			ccos on fv.ccos_id = ccos.ccos_id
		           	      left join provincia   			pro  on cli.pro_id  = pro.pro_id
		where 
		
			exists (select fv_id from #t_fv_DC_CSC_VEN_0216 where fv_id = fv.fv_id)
		
		------------------------------------------------------------------
		union all
		------------------------------------------------------------------

/*- ///////////////////////////////////////////////////////////////////////

DEUDA (VENCIMIENTOS SIN PAGAR) DE FACTURAS, NC Y ND

/////////////////////////////////////////////////////////////////////// */
		
		select 
			fv.fv_id     as comp_id,
			fv.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
		  cli_nombre	 as Cliente,
			fvd_fecha		 as Fecha,
			doc_nombre	 as Documento,
			fv_nrodoc    as NroDoc,
			cpg_nombre   as [Cond. Pago],
			case 
				when fv.doct_id = 7  then    0
				else 												 fvd_importe
			end 				 as Debe,
			case 
				when fv.doct_id = 7  then    fvd_importe
				else 												 0
			end 				 as Haber,
			case 
				when fv.doct_id = 7  then    -fv_totalcomercial
				else 												 +fv_totalcomercial
			end 				 as Saldo,
		  fv_descrip   as Observaciones
		
		from 
			facturaventa fv inner join condicionPago    cpg  on fv.cpg_id   = cpg.cpg_id 
																												and cpg_escontado = 0
		
											inner join cliente       		cli	 on fv.cli_id   = cli.cli_id
		                  inner join documento 				doc  on fv.doc_id   = doc.doc_id
		                  inner join moneda    				mon  on fv.mon_id   = mon.mon_id
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   				emp  on doc.emp_id  = emp.emp_id
		
											inner join facturaVentaDeuda fvd on fv.fv_id    = fvd.fv_id
		
											left join centroCosto 			 ccos on fv.ccos_id = ccos.ccos_id
		           	      left join provincia   			 pro  on cli.pro_id = pro.pro_id
		where 
		
			exists (select fv_id from #t_fv_DC_CSC_VEN_0216 where fv_id = fv.fv_id)
		
		------------------------------------------------------------------
		union all
		------------------------------------------------------------------
		
/*- ///////////////////////////////////////////////////////////////////////

COBROS (VENCIMIENTOS COBRADOS) DE FACTURAS, NC Y ND

/////////////////////////////////////////////////////////////////////// */

		select 
			fv.fv_id     as comp_id,
			fv.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
		  cli_nombre	 as Cliente,
			fvp_fecha		 as Fecha,
			doc_nombre	 as Documento,
			fv_nrodoc    as NroDoc,
			cpg_nombre   as [Cond. Pago],
			case 
				when fv.doct_id = 7  then    0
				else 												 fvp_importe
			end 				 as Debe,
			case 
				when fv.doct_id = 7  then    fvp_importe
				else 												 0
			end 				 as Haber,
			case 
				when fv.doct_id = 7  then    -fvp_importe
				else 												 +fvp_importe
			end 				 as Saldo,
		  fv_descrip   as Observaciones
		
		from 
			facturaventa fv inner join condicionPago    cpg  on fv.cpg_id   = cpg.cpg_id 
																												and cpg_escontado = 0
		
											inner join cliente       		cli	 on fv.cli_id   = cli.cli_id
		                  inner join documento 				doc  on fv.doc_id   = doc.doc_id
		                  inner join moneda    				mon  on fv.mon_id   = mon.mon_id
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   				emp  on doc.emp_id  = emp.emp_id
		
											inner join facturaVentaPago fvp on fv.fv_id    = fvp.fv_id
		
											left join centroCosto 			 ccos on fv.ccos_id = ccos.ccos_id
		           	      left join provincia   			 pro  on cli.pro_id = pro.pro_id
		where 
		
			exists (select fv_id from #t_fv_DC_CSC_VEN_0216 where fv_id = fv.fv_id)

		------------------------------------------------------------------
		union all
		------------------------------------------------------------------

/*- ///////////////////////////////////////////////////////////////////////

REMITOS PENDIENTES

/////////////////////////////////////////////////////////////////////// */
		
		select 
			rv.rv_id     as comp_id,
			rv.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
		  cli_nombre	 as Cliente,
			rv_fecha		 as Fecha,
			doc_nombre	 as Documento,
			rv_nrodoc    as NroDoc,
			cpg_nombre   as [Cond. Pago],
			case 
				when rv.doct_id = 24  then   0
				else 												 rv_pendiente
			end 				 as Debe,
			case 
				when rv.doct_id = 24  then   rv_pendiente
				else 												 0
			end 				 as Haber,
			case 
				when rv.doct_id = 24  then   -rv_pendiente
				else 												 +rv_pendiente
			end 				 as Saldo,
		  rv_descrip   as Observaciones
		
		from 
			remitoventa rv  inner join condicionPago    cpg  on rv.cpg_id   = cpg.cpg_id 
											inner join cliente       		cli	 on rv.cli_id   = cli.cli_id
		                  inner join documento 				doc  on rv.doc_id   = doc.doc_id
		                  inner join moneda    				mon  on doc.mon_id  = mon.mon_id
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   				emp  on doc.emp_id  = emp.emp_id
		
											left join centroCosto 			 ccos on rv.ccos_id = ccos.ccos_id
		           	      left join provincia   			 pro  on cli.pro_id = pro.pro_id
		where 
		
						  rv_fecha >= @@Fini
					and	rv_fecha <= @Ffin 

					and round(rv_pendiente,2)<>0
		
					and rv.est_id <> 7
		
					and (
								exists(select * from EmpresaUsuario where emp_id = doc.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)
					and (
								exists(select * from UsuarioEmpresa where cli_id = rv.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)

		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (cli.pro_id 	= @pro_id 	or @pro_id	=0)
		and   (rv.cli_id 		= @cli_id 	or @cli_id	=0)
		and   (doc.cico_id 	= @cico_id	or @cico_id	=0)
		and   (rv.doc_id 		= @doc_id 	or @doc_id	=0)
		and   (rv.emp_id 		= @emp_id 	or @emp_id	=0)
		and   (doc.mon_id 	= @mon_id 	or @mon_id	=0)
		and   (rv.ccos_id 	= @ccos_id 	or @ccos_id	=0)
		and   (rv.suc_id 		= @suc_id 	or @suc_id	=0)
		
		-- Arboles
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 6    and rptarb_hojaid = cli.pro_id))  or (@ram_id_provincia = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 28   and rptarb_hojaid = rv.cli_id)) 	or (@ram_id_cliente = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1016 and rptarb_hojaid = doc.cico_id)) or (@ram_id_circuitoContable = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 4001 and rptarb_hojaid = rv.doc_id)) 	or (@ram_id_documento = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 12   and rptarb_hojaid = doc.mon_id))  or (@ram_id_moneda = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1018 and rptarb_hojaid = rv.emp_id))   or (@ram_id_empresa = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 21   and rptarb_hojaid = rv.ccos_id))	or (@ram_id_centroCosto = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1007 and rptarb_hojaid = rv.suc_id)) 	or (@ram_id_sucursal = 0))

		------------------------------------------------------------------
		union all
		------------------------------------------------------------------

/*- ///////////////////////////////////////////////////////////////////////

PEDIDOS PENDIENTES

/////////////////////////////////////////////////////////////////////// */
		
		select 
			pv.pv_id     as comp_id,
			pv.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
		  cli_nombre	 as Cliente,
			pv_fecha		 as Fecha,
			doc_nombre	 as Documento,
			pv_nrodoc    as NroDoc,
			cpg_nombre   as [Cond. Pago],
			case 
				when pv.doct_id = 22  then   0
				else 												 pv_pendiente
			end 				 as Debe,
			case 
				when pv.doct_id = 22  then   pv_pendiente
				else 												 0
			end 				 as Haber,
			case 
				when pv.doct_id = 22  then   -pv_pendiente
				else 												 +pv_pendiente
			end 				 as Saldo,
		  pv_descrip   as Observaciones
		
		from 
			pedidoventa pv  inner join condicionPago    cpg  on pv.cpg_id   = cpg.cpg_id 
											inner join cliente       		cli	 on pv.cli_id   = cli.cli_id
		                  inner join documento 				doc  on pv.doc_id   = doc.doc_id
		                  inner join moneda    				mon  on doc.mon_id  = mon.mon_id
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   				emp  on doc.emp_id  = emp.emp_id
		
											left join centroCosto 			 ccos on pv.ccos_id = ccos.ccos_id
		           	      left join provincia   			 pro  on cli.pro_id = pro.pro_id
		where 
		
						  pv_fecha >= @@Fini
					and	pv_fecha <= @Ffin 
		
					and pv.est_id <> 7

					and round(pv_pendiente,2)<>0
		
					and (
								exists(select * from EmpresaUsuario where emp_id = doc.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)
    			and (
								exists(select * from UsuarioEmpresa where cli_id = pv.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)

		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (cli.pro_id 	= @pro_id 	or @pro_id	=0)
		and   (pv.cli_id 		= @cli_id 	or @cli_id	=0)
		and   (doc.cico_id 	= @cico_id	or @cico_id	=0)
		and   (pv.doc_id 		= @doc_id 	or @doc_id	=0)
		and   (pv.emp_id 		= @emp_id 	or @emp_id	=0)
		and   (doc.mon_id 	= @mon_id 	or @mon_id	=0)
		and   (pv.ccos_id 	= @ccos_id 	or @ccos_id	=0)
		and   (pv.suc_id 		= @suc_id 	or @suc_id	=0)
		
		-- Arboles
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 6    and rptarb_hojaid = cli.pro_id))  or (@ram_id_provincia = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 28   and rptarb_hojaid = pv.cli_id)) 	or (@ram_id_cliente = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1016 and rptarb_hojaid = doc.cico_id)) or (@ram_id_circuitoContable = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 4001 and rptarb_hojaid = pv.doc_id)) 	or (@ram_id_documento = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 12   and rptarb_hojaid = doc.mon_id))  or (@ram_id_moneda = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1018 and rptarb_hojaid = pv.emp_id))   or (@ram_id_empresa = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 21   and rptarb_hojaid = pv.ccos_id))	or (@ram_id_centroCosto = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1007 and rptarb_hojaid = pv.suc_id)) 	or (@ram_id_sucursal = 0))

		------------------------------------------------------------------
		union all
		------------------------------------------------------------------
		
/*- ///////////////////////////////////////////////////////////////////////

COBRANZAS

/////////////////////////////////////////////////////////////////////// */

		select 
			cobz_id        as comp_id,
			cobz.doct_id   as doct_id,
			1 					 as orden_id,	
			emp_nombre   as Empresa,
			cli.cli_nombre as Cliente,
			cobz_fecha     as Fecha,
			doc_nombre	   as Documento,
			cobz_nrodoc    as NroDoc,
			null           as [Cond. Pago],
			0							 as Debe,
			cobz_total     as Haber,
			-cobz_total    as Saldo,
		  cobz_descrip   as Observaciones
		
		from
			cobranza cobz inner join cliente cli         on cli.cli_id   = cobz.cli_id
										inner join documento doc  		 on doc.doc_id 	 = cobz.doc_id
		
		                  inner join circuitocontable cico on doc.cico_id = cico.cico_id
		                  inner join empresa   emp         on doc.emp_id  = emp.emp_id
		
											left join centroCosto ccos       on cobz.ccos_id = ccos.ccos_id
		           	      left join provincia   pro        on cli.pro_id   = pro.pro_id		
		where 
		
						  cobz_fecha >= @@Fini
					and	cobz_fecha <= @Ffin 
		
					and cobz.est_id <> 7
		
					and (
								exists(select * from EmpresaUsuario where emp_id = doc.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)
    			and (
								exists(select * from UsuarioEmpresa where cli_id = cobz.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)

		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (cli.pro_id 	= @pro_id 	or @pro_id	=0)
		and   (cobz.cli_id 	= @cli_id 	or @cli_id	=0)
		and   (doc.cico_id 	= @cico_id 	or @cico_id	=0)
		and   (cobz.doc_id 	= @doc_id 	or @doc_id	=0)
		and   (cobz.emp_id 	= @emp_id 	or @emp_id	=0)
		and   (cobz.ccos_id = @ccos_id 	or @ccos_id	=0)
		and   (cobz.suc_id 	= @suc_id 	or @suc_id	=0)
		
		-- Arboles
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 6    and rptarb_hojaid = cli.pro_id))  or (@ram_id_provincia = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 28   and rptarb_hojaid = cobz.cli_id)) or (@ram_id_cliente = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1016 and rptarb_hojaid = doc.cico_id)) or (@ram_id_circuitoContable = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 4001 and rptarb_hojaid = cobz.doc_id)) or (@ram_id_documento = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1018 and rptarb_hojaid = cobz.emp_id)) or (@ram_id_empresa = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 21   and rptarb_hojaid = cobz.ccos_id))or (@ram_id_centroCosto = 0))
		and   ((exists(select rptarb_hojaid from rptArbolRamaHoja where rptarb_cliente = @clienteID and tbl_id = 1007 and rptarb_hojaid = cobz.suc_id)) or (@ram_id_sucursal = 0))
		
		order by cli_nombre, emp_nombre, doct_id, NroDoc

end
go
