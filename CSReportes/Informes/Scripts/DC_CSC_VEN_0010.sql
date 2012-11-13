/*---------------------------------------------------------------------
Nombre: Facturas a Pagar
---------------------------------------------------------------------*/

/*
Para testear:

DC_CSC_VEN_0010 
										1,
										'20000301',
										'20150331',
										'0',
										'0',
										'0',
										0,
                    '0',
										'0'
*/
if exists (select * from sysobjects where id = object_id(N'[dbo].[DC_CSC_VEN_0010]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DC_CSC_VEN_0010]

go
create procedure DC_CSC_VEN_0010 (

  @@us_id    int,
	@@Fini 		 datetime,
	@@Ffin 		 datetime,

	@@cli_id  			varchar(255),
	@@suc_id   			varchar(255),
	@@cico_id				varchar(255),
	@@cue_id	 			varchar(255), 
	@@soloDeudores  smallint,
	@@emp_id   			varchar(255),
	@@bSoloSaldos 	smallint = 0
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

declare @cli_id  int
declare @suc_id  int
declare @cico_id int
declare @cue_id  int
declare @emp_id  int 

declare @ram_id_Cliente 	int
declare @ram_id_Sucursal  int
declare @ram_id_circuitoContable 	int
declare @ram_id_Cuenta 		int
declare @ram_id_Empresa   int 

declare @clienteID int
declare @IsRaiz    tinyint

exec sp_ArbConvertId @@cli_id, @cli_id out, @ram_id_Cliente 	out
exec sp_ArbConvertId @@suc_id, @suc_id out, @ram_id_Sucursal 	out
exec sp_ArbConvertId @@cico_id, @cico_id out, @ram_id_circuitoContable out
exec sp_ArbConvertId @@cue_id, @cue_id out, @ram_id_Cuenta 		out
exec sp_ArbConvertId @@emp_id, @emp_id out, @ram_id_Empresa 	out 

exec sp_GetRptId @clienteID out

if @ram_id_Cliente <> 0 begin

--	exec sp_ArbGetGroups @ram_id_Cliente, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_Cliente, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_Cliente, @clienteID 
	end else 
		set @ram_id_Cliente = 0
end

if @ram_id_Sucursal <> 0 begin

--	exec sp_ArbGetGroups @ram_id_Sucursal, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_Sucursal, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_Sucursal, @clienteID 
	end else 
		set @ram_id_Sucursal = 0
end

if @ram_id_Cuenta <> 0 begin

--	exec sp_ArbGetGroups @ram_id_Cuenta, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_Cuenta, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_Cuenta, @clienteID 
	end else 
		set @ram_id_Cuenta = 0
end

if @ram_id_circuitoContable <> 0 begin

--	exec sp_ArbGetGroups @ram_id_circuitoContable, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_circuitoContable, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_circuitoContable, @clienteID 
	end else 
		set @ram_id_circuitoContable = 0
end

if @ram_id_Empresa <> 0 begin

--	exec sp_ArbGetGroups @ram_id_Empresa, @clienteID, @@us_id

	exec sp_ArbIsRaiz @ram_id_Empresa, @IsRaiz out
  if @IsRaiz = 0 begin
		exec sp_ArbGetAllHojas @ram_id_Empresa, @clienteID 
	end else 
		set @ram_id_Empresa = 0
end
/*- ///////////////////////////////////////////////////////////////////////

FIN PRIMERA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

declare @cta_deudor     tinyint set @cta_deudor     = 1
declare @cta_deudorcobz tinyint set @cta_deudorcobz = 5

--/////////////////////////////////////////////////////////////////////////
--
--	Saldos Iniciales
--
--/////////////////////////////////////////////////////////////////////////

create table #dc_csc_ven_0010 (

	cli_id			int not null,
  cue_id      int null,
  emp_id      int not null,
  suc_id      int not null,
	neto        decimal(18,6) not null default(0),
	descuento   decimal(18,6) not null default(0),
  subtotal    decimal(18,6) not null default(0),
  iva   			decimal(18,6) not null default(0),
	total       decimal(18,6) not null,
  pendiente   decimal(18,6) not null
)
--/////////////////////////////////////////////////////////////////////////


--//////////////////////////////////////////
-- Cobranzas
--//////////////////////////////////////////

insert into #dc_csc_ven_0010 (cli_id,cue_id,emp_id,suc_id,total,pendiente)

select 

				cli_id,
				null,
        cobz.emp_id,
        suc_id,
				-cobz_total,
				-(cobz_total - isnull((select sum(fvcobz_importe) 
		                           from FacturaVentaCobranza fvcobz inner join FacturaVenta fv
															  																  on fvcobz.fv_id = fv.fv_id			
		                           where fvcobz.cobz_id = cobz.cobz_id
															   and fv.fv_fecha <= @@Fini
		                          ),0))

from 

	Cobranza cobz inner join Documento doc on cobz.doc_id = doc.doc_id

where 
				  cobz_fecha < @@Fini  

			and cobz.est_id <> 7


			and ( 		(cobz_total - isnull((select sum(fvcobz_importe) 
						                           from FacturaVentaCobranza fvcobz inner join FacturaVenta fv
																			  																  on fvcobz.fv_id = fv.fv_id			
						                           where fvcobz.cobz_id = cobz.cobz_id
																			   and fv.fv_fecha <= @@Fini
						                          ),0)<>0
								)
						or 
								@@soloDeudores = 0
					)

			and (
						exists(select * from EmpresaUsuario where emp_id = cobz.emp_id and us_id = @@us_id) or (@@us_id = 1)
					)

			and (
						exists(select * from UsuarioEmpresa where cli_id = cobz.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
					)

/* -///////////////////////////////////////////////////////////////////////

INICIO SEGUNDA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

and   (cobz.cli_id  = @cli_id  or @cli_id =0)
and   (doc.cico_id  = @cico_id or @cico_id=0)
and   (cobz.suc_id  = @suc_id  or @suc_id =0)

and   (exists(
							select * from CobranzaItem where cobz_id 			= cobz.cobz_id 
																						and cobzi_tipo 	= @cta_deudorcobz
																						and cue_id 			= @cue_id   
							)
				or @cue_id  =0
			)

and   (cobz.emp_id   = @emp_id   or @emp_id  =0) 

-- Arboles
and   (
					(exists(select rptarb_hojaid 
                  from rptArbolRamaHoja 
                  where
                       rptarb_cliente = @clienteID
                  and  tbl_id = 28 
                  and  rptarb_hojaid = cobz.cli_id
							   ) 
           )
        or 
					 (@ram_id_Cliente = 0)
			 )

and   (
					(exists(select rptarb_hojaid 
                  from rptArbolRamaHoja 
                  where
                       rptarb_cliente = @clienteID
                  and  tbl_id = 1007  
                  and  rptarb_hojaid = cobz.suc_id
							   ) 
           )
        or 
					 (@ram_id_Sucursal = 0)
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
                  and  tbl_id = 17 
                  and  (
												exists(
															select * from CobranzaItem where cobz_id 			= cobz.cobz_id 
																														and cobzi_tipo 	= @cta_deudorcobz
																														and cue_id 			= rptarb_hojaid   
															)
							   				) 
									)
           )
        or 
					 (@ram_id_Cuenta = 0)
			 )

and   (
					(exists(select rptarb_hojaid 
                  from rptArbolRamaHoja 
                  where
                       rptarb_cliente = @clienteID
                  and  tbl_id = 1018
                  and  rptarb_hojaid = cobz.emp_id
							   ) 
           )
        or 
					 (@ram_id_Empresa = 0)
			 )

--//////////////////////////////////////////
-- Facturas y Notas de Credito
--//////////////////////////////////////////

insert into #dc_csc_ven_0010 (cli_id,cue_id,emp_id,suc_id,neto,descuento,subtotal,iva,total,pendiente)

select 

				cli_id,
				cue_id,
        fv.emp_id,
        suc_id,
				
				case fv.doct_id 
					when 7 then 	- fv_neto
					else   			 	  fv_neto
				end
			       				 as [Neto],

				case fv.doct_id 
					when 7 then			- (isnull(fv_importedesc1,0) 
												   + isnull(fv_importedesc2,0)
                          )
					else             isnull(fv_importedesc1,0) 
												   + isnull(fv_importedesc2,0)
				end                
											 as [Descuento],
		
        case fv.doct_id 
					when 7	then   - fv_subtotal   
					else             fv_subtotal
				end			
				 							 as [Sub Total],
		
        case fv.doct_id 
					when 7	then   - (isnull(fv_ivari,0)
												  + isnull(fv_ivarni,0) 
													)
					else              isnull(fv_ivari,0)
												  + isnull(fv_ivarni,0) 
				end
											 as [Iva],
		
        case fv.doct_id 
					when 7	then	 - fv_totalcomercial
					else						 fv_totalcomercial
				end
											 as [Total],
		
        case fv.doct_id 
					when 7	then	 - (fv_totalcomercial - IsNull((select sum(fvnc_importe) 
											                         from FacturaVentaNotaCredito fvnc inner join FacturaVenta fv2
																																							   on fvnc.fv_id_factura = fv2.fv_id			
											                         where fvnc.fv_id_notacredito = fv.fv_id
																							   and fv2.fv_fecha <= @@Fini
											                        ),0)
														)
					else						 (fv_totalcomercial - IsNull((select sum(fvnc_importe) 
			                               from FacturaVentaNotaCredito fvnc inner join FacturaVenta nc
																																		   on fvnc.fv_id_notacredito = nc.fv_id			
			                               where fvnc.fv_id_factura = fv.fv_id
																		   and nc.fv_fecha <= @@Fini
			                               ),0)
													 - IsNull((select sum(fvcobz_importe) 
				                             from FacturaVentaCobranza fvcobz inner join Cobranza cobz
																			 																  on fvcobz.cobz_id = cobz.cobz_id			
				                             where fvcobz.fv_id = fv.fv_id
																		   and cobz.cobz_fecha <= @@Fini
				                             ),0))
				end
			 							 	 as [Pendiente]

from 

	FacturaVenta fv inner join Documento doc                          on fv.doc_id    = doc.doc_id
                  left  join AsientoItem ai                         on fv.as_id     = ai.as_id and asi_tipo = @cta_deudor
									
where 
				  fv_fecha < @@Fini  

			and fv.est_id <> 7

			and (
							((
								case fv.doct_id 
									when 7	then	 - (fv_totalcomercial - IsNull((select sum(fvnc_importe) 
															                         from FacturaVentaNotaCredito fvnc inner join FacturaVenta fv2
																																											   on fvnc.fv_id_factura = fv2.fv_id			
															                         where fvnc.fv_id_notacredito = fv.fv_id
																											   and fv2.fv_fecha <= @@Fini
															                        ),0)
																		)
									else						 (fv_totalcomercial - IsNull((select sum(fvnc_importe) 
							                               from FacturaVentaNotaCredito fvnc inner join FacturaVenta nc
																																						   on fvnc.fv_id_notacredito = nc.fv_id			
							                               where fvnc.fv_id_factura = fv.fv_id
																						   and nc.fv_fecha <= @@Fini
							                               ),0)
																	 - IsNull((select sum(fvcobz_importe) 
								                             from FacturaVentaCobranza fvcobz inner join Cobranza cobz
																							 																  on fvcobz.cobz_id = cobz.cobz_id			
								                             where fvcobz.fv_id = fv.fv_id
																						   and cobz.cobz_fecha <= @@Fini
								                             ),0))
								end
							)<>0)

					 or @@soloDeudores = 0
					)

			and (
						exists(select * from EmpresaUsuario where emp_id = fv.emp_id and us_id = @@us_id) or (@@us_id = 1)
					)

			and (
						exists(select * from UsuarioEmpresa where cli_id = fv.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
					)
/* -///////////////////////////////////////////////////////////////////////

INICIO SEGUNDA PARTE DE ARBOLES

/////////////////////////////////////////////////////////////////////// */

and   (fv.cli_id 		= @cli_id 	or @cli_id	=0)
and   (fv.suc_id 		= @suc_id 	or @suc_id	=0)
and   (doc.cico_id  = @cico_id  or @cico_id =0)
and   (ai.cue_id 		= @cue_id 	or @cue_id	=0)
and   (fv.emp_id 		= @emp_id 	or @emp_id	=0) 

-- Arboles
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
					 (@ram_id_Cliente = 0)
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
					 (@ram_id_Sucursal = 0)
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
                  and  tbl_id = 17 
                  and  rptarb_hojaid = ai.cue_id
							   ) 
           )
        or 
					 (@ram_id_Cuenta = 0)
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
					 (@ram_id_Empresa = 0)
			 )

