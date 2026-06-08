CREATE PLUGGABLE DATABASE campusfp_pdb
ADMIN USER campus_admin IDENTIFIED BY CampusFP2025
FILE_NAME_CONVERT = (
'/opt/oracle/oradata/XE/pdbseed/',
'/opt/oracle/oradata/XE/campusfp_pdb/'
);

ALTER PLUGGABLE DATABASE campusfp_pdb OPEN;

ALTER PLUGGABLE DATABASE campusfp_pdb SAVE STATE;
SHOW PDBS;
ALTER SESSION SET CONTAINER=campusfp_pdb;

-- ============================================================
-- CAMPUSFP
-- BASE DE DATOS ORACLE SQL DEVELOPER
-- DEMO ASIR
-- ============================================================

-- ============================================================
-- LIMPIEZA
-- ============================================================

BEGIN EXECUTE IMMEDIATE 'DROP TABLE horarios CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE matriculas CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE profesores_asignaturas CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE asignaturas CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE alumnos CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE profesores CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE aulas CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE ciclos_formativos CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- ============================================================
-- TABLAS
-- ============================================================

CREATE TABLE ciclos_formativos (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    familia VARCHAR2(100),
    nivel VARCHAR2(20),
    duracion_horas NUMBER,
    activo NUMBER(1)
);

CREATE TABLE profesores (
    id NUMBER PRIMARY KEY,
    dni VARCHAR2(9) UNIQUE,
    nombre VARCHAR2(50),
    apellidos VARCHAR2(100),
    email VARCHAR2(150),
    telefono VARCHAR2(15),
    especialidad VARCHAR2(100),
    fecha_contratacion DATE,
    salario NUMBER(10,2),
    activo NUMBER(1),
    ciclo_id NUMBER,
    coordinador_id NUMBER,

    FOREIGN KEY (ciclo_id)
        REFERENCES ciclos_formativos(id),

    FOREIGN KEY (coordinador_id)
        REFERENCES profesores(id)
);

CREATE TABLE alumnos (
    id NUMBER PRIMARY KEY,
    dni VARCHAR2(9) UNIQUE,
    nombre VARCHAR2(50),
    apellidos VARCHAR2(100),
    email VARCHAR2(150),
    telefono VARCHAR2(15),
    direccion VARCHAR2(200),
    fecha_nacimiento DATE,
    fecha_alta DATE,
    estado VARCHAR2(20),
    ciclo_id NUMBER,

    FOREIGN KEY (ciclo_id)
        REFERENCES ciclos_formativos(id)
);

CREATE TABLE asignaturas (
    id NUMBER PRIMARY KEY,
    codigo VARCHAR2(20),
    nombre VARCHAR2(150),
    horas NUMBER,
    curso NUMBER,
    descripcion CLOB,
    ciclo_id NUMBER,

    FOREIGN KEY (ciclo_id)
        REFERENCES ciclos_formativos(id)
);

CREATE TABLE profesores_asignaturas (
    profesor_id NUMBER,
    asignatura_id NUMBER,
    aula VARCHAR2(20),

    PRIMARY KEY (profesor_id, asignatura_id),

    FOREIGN KEY (profesor_id)
        REFERENCES profesores(id),

    FOREIGN KEY (asignatura_id)
        REFERENCES asignaturas(id)
);

CREATE TABLE matriculas (
    id NUMBER PRIMARY KEY,
    alumno_id NUMBER,
    fecha_matricula DATE,
    curso_academico VARCHAR2(20),
    estado VARCHAR2(20),
    importe NUMBER(10,2),

    FOREIGN KEY (alumno_id)
        REFERENCES alumnos(id)
);

CREATE TABLE aulas (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    planta NUMBER,
    capacidad NUMBER,
    tipo VARCHAR2(50)
);

CREATE TABLE horarios (
    id NUMBER PRIMARY KEY,
    asignatura_id NUMBER,
    profesor_id NUMBER,
    aula_id NUMBER,
    dia_semana VARCHAR2(20),
    hora_inicio VARCHAR2(10),
    hora_fin VARCHAR2(10),

    FOREIGN KEY (asignatura_id)
        REFERENCES asignaturas(id),

    FOREIGN KEY (profesor_id)
        REFERENCES profesores(id),

    FOREIGN KEY (aula_id)
        REFERENCES aulas(id)
);

