/*Creamos el role de Gerente_de_Ventas*/
CREATE ROLE Gerente_de_Ventas;

/*Tablas que puede consultar*/
GRANT SELECT ON TABLE Mineral,Inventario_Producto,Cliente,Lugar,Telefono,Correo,Usuario,Estatus_Pedido TO Gerente_de_Ventas WITH GRANT OPTION;

/*Tablas que puede usar con libertad*/
GRANT SELECT,UPDATE,INSERT,SELECT ON TABLE Pedido_Venta,Detalle_Pedido_Venta,Pago_Venta,Historico_Estatus_Pedido_Venta TO Gerente_de_Ventas WITH GRANT OPTION;

/*Tablas que solo puede cambiar su registro*/
GRANT UPDATE ON TABLE Usuario,Telefono,Correo TO Gerente_de_Ventas WITH GRANT OPTION;

/*Tablas que usan trigger*/
GRANT TRIGGER ON TABLE Usuario,Telefono,Correo TO Gerente_de_Ventas WITH GRANT OPTION;

/*Estas son las funciones que puede usar*/
GRANT EXECUTE ON FUNCTION lista_clientes,lista_minerales,lista_inventario,obtener_tipo_operacion_inventario, lista_pedidos_venta, lista_clientes_venta, lista_minerales_venta, obtener_detalles_pedido_venta,
                                                    obtener_detalles_pedido_venta_solicitud, obtener_metodos_pago_cliente, obtener_pago_venta, obtener_pedido_venta_cliente TO Gerente_de_Ventas WITH GRANT OPTION;

GRANT EXECUTE ON PROCEDURE sp_crear_pedido_venta, sp_crear_pago_venta, sp_crear_relacion_solicitud_pedido, update_estatus_pedido_venta, update_estatus_pedido_reposicion_venta,
                                                    update_estatus_pedido_venta_fin_solicitud TO Gerente_de_Ventas WITH GRANT OPTION;

/*Creamos el rol de Lider_de_Proyecto*/
CREATE ROLE Lider_de_Proyecto;

/*Tablas que puede consultar*/
GRANT SELECT ON TABLE Mineral,Inventario_Producto,aliado,lugar,Empleado,Telefono,Correo,Recurso,Marca,Modelo,Tipo_Recurso,Cargo,
					  Contrato_Empleado,Cliente,Horario,Empleado_Horario,Empleado_Beneficio,Beneficio,Inventario_Recurso,Usuario,
					  Estatus_Ejecucion,Solicitud_Proyecto_Aliados,Detalle_Solicitud_Empleado,Detalle_Solicitud_Recurso,Estatus_Disponibilidad,
					  Historico_Estatus_Solicitud_Aliados
					  TO Lider_de_Proyecto WITH GRANT OPTION;

/*Tablas que solo puede cambiar su registro*/
GRANT UPDATE ON TABLE Usuario,Telefono,Correo TO Lider_de_Proyecto WITH GRANT OPTION;

/*Tablas que solo puede consultar e insertar*/
Grant INSERT,SELECT ON TABLE Historico_Estatus_Empleado,Historico_Estatus_Recurso,Historico_Estatus_Concesion TO Lider_de_proyecto WITH GRANT OPTION;

/*Tablas que puede usar con libertad*/
GRANT INSERT,UPDATE,DELETE,SELECT ON TABLE Proyecto_Configuracion,Etapa_Configuracion,Actividad_Configuracion,Cargo_Actividad,Recurso_Actividad,
										   Pozo,Yacimiento,Mina,Historico_Estatus_Pozo,Estatus_Pozo,Proyecto_Ejecucion,Historico_Estatus_Proyecto,
										   Etapa_Ejecucion,Historico_Estatus_Etapa,Actividad_Ejecucion,Historico_Estatus_Actividad,Ejecucion_Empleado,
										   Ejecucion_Recurso,Presupuesto
										   TO Lider_de_Proyecto WITH GRANT OPTION;	

/*Tablas que usan trigger*/
GRANT TRIGGER ON TABLE Usuario,Telefono,Correo,Ejecucion_Empleado,Ejecucion_Recurso TO Lider_de_Proyecto WITH GRANT OPTION;

/*Crear proyecto ejecucion,lista de proyectos ejecucion,Crear actividad ejecucion,lista de etapas y actividades en ejecucion,linea del tiempo*/
/*Estas son las funciones que puede usar*/
GRANT EXECUTE ON FUNCTION lista_clientes,lista_aliados,lista_empleados,lista_minerales,lista_recursos,lista_proyectos_config,
						  lista_etapas_config,lista_actividades_config, lista_proyectos_ejecucion, lista_etapas_ejecucion, lista_actividades_ejecucion,
                           lista_pozos_de_mineral TO Lider_de_Proyecto WITH GRANT OPTION;

/*Creamos el rol de Operario_Minero*/
CREATE ROLE Operario_Minero;

/*Tablas a las cuales solo puede consultar*/
GRANT SELECT ON TABLE Mineral,Inventario_Producto,Recurso,Tipo_Recurso,Marca,Modelo,Inventario_Producto,Proyecto_Configuracion,Etapa_Configuracion,
					  Actividad_Configuracion,Recurso_Actividad,Cargo_Actividad,Cargo,Proyecto_Ejecucion,Historico_Estatus_Proyecto,Estatus_Ejecucion,
					  Etapa_Ejecucion,Historico_Estatus_Etapa,Actividad_Ejecucion,Historico_Estatus_Actividad,Pozo
					  TO Operario_Minero WITH GRANT OPTION;

/*linea del tiempo,lista proyectos ejecucion,lista actividades ejecucion,lista etapas ejecucion*/
/*Estos son las funciones que puede usar*/
GRANT EXECUTE ON FUNCTION lista_minerales,lista_proyectos_config,lista_etapas_config,lista_actividades_config,lista_recursos,
                                                    lista_proyectos_ejecucion, lista_etapas_ejecucion, lista_actividades_ejecucion TO Operario_Minero WITH GRANT OPTION;

/*Usuario Gerente de Ventas*/
CREATE USER MarcelaJuliaMP48 WITH PASSWORD '12345678' IN ROLE Gerente_de_Ventas;

/*Usuario Lider de Proyectos*/
CREATE USER FernandoLuisLG47 WITH PASSWORD '12345678' IN ROLE Lider_de_Proyecto;

/*Usuario Operario Minero*/
CREATE USER JuanPabloGR1 WITH PASSWORD '12345678' IN ROLE Operario_Minero;


