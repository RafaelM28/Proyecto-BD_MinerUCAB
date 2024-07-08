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
        (SELECT MAX(hist_est_pedido_compra_codigo) FROM historico_estatus_pedido_compra)+1,
        (SELECT estatus_pedido_codigo FROM estatus_pedido WHERE estatus_pedido_nombre = 'En proceso'),
        NEW.pedido_compra_numero, NEW.fk_aliado, CURRENT_TIMESTAMP );
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Creacion de una funcion check_update_hist_est_pedido_compra
CREATE OR REPLACE FUNCTION check_update_hist_est_pedido_compra()
RETURNS trigger AS $$
BEGIN
    -- Verifica si el estatus del pedido de compra era 'En proceso'
    -- Si es así, se inserta un nuevo registro en la tabla Historico_Estatus_Pedido_Compra con estatus 'Por pagar'
    IF OLD.fk_estatus_pedido = (SELECT EP.estatus_pedido_codigo FROM estatus_pedido EP WHERE EP.estatus_pedido_nombre = 'En proceso') THEN
            INSERT INTO historico_estatus_pedido_compra (hist_est_pedido_compra_codigo, fk_estatus_pedido, fk_pedido_compra_1, fk_pedido_compra_2, hist_est_pedido_compra_fecha_inicio, hist_est_pedido_compra_fecha_fin)
            VALUES
                ((SELECT MAX(hist_est_pedido_compra_codigo) FROM historico_estatus_pedido_compra)+1,
                (SELECT estatus_pedido_codigo FROM estatus_pedido WHERE estatus_pedido_nombre = 'Por pagar'),
                OLD.fk_pedido_compra_1, OLD.fk_pedido_compra_2, CURRENT_TIMESTAMP, NULL);

    -- Verifica si el estatus del pedido de compra era 'Por pagar'
    -- Si es así, se inserta un nuevo registro en la tabla Historico_Estatus_Pedido_Compra con estatus 'Pagado'
    ELSIF OLD.fk_estatus_pedido = (SELECT EP.estatus_pedido_codigo FROM estatus_pedido EP WHERE EP.estatus_pedido_nombre = 'Por pagar') THEN
            INSERT INTO historico_estatus_pedido_compra (hist_est_pedido_compra_codigo, fk_estatus_pedido, fk_pedido_compra_1, fk_pedido_compra_2, hist_est_pedido_compra_fecha_inicio, hist_est_pedido_compra_fecha_fin)
            VALUES
                ((SELECT MAX(hist_est_pedido_compra_codigo) FROM historico_estatus_pedido_compra)+1,
                (SELECT estatus_pedido_codigo FROM estatus_pedido WHERE estatus_pedido_nombre = 'Pagado'),
                OLD.fk_pedido_compra_1, OLD.fk_pedido_compra_2, CURRENT_TIMESTAMP, NULL);
    END IF;
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

    --Se actualiza el registro de Historico_Estatus_Pedido_Compra con la fecha de fin
    -- Esto activa un trigger check_update_hist_est_pedido_compra que inserta un nuevo registro con el estatus 'Pagado'
    UPDATE Historico_Estatus_Pedido_Compra HPC
    SET hist_est_pedido_compra_fecha_fin = CURRENT_TIMESTAMP
    WHERE HPC.hist_est_pedido_compra_codigo = (SELECT MAX(HPC_2.hist_est_pedido_compra_codigo)
                                                                                FROM historico_estatus_pedido_compra HPC_2
                                                                                WHERE HPC_2.fk_pedido_compra_1 = NEW.fk_pedido_compra_1);

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

