-- Base de Datos I - Unidad 4 - Ej18: ProduccionIndustrial
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS INSPECCION;
DROP TABLE IF EXISTS ORDEN_FABRICACION;
DROP TABLE IF EXISTS LINEA_MONTAJE;
DROP TABLE IF EXISTS EMPLEADO;
DROP TABLE IF EXISTS articulo_componente;
DROP TABLE IF EXISTS ARTICULO;

CREATE TABLE ARTICULO (
    id_articulo INT PRIMARY KEY,
    codigo_articulo VARCHAR(50) UNIQUE,
    nombre_comercial VARCHAR(50),
    descripcion_tecnica VARCHAR(100),
    tipo_articulo VARCHAR(50),
    tiempo_estandar_fab INT,
    unidad_medida VARCHAR(100)
);

CREATE TABLE articulo_componente (
    id_art_comp INT PRIMARY KEY,
    id_articulo_padre INT,
    id_articulo_hijo INT,
    cantidad_necesaria INT,
    FOREIGN KEY (id_articulo_padre) REFERENCES ARTICULO(id_articulo),
    FOREIGN KEY (id_articulo_hijo) REFERENCES ARTICULO(id_articulo)
);

CREATE TABLE EMPLEADO (
    id_empleado INT PRIMARY KEY,
    legajo_empleado VARCHAR(50),
    nombre_empleado VARCHAR(50),
    apellido_empleado VARCHAR(100),
    puesto VARCHAR(50),
    sector VARCHAR(100),
    fecha_ingreso DATE
);

