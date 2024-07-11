Create or replace view total_proyectos_ganancia_estimada_perdidas
as
 Select Distinct pe.proyecto_ejec_nombre as proyecto_nombre,
 (pr.presupuesto_costo_total *(pe.proyecto_ejec_fecha_fin_estimada - pe.proyecto_ejec_fecha_inicio_estimada)) as Ganancia_Perdida_Estimada,
 (pr.presupuesto_costo_total * (pe.proyecto_ejec_fecha_fin_real - pe.proyecto_ejec_fecha_inicio_real)) - (pr.presupuesto_costo_total *(pe.proyecto_ejec_fecha_fin_estimada - pe.proyecto_ejec_fecha_inicio_estimada)) as Ganancia_Perdida
 From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,Ejecucion_Empleado eeo,Presupuesto pr
 Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
  and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
  and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
  and  eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
  and er.fk_presupuesto = pr.presupuesto_numero
  and  eeo.fk_presupuesto = pr.presupuesto_numero;

Create or replace view empleados_asignados
as
 Select ca.cargo_nombre as nombre_cargo,
 		eeo.ejecucion_empleado_salario as empleado_salario,
		eeo.ejecucion_empleado_viaticos as empleado_viatico
 From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Empleado eeo,
 	  Empleado e,Contrato_Empleado ce, Cargo ca
 Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
	  and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
	  and eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
	  and eeo.fk_empleado = e.empleado_codigo
	  and ce.fk_empleado = e.empleado_codigo
	  and ce.fk_cargo = ca.cargo_codigo
 Order by pe.proyecto_ejec_codigo, ee.etapa_ejec_numero,ae.actividad_ejec_codigo;

Create or replace view recursos_asignados
as
 Select tr.tipo_recurso_nombre as nombre_tipo_recurso,
 		er.ejecucion_recurso_cantidad as recurso_cantidad,
		er.ejecucion_recurso_costo_mensual as recurso_costo,
		er.ejecucion_recurso_costo_mantenimiento as recurso_mantenimiento
 From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae,Ejecucion_Recurso er,
 	  Inventario_Recurso ir,Recurso r,Tipo_Recurso tr
 Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
   and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
   and er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
   and er.fk_inventario_recurso_2 = ir.fk_recurso
   and ir.fk_recurso = r.recurso_codigo
   and r.fk_tipo_recurso = tr.tipo_recurso_codigo
  Order by pe.proyecto_ejec_codigo, ee.etapa_ejec_numero,ae.actividad_ejec_codigo;

Create or replace view actividades
as
 Select ae.actividad_ejec_nombre as actividad_nombre
 From Proyecto_Ejecucion pe,Etapa_Ejecucion ee,Actividad_Ejecucion ae
 Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
   and ae.fk_etapa_ejecucion = ee.etapa_ejec_codigo
 Order by pe.proyecto_ejec_codigo, ee.etapa_ejec_numero,ae.actividad_ejec_codigo;

Create or replace view etapas
as
 Select ee.etapa_ejec_nombre as etapa_nombre,
		ee.etapa_ejec_numero as etepa_numero
 From Proyecto_Ejecucion pe,Etapa_Ejecucion ee
 Where ee.fk_proyecto_ejecucion = pe.proyecto_ejec_codigo
 Order by pe.proyecto_ejec_codigo, ee.etapa_ejec_numero;

Create or replace view proyectos
as
 Select pe.proyecto_ejec_nombre as proyecto_nombre
 From Proyecto_Ejecucion pe
 Order by pe.proyecto_ejec_codigo;
 
Create or replace view costo_actividad
as
	Select SUM(costo_total) as costo_total,codigo,nombre_actividad
	From (Select SUM(er.ejecucion_recurso_costo_mensual) as costo_total,ae.actividad_ejec_codigo as codigo,ae.actividad_ejec_nombre as nombre_actividad
		  From Actividad_Ejecucion ae,Ejecucion_Recurso er
		  Where er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ae.actividad_ejec_codigo
		  UNION ALL
		  Select SUM(er.ejecucion_recurso_costo_mantenimiento) as costo_total,ae.actividad_ejec_codigo as codigo,ae.actividad_ejec_nombre as nombre_actividad
		  From Actividad_Ejecucion ae,Ejecucion_Recurso er
		  Where er.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ae.actividad_ejec_codigo
		  UNION ALL
		  Select SUM(eeo.ejecucion_empleado_salario) as costo_total,ae.actividad_ejec_codigo as codigo,ae.actividad_ejec_nombre as nombre_actividad
		  From Actividad_Ejecucion ae,Ejecucion_Empleado eeo
		  Where eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ae.actividad_ejec_codigo
		  UNION ALL
		  Select SUM(eeo.ejecucion_empleado_salario) as costo_total,ae.actividad_ejec_codigo as codigo,ae.actividad_ejec_nombre as nombre_actividad
		  From Actividad_Ejecucion ae,Ejecucion_Empleado eeo
		  Where eeo.fk_actividad_ejecucion = ae.actividad_ejec_codigo
		  Group by ae.actividad_ejec_codigo)
	Group by codigo,nombre_actividad
	Order by codigo;