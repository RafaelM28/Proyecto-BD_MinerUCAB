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
    persona_jur_razon_social VARCHAR(30) NOT NULL UNIQUE,
    -- Denominación comercial del aliado
    persona_jur_denominacion_comercial VARCHAR(30) NOT NULL UNIQUE,
    -- Capital total del aliado
    persona_jur_capital_total NUMERIC(10,2) NOT NULL,
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
    persona_jur_razon_social VARCHAR(30) NOT NULL UNIQUE,
    -- Denominación comercial del cliente
    persona_jur_denominacion_comercial VARCHAR(30) NOT NULL UNIQUE,
    -- Capital total del cliente
    persona_jur_capital_total NUMERIC(10,2) NOT NULL,
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
    -- Clave foránea del aliado
    fk_aliado SMALLINT,
    -- Clave foránea del cliente
    fk_cliente SMALLINT,
    -- Clave foránea del empleado
    fk_empleado SMALLINT,

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
    -- Clave foránea del aliado
    fk_aliado        SMALLINT,
    -- Clave foránea del cliente
    fk_cliente       SMALLINT,
    -- Clave foránea del empleado
    fk_empleado      SMALLINT,

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
    -- Fecha de inicio del contrato
    emp_cargo_fecha_ingreso DATE NOT NULL,
    -- Fecha de fin del contrato
    emp_cargo_fecha_salida DATE,
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Clave foránea del cargo
    fk_cargo SMALLINT NOT NULL,

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
    -- Fecha de inicio de estatus
    hist_est_empl_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_emplo_fecha_fin TIMESTAMP,
    -- Clave foránea del empleado
    fk_empleado SMALLINT NOT NULL,
    -- Clave foránea del estatus
    fk_estatus_disponibilidad SMALLINT NOT NULL,

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
    -- Clave foránea del yacimiento
    fk_yacimiento SMALLINT NOT NULL,
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,
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
    -- Restricción de clave foránea que referencia a la tabla MINA para su primera PK
    CONSTRAINT fk_mina_1_pozo FOREIGN KEY (fk_mina_1) REFERENCES Mina (mina_id),
    -- Restricción de clave foránea que referencia a la tabla MINA para su segunda PK
    CONSTRAINT fk_mina_2_pozo FOREIGN KEY (fk_mina_2) REFERENCES Mina (mina_id),
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
    -- Fecha de inicio de estatus
    hist_est_pozo_fecha_inicio TIMESTAMP NOT NULL,
    -- Fecha de fin de estatus
    hist_est_pozo_fecha_fin TIMESTAMP,
    -- Clave foránea del pozo
    fk_pozo_1 SMALLINT NOT NULL,
    -- Clave foránea del pozo
    fk_pozo_2 SMALLINT NOT NULL,
    -- Clave foránea del pozo
    fk_pozo_3 SMALLINT NOT NULL,
    -- Clave foránea del estatus
    fk_estatus_pozo SMALLINT NOT NULL,

    -- Restricción de clave primaria
    CONSTRAINT pk_historico_estatus_pozo PRIMARY KEY (hist_est_pozo_codigo, fk_pozo_1, fk_pozo_2, fk_pozo_3, fk_estatus_pozo),
    -- Restricción de clave foránea que referencia a la tabla POZO para su primera PK
    CONSTRAINT fk_pozo_1_historico_estatus_pozo FOREIGN KEY (fk_pozo_1) REFERENCES Pozo (pozo_id),
    -- Restricción de clave foránea que referencia a la tabla POZO para su segunda PK
    CONSTRAINT fk_pozo_2_historico_estatus_pozo FOREIGN KEY (fk_pozo_2) REFERENCES Pozo (pozo_id),
    -- Restricción de clave foránea que referencia a la tabla POZO para su tercera PK
    CONSTRAINT fk_pozo_3_historico_estatus_pozo FOREIGN KEY (fk_pozo_3) REFERENCES Pozo (pozo_id),
    -- Restricción de clave foránea que referencia a la tabla ESTATUS_POZO
    CONSTRAINT fk_estatus_historico_estatus_pozo FOREIGN KEY (fk_estatus_pozo) REFERENCES Estatus_Pozo (estatus_pozo_codigo)
);

CREATE TABLE Inventario_Producto (
    -- Código del inventario
    inventario_producto_codigo SMALLSERIAL NOT NULL UNIQUE,
    -- Cantidad de producto
    inventario_producto_cantidad_total INTEGER NOT NULL,
    -- Cantidad de producto que ingresó en la operación
    inventario_producto_operacion INTEGER NOT NULL,
    -- Tipo de operación
    inventario_producto_tipo_operacion VARCHAR(15) NOT NULL,
    -- Fecha de la operación
    inventario_producto_fecha_movimiento DATE NOT NULL,
    -- Clave foránea del mineral
    fk_mineral SMALLINT NOT NULL,

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