-- Creación de un procedimiento almacenado para crear un usuario cliente
CREATE OR REPLACE PROCEDURE sp_crear_cliente(p_razon_social VARCHAR,p_rif VARCHAR,p_denominacion_comercial VARCHAR,capital NUMERIC,p_detalle_principal VARCHAR,p_detalle_fiscal VARCHAR,p_estado_principal SMALLINT,p_municipio_principal SMALLINT,p_parroquia_principal SMALLINT,p_estado_fiscal SMALLINT,p_municipio_fiscal SMALLINT,p_parroquia_fiscal SMALLINT,p_correo_electronico VARCHAR,p_telefono_prefijo VARCHAR,p_telefono_numero VARCHAR,p_telefono_tipo VARCHAR,p_nombre_usuario VARCHAR,p_clave VARCHAR,p_confirmar_clave VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que la clave y la confirmación de clave sean iguales
    IF p_clave != p_confirmar_clave THEN
        RAISE EXCEPTION 'La clave y la confirmación de clave no coinciden';
    END IF;

    -- Insertar los datos en la tabla de empresas
    INSERT INTO Cliente (persona_jur_codigo,persona_jur_razon_social,persona_jur_RIF,persona_jur_denominacion_comercial,persona_jur_capital_total,persona_jur_direccion_fiscal,persona_jur_direccion_principal,fk_lugar_1,fk_lugar_2) VALUES
	((SELECT MAX(persona_jur_codigo) FROM Cliente)+1,p_razon_social,p_rif,p_denominacion_comercial,capital,p_detalle_fiscal,p_detalle_principal,
        (SELECT pa.lugar_codigo
        From Lugar e, Lugar mu, Lugar pa
        Where e.lugar_codigo = mu.fk_lugar and mu.lugar_codigo = pa.fk_lugar and e.lugar_codigo = p_estado_principal and mu.lugar_codigo = p_municipio_principal and pa.lugar_codigo = p_parroquia_principal),
        (SELECT pa.lugar_codigo
        From Lugar e, Lugar mu, Lugar pa
        Where e.lugar_codigo = mu.fk_lugar and mu.lugar_codigo = pa.fk_lugar and e.lugar_codigo = p_estado_fiscal and mu.lugar_codigo = p_municipio_fiscal and pa.lugar_codigo = p_parroquia_fiscal));


	If p_correo_electronico IS NOT NULL then
		INSERT INTO Correo (correo_codigo,correo_nombre,fk_cliente) VALUES
		((SELECT MAX(correo_codigo) FROM Correo)+1,p_correo_electronico,(SELECT MAX(persona_jur_codigo) FROM Cliente));
	END IF;

	If p_telefono_prefijo IS NOT NULL AND p_telefono_numero IS NOT NULL then
		INSERT INTO Telefono (telefono_codigo,telefono_prefijo,telefono_numero,telefono_tipo,fk_cliente) VALUES
		((SELECT MAX(telefono_codigo) FROM Telefono)+1,p_telefono_prefijo,p_telefono_numero,p_telefono_tipo,(SELECT MAX(persona_jur_codigo) FROM Cliente));
	END IF;

    -- Insertar los datos en la tabla de usuarios
    INSERT INTO Usuario (usuario_codigo,usuario_nombre,usuario_clave,fk_cliente,fk_rol) VALUES
	((SELECT MAX(usuario_codigo) FROM Usuario)+1,p_nombre_usuario,p_clave,(SELECT MAX(persona_jur_codigo) FROM Cliente),(Select rol_codigo
																			   From Rol
																			   Where rol_nombre = 'Cliente'));
END;
$$;

-- Creación de un procedimiento almacenado para crear una solicitud de compra
CREATE OR REPLACE PROCEDURE sp_crear_solicitud_compra(aliado_codigo INTEGER, detalle_compra tipo_detalle_compra[])
LANGUAGE plpgsql
AS $$
DECLARE
    fila tipo_detalle_compra;
    pedido_monto_subtil NUMERIC(10,2) = 0;
BEGIN
    -- Insertar los datos en la tabla de solicitud de compra
    INSERT INTO Pedido_Compra (pedido_compra_numero,fk_aliado,pedido_compra_fecha_emision,pedido_compra_monto_subtil,pedido_compra_monto_total) VALUES
    ((SELECT MAX(pedido_compra_numero) FROM Pedido_Compra)+1,aliado_codigo,CURRENT_DATE,0,0);

    -- Ciclo para recorrer cada fila de la tabla detalle_compra (pasada como parámetro)
    FOREACH  fila IN ARRAY detalle_compra LOOP

        -- Insertar los datos en la tabla Inventario Producto en base a los datos de la fila
        INSERT INTO inventario_producto (inventario_producto_codigo, fk_mineral, inventario_producto_cantidad_total, inventario_producto_operacion, inventario_producto_tipo_operacion, inventario_producto_fecha_movimiento)
        VALUES ((SELECT MAX(inventario_producto_codigo) FROM inventario_producto)+1,
                (SELECT mineral_codigo FROM mineral WHERE mineral_codigo = fila.detalle_mineral),
                (SELECT I.inventario_producto_cantidad_total FROM inventario_producto I WHERE I.inventario_producto_codigo = (SELECT MAX(IP.inventario_producto_codigo) FROM inventario_producto IP WHERE IP.fk_mineral = fila.detalle_mineral)),
                NULL, NULL, NULL);

        -- Insertar los datos en la tabla Detalle Pedido Compra en base a los datos de la fila
        INSERT INTO detalle_pedido_compra (detalle_pedido_compra_codigo, fk_pedido_compra_1, fk_pedido_compra_2, fk_inventario_producto_1, fk_inventario_producto_2, detalle_compra_cantidad_mineral, detalle_compra_precio_unitario)
        VALUES ((SELECT MAX(detalle_pedido_compra_codigo) FROM detalle_pedido_compra)+1,
                (SELECT MAX(pedido_compra_numero) FROM Pedido_Compra),
                aliado_codigo,
                (SELECT MAX(inventario_producto_codigo) FROM inventario_producto),
                fila.detalle_mineral, fila.detalle_cantidad, fila.detalle_precio);

        -- Actualizar el monto total del pedido de compra (variable) en base al precio de la fila
        pedido_monto_subtil = pedido_monto_subtil + (fila.detalle_precio*fila.detalle_cantidad);
    END LOOP;
    -- Actualizar el monto subtil del pedido de compra en base al precio de la fila
    UPDATE Pedido_Compra SET pedido_compra_monto_subtil = pedido_monto_subtil, pedido_compra_monto_total = (pedido_monto_subtil*1.16) WHERE pedido_compra_numero = (SELECT MAX(pedido_compra_numero) FROM Pedido_Compra);
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

-- Creación de una función lista_minerales_home()
CREATE OR REPLACE FUNCTION lista_minerales_home()
RETURNS TABLE (mineral_nombre VARCHAR(50))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla mineral
    RETURN QUERY SELECT M.mineral_nombre
    FROM mineral M
    ORDER BY M.mineral_codigo;
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
    FROM pedido_compra PC, aliado A, historico_estatus_pedido_compra HPC, estatus_pedido EP,
              (SELECT HPC.fk_pedido_compra_1, MAX(HPC.hist_est_pedido_compra_codigo) FROM historico_estatus_pedido_compra HPC GROUP BY HPC.fk_pedido_compra_1) AS Ultimo_Estatus
    WHERE PC.fk_aliado = A.persona_jur_codigo AND PC.pedido_compra_numero = Ultimo_Estatus.fk_pedido_compra_1
                AND HPC.hist_est_pedido_compra_codigo = Ultimo_Estatus.max AND HPC.fk_estatus_pedido = EP.estatus_pedido_codigo;
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

-- Creación de una función lista_estados()
CREATE OR REPLACE FUNCTION lista_estados()
RETURNS TABLE (lugar_codigo SMALLINT, lugar_nombre VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla Lugar
    RETURN QUERY SELECT L.lugar_codigo, L.lugar_nombre
    FROM lugar L
    WHERE L.lugar_tipo = 'Estado';
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_municipios()
CREATE OR REPLACE FUNCTION lista_municipios(estado_id SMALLINT)
RETURNS TABLE (lugar_codigo SMALLINT, lugar_nombre VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla Lugar
    RETURN QUERY SELECT L.lugar_codigo, L.lugar_nombre
    FROM lugar L
    WHERE L.lugar_tipo = 'Municipio' AND L.fk_lugar = estado_id;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_parroquias()
CREATE OR REPLACE FUNCTION lista_parroquias(municipio_id SMALLINT)
RETURNS TABLE (lugar_codigo SMALLINT, lugar_nombre VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla Lugar
    RETURN QUERY SELECT L.lugar_codigo, L.lugar_nombre
    FROM lugar L
    WHERE L.lugar_tipo = 'Parroquia' AND L.fk_lugar = municipio_id;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_aliados_solicitud()
CREATE OR REPLACE FUNCTION lista_aliados_solicitud()
RETURNS TABLE (aliado_codigo SMALLINT, aliado_nombre VARCHAR(50))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla aliado
    RETURN QUERY SELECT A.persona_jur_codigo, A.persona_jur_denominacion_comercial
    FROM aliado A;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_minerales_solicitud()
CREATE OR REPLACE FUNCTION lista_minerales_solicitud(aliado_id INTEGER)
RETURNS TABLE (mineral_codigo SMALLINT, mineral_nombre VARCHAR(30))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla mineral e inventario_yacim_mineral
    RETURN QUERY SELECT IYM.fk_mineral, M.mineral_nombre
    FROM inventario_yacim_mineral IYM, mineral M
    WHERE IYM.fk_aliado = aliado_id AND M.mineral_codigo = IYM.fk_mineral;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función ver_solicitud_compra()
CREATE OR REPLACE FUNCTION ver_solicitud_compra(pedido_compra_id SMALLINT)
RETURNS TABLE (pedido_compra_fecha_emision DATE, estatus_pedido_nombre VARCHAR(15), aliado_id SMALLINT, aliado_nombre VARCHAR(45), aliado_rif VARCHAR(20), aliado_correo VARCHAR(50),
               aliado_direccion VARCHAR(100), aliado_telefono VARCHAR(15), ucab_emp VARCHAR(35), fecha_pago DATE, venta_asociada SMALLINT, pedido_compra_monto_total NUMERIC(10,2))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla pedido_compra y tablas asociadas a ella
    RETURN QUERY SELECT P.pedido_compra_fecha_emision, EP.estatus_pedido_nombre, A.persona_jur_codigo, A.persona_jur_razon_social, A.persona_jur_rif,
                        -- Se utiliza COALESCE para manejar valores nulos en caso de que no existan registros asociados
                        COALESCE(C.correo_nombre, NULL) AS correo, A.persona_jur_direccion_fiscal, COALESCE((T.telefono_prefijo||'-'||T.telefono_numero), NULL) AS aliado_telefono,
                        COALESCE(E.empleado_primer_nombre||' '||E.empleado_primer_apellido, NULL) AS ucab_emp, COALESCE(PC.pago_compra_fecha_emision, NULL) AS fecha_pago,
                        COALESCE(PCV.fk_pedido_venta_1, NULL) AS venta_asociada, P.pedido_compra_monto_total

    FROM pedido_compra P INNER JOIN historico_estatus_pedido_compra HPC ON P.pedido_compra_numero = HPC.fk_pedido_compra_1,
         historico_estatus_pedido_compra HPC INNER JOIN estatus_pedido EP ON HPC.fk_estatus_pedido = EP.estatus_pedido_codigo,
         aliado A LEFT JOIN correo C ON A.persona_jur_codigo = C.fk_aliado, aliado A LEFT JOIN telefono T ON A.persona_jur_codigo = T.fk_aliado,
         aliado AUCAB LEFT JOIN empleado E ON AUCAB.persona_jur_codigo = E.fk_aliado_1,
         pago_compra PC LEFT JOIN pedido_compra P ON (PC.fk_pedido_compra_1 = P.pedido_compra_numero AND PC.fk_pedido_compra_2 = P.fk_aliado),
        pedido_compra P LEFT JOIN pedido_compra_venta PCV ON P.pedido_compra_numero = PCV.fk_pedido_compra_1

    WHERE P.pedido_compra_numero = pedido_compra_id AND P.fk_aliado = A.persona_jur_codigo AND AUCAB.persona_jur_denominacion_comercial = 'MinerUCAB';
END;
$$ LANGUAGE plpgsql;

-- Creación de una función update_estatus_pedido_compra()
CREATE OR REPLACE PROCEDURE update_estatus_pedido_compra (IN pedido_compra_id SMALLINT, IN aliado_id SMALLINT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Actualiza el registro de Historico_Estatus_Pedido_Compra con la fecha de fin
    UPDATE historico_estatus_pedido_compra HPC
    SET hist_est_pedido_compra_fecha_fin = CURRENT_TIMESTAMP
    WHERE HPC.hist_est_pedido_compra_codigo = (SELECT MAX(HPC_2.hist_est_pedido_compra_codigo)
                                                                                FROM historico_estatus_pedido_compra HPC_2
                                                                                WHERE HPC_2.fk_pedido_compra_1 = pedido_compra_id AND HPC_2.fk_pedido_compra_2 = aliado_id);
END;
$$;

-- Creación de una función obtener_metodos_pago()
CREATE OR REPLACE FUNCTION obtener_metodos_pago(cliente_id SMALLINT)
RETURNS TABLE (metodo_codigo SMALLINT, metodo_pago VARCHAR(30), tipo_metodo text)
AS $$
BEGIN
    RETURN QUERY
        -- La consulta selecciona los campos de las tablas tarjeta_debito, tarjeta_credito, efectivo y cheque
        -- Se utiliza UNION para unir los resultados de las consultas en tres columnas
        SELECT TD.metodo_pago_codigo, TD.tdb_numero, 'Tarjeta de Débito'
                FROM tarjeta_debito TD
                WHERE TD.fk_cliente = cliente_id
        UNION
            SELECT TC.metodo_pago_codigo, TC.tdc_numero, 'Tarjeta de Crédito'
                FROM tarjeta_credito TC
                WHERE TC.fk_cliente = cliente_id
        UNION
            SELECT E.metodo_pago_codigo, (CAST(E.efectivo_denominacion AS varchar)||' '||'$') AS dolares, 'Efectivo'
                FROM efectivo E
                WHERE E.fk_cliente = cliente_id
        UNION
            SELECT CH.metodo_pago_codigo, CAST(CH.cheque_numero AS varchar), 'Cheque'
                FROM cheque CH
                WHERE CH.fk_cliente = cliente_id;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función obtener_detalles_pedido_compra()
CREATE OR REPLACE FUNCTION obtener_detalles_pedido_compra(pedido_compra_id SMALLINT)
RETURNS TABLE (mineral_codigo SMALLINT, mineral_nombre VARCHAR(30), cantidad_mineral SMALLINT, precio_unitario NUMERIC(10,2))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla detalle_pedido_compra y tablas asociadas a ella
    RETURN QUERY SELECT M.mineral_codigo, M.mineral_nombre, DPC.detalle_compra_cantidad_mineral, DPC.detalle_compra_precio_unitario
    FROM detalle_pedido_compra DPC, mineral M
    WHERE DPC.fk_pedido_compra_1 = pedido_compra_id AND DPC.fk_inventario_producto_2 = M.mineral_codigo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_pago_compra(pedido_compra_id SMALLINT, aliado_id SMALLINT)
RETURNS TABLE (tipo_metodo text, fecha_pago DATE)
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla pago_compra
    RETURN QUERY SELECT
        CASE
            WHEN PC.fk_tarjeta_debito IS NOT NULL THEN 'Tarjeta de Débito'
            WHEN PC.fk_tarjeta_credito IS NOT NULL THEN 'Tarjeta de Crédito'
            WHEN PC.fk_efectivo IS NOT NULL THEN 'Efectivo'
            WHEN PC.fk_cheque IS NOT NULL THEN 'Cheque'
        END AS tipo_metodo, pago_compra_fecha_emision
    FROM pago_compra PC
    WHERE PC.fk_pedido_compra_1 = pedido_compra_id AND PC.fk_pedido_compra_2 = aliado_id;
END;
$$ LANGUAGE plpgsql;

-- Creación de un procedimiento almacenado sp_crear_pago_compra
CREATE OR REPLACE PROCEDURE sp_crear_pago_compra (IN pedido_compra_id SMALLINT, IN aliado_id SMALLINT,  metodo_codigo SMALLINT, tipo_metodo text, IN monto_pedido NUMERIC(10,2), IN fecha_pago DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Se utiliza un CASE para insertar el pago de compra según el tipo de método de pago
    CASE
        -- Si el tipo de método de pago es 'Tarjeta de Débito', se inserta el pago de compra con el método de pago correspondiente
        WHEN tipo_metodo = 'Tarjeta de Débito' THEN
                INSERT INTO pago_compra (pago_compra_codigo, fk_tarjeta_debito, fk_tarjeta_credito, fk_efectivo, fk_cheque, fk_pedido_compra_1, fk_pedido_compra_2, pago_compra_monto, pago_compra_fecha_emision)
                VALUES
                        ((SELECT MAX(pago_compra_codigo) FROM pago_compra)+1,
                        metodo_codigo, NULL, NULL, NULL,
                        pedido_compra_id, aliado_id, monto_pedido, fecha_pago);
        -- Si el tipo de método de pago es 'Tarjeta de Crédito', se inserta el pago de compra con el método de pago correspondiente
        WHEN tipo_metodo = 'Tarjeta de Crédito' THEN
                INSERT INTO pago_compra (pago_compra_codigo, fk_tarjeta_debito, fk_tarjeta_credito, fk_efectivo, fk_cheque, fk_pedido_compra_1, fk_pedido_compra_2, pago_compra_monto, pago_compra_fecha_emision)
                VALUES
                        ((SELECT MAX(pago_compra_codigo) FROM pago_compra)+1,
                        NULL, metodo_codigo, NULL, NULL,
                        pedido_compra_id, aliado_id, monto_pedido, fecha_pago);
        -- Si el tipo de método de pago es 'Efectivo', se inserta el pago de compra con el método de pago correspondiente
        WHEN tipo_metodo = 'Efectivo' THEN
                INSERT INTO pago_compra (pago_compra_codigo, fk_tarjeta_debito, fk_tarjeta_credito, fk_efectivo, fk_cheque, fk_pedido_compra_1, fk_pedido_compra_2, pago_compra_monto, pago_compra_fecha_emision)
                VALUES
                        ((SELECT MAX(pago_compra_codigo) FROM pago_compra)+1,
                        NULL, NULL, metodo_codigo, NULL,
                        pedido_compra_id, aliado_id, monto_pedido, fecha_pago);
        -- Si el tipo de método de pago es 'Cheque', se inserta el pago de compra con el método de pago correspondiente
        WHEN tipo_metodo = 'Cheque' THEN
                INSERT INTO pago_compra (pago_compra_codigo, fk_tarjeta_debito, fk_tarjeta_credito, fk_efectivo, fk_cheque, fk_pedido_compra_1, fk_pedido_compra_2, pago_compra_monto, pago_compra_fecha_emision)
                VALUES
                        ((SELECT MAX(pago_compra_codigo) FROM pago_compra)+1,
                        NULL, NULL, NULL, metodo_codigo,
                        pedido_compra_id, aliado_id, monto_pedido, fecha_pago);
    END CASE;
END;
$$;