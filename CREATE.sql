CREATE TABLE Privilegio (
    -- Código del privilegio
    privilegio_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del privilegio
    privilegio_nombre VARCHAR(30) NOT NULL  UNIQUE,

    -- Restricción de clave primaria
    CONSTRAINT pk_privilegio PRIMARY KEY (privilegio_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_privilegio_nombre CHECK (privilegio_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Rol (
    -- Código del rol
    rol_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del rol
    rol_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del rol
    rol_descripcion VARCHAR(100) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_rol PRIMARY KEY (rol_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_rol_nombre CHECK (rol_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_rol_descripcion CHECK (rol_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Rol_Privilegio (
    -- Clave foránea del rol
    fk_rol SMALLINT NOT NULL,
    -- Clave foránea del privilegio
    fk_privilegio SMALLINT NOT NULL,

    -- Restrición de clave primaria compuesta
    CONSTRAINT pk_rol_privilegio PRIMARY KEY (fk_rol, fk_privilegio),
    -- Restricción de clave foránea que referencia a la tabla ROL
    CONSTRAINT fk_rol FOREIGN KEY (fk_rol) REFERENCES ROL (rol_codigo),
    -- Restricción de clave foránea que referencia a la tabla Privilegio
    CONSTRAINT fk_privilegio FOREIGN KEY (fk_privilegio) REFERENCES Privilegio (privilegio_codigo)
);

CREATE TABLE Lugar (
    -- Código del lugar
    lugar_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del lugar
    lugar_nombre VARCHAR(100) NOT NULL,
    -- Tipo del lugar
    lugar_tipo VARCHAR(15) NOT NULL,
    -- Clave foránea del lugar
    fk_lugar SMALLINT,

    -- Restricción de clave primaria
    CONSTRAINT pk_lugar PRIMARY KEY (lugar_codigo),
    -- Restricción para verificar que el nombre contenga letras, espacios y números
    CONSTRAINT check_lugar_nombre CHECK (lugar_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que el tipo sea 'Estado', 'Municipio' o 'Parroquia'
    CONSTRAINT check_lugar_tipo CHECK (lugar_tipo IN ('Estado', 'Municipio', 'Parroquia')),
    -- Restricción de clave foránea que referencia a la tabla LUGAR
    CONSTRAINT fk_lugar FOREIGN KEY (fk_lugar) REFERENCES Lugar (lugar_codigo)
);

CREATE TABLE Aliado (
    -- Código del aliado
    persona_jur_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- RIF del aliado
    persona_jur_RIF VARCHAR(20) NOT NULL UNIQUE,
    -- Razón social del aliado
    persona_jur_razon_social VARCHAR(45) NOT NULL UNIQUE,
    -- Denominación comercial del aliado
    persona_jur_denominacion_comercial VARCHAR(30) NOT NULL UNIQUE,
    -- Capital total del aliado
    persona_jur_capital_total NUMERIC(15,2) NOT NULL,
    -- Dirección fiscal del aliado
    persona_jur_direccion_fiscal VARCHAR(100) NOT NULL,
    -- Dirección principal del aliado
    persona_jur_direccion_principal VARCHAR(100) NOT NULL,
    -- Clave foránea del lugar 1 para dirección fiscal
    fk_lugar_1 SMALLINT NOT NULL,
    -- Clave foránea del lugar 2 para dirección principal
    fk_lugar_2 SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_aliado PRIMARY KEY (persona_jur_codigo),
    -- Restricción para verificar que el RIF comienza con una letra (J, V, E, P o G) y luego le siguen 9 a 10 dígitos
    CONSTRAINT check_persona_jur_RIF CHECK (persona_jur_RIF ~ '^[VEJPG]{1}[0-9]{9,10}$'),
    -- Restricción para verificar que la razón social solo contenga letras y espacios
    CONSTRAINT check_aliado_razon_social CHECK (persona_jur_razon_social ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la denominación comercial solo contenga letras y espacios
    CONSTRAINT check_aliado_denominacion_comercial CHECK (persona_jur_denominacion_comercial ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
     -- Restricción para verificar que el capital total sea mayor a 0
    CONSTRAINT check_persona_jur_capital_total CHECK (persona_jur_capital_total > 0),
    -- Restricción para verificar que la dirección fiscal contenga letras, espacios y números
    CONSTRAINT check_aliado_direccion_fiscal CHECK (persona_jur_direccion_fiscal ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la dirección principal contenga letras, espacios y números
    CONSTRAINT check_aliado_direccion_principal CHECK (persona_jur_direccion_principal ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción de clave foránea que referencia a la tabla LUGAR para el lugar 1
    CONSTRAINT fk_lugar_1 FOREIGN KEY (fk_lugar_1) REFERENCES Lugar (lugar_codigo),
    -- Restricción de clave foránea que referencia a la tabla LUGAR para el lugar 2
    CONSTRAINT fk_lugar_2 FOREIGN KEY (fk_lugar_2) REFERENCES Lugar (lugar_codigo)
);

CREATE TABLE Cliente (
    -- Código del cliente
    persona_jur_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- RIF del cliente
    persona_jur_RIF VARCHAR(20) NOT NULL UNIQUE,
    -- Razón social del cliente
    persona_jur_razon_social VARCHAR(45) NOT NULL UNIQUE,
    -- Denominación comercial del cliente
    persona_jur_denominacion_comercial VARCHAR(30) NOT NULL UNIQUE,
    -- Capital total del cliente
    persona_jur_capital_total NUMERIC(15,2) NOT NULL,
    -- Dirección fiscal del cliente
    persona_jur_direccion_fiscal VARCHAR(100) NOT NULL,
    -- Dirección principal del cliente
    persona_jur_direccion_principal VARCHAR(100) NOT NULL,
    -- Clave foránea del lugar 1 para dirección fiscal
    fk_lugar_1 SMALLINT NOT NULL,
    -- Clave foránea del lugar 2 para dirección principal
    fk_lugar_2 SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_cliente PRIMARY KEY (persona_jur_codigo),
    -- Restricción para verificar que el RIF comienza con una letra (J, V, E, P o G) y luego le siguen 9 a 10 dígitos
    CONSTRAINT check_persona_jur_RIF CHECK (persona_jur_RIF ~ '^[VEJPG]{1}[0-9]{9,10}$'),
    -- Restricción para verificar que la razón social solo contenga letras y espacios
    CONSTRAINT check_cliente_razon_social CHECK (persona_jur_razon_social ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la denominación comercial solo contenga letras y espacios
    CONSTRAINT check_cliente_denominacion_comercial CHECK (persona_jur_denominacion_comercial ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el capital total sea mayor a 0
    CONSTRAINT check_persona_jur_capital_total CHECK (persona_jur_capital_total > 0),
    -- Restricción para verificar que la dirección fiscal contenga letras, espacios y números
    CONSTRAINT check_cliente_direccion_fiscal CHECK (persona_jur_direccion_fiscal ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la dirección principal contenga letras, espacios y números
    CONSTRAINT check_cliente_direccion_principal CHECK (persona_jur_direccion_principal ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción de clave foránea que referencia a la tabla LUGAR para el lugar 1
    CONSTRAINT fk_lugar_1_cliente FOREIGN KEY (fk_lugar_1) REFERENCES Lugar (lugar_codigo),
    -- Restricción de clave foránea que referencia a la tabla LUGAR para el lugar 2
    CONSTRAINT fk_lugar_2_cliente FOREIGN KEY (fk_lugar_2) REFERENCES Lugar (lugar_codigo)
);

CREATE TABLE Empleado (
    -- Código del empleado
    empleado_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Cédula del empleado
    empleado_cedula VARCHAR(8) NOT NULL UNIQUE,
    -- RIF del empleado
    empleado_RIF VARCHAR(15) NOT NULL UNIQUE,
    -- Primer nombre del empleado
    empleado_primer_nombre VARCHAR(15) NOT NULL,
    -- Segundo nombre del empleado
    empleado_segundo_nombre VARCHAR(15),
    -- Primer apellido del empleado
    empleado_primer_apellido VARCHAR(15) NOT NULL,
    -- Segundo apellido del empleado
    empleado_segundo_apellido VARCHAR(30),
    -- Fecha de nacimiento del empleado
    empleado_fecha_nacimiento DATE NOT NULL,
    -- Detalle de dirección del empleado
    empleado_detalle_direccion VARCHAR(100) NOT NULL,
    -- Clave foránea del lugar
    fk_lugar SMALLINT NOT NULL,
    -- Clave foranea de cliente como representante del cliente
    fk_cliente SMALLINT,
    -- Clave foranea de aliado 1 como representante del aliado
    fk_aliado_1 SMALLINT,
    -- Clave foranea de aliado 2 como perteneciente al aliado
    fk_aliado_2 SMALLINT,

    -- Restricción de clave primaria
    CONSTRAINT pk_empleado PRIMARY KEY (empleado_codigo),
    -- Restricción para verificar que la cédula tenga de 6 a 8 dígitos y solo permita números
    CONSTRAINT check_empleado_cedula CHECK (empleado_cedula ~ '^[0-9]{6,8}$'),
    -- Restricción para verificar que el RIF comienza con una letra (J, V, E, P o G) y luego le siguen 9 a 10 dígitos
    CONSTRAINT check_empleado_RIF CHECK (empleado_RIF ~ '^[VEJPG]{1}[0-9]{9,10}$'),
    -- Restricción para verificar que el primer nombre solo contenga letras y espacios
    CONSTRAINT check_empleado_primer_nombre CHECK (empleado_primer_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el segundo nombre solo contenga letras y espacios
    CONSTRAINT check_empleado_segundo_nombre CHECK (empleado_segundo_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el primer apellido solo contenga letras y espacios
    CONSTRAINT check_empleado_primer_apellido CHECK (empleado_primer_apellido ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el segundo apellido solo contenga letras y espacios
    CONSTRAINT check_empleado_segundo_apellido CHECK (empleado_segundo_apellido ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la fecha de nacimiento corresponda a una persona de 18 años o más
    CONSTRAINT check_empleado_fecha_nacimiento CHECK (empleado_fecha_nacimiento <= (CURRENT_DATE - INTERVAL '18 years')),
    -- Restricción para verificar que el detalle de dirección contenga letras, espacios y números
    CONSTRAINT check_empleado_detalle_direccion CHECK (empleado_detalle_direccion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción de clave foránea que referencia a la tabla LUGAR
    CONSTRAINT fk_lugar_empleado FOREIGN KEY (fk_lugar) REFERENCES Lugar (lugar_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_empleado FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_1_empleado FOREIGN KEY (fk_aliado_1) REFERENCES Aliado (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_2_empleado FOREIGN KEY (fk_aliado_2) REFERENCES Aliado (persona_jur_codigo)
);

CREATE TABLE Usuario (
    -- Código del usuario
    usuario_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de usuario
    usuario_nombre VARCHAR(15) NOT NULL UNIQUE,
    -- Contraseña del usuario
    usuario_clave VARCHAR(8) NOT NULL,
    -- Clave foránea del empleado
    fk_empleado SMALLINT,
    -- Clave foránea del aliado
    fk_aliado SMALLINT,
    -- Clave foránea del cliente
    fk_cliente SMALLINT,
    -- Clave foránea del rol
    fk_rol SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_usuario PRIMARY KEY (usuario_codigo),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_usuario FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_usuario FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_usuario FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla ROL
    CONSTRAINT fk_rol_usuario FOREIGN KEY (fk_rol) REFERENCES Rol (rol_codigo)
);

CREATE TABLE Correo (
    -- Código del correo
    correo_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de correo
    correo_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Clave foránea del empleado
    fk_empleado SMALLINT,
    -- Clave foránea del aliado
    fk_aliado SMALLINT,
    -- Clave foránea del cliente
    fk_cliente SMALLINT,

    -- Restricción de clave primaria
    CONSTRAINT pk_correo PRIMARY KEY (correo_codigo),
    -- Restricción para verificar que el nombre de correo sea válida
    CONSTRAINT check_correo_nombre CHECK (correo_nombre ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_correo FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_correo FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_correo FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo)
);

CREATE TABLE Telefono
(
    -- Código del teléfono
    telefono_codigo  SMALLSERIAL NOT NULL UNIQUE,
    -- Prefijo del teléfono
    telefono_prefijo VARCHAR(4)  NOT NULL,
    -- Número de teléfono
    telefono_numero  VARCHAR(7)  NOT NULL UNIQUE,
    -- Tipo de teléfono
    telefono_tipo    VARCHAR(20) NOT NULL,
    -- Clave foránea del empleado
    fk_empleado SMALLINT,
    -- Clave foránea del aliado
    fk_aliado SMALLINT,
    -- Clave foránea del cliente
    fk_cliente SMALLINT,

    -- Restricción de clave primaria
    CONSTRAINT pk_telefono PRIMARY KEY (telefono_codigo),
    -- Restricción para verificar que el número de teléfono sea válido
    CONSTRAINT check_telefono_numero CHECK (telefono_numero ~ '^[0-9]{7}$'),
    -- Restricción para verificar que el prefijo del teléfono sea válido
    CONSTRAINT check_telefono_prefijo CHECK (telefono_prefijo ~ '^[0-9]{4}$'),
    -- Restricción para verificar que el prefijo y el número de teléfono sean únicos
    CONSTRAINT check_telefono_prefijo_numero UNIQUE (telefono_prefijo, telefono_numero),
    -- Restricción para verificar que el tipo de teléfono sea 'Personal', 'Oficina', 'Principal' o 'Casa'
    CONSTRAINT check_telefono_tipo CHECK (telefono_tipo IN ('Personal', 'Oficina', 'Principal', 'Casa')),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_telefono FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_telefono FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo)
);

CREATE TABLE Beneficio (
    -- Código del beneficio
    beneficio_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del beneficio
    beneficio_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del beneficio
    beneficio_descripcion VARCHAR(100),
    -- Fecha de inicio del beneficio
    beneficio_tipo  VARCHAR(15) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_beneficio PRIMARY KEY (beneficio_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_beneficio_nombre CHECK (beneficio_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_beneficio_descripcion CHECK (beneficio_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el tipo sea 'Semanal', 'Quincenal' o 'Mensual'
    CONSTRAINT check_beneficio_tipo CHECK (beneficio_tipo IN ('Semanal', 'Quincenal', 'Mensual'))
);

CREATE TABLE Empleado_Beneficio (
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Clave foránea del beneficio
    fk_beneficio SMALLINT NOT NULL,
    -- Monto del beneficio
    emp_benef_monto NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria compuesta
    CONSTRAINT pk_empleado_beneficio PRIMARY KEY (fk_empleado, fk_beneficio),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_beneficio FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla BENEFICIO
    CONSTRAINT fk_beneficio_beneficio FOREIGN KEY (fk_beneficio) REFERENCES Beneficio (beneficio_codigo),
    -- Restricción para verificar que el monto sea mayor a 0
    CONSTRAINT check_emp_benef_monto CHECK (emp_benef_monto > 0)
);

CREATE TABLE Horario (
    -- Código del horario
    horario_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Día de la semana
    horario_dia VARCHAR(15) NOT NULL,
    -- Hora de entrada
    horario_hora_entrada TIME NOT NULL,
    -- Hora de salida
    horario_hora_salida TIME NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_horario PRIMARY KEY (horario_codigo),
    -- Restricción para verificar que el día sea 'Lunes', 'Martes', 'Miércoles', 'Jueves' o 'Viernes'
    CONSTRAINT check_horario_dia CHECK (horario_dia IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'))
);

CREATE TABLE Empleado_Horario (
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Clave foránea del horario
    fk_horario SMALLINT NOT NULL,

    -- Restricción de clave primaria compuesta
    CONSTRAINT pk_empleado_horario PRIMARY KEY (fk_empleado, fk_horario),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_horario FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla HORARIO
    CONSTRAINT fk_horario_horario FOREIGN KEY (fk_horario) REFERENCES Horario (horario_codigo)
);

CREATE TABLE Cargo (
    -- Código del cargo
    cargo_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del cargo
    cargo_nombre VARCHAR(15) NOT NULL UNIQUE,
    -- Descripción del cargo
    cargo_descripcion VARCHAR(100) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_cargo PRIMARY KEY (cargo_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_cargo_nombre CHECK (cargo_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_cargo_descripcion CHECK (cargo_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Contrato_Empleado (
    -- Código del contrato
    contrato_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del cargo
    fk_cargo SMALLINT NOT NULL,
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Fecha de inicio del contrato
    emp_cargo_fecha_ingreso DATE NOT NULL,
    -- Fecha de fin del contrato
    emp_cargo_fecha_salida DATE,

    -- Restricción de clave primaria
    CONSTRAINT pk_contrato PRIMARY KEY (contrato_codigo, fk_empleado, fk_cargo),
    -- Restricción para verificar que la fecha de inicio sea menor o igual a la fecha de fin
    CONSTRAINT check_contrato_fecha CHECK (emp_cargo_fecha_ingreso <= emp_cargo_fecha_salida),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_contrato FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla CARGO
    CONSTRAINT fk_cargo_contrato FOREIGN KEY (fk_cargo) REFERENCES Cargo (cargo_codigo)
);

CREATE TABLE Estatus_Disponibilidad (
    -- Código del estatus
    estatus_disponibilidad_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del estatus
    estatus_disponibilidad_nombre VARCHAR(15) NOT NULL UNIQUE,
    -- Descripción del estatus
    estatus_disponibilidad_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_estatus PRIMARY KEY (estatus_disponibilidad_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_estatus_disponibilidad_nombre CHECK (estatus_disponibilidad_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_estatus_disponibilidad_descripcion CHECK (estatus_disponibilidad_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Historico_Estatus_Empleado (
    -- Código del historico
    hist_est_empleado_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del estatus
    fk_estatus_disponibilidad SMALLINT NOT NULL,
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_empl_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_emplo_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus PRIMARY KEY (hist_est_empleado_codigo, fk_empleado, fk_estatus_disponibilidad),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_historico_estatus FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_DISPONIBILIDAD
    CONSTRAINT fk_estatus_historico_estatus FOREIGN KEY (fk_estatus_disponibilidad) REFERENCES Estatus_Disponibilidad (estatus_disponibilidad_codigo)
);

CREATE TABLE Mineral (
    -- Código del mineral
    mineral_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del mineral
    mineral_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del mineral
    mineral_descripcion VARCHAR(100),
    -- Nivel de dureza del mineral
    mineral_dureza SMALLINT,
    -- Porcentaje de composición del mineral
    mineral_porcentaje_composicion REAL,
    -- Grado de transparencia del mineral
    mineral_transparencia VARCHAR(15),
    -- Tipo de rayado del mineral
    mineral_rayado VARCHAR(20),
    -- Grado de exfoliación del mineral
    mineral_exfoliacion VARCHAR(10),
    -- Tipo de fractura del mineral
    mineral_fractura VARCHAR(30),
    -- Medida de densidad del mineral
    mineral_densidad REAL,
    -- Grado de hábito cristalino del mineral
    mineral_habito_cristalino VARCHAR(15),
    -- Nivel de brillo del mineral metálico
    metalicos_brillo SMALLINT,
    -- Grado de conductividad del mineral metálico
    metalicos_conductividad VARCHAR(10),
    -- Grado de tenacidad del mineral metálico
    no_metalicos_tenacidad VARCHAR(10),
    -- Tipo de mineral
    mineral_tipo VARCHAR(15) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_mineral PRIMARY KEY (mineral_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_mineral_nombre CHECK (mineral_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_mineral_descripcion CHECK (mineral_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el nivel de dureza esté entre -1 y 10
    CONSTRAINT check_mineral_dureza CHECK (mineral_dureza BETWEEN -1 AND 10),
    -- Restricción para verificar que el porcentaje de composición esté entre 0.01 y 100
    CONSTRAINT check_mineral_porcentaje_composicion CHECK (mineral_porcentaje_composicion BETWEEN 0.01 AND 100),
    -- Restricción para verificar que el grado de transparencia sea 'Transparente', 'Opaco' o 'Translúcido'
    CONSTRAINT check_mineral_transparencia CHECK (mineral_transparencia IN ('Transparente', 'Opaco', 'Translúcido')),
    -- Restricción para verificar que el tipo de rayado solo contenga letras y espacios
    CONSTRAINT check_mineral_rayado CHECK (mineral_rayado ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el grado de exfoliación sea 'Excelente', 'Buena' o 'Pobre'
    CONSTRAINT check_mineral_exfoliacion CHECK (mineral_exfoliacion IN ('Excelente', 'Buena', 'Pobre')),
    -- Restricción para verificar que el tipo de fractura solo contenga letras y espacios
    CONSTRAINT check_mineral_fractura CHECK (mineral_fractura ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la medida de densidad esté entre 0.01 y 100
    CONSTRAINT check_mineral_densidad CHECK (mineral_densidad BETWEEN 0.01 AND 100),
    -- Restricción para verificar que el grado de hábito cristalino sea 'Aislado', 'Agregado' o 'Masa'
    CONSTRAINT check_mineral_habito_cristalino CHECK (mineral_habito_cristalino IN ('Aislado', 'Agregado', 'Masa')),
    -- Restricción para verificar que el nivel de brillo esté entre 1 y 10
    CONSTRAINT check_metalicos_brillo CHECK (metalicos_brillo BETWEEN 1 AND 10),
    -- Restricción para verificar que el grado de conductividad sea 'Baja', 'Media' o 'Alta'
    CONSTRAINT check_metalicos_conductividad CHECK (metalicos_conductividad IN ('Baja', 'Media', 'Alta')),
    -- Restricción para verificar que el grado de tenacidad sea 'Frágil', 'Dúctil', 'Maleable', 'Flexible' o 'Elástico'
    CONSTRAINT check_no_metalicos_tenacidad CHECK (no_metalicos_tenacidad IN ('Frágil', 'Dúctil', 'Maleable', 'Flexible', 'Elástico')),
    -- Restricción para verificar que el tipo de mineral sea 'Metálico' o 'No Metálico'
    CONSTRAINT check_metalicos_tipo CHECK (mineral_tipo IN ('Metálico', 'No Metálico'))
);

CREATE TABLE Yacimiento (
    -- Código del yacimiento
    yacimiento_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del yacimiento
    yacimiento_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del yacimiento
    yacimiento_descripcion VARCHAR(100),
    -- Fecha de descubrimiento del yacimiento
    yacimiento_periodo_origen VARCHAR(20) NOT NULL,
    -- Origen del yacimiento autóctono
    yacim_autoc_origen VARCHAR(30),
    -- Método de transporte del yacimiento alóctono
    yacim_aloc_transporte VARCHAR(30),
    -- Tipo de yacimiento
    yacimiento_tipo VARCHAR(15) NOT NULL,
    -- Clave foránea del lugar
    fk_lugar SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_yacimiento PRIMARY KEY (yacimiento_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_yacimiento_nombre CHECK (yacimiento_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_yacimiento_descripcion CHECK (yacimiento_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el periodo de origen solo contenga letras y espacios
    CONSTRAINT check_yacimiento_periodo_origen CHECK (yacimiento_periodo_origen ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el origen autóctono solo contenga letras y espacios
    CONSTRAINT check_yacim_autoc_origen CHECK (yacim_autoc_origen ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el método de transporte alóctono solo contenga letras y espacios
    CONSTRAINT check_yacim_aloc_transporte CHECK (yacim_aloc_transporte ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el tipo de yacimiento sea 'Autóctono' o 'Alóctono'
    CONSTRAINT check_yacimiento_tipo CHECK (yacimiento_tipo IN ('Autóctono', 'Alóctono')),
    -- Restricción de clave foránea que referencia a la tabla LUGAR
    CONSTRAINT fk_lugar_yacimiento FOREIGN KEY (fk_lugar) REFERENCES Lugar (lugar_codigo)
);

CREATE TABLE Inventario_Yacim_Mineral (
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,
    -- Clave foránea del yacimiento
    fk_yacimiento SMALLINT NOT NULL,
    -- Clave foránea del aliado
    fk_aliado SMALLINT,

    -- Restricción de clave primaria compuesta
    CONSTRAINT pk_inventario_yacim_mineral PRIMARY KEY (fk_yacimiento, fk_mineral),
    -- Restricción de clave foránea que referencia a la tabla YACIMIENTO
    CONSTRAINT fk_yacimiento_inventario_yacim_mineral FOREIGN KEY (fk_yacimiento) REFERENCES Yacimiento (yacimiento_codigo),
    -- Restricción de clave foránea que referencia a la tabla MINERAL
    CONSTRAINT fk_mineral_inventario_yacim_mineral FOREIGN KEY (fk_mineral) REFERENCES Mineral (mineral_codigo),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_inventario_yacim_mineral FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo)
);

CREATE TABLE Mina (
    -- ID de la mina
    mina_id SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la mina
    mina_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción de la mina
    mina_descripcion VARCHAR(100),
    -- Clave foránea del yacimiento
    fk_yacimiento SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_mina PRIMARY KEY (mina_ID, fk_yacimiento),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_mina_nombre CHECK (mina_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_mina_descripcion CHECK (mina_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción de clave foránea que referencia a la tabla YACIMIENTO
    CONSTRAINT fk_yacimiento_mina FOREIGN KEY (fk_yacimiento) REFERENCES Yacimiento (yacimiento_codigo)
);

CREATE TABLE Pozo (
    -- ID del pozo
    pozo_id SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del pozo
    pozo_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del pozo
    pozo_descripcion VARCHAR(100),
    -- Cantidad de metros del pozo
    pozo_cantidad_mts NUMERIC(10,2) NOT NULL,
    -- Capacidad del pozo
    pozo_capacidad_mineral INTEGER NOT NULL,
    -- Clave foránea de la mina 1
    fk_mina_1 SMALLINT NOT NULL,
    -- Clave foránea de la mina 2
    fk_mina_2 SMALLINT NOT NULL,
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_pozo PRIMARY KEY (pozo_id, fk_mina_1, fk_mina_2),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_pozo_nombre CHECK (pozo_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_pozo_descripcion CHECK (pozo_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la cantidad de metros sea mayor a 0
    CONSTRAINT check_pozo_cantidad_mts CHECK (pozo_cantidad_mts > 0),
    -- Restricción para verificar que la capacidad del pozo sea mayor o igual a 0
    CONSTRAINT check_pozo_capacidad_mineral CHECK (pozo_capacidad_mineral >= 0),
    -- Restricción de clave foránea que referencia a la tabla MINA para su primera y segunda PK
    CONSTRAINT fk_mina_pozo FOREIGN KEY (fk_mina_1, fk_mina_2) REFERENCES Mina (mina_id, fk_yacimiento),
    -- Restricción de clave foránea que referencia a la tabla MINERAL
    CONSTRAINT fk_mineral_pozo FOREIGN KEY (fk_mineral) REFERENCES Mineral (mineral_codigo)
);

CREATE TABLE Estatus_Pozo (
    -- Código del estatus
    estatus_pozo_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del estatus
    estatus_pozo_nombre VARCHAR(15) NOT NULL UNIQUE,
    -- Descripción del estatus
    estatus_pozo_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_estatus_pozo PRIMARY KEY (estatus_pozo_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_estatus_pozo_nombre CHECK (estatus_pozo_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_estatus_pozo_descripcion CHECK (estatus_pozo_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Historico_Estatus_Pozo (
    -- Código del historico
    hist_est_pozo_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del estatus
    fk_estatus_pozo SMALLINT NOT NULL,
    -- Clave foránea del pozo
    fk_pozo_1 SMALLINT NOT NULL,
    -- Clave foránea del pozo
    fk_pozo_2 SMALLINT NOT NULL,
    -- Clave foránea del pozo
    fk_pozo_3 SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_pozo_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_pozo_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_pozo PRIMARY KEY (hist_est_pozo_codigo, fk_pozo_1, fk_pozo_2, fk_pozo_3, fk_estatus_pozo),
    -- Restricción de clave foránea que referencia a la tabla POZO para su primera, segunda y tercera PK
    CONSTRAINT fk_pozo_historico_estatus_pozo FOREIGN KEY (fk_pozo_1, fk_pozo_2, fk_pozo_3) REFERENCES Pozo (pozo_id, fk_mina_1, fk_mina_2),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_POZO
    CONSTRAINT fk_estatus_historico_estatus_pozo FOREIGN KEY (fk_estatus_pozo) REFERENCES Estatus_Pozo (estatus_pozo_codigo)
);

CREATE TABLE Inventario_Producto (
    -- Código del inventario
    inventario_producto_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,
    -- Cantidad de producto
    inventario_producto_cantidad_total INTEGER NOT NULL,
    -- Cantidad de producto que ingresó en la operación
    inventario_producto_operacion INTEGER NOT NULL,
    -- Tipo de operación
    inventario_producto_tipo_operacion VARCHAR(15) NOT NULL,
    -- Fecha de la operación
    inventario_producto_fecha_movimiento DATE NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_inventario_producto PRIMARY KEY (inventario_producto_codigo, fk_mineral),
    -- Restricción para verificar que la cantidad total sea mayor o igual a 0
    CONSTRAINT check_inventario_producto_cantidad CHECK (inventario_producto_cantidad_total >= 0),
    -- Restricción para verificar que la cantidad de la operación sea mayor a 0
    CONSTRAINT check_inventario_producto_operacion CHECK (inventario_producto_operacion > 0),
    -- Restricción para verificar que el tipo de operación sea 'Ingreso' o 'Egreso'
    CONSTRAINT check_inventario_producto_tipo_operacion CHECK (inventario_producto_tipo_operacion IN ('Ingreso', 'Egreso')),
    -- Restricción de clave foránea que referencia a la tabla MINERAL
    CONSTRAINT fk_mineral_inventario_producto FOREIGN KEY (fk_mineral) REFERENCES Mineral (mineral_codigo)
);

CREATE TABLE Marca (
    -- Código de la marca
    marca_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la marca
    marca_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción de la marca
    marca_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_marca PRIMARY KEY (marca_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_marca_nombre CHECK (marca_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_marca_descripcion CHECK (marca_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Modelo (
    -- Código del modelo
    modelo_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea de la marca
    fk_marca SMALLINT NOT NULL,
    -- Nombre del modelo
    modelo_nombre VARCHAR(50) NOT NULL UNIQUE,
    -- Descripción del modelo
    modelo_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_modelo PRIMARY KEY (modelo_codigo, fk_marca),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_modelo_nombre CHECK (modelo_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_modelo_descripcion CHECK (modelo_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción de clave foránea que referencia a la tabla MARCA
    CONSTRAINT fk_marca_modelo FOREIGN KEY (fk_marca) REFERENCES Marca (marca_codigo)
);

CREATE TABLE Tipo_Recurso (
    -- Código del tipo de recurso
    tipo_recurso_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del tipo de recurso
    tipo_recurso_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del tipo de recurso
    tipo_recurso_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_tipo_recurso PRIMARY KEY (tipo_recurso_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_tipo_recurso_nombre CHECK (tipo_recurso_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_tipo_recurso_descripcion CHECK (tipo_recurso_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Recurso (
    -- Código del recurso
    recurso_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del recurso
    recurso_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Número de serie del recurso
    recurso_numero_serie VARCHAR(15) NOT NULL UNIQUE,
    -- Descripción del recurso
    recurso_descripcion VARCHAR(100),
    -- Clave foránea del modelo 1
    fk_modelo_1 SMALLINT NOT NULL,
    -- Clave foránea del modelo 2
    fk_modelo_2 SMALLINT NOT NULL,
    -- Clave foránea del tipo de recurso
    fk_tipo_recurso SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_recurso PRIMARY KEY (recurso_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_recurso_nombre CHECK (recurso_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que el número de serie solo contenga letras, números y espacios
    CONSTRAINT check_recurso_numero_serie CHECK (recurso_numero_serie ~ '^[a-zA-Z0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_recurso_descripcion CHECK (recurso_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción de clave foránea que referencia a la tabla MODELO para su primera y segunda PK
    CONSTRAINT fk_modelo_recurso FOREIGN KEY (fk_modelo_1, fk_modelo_2) REFERENCES Modelo (modelo_codigo, fk_marca),
    -- Restricción de clave foránea que referencia a la tabla TIPO_RECURSO
    CONSTRAINT fk_tipo_recurso_recurso FOREIGN KEY (fk_tipo_recurso) REFERENCES Tipo_Recurso (tipo_recurso_codigo)
);

CREATE TABLE Inventario_Recurso (
    -- Código del inventario
    inventario_recurso_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del recurso
    fk_recurso SMALLINT NOT NULL UNIQUE,
    -- Cantidad de recurso
    inventario_recurso_cantidad_total INTEGER NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_inventario_recurso PRIMARY KEY (inventario_recurso_codigo, fk_recurso),
    -- Restricción para verificar que la cantidad total sea mayor o igual a 0
    CONSTRAINT check_inventario_recurso_cantidad CHECK (inventario_recurso_cantidad_total >= 0),
    -- Restricción de clave foránea que referencia a la tabla RECURSO
    CONSTRAINT fk_recurso_inventario_recurso FOREIGN KEY (fk_recurso) REFERENCES Recurso (recurso_codigo)
);

CREATE TABLE Inventario_Concesion_Recurso (
    -- Clave foránea del recurso
    fk_recurso SMALLINT NOT NULL,
    -- Clave foránea del aliado
    fk_aliado SMALLINT NOT NULL,
    -- Recurso del aliado es nuevo o usado
    inventario_concesion_recurso_usado BOOLEAN,

    -- Restricción de clave primaria
    CONSTRAINT pk_inventario_concesion_recurso PRIMARY KEY (fk_recurso, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla RECURSO
    CONSTRAINT fk_recurso_inventario_concesion_recurso FOREIGN KEY (fk_recurso) REFERENCES Recurso (recurso_codigo),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_inventario_concesion_recurso FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo)
);

CREATE TABLE Historico_Estatus_Recurso (
    -- Código del historico
    hist_est_recurso_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del inventario_recurso 1
    fk_inventario_recurso_1 SMALLINT NOT NULL,
    -- Clave foránea del inventario_recurso 2
    fk_inventario_recurso_2 SMALLINT NOT NULL,
    -- Clave foránea de estatus_disponibilidad
    fk_estatus_disponibilidad SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_recurso_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_recurso_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_recurso PRIMARY KEY (hist_est_recurso_codigo, fk_inventario_recurso_1, fk_inventario_recurso_2, fk_estatus_disponibilidad),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_RECURSO para su primera y segunda PK
    CONSTRAINT fk_inventario_recurso_historico_estatus_recurso FOREIGN KEY (fk_inventario_recurso_1, fk_inventario_recurso_2) REFERENCES Inventario_Recurso (inventario_recurso_codigo, fk_recurso),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_DISPONIBILIDAD
    CONSTRAINT fk_estatus_historico_estatus_recurso FOREIGN KEY (fk_estatus_disponibilidad) REFERENCES Estatus_Disponibilidad (estatus_disponibilidad_codigo)
);

CREATE TABLE Historico_Estatus_Concesion (
    -- Código del historico
    hist_est_concesion_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del inventario_concesion_recurso 1
    fk_inventario_concesion_recurso_1 SMALLINT NOT NULL,
    -- Clave foránea del inventario_concesion_recurso 2
    fk_inventario_concesion_recurso_2 SMALLINT NOT NULL,
    -- Clave foránea de estatus_disponibilidad
    fk_estatus_disponibilidad SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_recurso_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_recurso_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_concesion PRIMARY KEY (hist_est_concesion_codigo, fk_inventario_concesion_recurso_1, fk_inventario_concesion_recurso_2, fk_estatus_disponibilidad),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_CONCESION_RECURSO para su primera y segunda PK
    CONSTRAINT fk_inventario_concesion_recurso_historico_estatus_recurso FOREIGN KEY (fk_inventario_concesion_recurso_1, fk_inventario_concesion_recurso_2) REFERENCES Inventario_Concesion_Recurso (fk_recurso, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_DISPONIBILIDAD
    CONSTRAINT fk_estatus_historico_estatus_recurso FOREIGN KEY (fk_estatus_disponibilidad) REFERENCES Estatus_Disponibilidad (estatus_disponibilidad_codigo)
);

CREATE TABLE Proyecto_Configuracion (
    -- Código de la configuración
    proyecto_config_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la configuración
    proyecto_config_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción de la configuración
    proyecto_config_descripcion VARCHAR(100),
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_proyecto_configuracion PRIMARY KEY (proyecto_config_codigo),
     -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_proyecto_configuracion_nombre CHECK (proyecto_config_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_proyecto_configuracion_descripcion CHECK (proyecto_config_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción de clave foránea que referencia a la tabla MINERAL
    CONSTRAINT fk_mineral_proyecto_configuracion FOREIGN KEY (fk_mineral) REFERENCES Mineral (mineral_codigo)
);

CREATE TABLE Etapa_Configuracion (
    -- Código de la etapa
    etapa_config_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la etapa
    etapa_config_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Número de la etapa
    etapa_config_numero SMALLINT NOT NULL,
    -- Descripción de la etapa
    etapa_config_descripcion VARCHAR(100),
    -- Clave foránea de la configuración
    fk_proyecto_config SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_etapa_configuracion PRIMARY KEY (etapa_config_codigo),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_etapa_configuracion_nombre CHECK (etapa_config_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que el número de la etapa sea mayor a 0
    CONSTRAINT check_etapa_configuracion_numero CHECK (etapa_config_numero > 0),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_etapa_configuracion_descripcion CHECK (etapa_config_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción de clave foránea que referencia a la tabla PROYECTO_CONFIGURACION
    CONSTRAINT fk_proyecto_configuracion_etapa_configuracion FOREIGN KEY (fk_proyecto_config) REFERENCES Proyecto_Configuracion (proyecto_config_codigo)
);

CREATE TABLE Actividad_Configuracion (
    -- Código de la actividad
    actividad_config_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la actividad
    actividad_config_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción de la actividad
    actividad_config_descripcion VARCHAR(100),
    -- Duración de la actividad en días
    actividad_config_duracion_dias SMALLINT NOT NULL,
    -- Clave foránea de la etapa
    fk_etapa_config SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_actividad_configuracion PRIMARY KEY (actividad_config_codigo),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_actividad_configuracion_nombre CHECK (actividad_config_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_actividad_configuracion_descripcion CHECK (actividad_config_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la duración de la actividad sea mayor a 0
    CONSTRAINT check_actividad_configuracion_duracion_dias CHECK (actividad_config_duracion_dias > 0),
    -- Restricción de clave foránea que referencia a la tabla ETAPA_CONFIGURACION
    CONSTRAINT fk_etapa_configuracion_actividad_configuracion FOREIGN KEY (fk_etapa_config) REFERENCES Etapa_Configuracion (etapa_config_codigo)
);

CREATE TABLE Cargo_Actividad (
    -- Código de la actividad
    fk_actividad_config SMALLINT NOT NULL,
    -- Código del cargo
    fk_cargo SMALLINT NOT NULL,
    -- Cantidad de empleados requeridos
    config_cargo_cantidad SMALLINT NOT NULL,
    -- Salario quincenal del cargo
    config_cargo_salario_quincenal NUMERIC(10,2) NOT NULL,
    -- Viáticos quincenales del cargo
    config_cargo_viaticos_quincenal NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_cargo_actividad PRIMARY KEY (fk_cargo, fk_actividad_config),
    -- Restricción para verificar que la cantidad de empleados requeridos sea mayor a 0
    CONSTRAINT check_cargo_actividad_cantidad_empleados CHECK (config_cargo_cantidad > 0),
    -- Restricción para verificar que el salario quincenal sea mayor a 0
    CONSTRAINT check_cargo_actividad_salario_quincenal CHECK (config_cargo_salario_quincenal > 0),
    -- Restricción para verificar que los viáticos quincenales sean mayores a 0
    CONSTRAINT check_cargo_actividad_viaticos_quincenal CHECK (config_cargo_viaticos_quincenal > 0),
    -- Restricción de clave foránea que referencia a la tabla CARGO
    CONSTRAINT fk_cargo_cargo_actividad FOREIGN KEY (fk_cargo) REFERENCES Cargo (cargo_codigo),
    -- Restricción de clave foránea que referencia a la tabla ACTIVIDAD_CONFIGURACION
    CONSTRAINT fk_actividad_cargo_actividad FOREIGN KEY (fk_actividad_config) REFERENCES Actividad_Configuracion (actividad_config_codigo)
);

CREATE TABLE Recurso_Actividad (
    -- Código de la actividad
    fk_actividad_config SMALLINT NOT NULL,
    -- Código del tipo de recurso
    fk_tipo_recurso SMALLINT NOT NULL,
    -- Cantidad de recursos requeridos
    config_recurso_cantidad SMALLINT NOT NULL,
    -- Costo mensual del recurso
    config_recurso_costo_mensual NUMERIC(10,2) NOT NULL,
    -- Costo de mantenimiento del recurso
    config_recurso_costo_mantenimiento NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_recurso_actividad PRIMARY KEY (fk_tipo_recurso, fk_actividad_config),
    -- Restricción para verificar que la cantidad de recursos requeridos sea mayor a 0
    CONSTRAINT check_recurso_actividad_cantidad_recursos CHECK (config_recurso_cantidad > 0),
    -- Restricción para verificar que el costo mensual sea mayor a 0
    CONSTRAINT check_recurso_actividad_costo_mensual CHECK (config_recurso_costo_mensual > 0),
    -- Restricción para verificar que el costo de mantenimiento sea mayor a 0
    CONSTRAINT check_recurso_actividad_costo_mantenimiento CHECK (config_recurso_costo_mantenimiento > 0),
    -- Restricción de clave foránea que referencia a la tabla RECURSO
    CONSTRAINT fk_recurso_recurso_actividad FOREIGN KEY (fk_tipo_recurso) REFERENCES Recurso (recurso_codigo),
    -- Restricción de clave foránea que referencia a la tabla ACTIVIDAD_CONFIGURACION
    CONSTRAINT fk_actividad_recurso_actividad FOREIGN KEY (fk_actividad_config) REFERENCES Actividad_Configuracion (actividad_config_codigo)
);

CREATE TABLE Proyecto_Ejecucion (
    -- Código del proyecto
    proyecto_ejec_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del proyecto
    proyecto_ejec_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del proyecto
    proyecto_ejec_descripcion VARCHAR(100),
    -- Fecha de inicio estimada del proyecto
    proyecto_ejec_fecha_inicio_estimada DATE,
    -- Fecha de fin estimada del proyecto
    proyecto_ejec_fecha_fin_estimada  DATE,
    -- Fecha de inicio real del proyecto
    proyecto_ejec_fecha_inicio_real DATE,
    -- Fecha de fin real del proyecto
    proyecto_ejec_fecha_fin_real DATE,
    -- Clave foránea del pozo 1
    fk_pozo_1 SMALLINT NOT NULL,
    -- Clave foránea del pozo 2
    fk_pozo_2 SMALLINT NOT NULL,
    -- Clave foránea del pozo 3
    fk_pozo_3 SMALLINT NOT NULL,
    -- Clave foránea de inventario_producto_1
    fk_inventario_producto_1 SMALLINT,
    -- Clave foránea de inventario_producto_2
    fk_inventario_producto_2 SMALLINT,

    -- Restricción de clave primaria
    CONSTRAINT pk_proyecto_ejecucion PRIMARY KEY (proyecto_ejec_codigo),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_proyecto_ejecucion_nombre CHECK (proyecto_ejec_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_proyecto_ejecucion_descripcion CHECK (proyecto_ejec_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la fecha de inicio estimada sea mayor a la fecha actual
    CONSTRAINT check_proyecto_ejecucion_fecha_inicio_estimada CHECK (proyecto_ejec_fecha_inicio_estimada > CURRENT_DATE),
    -- Restricción para verificar que la fecha de fin estimada sea mayor a la fecha de inicio estimada
    CONSTRAINT check_proyecto_ejecucion_fecha_fin_estimada CHECK (proyecto_ejec_fecha_fin_estimada > proyecto_ejec_fecha_inicio_estimada),
    -- Restricción de clave foránea que referencia a la tabla POZO para su primera, segunda y tercera PK
    CONSTRAINT fk_pozo_proyecto_ejecucion FOREIGN KEY (fk_pozo_1, fk_pozo_2, fk_pozo_3) REFERENCES Pozo (pozo_id, fk_mina_1, fk_mina_2),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_PRODUCTO para su primera y segunda PK
    CONSTRAINT fk_inventario_producto_proyecto_ejecucion FOREIGN KEY (fk_inventario_producto_1, fk_inventario_producto_2) REFERENCES Inventario_Producto (inventario_producto_codigo, fk_mineral)
);

CREATE TABLE Etapa_Ejecucion (
    -- Código de la etapa
    etapa_ejec_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la etapa
    etapa_ejec_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Número de la etapa
    etapa_ejec_numero SMALLINT NOT NULL,
    -- Descripción de la etapa
    etapa_ejec_descripcion VARCHAR(100),
    -- Fecha de inicio estimada de la etapa
    etapa_ejec_fecha_inicio_estimada DATE,
    -- Fecha de fin estimada de la etapa
    etapa_ejec_fecha_fin_estimada DATE,
    -- Fecha de inicio real de la etapa
    etapa_ejec_fecha_inicio_real DATE,
    -- Fecha de fin real de la etapa
    etapa_ejec_fecha_fin_real DATE,
    -- Clave foránea del proyecto
    fk_proyecto_ejecucion SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_etapa_ejecucion PRIMARY KEY (etapa_ejec_codigo),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_etapa_ejecucion_nombre CHECK (etapa_ejec_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que el número de la etapa sea mayor a 0
    CONSTRAINT check_etapa_ejecucion_numero CHECK (etapa_ejec_numero > 0),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_etapa_ejecucion_descripcion CHECK (etapa_ejec_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la fecha de inicio estimada sea mayor a la fecha actual
    CONSTRAINT check_etapa_ejecucion_fecha_inicio_estimada CHECK (etapa_ejec_fecha_inicio_estimada > CURRENT_DATE),
    -- Restricción para verificar que la fecha de fin estimada sea mayor a la fecha de inicio estimada
    CONSTRAINT check_etapa_ejecucion_fecha_fin_estimada CHECK (etapa_ejec_fecha_fin_estimada > etapa_ejec_fecha_inicio_estimada),
    -- Restricción de clave foránea que referencia a la tabla PROYECTO_EJECUCION
    CONSTRAINT fk_proyecto_ejecucion_etapa_ejecucion FOREIGN KEY (fk_proyecto_ejecucion) REFERENCES Proyecto_Ejecucion (proyecto_ejec_codigo)
);

CREATE TABLE Actividad_Ejecucion (
    -- Código de la actividad
    actividad_ejec_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre de la actividad
    actividad_ejec_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción de la actividad
    actividad_ejec_descripcion VARCHAR(100),
    -- Duración de la actividad en días
    actividad_ejec_duracion_dias SMALLINT NOT NULL,
    -- Fecha de inicio estimada de la actividad
    actividad_ejec_fecha_inicio_estimada DATE,
    -- Fecha de fin estimada de la actividad
    actividad_ejec_fecha_fin_estimada DATE,
    -- Fecha de inicio real de la actividad
    actividad_ejec_fecha_inicio_real DATE,
    -- Fecha de fin real de la actividad
    actividad_ejec_fecha_fin_real DATE,
    -- Clave foránea de la etapa
    fk_etapa_ejecucion SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_actividad_ejecucion PRIMARY KEY (actividad_ejec_codigo),
    -- Restricción para verificar que el nombre solo contenga letras, espacios y números
    CONSTRAINT check_actividad_ejecucion_nombre CHECK (actividad_ejec_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9 ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_actividad_ejecucion_descripcion CHECK (actividad_ejec_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la duración de la actividad sea mayor a 0
    CONSTRAINT check_actividad_ejecucion_duracion_dias CHECK (actividad_ejec_duracion_dias > 0),
    -- Restricción para verificar que la fecha de inicio estimada sea mayor a la fecha actual
    CONSTRAINT check_actividad_ejecucion_fecha_inicio_estimada CHECK (actividad_ejec_fecha_inicio_estimada > CURRENT_DATE),
    -- Restricción para verificar que la fecha de fin estimada sea mayor a la fecha de inicio estimada
    CONSTRAINT check_actividad_ejecucion_fecha_fin_estimada CHECK (actividad_ejec_fecha_fin_estimada > actividad_ejec_fecha_inicio_estimada),
    -- Restricción de clave foranea que referencia a la tabla ETAPA_EJECUCION
    CONSTRAINT fk_etapa_ejecucion_actividad_ejecucion FOREIGN KEY (fk_etapa_ejecucion) REFERENCES Etapa_Ejecucion (etapa_ejec_codigo)
);

CREATE TABLE Estatus_Ejecucion (
    -- Código del estatus
    estatus_ejecucion_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del estatus
    estatus_ejecucion_nombre VARCHAR(15) NOT NULL UNIQUE,
    -- Descripción del estatus
    estatus_ejecucion_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_estatus_ejecucion PRIMARY KEY (estatus_ejecucion_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_estatus_ejecucion_nombre CHECK (estatus_ejecucion_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_estatus_ejecucion_descripcion CHECK (estatus_ejecucion_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Historico_Estatus_Proyecto (
    -- Código del historico
    hist_est_proyecto_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del proyecto
    fk_proyecto_ejecucion SMALLINT NOT NULL,
    -- Clave foránea del estatus
    fk_estatus_ejecucion SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_proyecto_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_proyecto_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_proyecto PRIMARY KEY (hist_est_proyecto_codigo, fk_proyecto_ejecucion, fk_estatus_ejecucion),
    -- Restricción de clave foránea que referencia a la tabla PROYECTO_EJECUCION
    CONSTRAINT fk_proyecto_historico_estatus_proyecto FOREIGN KEY (fk_proyecto_ejecucion) REFERENCES Proyecto_Ejecucion (proyecto_ejec_codigo),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_EJECUCION
    CONSTRAINT fk_estatus_historico_estatus_proyecto FOREIGN KEY (fk_estatus_ejecucion) REFERENCES Estatus_Ejecucion (estatus_ejecucion_codigo)
);

CREATE TABLE Historico_Estatus_Etapa (
    -- Código del historico
    hist_est_etapa_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea de la etapa
    fk_etapa_ejecucion SMALLINT NOT NULL,
    -- Clave foránea del estatus
    fk_estatus_ejecucion SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_etapa_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_etapa_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_etapa PRIMARY KEY (hist_est_etapa_codigo, fk_etapa_ejecucion, fk_estatus_ejecucion),
    -- Restricción de clave foránea que referencia a la tabla ETAPA_EJECUCION
    CONSTRAINT fk_etapa_historico_estatus_etapa FOREIGN KEY (fk_etapa_ejecucion) REFERENCES Etapa_Ejecucion (etapa_ejec_codigo),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_EJECUCION
    CONSTRAINT fk_estatus_historico_estatus_etapa FOREIGN KEY (fk_estatus_ejecucion) REFERENCES Estatus_Ejecucion (estatus_ejecucion_codigo)
);

CREATE TABLE Historico_Estatus_Actividad (
    -- Código del historico
    hist_est_actividad_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea de la actividad
    fk_actividad_ejecucion SMALLINT NOT NULL,
    -- Clave foránea del estatus
    fk_estatus_ejecucion SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_actividad_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_actividad_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_actividad PRIMARY KEY (hist_est_actividad_codigo, fk_actividad_ejecucion, fk_estatus_ejecucion),
    -- Restricción de clave foránea que referencia a la tabla ACTIVIDAD_EJECUCION
    CONSTRAINT fk_actividad_historico_estatus_actividad FOREIGN KEY (fk_actividad_ejecucion) REFERENCES Actividad_Ejecucion (actividad_ejec_codigo),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_EJECUCION
    CONSTRAINT fk_estatus_historico_estatus_actividad FOREIGN KEY (fk_estatus_ejecucion) REFERENCES Estatus_Ejecucion (estatus_ejecucion_codigo)
);

CREATE TABLE Presupuesto (
    -- Código del presupuesto
    presupuesto_numero SMALLSERIAL NOT NULL UNIQUE,
    -- Fecha de emisión del presupuesto
    presupuesto_fecha_emision DATE NOT NULL,
    -- Costo subtil del presupuesto
    presupuesto_costo_subtil NUMERIC(10,2) NOT NULL,
    -- Costo total del presupuesto
    presupuesto_costo_total NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_presupuesto PRIMARY KEY (presupuesto_numero),
    -- Restricción para verificar que el costo subtil sea mayor a 0
    CONSTRAINT check_presupuesto_costo_subtil CHECK (presupuesto_costo_subtil > 0),
    -- Restricción para verificar que el costo total sea mayor a 0
    CONSTRAINT check_presupuesto_costo_total CHECK (presupuesto_costo_total > 0)
);

CREATE TABLE Solicitud_Proyecto_Aliados (
    -- Código de la solicitud
    solicitud_aliados_numero SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del aliado
    fk_aliado SMALLINT NOT NULL,
    -- Fecha de emisión de la solicitud
   solicitud_aliados_fecha_emision DATE NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_solicitud_proyecto PRIMARY KEY (solicitud_aliados_numero, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_solicitud_proyecto FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo)
);

CREATE TABLE Estatus_Pedido (
    -- Código del estatus
    estatus_pedido_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del estatus
    estatus_pedido_nombre VARCHAR(30) NOT NULL UNIQUE,
    -- Descripción del estatus
    estatus_pedido_descripcion VARCHAR(100),

    -- Restricción de clave primaria
    CONSTRAINT pk_estatus_pedido PRIMARY KEY (estatus_pedido_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_estatus_pedido_nombre CHECK (estatus_pedido_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la descripción solo contenga letras y espacios
    CONSTRAINT check_estatus_pedido_descripcion CHECK (estatus_pedido_descripcion ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Historico_Estatus_Solicitud_Aliados (
    -- Código del historico
    hist_est_solic_aliados_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del estatus
    fk_estatus_pedido SMALLINT NOT NULL,
    -- Clave foránea de la solicitud 1
    fk_solicitud_aliados_1 SMALLINT NOT NULL,
    -- Clave foránea de la solicitud 2
    fk_solicitud_aliados_2 SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_solic_aliados_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_solic_aliados_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_solicitud_aliados PRIMARY KEY (hist_est_solic_aliados_codigo, fk_solicitud_aliados_1, fk_solicitud_aliados_2, fk_estatus_pedido),
    CONSTRAINT fk_estatus_historico_estatus_solicitud_aliados FOREIGN KEY (fk_estatus_pedido) REFERENCES Estatus_Pedido (estatus_pedido_codigo),
    CONSTRAINT fk_solicitud_historico_estatus_solicitud_aliados FOREIGN KEY (fk_solicitud_aliados_1, fk_solicitud_aliados_2) REFERENCES Solicitud_Proyecto_Aliados (solicitud_aliados_numero, fk_aliado)
);

CREATE TABLE Ejecucion_Empleado (
    -- Clave foranea de la actividad
    fk_actividad_ejecucion SMALLINT NOT NULL,
    -- Cantidad de empleados
    ejecucion_empleado_cantidad SMALLINT NOT NULL,
    -- Salario quincenal del empleado
    ejecucion_empleado_salario NUMERIC(10,2) NOT NULL,
    -- Viáticos quincenales del empleado
    ejecucion_empleado_viaticos NUMERIC(10,2) NOT NULL,
    -- Clave foranea del presupuesto
    fk_presupuesto SMALLINT NOT NULL,
    -- Clave foranea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Clave foranea del aliado 1
    fk_solicitud_aliado_1 SMALLINT NOT NULL,
    -- Clave foranea del aliado 2
    fk_solicitud_aliado_2 SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_ejecucion_empleado PRIMARY KEY (fk_actividad_ejecucion),
    --  Restricción para verificar que la cantidad de empleados sea mayor a 0
    CONSTRAINT check_ejecucion_empleado_cantidad CHECK (ejecucion_empleado_cantidad > 0),
    -- Restricción para verificar que el salario quincenal sea mayor a 0
    CONSTRAINT check_ejecucion_empleado_salario CHECK (ejecucion_empleado_salario > 0),
    -- Restricción para verificar que los viáticos quincenales sean mayores a 0
    CONSTRAINT check_ejecucion_empleado_viaticos CHECK (ejecucion_empleado_viaticos > 0),
    -- Restricción de clave foránea que referencia a la tabla ACTIVIDAD_EJECUCION
    CONSTRAINT fk_actividad_ejecucion_ejecucion_empleado FOREIGN KEY (fk_actividad_ejecucion) REFERENCES Actividad_Ejecucion (actividad_ejec_codigo),
    -- Restricción de clave foránea que referencia a la tabla PRESUPUESTO
    CONSTRAINT fk_presupuesto_ejecucion_empleado FOREIGN KEY (fk_presupuesto) REFERENCES Presupuesto (presupuesto_numero),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_ejecucion_empleado FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo),
    -- Restricción de clave foránea que referencia a la tabla SOLICITUD_PROYECTO_ALIADOS
    CONSTRAINT fk_solicitud_aliado_ejecucion_empleado FOREIGN KEY (fk_solicitud_aliado_1, fk_solicitud_aliado_2) REFERENCES Solicitud_Proyecto_Aliados (solicitud_aliados_numero, fk_aliado)
);

CREATE TABLE Ejecucion_Recurso (
    -- Clave foranea de la actividad
    fk_actividad_ejecucion SMALLINT NOT NULL,
    -- Cantidad de recursos
    ejecucion_recurso_cantidad SMALLINT NOT NULL,
    -- Costo mensual del recurso
    ejecucion_recurso_costo_mensual NUMERIC(10,2) NOT NULL,
    -- Costo de mantenimiento del recurso
    ejecucion_recurso_costo_mantenimiento NUMERIC(10,2) NOT NULL,
    -- Clave foranea del presupuesto
    fk_presupuesto SMALLINT NOT NULL,
    -- Clave foranea del aliado 1
    fk_solicitud_aliado_1 SMALLINT NOT NULL,
    -- Clave foranea del aliado 2
    fk_solicitud_aliado_2 SMALLINT NOT NULL,
    -- Clave foranea del inventario recurso 1
    fk_inventario_recurso_1 SMALLINT NOT NULL,
    -- Clave foranea del inventario recurso 2
    fk_inventario_recurso_2 SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_ejecucion_recurso PRIMARY KEY (fk_actividad_ejecucion),
    --  Restricción para verificar que la cantidad de recursos sea mayor a 0
    CONSTRAINT check_ejecucion_recurso_cantidad CHECK (ejecucion_recurso_cantidad > 0),
    -- Restricción para verificar que el costo mensual sea mayor a 0
    CONSTRAINT check_ejecucion_recurso_costo_mensual CHECK (ejecucion_recurso_costo_mensual > 0),
    -- Restricción para verificar que el costo de mantenimiento sea mayor a 0
    CONSTRAINT check_ejecucion_recurso_costo_mantenimiento CHECK (ejecucion_recurso_costo_mantenimiento > 0),
    -- Restricción de clave foránea que referencia a la tabla ACTIVIDAD_EJECUCION
    CONSTRAINT fk_actividad_ejecucion_ejecucion_recurso FOREIGN KEY (fk_actividad_ejecucion) REFERENCES Actividad_Ejecucion (actividad_ejec_codigo),
    -- Restricción de clave foránea que referencia a la tabla PRESUPUESTO
    CONSTRAINT fk_presupuesto_ejecucion_recurso FOREIGN KEY (fk_presupuesto) REFERENCES Presupuesto (presupuesto_numero),
    -- Restricción de clave foránea que referencia a la tabla SOLICITUD_PROYECTO_ALIADOS
    CONSTRAINT fk_solicitud_aliado_ejecucion_recurso FOREIGN KEY (fk_solicitud_aliado_1, fk_solicitud_aliado_2) REFERENCES Solicitud_Proyecto_Aliados (solicitud_aliados_numero, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_RECURSO
    CONSTRAINT fk_inventario_recurso_ejecucion_recurso FOREIGN KEY (fk_inventario_recurso_1, fk_inventario_recurso_2) REFERENCES Inventario_Recurso (inventario_recurso_codigo, fk_recurso)
);

CREATE TABLE Detalle_Solicitud_Empleado (
    -- Código del detalle
    detalle_solicitud_empleado_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Código de la solicitud
    fk_solicitud_aliado_1 SMALLINT NOT NULL,
    -- Código de la solicitud
    fk_solicitud_aliado_2 SMALLINT NOT NULL,
    -- Cantidad de empleados
    detalle_solicitud_empleado_cantidad SMALLINT NOT NULL,
    -- Salario quincenal del empleado
    detalle_solicitud_empleado_salario NUMERIC(10,2) NOT NULL,
    -- Viáticos quincenales del empleado
    detalle_solicitud_empleado_viaticos NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_detalle_solicitud_empleado PRIMARY KEY (detalle_solicitud_empleado_codigo, fk_empleado, fk_solicitud_aliado_1, fk_solicitud_aliado_2),
    --  Restricción para verificar que la cantidad de empleados sea mayor a 0
    CONSTRAINT check_detalle_solicitud_empleado_cantidad CHECK (detalle_solicitud_empleado_cantidad > 0),
    -- Restricción para verificar que el salario quincenal sea mayor a 0
    CONSTRAINT check_detalle_solicitud_empleado_salario CHECK (detalle_solicitud_empleado_salario > 0),
    -- Restricción para verificar que los viáticos quincenales sean mayores a 0
    CONSTRAINT check_detalle_solicitud_empleado_viaticos CHECK (detalle_solicitud_empleado_viaticos > 0),
    -- Restricción de clave foránea que referencia a la tabla SOLICITUD_PROYECTO_ALIADOS
    CONSTRAINT fk_solicitud_aliado_detalle_solicitud_empleado FOREIGN KEY (fk_solicitud_aliado_1, fk_solicitud_aliado_2) REFERENCES Solicitud_Proyecto_Aliados (solicitud_aliados_numero, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla EMPLEADO
    CONSTRAINT fk_empleado_detalle_solicitud_empleado FOREIGN KEY (fk_empleado) REFERENCES Empleado (empleado_codigo)
);

CREATE TABLE Detalle_Solicitud_Recurso (
    -- Código del detalle
    detalle_solicitud_recurso_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código del inventario recurso 1
    fk_inventario_recurso_1 SMALLINT NOT NULL,
    -- Código del inventario recurso 2
    fk_inventario_recurso_2 SMALLINT NOT NULL,
    -- Código de la solicitud
    fk_solicitud_aliado_1 SMALLINT NOT NULL,
    -- Código de la solicitud
    fk_solicitud_aliado_2 SMALLINT NOT NULL,
    -- Cantidad de recursos
    detalle_solicitud_recurso_cantidad SMALLINT NOT NULL,
    -- Costo mensual del recurso
    detalle_solicitud_recurso_costo_mensual NUMERIC(10,2) NOT NULL,
    -- Costo de mantenimiento del recurso
    detalle_solicitud_recurso_costo_mantenimiento NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_detalle_solicitud_recurso PRIMARY KEY (detalle_solicitud_recurso_codigo, fk_inventario_recurso_1, fk_inventario_recurso_2, fk_solicitud_aliado_1, fk_solicitud_aliado_2),
    --  Restricción para verificar que la cantidad de recursos sea mayor a 0
    CONSTRAINT check_detalle_solicitud_recurso_cantidad CHECK (detalle_solicitud_recurso_cantidad > 0),
    -- Restricción para verificar que el costo mensual sea mayor a 0
    CONSTRAINT check_detalle_solicitud_recurso_costo_mensual CHECK (detalle_solicitud_recurso_costo_mensual > 0),
    -- Restricción para verificar que el costo de mantenimiento sea mayor a 0
    CONSTRAINT check_detalle_solicitud_recurso_costo_mantenimiento CHECK (detalle_solicitud_recurso_costo_mantenimiento > 0),
    -- Restricción de clave foránea que referencia a la tabla SOLICITUD_PROYECTO_ALIADOS
    CONSTRAINT fk_solicitud_aliado_detalle_solicitud_recurso FOREIGN KEY (fk_solicitud_aliado_1, fk_solicitud_aliado_2) REFERENCES Solicitud_Proyecto_Aliados (solicitud_aliados_numero, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_RECURSO
    CONSTRAINT fk_inventario_recurso_detalle_solicitud_recurso FOREIGN KEY (fk_inventario_recurso_1, fk_inventario_recurso_2) REFERENCES Inventario_Recurso (inventario_recurso_codigo, fk_recurso)
);

CREATE TABLE Pedido_Compra (
    -- Código del pedido
    pedido_compra_numero SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del aliado
    fk_aliado SMALLINT NOT NULL,
    -- Fecha de emisión del pedido
    pedido_compra_fecha_emision DATE NOT NULL,
    -- Monto subtil del pedido
    pedido_compra_monto_subtil NUMERIC(10,2) NOT NULL,
    -- Monto total del pedido
    pedido_compra_monto_total NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_pedido_compra PRIMARY KEY (pedido_compra_numero, fk_aliado),
    -- Restricción para verificar que el monto subtil sea mayor a 0
    CONSTRAINT check_pedido_compra_monto_subtil CHECK (pedido_compra_monto_subtil > 0),
    -- Restricción para verificar que el costo total sea mayor a 0
    CONSTRAINT check_pedido_compra_monto_total CHECK (pedido_compra_monto_total > 0),
    -- Restricción de clave foránea que referencia a la tabla ALIADO
    CONSTRAINT fk_aliado_pedido_compra FOREIGN KEY (fk_aliado) REFERENCES Aliado (persona_jur_codigo)
);

CREATE TABLE Detalle_Pedido_Compra (
    -- Código del detalle
    detalle_pedido_compra_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código del pedido 1
    fk_pedido_compra_1 SMALLINT NOT NULL,
    -- Código del pedido 2
    fk_pedido_compra_2 SMALLINT NOT NULL,
    -- Código del inventario producto 1
    fk_inventario_producto_1 SMALLINT NOT NULL,
    -- Código del inventario producto 2
    fk_inventario_producto_2 SMALLINT NOT NULL,
    -- Cantidad de productos
    detalle_compra_cantidad_mineral SMALLINT NOT NULL,
    -- Precio unitario del producto
    detalle_compra_precio_unitario NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_detalle_pedido_compra PRIMARY KEY (detalle_pedido_compra_codigo, fk_pedido_compra_1, fk_pedido_compra_2, fk_inventario_producto_1, fk_inventario_producto_2),
    --  Restricción para verificar que la cantidad de productos sea mayor a 0
    CONSTRAINT check_detalle_pedido_compra_cantidad CHECK (detalle_compra_cantidad_mineral > 0),
    -- Restricción para verificar que el precio unitario sea mayor a 0
    CONSTRAINT check_detalle_pedido_compra_precio_unitario CHECK (detalle_compra_precio_unitario > 0),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_COMPRA
    CONSTRAINT fk_pedido_compra_detalle_pedido_compra FOREIGN KEY (fk_pedido_compra_1, fk_pedido_compra_2) REFERENCES Pedido_Compra (pedido_compra_numero, fk_aliado),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_PRODUCTO
    CONSTRAINT fk_inventario_producto_detalle_pedido_compra FOREIGN KEY (fk_inventario_producto_1, fk_inventario_producto_2) REFERENCES Inventario_Producto (inventario_producto_codigo, fk_mineral)
);

CREATE TABLE Historico_Estatus_Pedido_Compra (
    -- Código del historico
    hist_est_pedido_compra_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del estatus
    fk_estatus_pedido SMALLINT NOT NULL,
    -- Clave foránea del pedido 1
    fk_pedido_compra_1 SMALLINT NOT NULL,
    -- Clave foránea del pedido 2
    fk_pedido_compra_2 SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_pedido_compra_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_pedido_compra_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_pedido_compra PRIMARY KEY (hist_est_pedido_compra_codigo, fk_pedido_compra_1, fk_pedido_compra_2, fk_estatus_pedido),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_PEDIDO
    CONSTRAINT fk_estatus_historico_estatus_pedido_compra FOREIGN KEY (fk_estatus_pedido) REFERENCES Estatus_Pedido (estatus_pedido_codigo),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_COMPRA
    CONSTRAINT fk_pedido_historico_estatus_pedido_compra FOREIGN KEY (fk_pedido_compra_1, fk_pedido_compra_2) REFERENCES Pedido_Compra (pedido_compra_numero, fk_aliado)
);

CREATE TABLE Pedido_Venta (
    -- Código del pedido
    pedido_venta_numero SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del cliente
    fk_cliente SMALLINT NOT NULL,
    -- Fecha de emisión del pedido
    pedido_venta_fecha_emision DATE NOT NULL,
    -- Monto subtil del pedido
    pedido_venta_monto_subtil NUMERIC(10,2) NOT NULL,
    -- Monto total del pedido
    pedido_venta_monto_total NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_pedido_venta PRIMARY KEY (pedido_venta_numero, fk_cliente),
    -- Restricción para verificar que el monto subtil sea mayor a 0
    CONSTRAINT check_pedido_venta_monto_subtil CHECK (pedido_venta_monto_subtil > 0),
    -- Restricción para verificar que el costo total sea mayor a 0
    CONSTRAINT check_pedido_venta_monto_total CHECK (pedido_venta_monto_total > 0),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_pedido_venta FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo)
);

CREATE TABLE Detalle_Pedido_Venta (
    -- Código del detalle
    detalle_venta_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código del pedido 1
    fk_pedido_venta_1 SMALLINT NOT NULL,
    -- Código del pedido 2
    fk_pedido_venta_2 SMALLINT NOT NULL,
    -- Código del inventario producto 1
    fk_inventario_producto_1 SMALLINT NOT NULL,
    -- Código del inventario producto 2
    fk_inventario_producto_2 SMALLINT NOT NULL,
    -- Cantidad de productos
    detalle_venta_cantidad_mineral SMALLINT NOT NULL,
    -- Precio unitario del producto
    detalle_venta_precio_unitario NUMERIC(10,2) NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_detalle_pedido_venta PRIMARY KEY (detalle_venta_codigo, fk_pedido_venta_1, fk_pedido_venta_2, fk_inventario_producto_1, fk_inventario_producto_2),
    --  Restricción para verificar que la cantidad de productos sea mayor a 0
    CONSTRAINT check_detalle_pedido_venta_cantidad CHECK (detalle_venta_cantidad_mineral > 0),
    -- Restricción para verificar que el precio unitario sea mayor a 0
    CONSTRAINT check_detalle_pedido_venta_precio_unitario CHECK (detalle_venta_precio_unitario > 0),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_VENTA
    CONSTRAINT fk_pedido_venta_detalle_pedido_venta FOREIGN KEY (fk_pedido_venta_1, fk_pedido_venta_2) REFERENCES Pedido_Venta (pedido_venta_numero, fk_cliente),
    -- Restricción de clave foránea que referencia a la tabla INVENTARIO_PRODUCTO
    CONSTRAINT fk_inventario_producto_detalle_pedido_venta FOREIGN KEY (fk_inventario_producto_1, fk_inventario_producto_2) REFERENCES Inventario_Producto (inventario_producto_codigo, fk_mineral)
);

CREATE TABLE Historico_Estatus_Pedido_Venta (
    -- Código del historico
    hist_est_pedido_venta_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del estatus
    fk_estatus_pedido SMALLINT NOT NULL,
    -- Clave foránea del pedido 1
    fk_pedido_venta_1 SMALLINT NOT NULL,
    -- Clave foránea del pedido 2
    fk_pedido_venta_2 SMALLINT NOT NULL,
    -- Fecha de inicio de estatus
    hist_est_pedido_venta_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_pedido_venta_fecha_fin TIMESTAMP,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_pedido_venta PRIMARY KEY (hist_est_pedido_venta_codigo, fk_pedido_venta_1, fk_pedido_venta_2, fk_estatus_pedido),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_PEDIDO
    CONSTRAINT fk_estatus_historico_estatus_pedido_venta FOREIGN KEY (fk_estatus_pedido) REFERENCES Estatus_Pedido (estatus_pedido_codigo),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_VENTA
    CONSTRAINT fk_pedido_historico_estatus_pedido_venta FOREIGN KEY (fk_pedido_venta_1, fk_pedido_venta_2) REFERENCES Pedido_Venta (pedido_venta_numero, fk_cliente)
);

CREATE TABLE Pedido_Compra_Venta (
    -- Código del pedido venta 1
    fk_pedido_venta_1 SMALLINT NOT NULL  UNIQUE,
    -- Código del pedido venta 2
    fk_pedido_venta_2 SMALLINT NOT NULL UNIQUE,
    -- Código del pedido compra 1
    fk_pedido_compra_1 SMALLINT NOT NULL UNIQUE,
    -- Código del pedido compra 2
    fk_pedido_compra_2 SMALLINT NOT NULL UNIQUE,

    -- Restricción de clave primaria
    CONSTRAINT pk_pedido_compra_venta PRIMARY KEY (fk_pedido_venta_1, fk_pedido_venta_2, fk_pedido_compra_1, fk_pedido_compra_2),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_VENTA
    CONSTRAINT fk_pedido_venta_pedido_compra FOREIGN KEY (fk_pedido_venta_1, fk_pedido_venta_2) REFERENCES Pedido_Venta (pedido_venta_numero, fk_cliente),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_COMPRA
    CONSTRAINT fk_pedido_compra_pedido_compra FOREIGN KEY (fk_pedido_compra_1, fk_pedido_compra_2) REFERENCES Pedido_Compra (pedido_compra_numero, fk_aliado)
);

CREATE TABLE Pedido_Venta_Proyecto (
    -- Código del proyecto ejecución
    fk_proyecto_ejecucion SMALLINT NOT NULL UNIQUE,
    -- Código del pedido venta 1
    fk_pedido_venta_1 SMALLINT NOT NULL  UNIQUE,
    -- Código del pedido venta 2
    fk_pedido_venta_2 SMALLINT NOT NULL UNIQUE,

    -- Restricción de clave primaria
    CONSTRAINT pk_pedido_venta_proyecto PRIMARY KEY (fk_proyecto_ejecucion, fk_pedido_venta_1, fk_pedido_venta_2),
    -- Restricción de clave foránea que referencia a la tabla PEDIDO_VENTA
    CONSTRAINT fk_pedido_venta_pedido_venta_proyecto FOREIGN KEY (fk_pedido_venta_1, fk_pedido_venta_2) REFERENCES Pedido_Venta (pedido_venta_numero, fk_cliente),
    -- Restricción de clave foránea que referencia a la tabla PROYECTO_EJECUCION
    CONSTRAINT fk_proyecto_pedido_venta_proyecto FOREIGN KEY (fk_proyecto_ejecucion) REFERENCES Proyecto_Ejecucion (proyecto_ejec_codigo)
);

CREATE TABLE Banco (
    -- Código del banco
    banco_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Nombre del banco
    banco_nombre VARCHAR(30) NOT NULL UNIQUE,

    -- Restricción de clave primaria
    CONSTRAINT pk_banco PRIMARY KEY (banco_codigo),
    -- Restricción para verificar que el nombre solo contenga letras y espacios
    CONSTRAINT check_banco_nombre CHECK (banco_nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$')
);

CREATE TABLE Tarjeta_Debito (
    -- Código de la tarjeta de débito
    metodo_pago_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código de la tarjeta
    tdb_numero VARCHAR(16) NOT NULL UNIQUE,
    -- Tipo de cuenta de la tarjeta
    tdb_tipo_cuenta VARCHAR(15) NOT NULL,
    -- Fecha de expiración de la tarjeta
    tdb_fecha_expiracion DATE NOT NULL,
    -- CVV de la tarjeta
    tdb_cvv VARCHAR(3) NOT NULL,
    -- Clave foránea del banco
    fk_banco SMALLINT NOT NULL,
    -- Clave foránea del cliente
    fk_cliente SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_tarjeta_debito PRIMARY KEY (metodo_pago_codigo, fk_banco),
    -- Restricción para verificar que el número de la tarjeta solo contenga números
    CONSTRAINT check_tarjeta_debito_numero CHECK (tdb_numero ~ '^[0-9]{16}$'),
    -- Restricción para verificar que el tipo de cuenta sea ahorro o corriente
    CONSTRAINT check_tarjeta_debito_tipo_cuenta CHECK (tdb_tipo_cuenta IN ('Ahorro', 'Corriente')),
    -- Restricción para verificar que la fecha de expiración sea mayor a la fecha actual
    CONSTRAINT check_tarjeta_debito_fecha_expiracion CHECK (tdb_fecha_expiracion > CURRENT_DATE),
    -- Restricción para verificar que el CVV solo contenga números
    CONSTRAINT check_tarjeta_debito_cvv CHECK (tdb_cvv ~ '^[0-9]{3}$'),
    -- Restricción de clave foránea que referencia a la tabla BANCO
    CONSTRAINT fk_banco_tarjeta_debito FOREIGN KEY (fk_banco) REFERENCES Banco (banco_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_tarjeta_debito FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo)
);

CREATE TABLE Tarjeta_Credito (
    -- Código de la tarjeta de crédito
    metodo_pago_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Código de la tarjeta
    tdc_numero VARCHAR(16) NOT NULL UNIQUE,
    -- Tipo de cuenta de la tarjeta
    tdc_tipo_cuenta VARCHAR(15) NOT NULL,
    -- Fecha de expiración de la tarjeta
    tdc_fecha_expiracion DATE NOT NULL,
    -- CVV de la tarjeta
    tdc_cvv VARCHAR(3) NOT NULL,
    -- Clave foránea del banco
    fk_banco SMALLINT NOT NULL,
    -- Clave foránea del cliente
    fk_cliente SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_tarjeta_credito PRIMARY KEY (metodo_pago_codigo, fk_banco),
    -- Restricción para verificar que el número de la tarjeta solo contenga números
    CONSTRAINT check_tarjeta_credito_numero CHECK (tdc_numero ~ '^[0-9]{16}$'),
    -- Restricción para verificar que el tipo de cuenta solo contenga letras y espacios
    CONSTRAINT check_tarjeta_credito_tipo_cuenta CHECK (tdc_tipo_cuenta ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]*$'),
    -- Restricción para verificar que la fecha de expiración sea mayor a la fecha actual
    CONSTRAINT check_tarjeta_credito_fecha_expiracion CHECK (tdc_fecha_expiracion > CURRENT_DATE),
    -- Restricción para verificar que el CVV solo contenga números
    CONSTRAINT check_tarjeta_credito_cvv CHECK (tdc_cvv ~ '^[0-9]{3}$'),
    -- Restricción de clave foránea que referencia a la tabla BANCO
    CONSTRAINT fk_banco_tarjeta_credito FOREIGN KEY (fk_banco) REFERENCES Banco (banco_codigo),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_tarjeta_credito FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo)
);

CREATE TABLE Efectivo (
    -- Código del efectivo
    metodo_pago_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Denominación del efectivo
    efectivo_denominacion SMALLINT NOT NULL,
    -- Clave foránea del cliente
    fk_cliente SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_efectivo PRIMARY KEY (metodo_pago_codigo),
    -- Restricción para verificar que el monto del efectivo sea mayor a 0
    CONSTRAINT check_efectivo_monto CHECK (efectivo_denominacion > 0),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_efectivo FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo)
);

CREATE TABLE Cheque (
    -- Código del cheque
    metodo_pago_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Número del cheque
    cheque_numero VARCHAR(10) NOT NULL UNIQUE,
    -- Clave foránea del banco
    fk_banco SMALLINT NOT NULL,
    -- Clave foránea del cliente
    fk_cliente SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_cheque PRIMARY KEY (metodo_pago_codigo, fk_banco),
    -- Restricción para verificar que el número del cheque solo contenga números
    CONSTRAINT check_cheque_numero CHECK (cheque_numero ~ '^[0-9]{10}$'),
    -- Restricción de clave foránea que referencia a la tabla CLIENTE
    CONSTRAINT fk_cliente_cheque FOREIGN KEY (fk_cliente) REFERENCES Cliente (persona_jur_codigo),
    -- Restricción de clave foránea que referencia a la tabla BANCO
    CONSTRAINT fk_banco_cheque FOREIGN KEY (fk_banco) REFERENCES Banco (banco_codigo)
);

CREATE TABLE Pago_Compra (
    -- Código del pago
    pago_compra_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del método de pago
    fk_tarjeta_debito SMALLINT,
    -- Clave foránea del método de pago
    fk_tarjeta_credito SMALLINT,
    -- Clave foránea del método de pago
    fk_efectivo SMALLINT,
    -- Clave foránea del método de pago
    fk_cheque SMALLINT,
    -- Clave foránea del pedido compra 1
    fk_pedido_compra_1 SMALLINT NOT NULL UNIQUE,
    -- Clave foránea del pedido compra 2
    fk_pedido_compra_2 SMALLINT NOT NULL UNIQUE,
    -- Monto del pago
    pago_compra_monto NUMERIC(10,2) NOT NULL,
    -- Fecha de emisión del pago
    pago_compra_fecha_emision DATE NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_pago_compra PRIMARY KEY (pago_compra_codigo, fk_pedido_compra_1, fk_pedido_compra_2),
    -- Restricción de clave foránea que referencia a la tabla TARJETA_DEBITO
    CONSTRAINT fk_tarjeta_debito_pago_compra FOREIGN KEY (fk_tarjeta_debito) REFERENCES Tarjeta_Debito (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla TARJETA_CREDITO
    CONSTRAINT fk_tarjeta_credito_pago_compra FOREIGN KEY (fk_tarjeta_credito) REFERENCES Tarjeta_Credito (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla EFECTIVO
    CONSTRAINT fk_efectivo_pago_compra FOREIGN KEY (fk_efectivo) REFERENCES Efectivo (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla CHEQUE
    CONSTRAINT fk_cheque_pago_compra FOREIGN KEY (fk_cheque) REFERENCES Cheque (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla PAGO_COMPRA
    CONSTRAINT check_pago_compra_monto CHECK (pago_compra_monto > 0)
);

CREATE TABLE Pago_Venta (
    -- Código del pago
    pago_venta_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Clave foránea del método de pago
    fk_tarjeta_debito SMALLINT,
    -- Clave foránea del método de pago
    fk_tarjeta_credito SMALLINT,
    -- Clave foránea del método de pago
    fk_efectivo SMALLINT,
    -- Clave foránea del método de pago
    fk_cheque SMALLINT,
    -- Clave foránea del pedido venta 1
    fk_pedido_venta_1 SMALLINT NOT NULL UNIQUE,
    -- Clave foránea del pedido venta 2
    fk_pedido_venta_2 SMALLINT NOT NULL UNIQUE,
    -- Monto del pago
    pago_venta_monto NUMERIC(10,2) NOT NULL,
    -- Fecha de emisión del pago
    pago_venta_fecha_emision DATE NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_pago_venta PRIMARY KEY (pago_venta_codigo, fk_pedido_venta_1, fk_pedido_venta_2),
    -- Restricción de clave foránea que referencia a la tabla TARJETA_DEBITO
    CONSTRAINT fk_tarjeta_debito_pago_venta FOREIGN KEY (fk_tarjeta_debito) REFERENCES Tarjeta_Debito (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla TARJETA_CREDITO
    CONSTRAINT fk_tarjeta_credito_pago_venta FOREIGN KEY (fk_tarjeta_credito) REFERENCES Tarjeta_Credito (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla EFECTIVO
    CONSTRAINT fk_efectivo_pago_venta FOREIGN KEY (fk_efectivo) REFERENCES Efectivo (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla CHEQUE
    CONSTRAINT fk_cheque_pago_venta FOREIGN KEY (fk_cheque) REFERENCES Cheque (metodo_pago_codigo),
    -- Restricción de clave foránea que referencia a la tabla PAGO_VENTA
    CONSTRAINT check_pago_venta_monto CHECK (pago_venta_monto > 0)
);
