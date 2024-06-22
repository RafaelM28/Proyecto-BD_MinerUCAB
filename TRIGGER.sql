-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_usuario'
CREATE TRIGGER trigger_check_arco_exclusivo_usuario
BEFORE INSERT OR UPDATE ON usuario
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_correo'
CREATE TRIGGER trigger_check_arco_exclusivo_correo
BEFORE INSERT OR UPDATE ON correo
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_telefono'
CREATE TRIGGER trigger_check_arco_exclusivo_telefono
BEFORE INSERT OR UPDATE ON telefono
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_posecion' para cada fila
 EXECUTE PROCEDURE check_arco_exclusivo_posecion();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_ejec_empleado'
CREATE TRIGGER trigger_check_arco_exclusivo_ejec_empleado
BEFORE INSERT OR UPDATE ON ejecucion_empleado
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_ejec_empleado' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_ejec_empleado();

-- Creación de un disparador llamado 'trigger_check_arco_exclusivo_ejec_recurso'
CREATE TRIGGER trigger_check_arco_exclusivo_ejec_recurso
BEFORE INSERT OR UPDATE ON ejecucion_recurso
FOR EACH ROW
-- Se llama a la función 'check_arco_exclusivo_ejec_recurso' para cada fila
EXECUTE PROCEDURE check_arco_exclusivo_ejec_recurso();

-- Creación de un disparador llamado 'trigger_check_yacimiento_tipo'
CREATE TRIGGER trigger_check_yacimiento_tipo
BEFORE INSERT OR UPDATE ON yacimiento
FOR EACH ROW
-- Se llama a la función 'check_yacimiento_tipo' para cada fila
EXECUTE PROCEDURE check_yacimiento_tipo();

-- Creación de un disparador llamado 'trigger_check_mineral_tipo'
CREATE TRIGGER trigger_check_mineral_tipo
BEFORE INSERT OR UPDATE ON mineral
FOR EACH ROW
-- Se llama a la función 'check_mineral_tipo' para cada fila
EXECUTE PROCEDURE check_mineral_tipo();