-- ============================================================
-- CICLOS FORMATIVOS
-- ============================================================

INSERT INTO ciclos_formativos VALUES
(1,'ASIR','Informática','Superior',2000,1);

INSERT INTO ciclos_formativos VALUES
(2,'DAM','Informática','Superior',2000,1);

INSERT INTO ciclos_formativos VALUES
(3,'DAW','Informática','Superior',2000,1);

INSERT INTO ciclos_formativos VALUES
(4,'SMR','Informática','Medio',2000,1);

INSERT INTO ciclos_formativos VALUES
(5,'Ciberseguridad','Informática','Especialización',720,1);

INSERT INTO ciclos_formativos VALUES
(6,'Marketing y Publicidad','Marketing','Superior',2000,1);

-- ============================================================
-- PROFESORES
-- ============================================================

INSERT INTO profesores VALUES
(1,'11111111A','Carlos','Martinez Ruiz',
'carlos.martinez@campusfp.es',
'600111111',
'Redes',
DATE '2018-09-01',
32000,
1,
1,
NULL);

INSERT INTO profesores VALUES
(2,'22222222B','Laura','Gomez Perez',
'laura.gomez@campusfp.es',
'600222222',
'Bases de Datos',
DATE '2019-09-01',
34000,
1,
1,
1);

INSERT INTO profesores VALUES
(3,'33333333C','Miguel','Sanchez Torres',
'miguel.sanchez@campusfp.es',
'600333333',
'Linux',
DATE '2017-09-01',
35000,
1,
1,
1);

INSERT INTO profesores VALUES
(4,'44444444D','Ana','Ruiz Martin',
'ana.ruiz@campusfp.es',
'600444444',
'Programación Java',
DATE '2020-09-01',
31000,
1,
2,
NULL);

INSERT INTO profesores VALUES
(5,'55555555E','Javier','Lopez Gil',
'javier.lopez@campusfp.es',
'600555555',
'Python',
DATE '2021-09-01',
30000,
1,
2,
4);

INSERT INTO profesores VALUES
(6,'66666666F','Sonia','Morales Diaz',
'sonia.morales@campusfp.es',
'600666666',
'Desarrollo Web',
DATE '2019-09-01',
33000,
1,
3,
NULL);

INSERT INTO profesores VALUES
(7,'77777777G','Pablo','Romero Vega',
'pablo.romero@campusfp.es',
'600777777',
'Ciberseguridad',
DATE '2022-09-01',
36000,
1,
5,
NULL);

INSERT INTO profesores VALUES
(8,'88888888H','Lucia','Navarro Campos',
'lucia.navarro@campusfp.es',
'600888888',
'Marketing Digital',
DATE '2020-09-01',
29500,
1,
6,
NULL);

-- ============================================================
-- ALUMNOS
-- ============================================================

INSERT INTO alumnos VALUES
(1,'10000001A','Sergio','Roman',
'sergio.roman@campusfp.es',
'611111111',
'Madrid',
DATE '2004-05-12',
SYSDATE,
'activo',
1);

INSERT INTO alumnos VALUES
(2,'10000002B','Ivan','Lopez',
'ivan.lopez@campusfp.es',
'622222222',
'Madrid',
DATE '2003-10-21',
SYSDATE,
'activo',
1);

INSERT INTO alumnos VALUES
(3,'10000003C','David','Moreno',
'david.moreno@campusfp.es',
'633333333',
'Getafe',
DATE '2005-01-11',
SYSDATE,
'activo',
2);

INSERT INTO alumnos VALUES
(4,'10000004D','Mario','Sanz',
'mario.sanz@campusfp.es',
'644444444',
'Leganés',
DATE '2004-07-22',
SYSDATE,
'activo',
2);

INSERT INTO alumnos VALUES
(5,'10000005E','Laura','Perez',
'laura.perez@campusfp.es',
'655555555',
'Alcorcón',
DATE '2005-02-19',
SYSDATE,
'activo',
3);

