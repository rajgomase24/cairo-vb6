if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_hlpw_usuario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_hlpw_usuario]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*

        select us_id,
               us_nombre   as Nombre
        from Usuario 
  
        where (exists (select * from EmpresaUsuario where us_id = Usuario.us_id) or 1 = 1)

  select * from usuario where us_nombre = 'mamoros'
  select count(*) from persona

 sp_hlpw_usuario 557,1,'d'

,-1,1

sp_hlpw_usuario 1,1


*/

create procedure sp_hlpw_usuario (
  @@us_id           int,
  @@emp_id          int,
  @@filter           varchar(255)  = '',
  @@check            smallint       = 0
)
as
begin
  set nocount on

  if @@check <> 0 begin
  
    select   us_id,
            us_nombre        as [Nombre]

    from usuario 

    where (us_nombre = @@filter)
      and activo <> 0
--      and (exists (select * from EmpresaUsuario where us_id = Usuario.us_id and emp_id = @@emp_id))
        and (exists (select * from UsuarioDepartamento 
                    where  (
                            us_id in (
                                    select us_id from UsuarioDepartamento 
                                    where dpto_id in (
                                                      select dpto_id from Departamento 
                                                      where pre_id_asignartareas in (
                                                                                    select pre_id 
                                                                                    from permiso 
                                                                                    where us_id = @@us_id 
                                                                                      or rol_id in (
                                                                                                    select rol_id 
                                                                                                    from usuariorol 
                                                                                                    where us_id = @@us_id
                                                                                                  )
                                                                                    )
                                                    )
                                  )
                              or us_id = @@us_id
                              )
                         and  us_id = Usuario.us_id

                  ) 
                  or @@us_id = 1)

  end else begin


      select top 50
             us_id,
             us_nombre   as Nombre,
             IsNull(prs_apellido + ', ' + prs_nombre,' ') as Persona

      from usuario left join persona on usuario.prs_id = persona.prs_id

      where (
                us_nombre like '%'+@@filter+'%' 
             or prs_apellido like '%'+@@filter+'%' 
             or prs_nombre like '%'+@@filter+'%'
             or @@filter = '' 
            )
        and usuario.activo <> 0
--        and (exists (select emp_id from EmpresaUsuario where us_id = Usuario.us_id and emp_id = @@emp_id))
        and (
                us_id = @@us_id
             or @@us_id = 1
             or 
                -- Todos los usuarios que pertenecen a departamentos 
                -- sobre los que tiene permiso de asignar tarea
                --
                exists (select us_id from UsuarioDepartamento ud
                        where  (
                               exists (
                                        select us_id from UsuarioDepartamento 
                                        where us_id = ud.us_id
                                          and exists (
                                                      -- Busco la prestacion asignar tareas
                                                      --
                                                      select dpto_id from Departamento 
                                                      where dpto_id = UsuarioDepartamento.dpto_id
                                                        and exists (
                                                                    -- Busco el permiso
                                                                    --
                                                                    select pre_id 
                                                                    from permiso 
                                                                    where pre_id = pre_id_asignartareas
                                                                      and (
                                                                               us_id = @@us_id 
                                                                            or exists (
                                                                                        -- Puede ser un rol
                                                                                        --
                                                                                        select rol_id 
                                                                                        from usuariorol 
                                                                                        where us_id = @@us_id
                                                                                          and rol_id = permiso.rol_id
                                                                                      )
                                                                          )
                                                                    )
                                                      )
                                      )
                                )
                             -- Es el usuario que estoy mostrando
                             -- en el select
                             --
                             and  us_id = Usuario.us_id
                        ) 
            )
  end    

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

