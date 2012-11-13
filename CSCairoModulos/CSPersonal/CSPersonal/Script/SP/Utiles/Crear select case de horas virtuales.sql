	set nocount on

	create table #t_horas	( east_id int, 
													east_nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL, 
													east_codigo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL
												)
  
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1000,'01 hora', '1')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1001,'01.5 hora', '1.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1002,'02 hs', '2')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1003,'02.5 hs', '2.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1004,'03 hs', '3')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1005,'03.5 hs', '3.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1006,'04 hs', '4')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1007,'04.5 hs', '4.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1008,'05 hs', '5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1009,'05.5 hs', '5.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1010,'06 hs', '6')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1011,'06.5 hs', '6.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1012,'07 hs', '7')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1013,'07.5 hs', '7.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1014,'08 hs', '8')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1015,'08.5 hs', '8.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1016,'09 hs', '9')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1017,'09.5 hs', '9.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1018,'10 hs', '10')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1019,'10.5 hs', '10.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1020,'11 hs', '11')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1021,'11.5 hs', '11.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1022,'12 hs', '12')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1023,'12.5 hs', '12.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1024,'13 hs', '13')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1025,'13.5 hs', '13.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1026,'14 hs', '14')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1027,'14.5 hs', '14.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1028,'15 hs', '15')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1029,'15.5 hs', '15.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1030,'16 hs', '16')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1031,'16.5 hs', '16.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1032,'17 hs', '17')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1033,'17.5 hs', '17.5')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1034,'18 hs', '18')
	insert into #t_horas (east_id, east_nombre, east_codigo)
								values (-1035,'18.5 hs', '18.5')

	select 'case ' + convert(varchar,east_id) + char(13)+char(10) + '  rtn=' + east_codigo from #t_horas

	drop table #t_horas