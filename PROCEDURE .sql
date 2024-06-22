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