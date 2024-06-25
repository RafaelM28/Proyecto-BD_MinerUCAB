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
