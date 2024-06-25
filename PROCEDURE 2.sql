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