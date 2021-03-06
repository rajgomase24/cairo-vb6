if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ProyectoDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ProyectoDelete]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
select * from proyecto
select * from prestacion where pre_id > 16000000
*/

create procedure sp_ProyectoDelete (
  @@proy_id          int
)
as
begin

  begin transaction

  declare @pre_id_listTarea     int
  declare @pre_id_editTarea      int
  declare @pre_id_delTarea      int
  declare @pre_id_addTarea      int
  declare @pre_id_listTareaP    int
  declare @pre_id_editTareaP    int
  declare @pre_id_delTareaP      int
  declare @pre_id_listTareaD    int
  declare @pre_id_editTareaD    int
  declare @pre_id_delTareaD      int
  declare @pre_id_listHoraD      int
  declare @pre_id_listHora      int
  declare @pre_id_editHoraP      int
  declare @pre_id_delHoraP      int
  declare @pre_id_editHora      int
  declare @pre_id_delHora        int
  declare @pre_id_addHora        int
  declare @pre_id_tomarTarea    int
  declare @pre_id_asignarTarea  int
  declare @pre_id_aprobarTarea  int

  select 
          @pre_id_listTarea        = pre_id_listTarea,
          @pre_id_editTarea        = pre_id_editTarea,
          @pre_id_delTarea        = pre_id_delTarea,
          @pre_id_addTarea        = pre_id_addTarea,
          @pre_id_editTareaP      = pre_id_editTareaP,
          @pre_id_delTareaP        = pre_id_delTareaP,
          @pre_id_listTareaD      = pre_id_listTareaD,
          @pre_id_editTareaD      = pre_id_editTareaD,
          @pre_id_delTareaD        = pre_id_delTareaD,
          @pre_id_listHoraD        = pre_id_listHoraD,
          @pre_id_listHora        = pre_id_listHora,
          @pre_id_editHora        = pre_id_editHora,
          @pre_id_editHoraP        = pre_id_editHoraP,
          @pre_id_delHoraP        = pre_id_delHoraP,
          @pre_id_delHora          = pre_id_delHora,
          @pre_id_addHora          = pre_id_addHora,
          @pre_id_tomarTarea      = pre_id_tomarTarea,
          @pre_id_asignarTarea    = pre_id_asignarTarea,
          @pre_id_aprobarTarea    = pre_id_aprobarTarea


  from Proyecto where proy_id = @@proy_id

------------------------------------------------------------------------

  if @pre_id_listTarea is not null begin

    delete permiso where pre_id = @pre_id_listTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_listTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_listTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_editTarea is not null begin

    delete permiso where pre_id = @pre_id_editTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_editTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_editTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_delTarea is not null begin

    delete permiso where pre_id = @pre_id_delTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_delTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_delTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_addTarea is not null begin

    delete permiso where pre_id = @pre_id_addTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_addTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_addTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_editTareaP is not null begin

    delete permiso where pre_id = @pre_id_editTareaP
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_editTareaP = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_editTareaP
    if @@error <> 0 goto ControlError
  end

  if @pre_id_delTareaP is not null begin

    delete permiso where pre_id = @pre_id_delTareaP
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_delTareaP = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_delTareaP
    if @@error <> 0 goto ControlError
  end

  if @pre_id_listTareaD is not null begin

    delete permiso where pre_id = @pre_id_listTareaD
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_listTareaD = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_listTareaD
    if @@error <> 0 goto ControlError
  end

  if @pre_id_editTareaD is not null begin

    delete permiso where pre_id = @pre_id_editTareaD
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_editTareaD = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_editTareaD
    if @@error <> 0 goto ControlError
  end

  if @pre_id_delTareaD is not null begin

    delete permiso where pre_id = @pre_id_delTareaD
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_delTareaD = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_delTareaD
    if @@error <> 0 goto ControlError
  end

  if @pre_id_listHoraD is not null begin

    delete permiso where pre_id = @pre_id_listHoraD
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_listHoraD = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_listHoraD
    if @@error <> 0 goto ControlError
  end

  if @pre_id_listHora is not null begin

    delete permiso where pre_id = @pre_id_listHora
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_listHora = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_listHora
    if @@error <> 0 goto ControlError
  end

  if @pre_id_editHora is not null begin

    delete permiso where pre_id = @pre_id_editHora
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_editHora = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_editHora
    if @@error <> 0 goto ControlError
  end

  if @pre_id_editHoraP is not null begin

    delete permiso where pre_id = @pre_id_editHoraP
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_editHoraP = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_editHoraP
    if @@error <> 0 goto ControlError
  end

  if @pre_id_delHoraP is not null begin

    delete permiso where pre_id = @pre_id_delHoraP
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_delHoraP = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_delHoraP
    if @@error <> 0 goto ControlError
  end

  if @pre_id_delHora is not null begin

    delete permiso where pre_id = @pre_id_delHora
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_delHora = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_delHora
    if @@error <> 0 goto ControlError
  end

  if @pre_id_addHora is not null begin

    delete permiso where pre_id = @pre_id_addHora
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_addHora = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_addHora
    if @@error <> 0 goto ControlError
  end

  if @pre_id_tomarTarea is not null begin

    delete permiso where pre_id = @pre_id_tomarTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_tomarTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_tomarTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_asignarTarea is not null begin

    delete permiso where pre_id = @pre_id_asignarTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_asignarTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_asignarTarea
    if @@error <> 0 goto ControlError
  end

  if @pre_id_aprobarTarea is not null begin

    delete permiso where pre_id = @pre_id_aprobarTarea
    if @@error <> 0 goto ControlError

    update Proyecto set pre_id_aprobarTarea = null where proy_id = @@proy_id
  
    delete Prestacion where pre_id = @pre_id_aprobarTarea
    if @@error <> 0 goto ControlError
  end

--------------------------------------------------------------------------

  delete ProyectoItem where proy_id = @@proy_id
  if @@error <> 0 goto ControlError

  delete Objetivo where proy_id = @@proy_id
  if @@error <> 0 goto ControlError

  delete Proyecto where proy_id = @@proy_id
  if @@error <> 0 goto ControlError

  commit transaction

  return
ControlError:

  raiserror ('Ha ocurrido un error al borrar el proyecto. sp_ProyectoDelete.', 16, 1)
  rollback transaction

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

