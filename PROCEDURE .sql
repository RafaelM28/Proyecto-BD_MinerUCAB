-- Creación de la función check_arco_exclusivo_posecion
CREATE OR REPLACE FUNCTION check_arco_exclusivo_posecion() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si solo uno de los campos fk_empleado, fk_aliado y fk_cliente está lleno
    -- y los demás están vacíos. Si es así, retorna el nuevo registro.
    IF (NEW.fk_empleado IS NOT NULL AND NEW.fk_aliado IS NULL AND NEW.fk_cliente IS NULL) OR
       (NEW.fk_empleado IS NULL AND NEW.fk_aliado IS NOT NULL AND NEW.fk_cliente IS NULL) OR
       (NEW.fk_empleado IS NULL AND NEW.fk_aliado IS NULL AND NEW.fk_cliente IS NOT NULL) THEN
        RETURN NEW;
    -- Si no se cumple la condición anterior, se lanza una excepción.
    ELSE
        RAISE EXCEPTION 'Solo uno de los campos fk_empleado, fk_aliado y fk_cliente debe estar lleno y los demás deben estar vacíos.';
    END IF;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

-- Creación de la función check_arco_exclusivo_ejec_empleado
CREATE OR REPLACE FUNCTION check_arco_exclusivo_ejec_empleado() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si solo uno de los campos (fk_empleado) y (fk_solicitud_aliado_1 y fk_solicitud_aliado_2) está lleno
    -- y los demás están vacíos. Si es así, retorna el nuevo registro.
    IF (NEW.fk_empleado IS NOT NULL AND (NEW.fk_solicitud_aliado_1 IS NULL AND NEW.fk_solicitud_aliado_2 IS NULL)) OR
       (NEW.fk_empleado IS NULL AND (NEW.fk_solicitud_aliado_1 IS NOT NULL AND NEW.fk_solicitud_aliado_2 IS NOT NULL)) THEN
        RETURN NEW;
    -- Si no se cumple la condición anterior, se lanza una excepción.
    ELSE
        RAISE EXCEPTION 'Solo uno de los campos (fk_empleado) y (fk_solicitud_aliado_1 y fk_solicitud_aliado_2) debe estar lleno y los demás deben estar vacíos.';
    END IF;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

-- Creación de la función check_arco_exclusivo_ejec_recurso
CREATE OR REPLACE FUNCTION check_arco_exclusivo_ejec_recurso() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si solo uno de los campos (fk_inventario_recurso_1 y fk_inventario_recurso_2) y (fk_solicitud_aliado_1 y fk_solicitud_aliado_2) está lleno
    -- y los demás están vacíos. Si es así, retorna el nuevo registro.
    IF ((NEW.fk_inventario_recurso_1 IS NOT NULL AND NEW.fk_inventario_recurso_2 IS NOT NULL) AND (NEW.fk_solicitud_aliado_1 IS NULL AND NEW.fk_solicitud_aliado_2 IS NULL)) OR
       ((NEW.fk_inventario_recurso_1 IS NULL AND NEW.fk_inventario_recurso_2 IS NULL) AND (NEW.fk_solicitud_aliado_1 IS NOT NULL AND NEW.fk_solicitud_aliado_2 IS NOT NULL)) THEN
        RETURN NEW;
    -- Si no se cumple la condición anterior, se lanza una excepción.
    ELSE
        RAISE EXCEPTION 'Solo uno de los campos (fk_inventario_recurso_1 y fk_inventario_recurso_2) y (fk_solicitud_aliado_1 y fk_solicitud_aliado_2) debe estar lleno y los demás deben estar vacíos.';
    END IF;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

-- Creación de la función check_arco_exclusivo_pago
CREATE OR REPLACE FUNCTION check_arco_exclusivo_pago() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si solo uno de los campos fk_tarjeta_debito y fk_tarjeta_credito y fk_efectivo y fk_cheque está lleno
    -- y los demás están vacíos. Si es así, retorna el nuevo registro.
    IF (NEW.fk_tarjeta_debito IS NOT NULL AND NEW.fk_tarjeta_credito IS NULL AND NEW.fk_efectivo IS NULL AND NEW.fk_cheque IS NULL) OR
       (NEW.fk_tarjeta_debito IS NULL AND NEW.fk_tarjeta_credito IS NOT NULL AND NEW.fk_efectivo IS NULL AND NEW.fk_cheque IS NULL) OR
       (NEW.fk_tarjeta_debito IS NULL AND NEW.fk_tarjeta_credito IS NULL AND NEW.fk_efectivo IS NOT NULL AND NEW.fk_cheque IS NULL) OR
       (NEW.fk_tarjeta_debito IS NULL AND NEW.fk_tarjeta_credito IS NULL AND NEW.fk_efectivo IS NULL AND NEW.fk_cheque IS NOT NULL) THEN
        RETURN NEW;
    -- Si no se cumple la condición anterior, se lanza una excepción.
    ELSE
        RAISE EXCEPTION 'Solo uno de los campos fk_tarjeta_debito y fk_tarjeta_credito y fk_efectivo y fk_cheque debe estar lleno y los demás deben estar vacíos.';
    END IF;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

