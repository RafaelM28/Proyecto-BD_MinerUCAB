create or replace view total_proyectos_por_estatus
as
	Select count(*), e.estatus_ejecucion_nombre
	From Estatus_Ejecucion e right join Historico_Estatus_Proyecto h 
		 on h.fk_estatus_ejecucion = e.estatus_ejecucion_codigo left join Proyecto_Ejecucion pe
		 on h.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	Group by e.estatus_ejecucion_nombre;
	
create or replace view total_empleados_recursos_por_proyecto
as
	Select pe.proyecto_ejec_nombre, SUM(er.ejecucion_recurso_cantidad) as Recursos_Asignados, count(*) as Empleados_Asignados
	From Proyecto_Ejecucion pe, Etapa_Ejecucion ej, Actividad_Ejecucion ae, Ejecucion_Recurso er, Ejecucion_Empleado ee
	Where ej.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  and ae.fk_etapa_ejecucion = ej.etapa_ejec_codigo
	  and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and ee.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	Group by pe.proyecto_ejec_nombre;
	
	
create or replace view costo_total_por_proyecto
as
	Select Distinct pe.proyecto_ejec_nombre as proyecto_nombre,pr.presupuesto_costo_total as costo_total
	From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,Ejecucion_Empleado eeo,Presupuesto pr
	Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and  eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and er.fk_presupuesto = pr.presupuesto_numero
	  and  eeo.fk_presupuesto = pr.presupuesto_numero;
	
create or replace view perdidas_por_proyecto
as
	Select Distinct pe.proyecto_ejec_nombre as proyecto_nombre, (pr.presupuesto_costo_total * (pe.proyecto_ejec_fecha_fin_real - pe.proyecto_ejec_fecha_inicio_real)) - (pr.presupuesto_costo_total *(pe.proyecto_ejec_fecha_fin_estimada - pe.proyecto_ejec_fecha_inicio_estimada)) as Ganancia_Perdida
	From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,Ejecucion_Empleado eeo,Presupuesto pr
	Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and  eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and er.fk_presupuesto = pr.presupuesto_numero
	  and  eeo.fk_presupuesto = pr.presupuesto_numero;
	
create or replace view costo_total_por_etapa
as
	Select SUM(costo_total) as costo_total,codigo,nombre_etapa
	From (Select SUM(er.ejecucion_recurso_costo_mensual) as costo_total,ee.etapa_ejec_codigo as codigo,ee.etapa_ejec_nombre as nombre_etapa
		  From Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er
		  Where ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  	    and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ee.etapa_ejec_codigo
		  UNION ALL
		  Select SUM(er.ejecucion_recurso_costo_mantenimiento) as costo_total,ee.etapa_ejec_codigo as codigo,ee.etapa_ejec_nombre as nombre_etapa
		  From Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er
		  Where ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  	    and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ee.etapa_ejec_codigo
		  UNION ALL
		  Select SUM(eeo.ejecucion_empleado_salario) as costo_total,ee.etapa_ejec_codigo as codigo,ee.etapa_ejec_nombre as nombre_etapa
		  From Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Empleado eeo
		  Where ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  	    and eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ee.etapa_ejec_codigo
		  UNION ALL
		  Select SUM(eeo.ejecucion_empleado_viaticos) as costo_total,ee.etapa_ejec_codigo as codigo,ee.etapa_ejec_nombre as nombre_etapa
		  From Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Empleado eeo
		  Where ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  	    and eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ee.etapa_ejec_codigo)
	Group by codigo,nombre_etapa
	Order by codigo;
	
create or replace view total_ganado_perdido_en_proyectos_por_ano
as
	Select EXTRACT(year FROM pe.proyecto_ejec_fecha_fin_real) as proyecto_ano, SUM((pr.presupuesto_costo_total * (pe.proyecto_ejec_fecha_fin_real - pe.proyecto_ejec_fecha_inicio_real)) - (pr.presupuesto_costo_total *(pe.proyecto_ejec_fecha_fin_estimada - pe.proyecto_ejec_fecha_inicio_estimada))) as Ganancia_Perdida
	From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,Ejecucion_Empleado eeo,Presupuesto pr
	Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and  eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and er.fk_presupuesto = pr.presupuesto_numero
	  and  eeo.fk_presupuesto = pr.presupuesto_numero
	Group by EXTRACT(year FROM pe.proyecto_ejec_fecha_fin_real);
	
create or replace view total_proyectos_por_mineral_con_ganancia_perdida
as
	Select E.total_proyectos,E.nombre_mineral,Ganancia_Perdida
	From (Select Count(*) as total_proyectos,mi.mineral_nombre as nombre_mineral
		  From Proyecto_Ejecucion pe,Pozo po,Mineral mi
		  Where pe.fk_pozo_1 = po.pozo_id
		    and pe.fk_pozo_2 = po.fk_mina_1
		    and pe.fk_pozo_3 = po.fk_mina_2
		    and po.fk_mineral = mi.mineral_codigo
		  Group by mi.mineral_nombre) E, (Select Distinct mi.mineral_nombre as mineral_nombre, SUM((pr.presupuesto_costo_total * (pe.proyecto_ejec_fecha_fin_real - pe.proyecto_ejec_fecha_inicio_real)) - (pr.presupuesto_costo_total *(pe.proyecto_ejec_fecha_fin_estimada - pe.proyecto_ejec_fecha_inicio_estimada))) as Ganancia_Perdida
										  From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,Ejecucion_Empleado eeo,Presupuesto pr,Pozo po,Mineral mi
										  Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  										and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  										and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  										and  eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  										and er.fk_presupuesto = pr.presupuesto_numero
	  										and  eeo.fk_presupuesto = pr.presupuesto_numero
										    and pe.fk_pozo_1 = po.pozo_id
		    								and pe.fk_pozo_2 = po.fk_mina_1
		    								and pe.fk_pozo_3 = po.fk_mina_2
		    								and po.fk_mineral = mi.mineral_codigo
										  Group by mineral_nombre) L
	Where E.nombre_mineral = L.mineral_nombre;