--/////////////////////////////////////////////////////////////////////////

	--/////////////////////////////////////////////////////////////////////////
	-- Solo Saldos
	--/////////////////////////////////////////////////////////////////////////
	if @@bSoloSaldos <> 0 begin

		--/////////////////////////////////////
		-- Saldos iniciales
		--/////////////////////////////////////
		select 		
		        1                  as grp_total,
						@@Fini             as [Fecha],
		        emp_nombre         as [Empresa], 
						cli_nombre         as [Cliente],
						cue_nombre         as [Cuenta],
		        suc_nombre         as [Sucursal],
					  sum(neto)  				 as [Neto],
						sum(descuento)		 as [Descuento],
						sum(subtotal)  		 as [Sub Total],
						sum(iva)					 as [Iva],
						sum(total)				 as [Total],
						sum(pendiente)		 as [Pendiente],
						sum(pendiente)		 as [Vto. Pendiente]
		
		from 
		
			#dc_csc_ven_0010 fv 
											inner join Cliente cli  												on fv.cli_id 	= cli.cli_id
		                  inner join Cuenta cue                           on fv.cue_id  = cue.cue_id
		                  inner join Empresa emp                          on fv.emp_id  = emp.emp_id 
		                  inner join Sucursal suc                         on fv.suc_id  = suc.suc_id
		group by 
		
						fv.cli_id,
						cli_nombre,
		        emp_nombre,
						cue_nombre,
		        suc_nombre

		order by
						cli_nombre,
		        emp_nombre,
						cue_nombre,
		        suc_nombre

	--/////////////////////////////////////////////////////////////////////////
	-- Saldo y Periodo
	--/////////////////////////////////////////////////////////////////////////
	end else begin

		--/////////////////////////////////////////////////////////////////////////
		--
		--	Facturas, Notas de Credio/Debito y Cobranzas en el Periodo
		--
		--/////////////////////////////////////////////////////////////////////////

		
		--/////////////////////////////////////
		-- Saldos iniciales
		--/////////////////////////////////////
		select 
		
		        1                  as grp_total,
						0       					 as comp_id,
			      0                  as nOrden_id,
						@@Fini             as [Fecha],
						''                 as [Numero],
						'Saldo inicial'    as [Comprobante],
						cli_nombre         as [Cliente],
		
					  sum(neto)  				 as [Neto],
						sum(descuento)		 as [Descuento],
						sum(subtotal)  		 as [Sub Total],
						sum(iva)					 as [Iva],
						sum(total)				 as [Total],
						sum(pendiente)		 as [Pendiente],
		
						''                 as [Moneda],
						''                 as [Estado],
						cue_nombre         as [Cuenta],
		        ''                 as [Documento],
		        emp_nombre         as [Empresa], 
		        suc_nombre         as [Sucursal],
						cli_contacto       as [Contacto],
		        ''                 as [Vendedor],
		        ''                 as [Cond. Pago],
		        ''                 as [Legajo],
		        ''                 as [Centro de Costo],
						''                 as [Vto.],
						0                  as [Vto. Importe],
						sum(pendiente)		 as [Vto. Pendiente],
						''                 as [Observaciones]
		
		from 
		
			#dc_csc_ven_0010 fv 
											inner join Cliente cli 												  on fv.cli_id 	= cli.cli_id
		                  inner join Cuenta cue                             on fv.cue_id  = cue.cue_id
		                  inner join Empresa emp                            on fv.emp_id  = emp.emp_id 
		                  inner join Sucursal suc                           on fv.suc_id  = suc.suc_id
		group by 
		
						fv.cli_id,
						cli_nombre,
						cue_nombre,
		        suc_nombre,
		        emp_nombre,
						cli_contacto       

		union all
		
		--/////////////////////////////////////
		--	Facturas, Notas de Credio/Debito
		--/////////////////////////////////////
		
		select 
		        1                  as grp_total,
						fv.fv_id					 as comp_id,
		        1                  as nOrden_id,
						fv_fecha           as [Fecha],
						fv_numero          as [Numero],
						fv_nrodoc          as [Comprobante],
						cli_nombre        as [Cliente],
		
						case fv.doct_id 
							when 7 then -fv_neto            
							else				 fv_neto
						end 							 as [Neto],
		
						case fv.doct_id 
							when 7 then -(	fv_importedesc1 
														+ fv_importedesc2  
														)
							else						fv_importedesc1 
														+ fv_importedesc2
						end				 as [Descuento],
		
						case fv.doct_id 
							when 7 then		-fv_subtotal        
							else           fv_subtotal
						end 			 as [Sub Total],
		
						case fv.doct_id 
							when 7 then	- (fv_ivari + fv_ivarni)
							else           fv_ivari + fv_ivarni 
						end 			 as [Iva],
		
						case fv.doct_id 
							when 7 then	-	fv_totalcomercial           
							else          fv_totalcomercial
						end 			 as [Total],
		
						case fv.doct_id 
							when 7 then - fv_pendiente       
							else          fv_pendiente
						end        as [Pendiente],
		
						mon_nombre         as [Moneda],
						est_nombre         as [Estado],
						cue_nombre         as [Cuenta],
		        doc_nombre         as [Documento],
		        emp_nombre         as Empresa, 
		        suc_nombre         as [Sucursal],
						cli_contacto       as [Contacto],
		        ven_nombre         as [Vendedor],
		        cpg_nombre         as [Cond. Pago],
		        case when lgj_titulo <> '' then lgj_titulo else lgj_codigo end as [Legajo],
		        ccos_nombre        as [Centro de Costo],
		        case 
								when fvd_fecha is not null then fvd_fecha
		            else                            fvp_fecha
		        end                as [Vto.],
		
						case fv.doct_id 
							when 7 then	- (IsNull(fvd_importe,fvp_importe))
							else           IsNull(fvd_importe,fvp_importe)
						end								 as [Vto. Importe],
		
						case fv.doct_id 
							when 7 then	- (IsNull(fvd_pendiente,0))
							else					 IsNull(fvd_pendiente,0)
		        end                as [Vto. Pendiente],
		            
						fv_descrip         as [Observaciones]
		
		from 
		
			FacturaVenta fv  inner join Cliente cli 												  on fv.cli_id 	  = cli.cli_id
		                   left  join FacturaVentaDeuda fvd 								on fv.fv_id  		= fvd.fv_id
		                   left  join FacturaVentaPago fvp 								  on fv.fv_id  		= fvp.fv_id
		                   inner join AsientoItem ai                        on fv.as_id     = ai.as_id and asi_tipo = @cta_deudor
		                   inner join Cuenta cue                            on ai.cue_id    = cue.cue_id
		                   inner join Moneda mon                            on fv.mon_id    = mon.mon_id
		                   inner join Estado est                            on fv.est_id    = est.est_id
		                   inner join Documento doc                         on fv.doc_id    = doc.doc_id
		                   inner join Empresa emp                           on doc.emp_id   = emp.emp_id 
		                   inner join Sucursal suc                          on fv.suc_id    = suc.suc_id
		                   left  join Legajo lgj                            on fv.lgj_id    = lgj.lgj_id
		                   inner join CondicionPago cpg                     on fv.cpg_id    = cpg.cpg_id
		                   left  join CentroCosto ccos                      on fv.ccos_id   = ccos.ccos_id
		                   left  join Vendedor ven                          on fv.ven_id    = ven.ven_id
		where 
		
						  @@Fini <= fv_fecha
					and	@@Ffin >= fv_fecha 		
		
					and fv.est_id <> 7

					and (round(fv_pendiente,2)<>0 or @@soloDeudores = 0)
		
					and (
								exists(select * from EmpresaUsuario where emp_id = doc.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)

					and (
								exists(select * from UsuarioEmpresa where cli_id = fv.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)
		
		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (fv.cli_id  	= @cli_id 	or @cli_id	=0)
		and   (fv.suc_id  	= @suc_id  	or @suc_id 	=0)
		and   (doc.cico_id  = @cico_id  or @cico_id =0)
		and   (ai.cue_id  	= @cue_id  	or @cue_id 	=0)
		and   (fv.emp_id  	= @emp_id  	or @emp_id 	=0) 
		
		-- Arboles
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
							 (@ram_id_Cliente = 0)
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
							 (@ram_id_Sucursal = 0)
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
		                  and  tbl_id = 17 
		                  and  rptarb_hojaid = ai.cue_id
									   ) 
		           )
		        or 
							 (@ram_id_Cuenta = 0)
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
							 (@ram_id_Empresa = 0)
					 )
		
		--/////////////////////////////////////
		--	Cobranzas
		--/////////////////////////////////////
		
		union all
		
		select 
		        1                  as grp_total,
						cobz.cobz_id			 as comp_id,
		        1                  as nOrden_id,
						cobz_fecha         as [Fecha],
						cobz_numero        as [Numero],
						cobz_nrodoc        as [Comprobante],
						cli_nombre         as [Cliente],
						0 							   as [Neto],
						0         				 as [Descuento],
						0 			 					 as [Sub Total],
		 			  0                  as [Iva],
						-	cobz_total     	 as [Total],
						-cobz_pendiente    as [Pendiente],
		
						''                 as [Moneda],
						est_nombre         as [Estado],
						''                 as [Cuenta],
		        doc_nombre         as [Documento],
		        emp_nombre         as Empresa, 
		        suc_nombre         as [Sucursal],
						cli_contacto       as [Contacto],
		        ''                 as [Vendedor],
		        ''                 as [Cond. Pago],
		        case when lgj_titulo <> '' then lgj_titulo else lgj_codigo end as [Legajo],
		        ccos_nombre        as [Centro de Costo],
						cobz_fecha         as [Vto.],
						-cobz_total				 as [Vto. Importe],
		        -cobz_pendiente    as [Vto. Pendiente],
		            
						cobz_descrip       as [Observaciones]
		
		from 
		
			Cobranza cobz    inner join Cliente cli 													on cobz.cli_id 	= cli.cli_id
		                   inner join Estado est                            on cobz.est_id   = est.est_id
		                   inner join Documento doc                         on cobz.doc_id   = doc.doc_id
		                   inner join Empresa emp                           on cobz.emp_id   = emp.emp_id 
		                   inner join Sucursal suc                          on cobz.suc_id   = suc.suc_id
		                   left  join Legajo lgj                            on cobz.lgj_id   = lgj.lgj_id
		                   left  join CentroCosto ccos                      on cobz.ccos_id  = ccos.ccos_id
		where 
		
						  @@Fini <= cobz_fecha
					and	@@Ffin >= cobz_fecha 		
		
					and cobz.est_id <> 7

					and (round(cobz_pendiente,2)<>0 or @@soloDeudores = 0)
		
					and (
								exists(select * from EmpresaUsuario where emp_id = cobz.emp_id and us_id = @@us_id) or (@@us_id = 1)
							)
		
					and (
								exists(select * from UsuarioEmpresa where cli_id = cobz.cli_id and us_id = @@us_id) or (@us_empresaEx = 0)
							)
		/* -///////////////////////////////////////////////////////////////////////
		
		INICIO SEGUNDA PARTE DE ARBOLES
		
		/////////////////////////////////////////////////////////////////////// */
		
		and   (cobz.cli_id 	= @cli_id 	or @cli_id	=0)
		and   (doc.cico_id  = @cico_id  or @cico_id =0)
		and   (cobz.suc_id 	= @suc_id 	or @suc_id	=0)
		and   (exists(
									select * from CobranzaItem where  cobz_id 		= cobz.cobz_id 
																								and cobzi_tipo 	= @cta_deudorcobz
																								and cue_id      = @cue_id   
									)
						or @cue_id  =0
					)
		and   (cobz.emp_id 	= @emp_id 	or @emp_id	=0) 
		
		-- Arboles
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 28 
		                  and  rptarb_hojaid = cobz.cli_id
									   ) 
		           )
		        or 
							 (@ram_id_Cliente = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1007 
		                  and  rptarb_hojaid = cobz.suc_id
									   ) 
		           )
		        or 
							 (@ram_id_Sucursal = 0)
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
		                  and  tbl_id = 17 
		                  and  (
														exists(
																	select * from CobranzaItem where cobz_id 			= cobz.cobz_id 
																																and cobzi_tipo 	= @cta_deudorcobz
																																and cue_id      = rptarb_hojaid   
																	)
									   				) 
									   ) 
		           )
		        or 
							 (@ram_id_Cuenta = 0)
					 )
		
		and   (
							(exists(select rptarb_hojaid 
		                  from rptArbolRamaHoja 
		                  where
		                       rptarb_cliente = @clienteID
		                  and  tbl_id = 1018 
		                  and  rptarb_hojaid = cobz.emp_id
									   ) 
		           )
		        or 
							 (@ram_id_Empresa = 0)
					 )
		
			order by Cliente, Cuenta, Fecha, nOrden_id
	
	end

end

go