-- Creación de una función check_yacimiento_tipo
CREATE OR REPLACE FUNCTION check_yacimiento_tipo() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si el tipo de yacimiento es 'Autóctono'
    -- En ese caso, se asegura de que 'yacim_autoc_origen' no esté vacío y 'yacim_aloc_transporte' esté vacío
    -- Si no se cumplen estas condiciones, se lanza una excepción
    IF (NEW.yacimiento_tipo = 'Autóctono' AND (NEW.yacim_autoc_origen IS NULL OR NEW.yacim_aloc_transporte IS NOT NULL)) OR
    -- Verifica si el tipo de yacimiento es 'Alóctono'
    -- En ese caso, se asegura de que 'yacim_autoc_origen' esté vacío y 'yacim_aloc_transporte' no esté vacío
    -- Si no se cumplen estas condiciones, se lanza una excepción
       (NEW.yacimiento_tipo = 'Alóctono' AND (NEW.yacim_autoc_origen IS NOT NULL OR NEW.yacim_aloc_transporte IS NULL)) THEN
        RAISE EXCEPTION 'Para yacimientos autóctonos, yacim_autoc_origen debe estar lleno y yacim_aloc_transporte vacío. Para yacimientos alóctonos, yacim_autoc_origen debe estar vacío y yacim_aloc_transporte lleno.';
    END IF;
    -- Si se cumplen todas las condiciones, se retorna el nuevo registro
    RETURN NEW;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

-- Creación de una función check_mineral_tipo
CREATE OR REPLACE FUNCTION check_mineral_tipo() RETURNS TRIGGER AS $$
BEGIN
    -- Verifica si el tipo de mineral es 'Metálico'
    -- En ese caso, se asegura de que 'metalicos_brillo' y 'metalicos_conductividad' no esten vacíos, y 'no_metalicos_tenacidad' esté vacío
    -- Si no se cumplen estas condiciones, se lanza una excepción
    IF (NEW.mineral_tipo = 'Metálico' AND (NEW.metalicos_brillo IS NULL OR NEW.metalicos_conductividad IS NULL OR NEW.no_metalicos_tenacidad IS NOT NULL)) OR
    -- Verifica si el tipo de mineral es 'No metálico'
    -- En ese caso, se asegura de que 'metalicos_brillo' y 'metalicos_conductividad' esten vacíos, y 'no_metalicos_tenacidad' no esté vacío
    -- Si no se cumplen estas condiciones, se lanza una excepción
         (NEW.mineral_tipo = 'No metálico' AND (NEW.metalicos_brillo IS NOT NULL OR NEW.metalicos_conductividad IS NOT NULL OR NEW.no_metalicos_tenacidad IS NULL)) THEN
        RAISE EXCEPTION 'Para minerales metálicos, metalicos_brillo y metalicos_conductividad deben estar llenos y no_metalicos_tenacidad vacío. Para minerales no metálicos, metalicos_brillo y metalicos_conductividad deben estar vacíos y no_metalicos_tenacidad lleno.';
    END IF;
    -- Si se cumplen todas las condiciones, se retorna el nuevo registro
    RETURN NEW;
END;
-- Se especifica que el lenguaje de la función es plpgsql
$$ LANGUAGE plpgsql;

