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
