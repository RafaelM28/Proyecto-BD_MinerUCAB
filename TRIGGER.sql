-- Creación de un disparador llamado 'trigger_insertar_historico_estatus_empleado'
CREATE OR REPLACE TRIGGER trigger_insertar_historico_estatus_empleado
AFTER INSERT ON Empleado
FOR EACH ROW
-- Se llama a la función 'insertar_historico_estatus_empleado' para cada fila
EXECUTE PROCEDURE insertar_historico_estatus_empleado();

-- Creación de un disparador llamado 'trigger_insertar_historico_estatus_empleado'
CREATE OR REPLACE TRIGGER trigger_insertar_historico_estatus_pedido_compra
AFTER INSERT ON Pedido_Compra
FOR EACH ROW
-- Se llama a la función 'insertar_historico_estatus_pedido_compra' para cada fila
EXECUTE PROCEDURE insertar_historico_estatus_pedido_compra();

-- Creación de un disparador llamado 'trigger_insertar_historico_estatus_empleado'
CREATE OR REPLACE TRIGGER trigger_borrar_detalle_pedido_compra
AFTER DELETE ON Detalle_Pedido_Compra
FOR EACH ROW
-- Se llama a la función 'borrar_detalle_pedido_compra' para cada fila
EXECUTE FUNCTION borrar_detalle_pedido_compra();

-- Creación de un disparador llamado 'trigger_insertar_historico_estatus_empleado'
CREATE OR REPLACE TRIGGER trigger_pago_compra_insert
AFTER INSERT ON Pago_Compra
FOR EACH ROW
-- Se llama a la función 'pago_compra_insert' para cada fila
EXECUTE FUNCTION pago_compra_insert();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_usuario'
CREATE OR REPLACE TRIGGER trigger_check_arco_exclusivo_usuario
BEFORE INSERT OR UPDATE ON usuario
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_correo'
CREATE OR REPLACE TRIGGER trigger_check_arco_exclusivo_correo
BEFORE INSERT OR UPDATE ON correo
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_telefono'
CREATE OR REPLACE TRIGGER trigger_check_arco_exclusivo_telefono
BEFORE INSERT OR UPDATE ON telefono
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
 EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_ejec_empleado'
CREATE OR REPLACE TRIGGER trigger_check_arco_exclusivo_ejec_empleado
BEFORE INSERT OR UPDATE ON ejecucion_empleado
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_ejec_empleado' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_ejec_empleado();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_ejec_recurso'
CREATE OR REPLACE TRIGGER trigger_check_arco_exclusivo_ejec_recurso
BEFORE INSERT OR UPDATE ON ejecucion_recurso
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_ejec_recurso' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_ejec_recurso();

-- Creación de un disparador llamado 'trigger_check_yacimiento_tipo'
CREATE OR REPLACE TRIGGER trigger_check_yacimiento_tipo
BEFORE INSERT OR UPDATE ON yacimiento
FOR EACH ROW
-- Se llama a la función 'check_yacimiento_tipo' para cada fila
EXECUTE PROCEDURE check_yacimiento_tipo();

-- Creación de un disparador llamado 'trigger_check_mineral_tipo'
CREATE OR REPLACE TRIGGER trigger_check_mineral_tipo
BEFORE INSERT OR UPDATE ON mineral
FOR EACH ROW
-- Se llama a la función 'check_mineral_tipo' para cada fila
EXECUTE PROCEDURE check_mineral_tipo();