--Creacion de una funcion insertar_historico_estatus_empleado
CREATE OR REPLACE FUNCTION insertar_historico_estatus_empleado()
RETURNS TRIGGER AS $$
BEGIN
	--Inserta un registro en la tabla Historico_Estatus_Empleado
	--El registro tiene la fecha del momento que se ejecuto
    INSERT INTO Historico_Estatus_Empleado (hist_est_empleado_codigo,fk_estatus_disponibilidad,fk_empleado,hist_est_empl_fecha_inicio) VALUES (
        (SELECT MAX(hist_est_empleado_codigo) FROM Historico_Estatus_Empleado)+1,1, NEW.empleado_codigo, CURRENT_TIMESTAMP );
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creacion de una funcion insertar_historico_estatus_pedido_compra
CREATE OR REPLACE FUNCTION insertar_historico_estatus_pedido_compra()
RETURNS TRIGGER AS $$
BEGIN
	--Inserta un registro en la tabla Historico_Estatus_Pedido_Compra
	--El registro tiene la fecha del momento que se ejecuto
    INSERT INTO historico_estatus_pedido_compra (hist_est_pedido_compra_codigo, fk_estatus_pedido, fk_pedido_compra_1, fk_pedido_compra_2, hist_est_pedido_compra_fecha_inicio) VALUES (
        (SELECT MAX(hist_est_pedido_compra_codigo) FROM historico_estatus_pedido_compra)+1,1, NEW.pedido_compra_numero, NEW.fk_aliado, CURRENT_TIMESTAMP );
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creacion de una funcion borrar_detalle_pedido_compra
CREATE OR REPLACE FUNCTION borrar_detalle_pedido_compra()
RETURNS TRIGGER AS $$
BEGIN
	--Borra el registro correspondiente en la tabla Inventario_Producto
    DELETE FROM Inventario_Producto
    WHERE inventario_producto_codigo = OLD.fk_inventario_producto_1
    AND fk_mineral = OLD.fk_inventario_producto_2;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

--Creacion de una funcion  pago_compra_insert
CREATE OR REPLACE FUNCTION pago_compra_insert()
RETURNS TRIGGER AS $$
DECLARE 
	fk_inventario_producto SMALLINT;
	cantidad INTEGER;
	ultimo_registro_id SMALLINT;