INSERT INTO alumnos VALUES
(6,'10000006F','Paula','Ruiz',
'paula.ruiz@campusfp.es',
'666666666',
'Móstoles',
DATE '2003-12-30',
SYSDATE,
'activo',
3);

INSERT INTO alumnos VALUES
(7,'10000007G','Andres','Torres',
'andres.torres@campusfp.es',
'677777777',
'Fuenlabrada',
DATE '2004-11-09',
SYSDATE,
'activo',
4);

INSERT INTO alumnos VALUES
(8,'10000008H','Lucia','Gomez',
'lucia.gomez@campusfp.es',
'688888888',
'Parla',
DATE '2005-06-17',
SYSDATE,
'activo',
4);

INSERT INTO alumnos VALUES
(9,'10000009I','Raul','Martinez',
'raul.martinez@campusfp.es',
'699999999',
'Madrid',
DATE '2002-09-15',
SYSDATE,
'activo',
5);

INSERT INTO alumnos VALUES
(10,'10000010J','Elena','Gil',
'elena.gil@campusfp.es',
'611222333',
'Getafe',
DATE '2001-08-10',
SYSDATE,
'activo',
5);

INSERT INTO alumnos VALUES
(11,'10000011K','Cristina','Lozano',
'cristina.lozano@campusfp.es',
'622333444',
'Madrid',
DATE '2005-04-14',
SYSDATE,
'activo',
6);

INSERT INTO alumnos VALUES
(12,'10000012L','Adrian','Vega',
'adrian.vega@campusfp.es',
'633444555',
'Madrid',
DATE '2004-03-20',
SYSDATE,
'baja',
1);

-- ============================================================
-- ASIGNATURAS
-- ============================================================

INSERT INTO asignaturas VALUES
(1,'ASIR101',
'Implantación de Sistemas Operativos',
256,
1,
'Administración Linux y Windows',
1);

INSERT INTO asignaturas VALUES
(2,'ASIR102',
'Bases de Datos',
192,
1,
'Oracle y SQL',
1);

INSERT INTO asignaturas VALUES
(3,'ASIR103',
'Planificación y Administración de Redes',
224,
1,
'Redes Cisco',
1);

INSERT INTO asignaturas VALUES
(4,'ASIR201',
'Servicios en Red',
210,
2,
'Apache, DNS, DHCP',
1);

INSERT INTO asignaturas VALUES
(5,'ASIR202',
'Seguridad y Alta Disponibilidad',
168,
2,
'Firewalls y hardening',
1);

INSERT INTO asignaturas VALUES
(6,'DAM101',
'Programación',
256,
1,
'Java y POO',
2);

INSERT INTO asignaturas VALUES
(7,'DAM102',
'Entornos de Desarrollo',
128,
1,
'Git y testing',
2);

INSERT INTO asignaturas VALUES
(8,'DAW101',
'Lenguajes de Marcas',
128,
1,
'HTML y CSS',
3);

INSERT INTO asignaturas VALUES
(9,'SMR101',
'Sistemas Operativos Monopuesto',
192,
1,
'Windows y Linux',
4);

INSERT INTO asignaturas VALUES
(10,'CIBER101',
'Hacking Ético',
180,
1,
'Pentesting',
5);

-- ============================================================
-- PROFESORES_ASIGNATURAS
-- ============================================================

INSERT INTO profesores_asignaturas VALUES
(1,3,'AULA A1');

INSERT INTO profesores_asignaturas VALUES
(2,2,'AULA A2');

INSERT INTO profesores_asignaturas VALUES
(3,1,'AULA A3');

INSERT INTO profesores_asignaturas VALUES
(3,4,'AULA A1');

INSERT INTO profesores_asignaturas VALUES
(1,5,'AULA LAB');

INSERT INTO profesores_asignaturas VALUES
(4,6,'AULA B1');

INSERT INTO profesores_asignaturas VALUES
(5,7,'AULA B2');

INSERT INTO profesores_asignaturas VALUES
(6,8,'AULA WEB');

