if exists (select * from sysobjects where id = object_id(N'[dbo].[sp_DocRemitoVentasSetPendiente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DocRemitoVentasSetPendiente]

/*

 sp_DocRemitoVentasSetPendiente 

*/

go
create procedure sp_DocRemitoVentasSetPendiente (
	@@desde       datetime = '19900101',
	@@hasta       datetime = '21000101'
)
as

begin

	declare @rv_id int

	declare c_Ventas insensitive cursor for 
		select rv_id from RemitoVenta where rv_fecha between @@desde and @@hasta

	open c_Ventas

	fetch next from c_Ventas into @rv_id
	while @@fetch_status = 0 begin

		exec sp_DocRemitoVentaSetItemPendiente @rv_id
		exec sp_DocRemitoVentaSetPendiente @rv_id

		fetch next from c_Ventas into @rv_id
  end

	close c_Ventas
	deallocate c_Ventas
end