BEGIN
	
	--Se cambia el estatus, fecha inicio y fecha final del registro en Historico_Estatus_Pedido_Compra
	--Ya que se registro el pago
    UPDATE Historico_Estatus_Pedido_Compra
    SET fk_estatus_pedido = 5, hist_est_pedido_compra_fecha_fin = NEW.pago_compra_fecha_emision, hist_est_pedido_compra_fecha_inicio = NEW.pago_compra_fecha_emision
    WHERE fk_pedido_compra_1 = NEW.fk_pedido_compra_1;
    
	--Se obtiene la fk correspondiente al inventario producto que se registra
	--con el pago compra y la fk de Detalle_Pedido_Compra
    SELECT fk_inventario_producto_1 INTO fk_inventario_producto
    FROM Detalle_Pedido_Compra
    WHERE fk_pedido_compra_1 = NEW.fk_pedido_compra_1;
	
	--Obtenemos la cantidad de minerales del detalle pedido compra correspondiente
	SELECT detalle_compra_cantidad_mineral INTO cantidad
	FROM Detalle_Pedido_Compra
	WHERE fk_pedido_compra_1 = NEW.fk_pedido_compra_1;

	--Actualizamos el registro de Inventario_Producto con la cantidad, fecha y tipo operacion del pago y detalle
    UPDATE Inventario_Producto
    SET inventario_producto_fecha_movimiento = NEW.pago_compra_fecha_emision,
        inventario_producto_operacion = cantidad,
        inventario_producto_tipo_operacion = 'Ingreso'
    WHERE inventario_producto_codigo = fk_inventario_producto;

    --Buscamos el ultimo registro del mineral obtenido en el Inventario_Producto
    SELECT MAX(inventario_producto_codigo) INTO ultimo_registro_id
    FROM Inventario_Producto
    WHERE fk_mineral = (SELECT fk_mineral FROM Inventario_Producto WHERE inventario_producto_codigo = fk_inventario_producto);

	--Y igualamos la cantidad total del registro a la suma del detalle con la cantidad total del ultimo registro del mineral asociado
    UPDATE Inventario_Producto
    SET inventario_producto_cantidad_total = cantidad + (SELECT inventario_producto_cantidad_total FROM Inventario_Producto WHERE inventario_producto_codigo = ultimo_registro_id)
    WHERE inventario_producto_codigo = fk_inventario_producto;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE sp_crear_cliente(p_razon_social VARCHAR,p_rif VARCHAR,p_denominacion_comercial VARCHAR,capital NUMERIC,p_detalle_principal VARCHAR,p_detalle_fiscal VARCHAR,p_estado_principal VARCHAR,p_municipio_principal VARCHAR,p_parroquia_principal VARCHAR,p_estado_fiscal VARCHAR,p_municipio_fiscal VARCHAR,p_parroquia_fiscal VARCHAR,p_correo_electronico VARCHAR,p_telefono_prefijo VARCHAR,p_telefono_numero VARCHAR,p_nombre_usuario VARCHAR,p_clave VARCHAR,p_confirmar_clave VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que la clave y la confirmación de clave sean iguales
    IF p_clave != p_confirmar_clave THEN
        RAISE EXCEPTION 'La clave y la confirmación de clave no coinciden';
    END IF;

    -- Insertar los datos en la tabla de empresas
    INSERT INTO Cliente (persona_jur_codigo,persona_jur_razon_social,persona_jur_RIF,persona_jur_denominacion_comercial,persona_jur_capital_total,persona_jur_direccion_fiscal,persona_jur_direccion_principal,fk_lugar_1,fk_lugar_2) VALUES 
	((SELECT MAX(persona_jur_codigo) FROM Cliente)+1,p_razon_social,p_rif,p_denominacion_comercial,capital,p_detalle_fiscal,p_detalle_principal,(Select lugar_codigo 
																																				 From Lugar 
																																				 Where lugar_nombre = p_parroquia_principal 
																																				 And lugar_tipo = 'Parroquia' 
																																				 AND fk_lugar = (Select lugar_codigo 
																																				 				 From Lugar 
																																								 Where lugar_nombre = p_municipio_principal 
																																				 				 And lugar_tipo = 'Municipio' 
																																								 AND fk_lugar = (Select lugar_codigo 
																																								 				 From Lugar 
																																												 Where lugar_nombre = p_estado_principal 
																																												 And lugar_tipo = 'Estado')))
	 																																	 	   ,(Select lugar_codigo 
																																				 From Lugar 
																																				 Where lugar_nombre = p_parroquia_fiscal
																																				 And lugar_tipo = 'Parroquia' 
																																				 AND fk_lugar = (Select lugar_codigo 
																																				 				 From Lugar 
																																								 Where lugar_nombre = p_municipio_fiscal
																																				 				 And lugar_tipo = 'Municipio' 
																																								 AND fk_lugar = (Select lugar_codigo 
																																								 				 From Lugar 
																																												 Where lugar_nombre = p_estado_fiscal
																																												 And lugar_tipo = 'Estado'))));
	If p_correo_electronico IS NOT NULL then
		INSERT INTO Correo (correo_codigo,correo_nombre,fk_cliente) VALUES 
		((SELECT MAX(correo_codigo) FROM Correo)+1,p_correo_electronico,(SELECT MAX(persona_jur_codigo) FROM Cliente));
	END IF;
	
	If p_telefono_prefijo IS NOT NULL AND p_telefono_numero IS NOT NULL then
		INSERT INTO Telefono (telefono_codigo,telefono_prefijo,telefono_numero,telefono_tipo,fk_cliente) VALUES 
		((SELECT MAX(telefono_codigo) FROM Telefono)+1,p_telefono_prefijo,p_telefono_numero,'Casa',(SELECT MAX(persona_jur_codigo) FROM Cliente));
	END IF;
	
    -- Insertar los datos en la tabla de usuarios
    INSERT INTO Usuario (usuario_codigo,usuario_nombre,usuario_clave,fk_cliente,fk_rol) VALUES 
	((SELECT MAX(usuario_codigo) FROM Usuario)+1,p_nombre_usuario,p_clave,(SELECT MAX(persona_jur_codigo) FROM Cliente),(Select rol_codigo 
																			   From Rol 
																			   Where rol_nombre = 'Cliente'));
END;
$$;

-- Creación de una función lista_clientes()
CREATE OR REPLACE FUNCTION lista_clientes()
-- Esta función devuelve una tabla con información de los clientes
RETURNS TABLE (cliente_codigo SMALLINT, cliente_rif VARCHAR(20), cliente_denom_comercial VARCHAR(30), cliente_dir_fiscal VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla cliente
    RETURN QUERY SELECT C.persona_jur_codigo, C.persona_jur_rif, C.persona_jur_denominacion_comercial, C.persona_jur_direccion_fiscal
    FROM cliente C;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_aliados()
CREATE OR REPLACE FUNCTION lista_aliados()
RETURNS TABLE (aliado_codigo SMALLINT, aliado_rif VARCHAR(20), aliado_denom_comercial VARCHAR(30), aliado_dir_fiscal VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla aliado
    RETURN QUERY SELECT A.persona_jur_codigo, A.persona_jur_rif, A.persona_jur_denominacion_comercial, A.persona_jur_direccion_fiscal
    FROM aliado A;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_empleados()
CREATE OR REPLACE FUNCTION lista_empleados()
RETURNS TABLE (empleado_codigo SMALLINT, empleado_cedula VARCHAR(8), empleado_nombre text,  empleado_empresa VARCHAR(45), empleado_cargo VARCHAR(30))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla empleado
    RETURN QUERY SELECT E.empleado_codigo, E.empleado_cedula, E.empleado_primer_nombre||' '|| E.empleado_primer_apellido AS empleado_nombre, A.persona_jur_denominacion_comercial, C.cargo_nombre
    FROM empleado E LEFT JOIN  aliado A on E.fk_aliado_2 = A.persona_jur_codigo, contrato_empleado CE, cargo C
    WHERE E.empleado_codigo = CE.fk_empleado AND CE.fk_cargo = C.cargo_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_usuarios()
CREATE OR REPLACE FUNCTION lista_usuarios()
RETURNS TABLE (usuario_codigo SMALLINT, propietario_nombre text, usuario_nombre VARCHAR(30), rol_nombre VARCHAR(50))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla usuario
 RETURN QUERY SELECT U.usuario_codigo,
    CASE
        -- Si el campo fk_aliado no es nulo, se muestra el nombre del aliado
        WHEN U.fk_aliado IS NOT NULL THEN CAST((SELECT A.persona_jur_razon_social FROM aliado A WHERE A.persona_jur_codigo = U.fk_aliado) AS text)
        -- Si el campo fk_cliente no es nulo, se muestra el nombre del cliente
        WHEN U.fk_cliente IS NOT NULL THEN CAST((SELECT C.persona_jur_razon_social FROM cliente C WHERE C.persona_jur_codigo = U.fk_cliente) AS text)
        -- Si el campo fk_empleado no es nulo, se muestra el nombre del empleado
        WHEN U.fk_empleado IS NOT NULL THEN (SELECT E.empleado_primer_nombre||' '|| E.empleado_primer_apellido AS empleado_nombre FROM empleado E WHERE E.empleado_codigo = U.fk_empleado)
    END,
                  U.usuario_nombre, R.rol_nombre
FROM usuario U, rol R
WHERE U.fk_rol = R.rol_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_privilegios()
CREATE OR REPLACE FUNCTION lista_privilegios()
RETURNS TABLE (privilegio_codigo SMALLINT, privilegio_nombre VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla privilegio
    RETURN QUERY SELECT P.privilegio_codigo, P.privilegio_nombre
    FROM privilegio P;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_roles()
CREATE OR REPLACE FUNCTION lista_roles()
RETURNS TABLE (rol_codigo SMALLINT, rol_nombre VARCHAR(50))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla rol
    RETURN QUERY SELECT R.rol_codigo, R.rol_nombre
    FROM rol R;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_minerales()
CREATE OR REPLACE FUNCTION lista_minerales()
RETURNS TABLE (mineral_codigo SMALLINT, mineral_nombre VARCHAR(50), mineral_tipo VARCHAR(15), inventario_cantidad INTEGER)
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla mineral
    RETURN QUERY SELECT M.mineral_codigo, M.mineral_nombre, M.mineral_tipo, I.inventario_producto_cantidad_total
    FROM mineral M, inventario_producto I
    WHERE I.inventario_producto_codigo IN (    SELECT MAX(inventario_producto_codigo)
                                                                        FROM Inventario_Producto IP
                                                                         WHERE IP.fk_mineral = M.mineral_codigo)
    ORDER BY M.mineral_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_recursos()
CREATE OR REPLACE FUNCTION lista_recursos()
RETURNS TABLE (recurso_codigo SMALLINT, recurso_nombre VARCHAR(50), recurso_tipo VARCHAR(30), modelo_nombre VARCHAR(50), inventario_cantidad INTEGER)
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla recurso
    RETURN QUERY SELECT R.recurso_codigo, R.recurso_nombre, TR.tipo_recurso_nombre, M.modelo_nombre, I.inventario_recurso_cantidad_total
    FROM tipo_recurso TR, modelo M, recurso R LEFT JOIN inventario_recurso I ON R.recurso_codigo = I.fk_recurso
    WHERE R.fk_tipo_recurso = TR.tipo_recurso_codigo AND R.fk_modelo_1 = M.modelo_codigo AND R.fk_modelo_2 = M.fk_marca
    ORDER BY R.recurso_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función obtener_tipo_operacion_inventario()
-- Esta función devuelve el tipo de operación de un inventario perteneciente a una compra o proyecto
CREATE OR REPLACE FUNCTION obtener_tipo_operacion_inventario(inventario_producto_codigo SMALLINT)
RETURNS text
LANGUAGE plpgsql
AS $$
        DECLARE
        tipo_operacion text;
BEGIN
    -- Verifica si el código existe en la tabla Detalle_Pedido_Compra
    IF EXISTS (SELECT 1 FROM Detalle_Pedido_Compra AS DPC WHERE DPC.fk_inventario_producto_1 = inventario_producto_codigo) THEN
        tipo_operacion = 'Compra';
    -- Si no, verifica si el código existe en la tabla Proyecto_Ejecucion
    ELSIF EXISTS (SELECT 1 FROM Proyecto_Ejecucion AS PE WHERE PE.fk_inventario_producto_1 = inventario_producto_codigo) THEN
        tipo_operacion = 'Proyecto';
    END IF;
    RETURN tipo_operacion;
END;
$$;

-- Creación de una función lista_inventario()
CREATE OR REPLACE FUNCTION lista_inventario()
RETURNS TABLE (inventario_codigo SMALLINT, mineral_nombre VARCHAR(30), inventario_product INTEGER, inventario_total INTEGER, inventario_tipo VARCHAR(15), inventario_fecha DATE, tipo_operacion text)
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla inventario
    RETURN QUERY SELECT I.inventario_producto_codigo, M.mineral_nombre, I.inventario_producto_operacion, I.inventario_producto_cantidad_total,
                                          I.inventario_producto_tipo_operacion, I.inventario_producto_fecha_movimiento,
        CASE
            -- Si el tipo de operación es 'Egreso', se muestra 'Venta'
        WHEN I.inventario_producto_tipo_operacion = 'Egreso' THEN (SELECT 'Venta')
            -- Si el tipo de operación es 'Ingreso', se muestra el resultado de la función obtener_tipo_operacion_inventario()
        WHEN I.inventario_producto_tipo_operacion = 'Ingreso' THEN (SELECT obtener_tipo_operacion_inventario(I.inventario_producto_codigo))
        END
    FROM inventario_producto I, mineral M
    WHERE I.fk_mineral = M.mineral_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_solicitudes()
CREATE OR REPLACE FUNCTION lista_solicitudes()
RETURNS TABLE (pedido_codigo SMALLINT, pedido_fecha_emision DATE, aliado VARCHAR(30), pedido_estatus VARCHAR(30))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla solicitud
    RETURN QUERY SELECT PC.pedido_compra_numero, PC.pedido_compra_fecha_emision, A.persona_jur_denominacion_comercial, EP.estatus_pedido_nombre
    FROM pedido_compra PC, aliado A, historico_estatus_pedido_compra HPC, estatus_pedido EP
    WHERE PC.fk_aliado = A.persona_jur_codigo AND PC.pedido_compra_numero = HPC.fk_pedido_compra_1 AND HPC.hist_est_pedido_compra_codigo = EP.estatus_pedido_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_proyectos_config()
CREATE OR REPLACE FUNCTION lista_proyectos_config()
RETURNS TABLE (proyecto_codigo SMALLINT, proyecto_nombre VARCHAR(30), mineral_nombre VARCHAR(30))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla proyecto
    RETURN QUERY SELECT PC.proyecto_config_codigo, PC.proyecto_config_nombre, M.mineral_nombre
    FROM proyecto_configuracion PC, mineral M
    WHERE PC.fk_mineral = M.mineral_codigo;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_etapas_config()
CREATE OR REPLACE FUNCTION lista_etapas_config()
RETURNS TABLE (etapa_codigo SMALLINT, etapa_nombre VARCHAR(30), etapa_numero SMALLINT)
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla etapa
    RETURN QUERY SELECT EC.etapa_config_codigo, EC.etapa_config_nombre, EC.etapa_config_numero
    FROM etapa_configuracion EC;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_actividades_config()
CREATE OR REPLACE FUNCTION lista_actividades_config()
RETURNS TABLE (actividad_codigo SMALLINT, actividad_nombre VARCHAR(45))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla actividad
    RETURN QUERY SELECT AC.actividad_config_codigo, AC.actividad_config_nombre
    FROM actividad_configuracion AC;
END;
$$ LANGUAGE plpgsql;