INSERT INTO profesores_asignaturas VALUES
(7,10,'AULA SEC');

INSERT INTO profesores_asignaturas VALUES
(3,9,'AULA SMR');

-- ============================================================
-- MATRICULAS
-- ============================================================

INSERT INTO matriculas VALUES
(1,1,SYSDATE,'2025/2026','pagada',1800);

INSERT INTO matriculas VALUES
(2,2,SYSDATE,'2025/2026','pendiente',1800);

INSERT INTO matriculas VALUES
(3,3,SYSDATE,'2025/2026','pagada',1900);

INSERT INTO matriculas VALUES
(4,4,SYSDATE,'2025/2026','pagada',1900);

INSERT INTO matriculas VALUES
(5,5,SYSDATE,'2025/2026','pendiente',1750);

INSERT INTO matriculas VALUES
(6,6,SYSDATE,'2025/2026','pagada',1750);

INSERT INTO matriculas VALUES
(7,7,SYSDATE,'2025/2026','pagada',1500);

INSERT INTO matriculas VALUES
(8,8,SYSDATE,'2025/2026','cancelada',1500);

INSERT INTO matriculas VALUES
(9,9,SYSDATE,'2025/2026','pagada',2200);

INSERT INTO matriculas VALUES
(10,10,SYSDATE,'2025/2026','pendiente',2200);

INSERT INTO matriculas VALUES
(11,11,SYSDATE,'2025/2026','pagada',1700);

INSERT INTO matriculas VALUES
(12,12,SYSDATE,'2025/2026','baja',1800);

-- ============================================================
-- AULAS
-- ============================================================

INSERT INTO aulas VALUES
(1,'AULA A1',1,30,'Redes');

INSERT INTO aulas VALUES
(2,'AULA A2',1,25,'Bases de Datos');

INSERT INTO aulas VALUES
(3,'AULA A3',1,30,'Linux');

INSERT INTO aulas VALUES
(4,'AULA B1',2,28,'Programación');

INSERT INTO aulas VALUES
(5,'AULA B2',2,28,'Desarrollo');

INSERT INTO aulas VALUES
(6,'AULA WEB',2,25,'Web');

INSERT INTO aulas VALUES
(7,'AULA SEC',3,20,'Ciberseguridad');

INSERT INTO aulas VALUES
(8,'AULA SMR',1,30,'Hardware');

INSERT INTO aulas VALUES
(9,'LABORATORIO',0,15,'Laboratorio');

-- ============================================================
-- HORARIOS
-- ============================================================

INSERT INTO horarios VALUES
(1,1,3,3,'Lunes','08:00','10:00');

INSERT INTO horarios VALUES
(2,2,2,2,'Lunes','10:00','12:00');

INSERT INTO horarios VALUES
(3,3,1,1,'Martes','08:00','10:00');

INSERT INTO horarios VALUES
(4,4,3,1,'Martes','10:00','12:00');

INSERT INTO horarios VALUES
(5,5,1,7,'Miércoles','08:00','10:00');

INSERT INTO horarios VALUES
(6,6,4,4,'Miércoles','10:00','12:00');

INSERT INTO horarios VALUES
(7,7,5,5,'Jueves','08:00','10:00');

INSERT INTO horarios VALUES
(8,8,6,6,'Jueves','10:00','12:00');

INSERT INTO horarios VALUES
(9,9,3,8,'Viernes','08:00','10:00');

INSERT INTO horarios VALUES
(10,10,7,7,'Viernes','10:00','12:00');

COMMIT;

-- ============================================================
-- CONSULTAS DE PRUEBA
-- ============================================================

-- TODOS LOS ALUMNOS DE ASIR

SELECT a.nombre, a.apellidos, c.nombre AS ciclo
FROM alumnos a
JOIN ciclos_formativos c
ON a.ciclo_id = c.id
WHERE c.nombre = 'ASIR';

-- PROFESORES Y ASIGNATURAS

SELECT
    p.nombre,
    p.apellidos,
    a.nombre AS asignatura
FROM profesores p
JOIN profesores_asignaturas pa
ON p.id = pa.profesor_id
JOIN asignaturas a
ON pa.asignatura_id = a.id;