CREATE TABLE LINEA_MONTAJE (
    id_linea INT PRIMARY KEY,
    id_supervisor INT,
    codigo_linea VARCHAR(50) UNIQUE,
    descripcion_linea VARCHAR(50),
    capacidad_horaria INT,
    estado_linea VARCHAR(100),
    turno_operativo VARCHAR(50),
    FOREIGN KEY (id_supervisor) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE ORDEN_FABRICACION (
    id_orden INT PRIMARY KEY,
    id_articulo INT,
    id_linea INT,
    numero_orden VARCHAR(50),
    fecha_emision DATE,
    cantidad_planificada INT,
    estado_orden VARCHAR(50),
    fecha_finalizacion DATE,
    FOREIGN KEY (id_articulo) REFERENCES ARTICULO(id_articulo),
    FOREIGN KEY (id_linea) REFERENCES LINEA_MONTAJE(id_linea)
);

CREATE TABLE INSPECCION (
    id_inspeccion INT PRIMARY KEY,
    id_orden INT,
    id_inspector INT,
    numero_inspeccion VARCHAR(50),
    fecha_hora_control DATE,
    resultado VARCHAR(50),
    motivo_falla VARCHAR(100),
    cantidad_inspeccionada INT,
    FOREIGN KEY (id_orden) REFERENCES ORDEN_FABRICACION(id_orden),
    FOREIGN KEY (id_inspector) REFERENCES EMPLEADO(id_empleado)
);

-- Datos de ARTICULO
INSERT INTO ARTICULO (id_articulo, codigo_articulo, nombre_comercial, tipo_articulo, tiempo_estandar_fab) VALUES (1, 'ART-001', 'Bicicleta Montaña', 'Final', 90);
INSERT INTO ARTICULO (id_articulo, codigo_articulo, nombre_comercial, tipo_articulo, tiempo_estandar_fab) VALUES (2, 'ART-002', 'Cuadro de acero', 'Intermedio', 45);
INSERT INTO ARTICULO (id_articulo, codigo_articulo, nombre_comercial, tipo_articulo, tiempo_estandar_fab) VALUES (3, 'ART-003', 'Rueda armada', 'Intermedio', 30);
INSERT INTO ARTICULO (id_articulo, codigo_articulo, nombre_comercial, tipo_articulo, tiempo_estandar_fab) VALUES (4, 'ART-005', 'Tornillo M6', 'Materia prima', 1);

-- Datos de articulo_componente
INSERT INTO articulo_componente (id_art_comp, id_articulo_padre, id_articulo_hijo, cantidad_necesaria) VALUES (1, 1, 2, 1);
INSERT INTO articulo_componente (id_art_comp, id_articulo_padre, id_articulo_hijo, cantidad_necesaria) VALUES (2, 1, 3, 2);
INSERT INTO articulo_componente (id_art_comp, id_articulo_padre, id_articulo_hijo, cantidad_necesaria) VALUES (3, 3, 4, 8);
INSERT INTO articulo_componente (id_art_comp, id_articulo_padre, id_articulo_hijo, cantidad_necesaria) VALUES (4, 2, 4, 12);

-- Datos de EMPLEADO
INSERT INTO EMPLEADO (id_empleado, legajo_empleado, nombre_empleado, puesto, fecha_ingreso) VALUES (1, 'EM-01', 'Gabriel', 'Supervisor', '2018-03-01');
INSERT INTO EMPLEADO (id_empleado, legajo_empleado, nombre_empleado, puesto, fecha_ingreso) VALUES (2, 'EM-02', 'Hilda', 'Supervisor', '2019-05-15');
INSERT INTO EMPLEADO (id_empleado, legajo_empleado, nombre_empleado, puesto, fecha_ingreso) VALUES (3, 'EM-04', 'Jimena', 'Inspector', '2021-02-01');
INSERT INTO EMPLEADO (id_empleado, legajo_empleado, nombre_empleado, puesto, fecha_ingreso) VALUES (4, 'EM-05', 'Karina', 'Inspector', '2022-11-07');

-- Datos de LINEA_MONTAJE
INSERT INTO LINEA_MONTAJE (id_linea, id_supervisor, codigo_linea, descripcion_linea, turno_operativo) VALUES (1, 1, 'L-01', 'Soldadura', 'Mañana');
INSERT INTO LINEA_MONTAJE (id_linea, id_supervisor, codigo_linea, descripcion_linea, turno_operativo) VALUES (2, 2, 'L-02', 'Pintura', 'Tarde');
INSERT INTO LINEA_MONTAJE (id_linea, id_supervisor, codigo_linea, descripcion_linea, turno_operativo) VALUES (3, 1, 'L-04', 'Armado de ruedas', 'Tarde');
INSERT INTO LINEA_MONTAJE (id_linea, id_supervisor, codigo_linea, descripcion_linea, turno_operativo) VALUES (4, 2, 'L-05', 'Control y embalaje', 'Noche');

-- Datos de ORDEN_FABRICACION
INSERT INTO ORDEN_FABRICACION (id_orden, id_articulo, id_linea, numero_orden, estado_orden) VALUES (1, 2, 1, 'OF-0002', 'Finalizada');
INSERT INTO ORDEN_FABRICACION (id_orden, id_articulo, id_linea, numero_orden, estado_orden) VALUES (2, 3, 3, 'OF-0003', 'En proceso');
INSERT INTO ORDEN_FABRICACION (id_orden, id_articulo, id_linea, numero_orden, estado_orden) VALUES (3, 1, 4, 'OF-0004', 'Planificada');
INSERT INTO ORDEN_FABRICACION (id_orden, id_articulo, id_linea, numero_orden, estado_orden) VALUES (4, 3, 2, 'OF-0005', 'Finalizada');

-- Datos de INSPECCION
INSERT INTO INSPECCION (id_inspeccion, id_orden, id_inspector, numero_inspeccion, resultado) VALUES (1, 1, 4, 'INS-002', 'Rechazado');
INSERT INTO INSPECCION (id_inspeccion, id_orden, id_inspector, numero_inspeccion, resultado) VALUES (2, 2, 3, 'INS-003', 'Aprobado');
INSERT INTO INSPECCION (id_inspeccion, id_orden, id_inspector, numero_inspeccion, resultado) VALUES (3, 3, 4, 'INS-004', 'Aprobado');
INSERT INTO INSPECCION (id_inspeccion, id_orden, id_inspector, numero_inspeccion, resultado) VALUES (4, 4, 3, 'INS-005', 'Rework');
