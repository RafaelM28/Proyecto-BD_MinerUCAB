-- Creación de una función lista_clientes()
CREATE OR REPLACE FUNCTION lista_clientes()
-- Esta función devuelve una tabla con información de los clientes
RETURNS TABLE (cliente_codigo SMALLINT, cliente_rif VARCHAR(20), cliente_denom_comercial VARCHAR(30), cliente_dir_fiscal VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla cliente
    RETURN QUERY SELECT C.persona_jur_codigo, C.persona_jur_rif, C.persona_jur_denominacion_comercial, C.persona_jur_direccion_fiscal
    FROM cliente C
    -- Limita el número de resultados a 30
    LIMIT 30;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_aliados()
CREATE OR REPLACE FUNCTION lista_aliados()
RETURNS TABLE (aliado_codigo SMALLINT, aliado_rif VARCHAR(20), aliado_denom_comercial VARCHAR(30), aliado_dir_fiscal VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla aliado
    RETURN QUERY SELECT A.persona_jur_codigo, A.persona_jur_rif, A.persona_jur_denominacion_comercial, A.persona_jur_direccion_fiscal
    FROM aliado A
    -- Limita el número de resultados a 30
    LIMIT 30;
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
    WHERE E.empleado_codigo = CE.fk_empleado AND CE.fk_cargo = C.cargo_codigo
    -- Limita el número de resultados a 30
    LIMIT 30;
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
        WHEN U.fk_aliado IS NOT NULL THEN CAST((SELECT A.persona_jur_razon_social FROM aliado A WHERE A.persona_jur_codigo = U.fk_aliado) AS text)
        WHEN U.fk_cliente IS NOT NULL THEN CAST((SELECT C.persona_jur_razon_social FROM cliente C WHERE C.persona_jur_codigo = U.fk_cliente) AS text)
        WHEN U.fk_empleado IS NOT NULL THEN (SELECT E.empleado_primer_nombre||' '|| E.empleado_primer_apellido AS empleado_nombre FROM empleado E WHERE E.empleado_codigo = U.fk_empleado)
    END,
                  U.usuario_nombre, R.rol_nombre
FROM usuario U, rol R
WHERE U.fk_rol = R.rol_codigo
LIMIT 30;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_privilegios()
CREATE OR REPLACE FUNCTION lista_privilegios()
RETURNS TABLE (privilegio_codigo SMALLINT, privilegio_nombre VARCHAR(100))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla privilegio
    RETURN QUERY SELECT P.privilegio_codigo, P.privilegio_nombre
    FROM privilegio P
    -- Limita el número de resultados a 30
    LIMIT 30;
END;
$$ LANGUAGE plpgsql;

-- Creación de una función lista_roles()
CREATE OR REPLACE FUNCTION lista_roles()
RETURNS TABLE (rol_codigo SMALLINT, rol_nombre VARCHAR(50))
AS $$
BEGIN
    -- La consulta selecciona los campos de la tabla rol
    RETURN QUERY SELECT R.rol_codigo, R.rol_nombre
    FROM rol R
    -- Limita el número de resultados a 30
    LIMIT 30;
END;
$$ LANGUAGE plpgsql;