-- HORARIOS COMPLETOS

SELECT
    a.nombre AS asignatura,
    p.nombre AS profesor,
    au.nombre AS aula,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin
FROM horarios h
JOIN asignaturas a
ON h.asignatura_id = a.id
JOIN profesores p
ON h.profesor_id = p.id
JOIN aulas au
ON h.aula_id = au.id;

-- ALUMNOS CON MATRICULA PENDIENTE

SELECT
    al.nombre,
    al.apellidos,
    m.estado
FROM alumnos al
JOIN matriculas m
ON al.id = m.alumno_id
WHERE m.estado = 'pendiente';

-- ============================================================
-- FIN
-- ============================================================

--VISTA UTIL
CREATE VIEW vista_horarios_asir AS
SELECT
    a.nombre AS asignatura,
    p.nombre AS profesor,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin
FROM horarios h
JOIN asignaturas a
ON h.asignatura_id = a.id
JOIN profesores p
ON h.profesor_id = p.id;



--PROCEDIMIENTO
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE listar_alumnos_asir
IS
BEGIN
    FOR alumno IN (
        SELECT nombre, apellidos
        FROM alumnos
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            alumno.nombre || ' ' || alumno.apellidos
        );
    END LOOP;
END;
/



-- VER TODAS LAS TABLAS
SELECT table_name
FROM user_tables
WHERE table_name IN (
    'CICLOS_FORMATIVOS',
    'PROFESORES',
    'ALUMNOS',
    'ASIGNATURAS',
    'PROFESORES_ASIGNATURAS',
    'MATRICULAS',
    'AULAS',
    'HORARIOS'
)
ORDER BY table_name;

-- CREAMOS USER CAMPUS
CREATE USER campus
IDENTIFIED BY Campus123;
GRANT CREATE SESSION TO campus;
GRANT CREATE TABLE TO campus;
GRANT CREATE VIEW TO campus;
GRANT CREATE TRIGGER TO campus;
GRANT CREATE PROCEDURE TO campus;
GRANT CREATE SEQUENCE TO campus;

-- TABLA AUDITORIA
CREATE TABLE auditoria_campusfp (
    id number generated always as identify,
    usuario_bd varchar2(200),
    tabla_afectada varchar2(100),
    operacion varchar2(20),
    fecha_operacion date,
    datos_anteriores clob,
    datos_nuevos clob,
    aprobado number(1),
    observacion varchar2(500)
    );
    
    
    
-- TRIGGER PARA INSERTAR EN TABLA AUDITORIA
CREATE OR REPLACE TRIGGER trg_auditoria_alumnos
AFTER INSERT OR UPDATE OR DELETE
ON alumnos
FOR EACH ROW
BEGIN

    INSERT INTO auditoria_campusfp (
        usuario_bd,
        tabla_afectada,
        operacion,
        fecha_operacion,
        datos_anteriores,
        datos_nuevos,
        aprobado,
        observacion
    )
    VALUES (
        USER,
        'ALUMNOS',
        CASE
            WHEN INSERTING THEN 'INSERT'
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END,
        SYSDATE,
        :OLD.nombre,
        :NEW.nombre,
        1,
        'OK'
    );

END;
/


-- TRIGGER PARA BLOQUEAR DELETES
CREATE OR REPLACE TRIGGER trg_bloqueo_delete_alumnos
BEFORE DELETE ON alumnos
FOR EACH ROW
BEGIN

    INSERT INTO auditoria_campusfp (
        usuario_bd,
        tabla_afectada,
        operacion,
        fecha_operacion,
        datos_anteriores,
        datos_nuevos,
        aprobado,
        observacion
    )
    VALUES (
        USER,
        'ALUMNOS',
        'DELETE',
        SYSDATE,
        :OLD.nombre,
        NULL,
        0,
        'DELETE BLOQUEADO. REQUIERE APROBACION SYSDBA'
    );

    RAISE_APPLICATION_ERROR(
        -20001,
        'DELETE BLOQUEADO. CONTACTE CON SYSDBA PARA APROBACION'
    );

END;
/




    
    








