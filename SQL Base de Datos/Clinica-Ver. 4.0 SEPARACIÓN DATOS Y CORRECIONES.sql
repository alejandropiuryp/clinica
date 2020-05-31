-------------------------------------------------------------------------------------------------------DROPS 
DROP TABLE TASAS;
DROP TABLE TRABAJADORES;
DROP TABLE LINEAS_DE_TASAS;
DROP TABLE CERTIFICADOS;
DROP TABLE INSTITUCIONES_REGULADORAS;
DROP TABLE REQUIERE;
DROP TABLE PRUEBAS_MEDICAS;
DROP TABLE CLIENTES;
DROP TABLE CITAS;
DROP TABLE FOTOS;

DROP TABLE TIPO_CERTIFICADO;
DROP TABLE ESTADO_CERTIFICADO;
DROP TABLE TIPO_INSITUCION;
DROP TABLE ESPECIALIDAD;
DROP TABLE TIPO_CITA;

DROP SEQUENCE INC_OID_TASAS;
DROP SEQUENCE INC_OID_LINEA_DE_TASAS;
DROP SEQUENCE INC_OID_CERTIFICADOS;
DROP SEQUENCE INC_OID_IR;
DROP SEQUENCE INC_OID_REQUIERE;
DROP SEQUENCE INC_OID_FOTOS;

-------------------------------------------------------------------------------------------------------TIPO CERTIFICADO
CREATE TABLE TIPO_CERTIFICADO (
 OID_TIPO_CERTIFICADO INT UNIQUE NOT NULL,
 TIPO VARCHAR(30)
);
/
INSERT INTO TIPO_CERTIFICADO VALUES (1,'Laborales');
INSERT INTO TIPO_CERTIFICADO VALUES (2,'Oposiciones laborales');
INSERT INTO TIPO_CERTIFICADO VALUES (3,'Gruistas');
INSERT INTO TIPO_CERTIFICADO VALUES (4,'Licencia de Armas');
INSERT INTO TIPO_CERTIFICADO VALUES (5,'Navegación');
INSERT INTO TIPO_CERTIFICADO VALUES (6,'Permiso de conducir');
INSERT INTO TIPO_CERTIFICADO VALUES (7,'Razas peligrosas');

-------------------------------------------------------------------------------------------------------ESTADO CERTIFICADO
CREATE TABLE ESTADO_CERTIFICADO (
 OID_ESTADO_CERTIFICADO INT UNIQUE NOT NULL,
 TIPO VARCHAR(20)
);
/
INSERT INTO ESTADO_CERTIFICADO VALUES (1,'Denegado');
INSERT INTO ESTADO_CERTIFICADO VALUES (2,'En proceso');
INSERT INTO ESTADO_CERTIFICADO VALUES (3,'Validado');

-------------------------------------------------------------------------------------------------------TIPO INSTITUCIÓN
CREATE TABLE TIPO_INSITUCION (
 OID_TIPO_INSITUCION INT UNIQUE NOT NULL,
 TIPO VARCHAR(50)
);
/
INSERT INTO TIPO_INSITUCION VALUES (1,'Sede Electrónica de Tráfico');
INSERT INTO TIPO_INSITUCION VALUES (2,'Departamento de armas de la Guardia Civil');
INSERT INTO TIPO_INSITUCION VALUES (3,'Junta de Andalucía Consejería de Transporte');

-------------------------------------------------------------------------------------------------------ESPECIALIDAD
CREATE TABLE ESPECIALIDAD (
 OID_ESPECIALIDAD INT UNIQUE NOT NULL,
 TIPO VARCHAR(20)
);
/
INSERT INTO ESPECIALIDAD VALUES (1,'MÉDICO');
INSERT INTO ESPECIALIDAD VALUES (2,'PSICÓLOGO');
INSERT INTO ESPECIALIDAD VALUES (3,'OFTALMÓLOGO');
INSERT INTO ESPECIALIDAD VALUES (4,'ABOGADO');

-------------------------------------------------------------------------------------------------------TIPO CITA
CREATE TABLE TIPO_CITA (
 OID_CITA INT UNIQUE NOT NULL,
 TIPO VARCHAR(20)
);
/
INSERT INTO TIPO_CITA VALUES (1,'Web');
INSERT INTO TIPO_CITA VALUES (2,'Teléfono');


-------------------------------------------------------------------------------------------------------TABLAS 

CREATE TABLE TRABAJADORES(
 NIF VARCHAR(9) NOT NULL,
 PRIMARY KEY (NIF),
 NOMBRE VARCHAR(25),
 APELLIDOS VARCHAR(25),
 ESPECIALIDAD NUMBER(1),
 TELEFONO NUMBER(9) NOT NULL,
 EMAIL VARCHAR(40),
 PASS VARCHAR2(75) NOT NULL,
 FOREIGN KEY (ESPECIALIDAD) REFERENCES ESPECIALIDAD(OID_ESPECIALIDAD) ON DELETE CASCADE
);
/
CREATE TABLE TASAS(
 OID_TASA NUMBER(7) NOT NULL,
 PRIMARY KEY (OID_TASA),
 NIF VARCHAR(9) NOT NULL,
 FECHA DATE,
 FOREIGN KEY (NIF) REFERENCES TRABAJADORES(NIF)on DELETE cascade
);
/
CREATE TABLE INSTITUCIONES_REGULADORAS(
 OID_IR NUMBER(7) NOT NULL,
 TIPO_INSTITUCION NUMBER(1) NOT NULL,
 FECHA_VALIDACION DATE,
 PRIMARY KEY (OID_IR),
 FOREIGN KEY (TIPO_INSTITUCION) REFERENCES TIPO_INSITUCION(OID_TIPO_INSITUCION) on DELETE cascade
);
/
CREATE TABLE CERTIFICADOS(
 OID_C NUMBER(7) NOT NULL,
 TIPO_CERTIFICADO NUMBER(1) NOT NULL,
 FECHA_EMISION date,
 PRECIO NUMBER(3),
 ESTADO_CERTIFICADO NUMBER(1),
 NIF VARCHAR(9) NOT NULL,
 OID_IR NUMBER(7) NOT NULL,
 PRIMARY KEY (OID_C),
 FOREIGN KEY (TIPO_CERTIFICADO) REFERENCES TIPO_CERTIFICADO(OID_TIPO_CERTIFICADO) ON DELETE CASCADE,
 FOREIGN KEY (ESTADO_CERTIFICADO) REFERENCES ESTADO_CERTIFICADO(OID_ESTADO_CERTIFICADO) ON DELETE CASCADE,
 FOREIGN KEY (NIF) REFERENCES TRABAJADORES(NIF) ON DELETE CASCADE,
 FOREIGN KEY (OID_IR) REFERENCES INSTITUCIONES_REGULADORAS(OID_IR) ON DELETE CASCADE 
);
/
CREATE TABLE LINEAS_DE_TASAS(
 OID_LINEAS_DE_TASAS NUMBER(7) NOT NULL,
 PRECIO NUMBER NOT NULL,
 CANTIDAD NUMBER(7) NOT NULL,
 OID_T NUMBER(7) NOT NULL,
 OID_C NUMBER(7) NOT NULL,
 PRIMARY KEY (OID_LINEAS_DE_TASAS),
 FOREIGN KEY (OID_T) REFERENCES TASAS(OID_TASA) on DELETE cascade,
 FOREIGN KEY (OID_C) REFERENCES CERTIFICADOS(OID_C) on DELETE cascade
);
/
CREATE TABLE CLIENTES(
 DNI VARCHAR(9) NOT NULL,
 NOMBRE VARCHAR(25) NOT NULL,
 APELLIDO VARCHAR(25) NOT NULL,
 EDAD int,
 DOMICILIO VARCHAR(50),
 TELEFONO NUMBER(9) NOT NULL,
 UNIQUE(TELEFONO),
 TARJETA_SANITARIA VARCHAR(50),
 PASS VARCHAR2(75) NOT NULL,
 FECHA_NACIMIENTO DATE,
 EMAIL VARCHAR2(75) NOT NULL UNIQUE,
 PRIMARY KEY(DNI)
);
/
CREATE TABLE PRUEBAS_MEDICAS(
 NOMBRE VARCHAR(25) NOT NULL,
 DNI VARCHAR(9) NOT NULL,
 PRIMARY KEY(NOMBRE),
 FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI) on DELETE cascade
);
/
CREATE TABLE REQUIERE(
 OID_R NUMBER(7) NOT NULL,
 OID_C NUMBER(7) NOT NULL,
 NOMBRE VARCHAR(25) NOT NULL,
 PRIMARY KEY (OID_R),
 FOREIGN KEY (OID_C) REFERENCES CERTIFICADOS(OID_C) on DELETE cascade,
 FOREIGN KEY (NOMBRE) REFERENCES PRUEBAS_MEDICAS(NOMBRE) on DELETE cascade
);
/
CREATE TABLE FOTOS(
 OID_F NUMBER(7) NOT NULL,
 TAMAÑO VARCHAR(20) NOT NULL,
 FORMATO VARCHAR(10),
 DNI VARCHAR(9) NOT NULL,
 PRIMARY KEY(OID_F),
 FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI) ON DELETE CASCADE
);
/
CREATE TABLE CITAS(
 FECHA DATE NOT NULL, 
 HORA VARCHAR(8) NOT NULL,
 TIPO_CITA NUMBER(1),
 DNI VARCHAR(9) NOT NULL,
 TIPO_CERTIFICADO NUMBER(1) NOT NULL,
 PRIMARY KEY(FECHA,HORA),
 FOREIGN KEY (TIPO_CITA) REFERENCES TIPO_CITA(OID_CITA) on DELETE cascade,
 FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI) on DELETE cascade,
 FOREIGN KEY (TIPO_CERTIFICADO) REFERENCES TIPO_CERTIFICADO(OID_TIPO_CERTIFICADO) on DELETE cascade
);
/
-------------------------------------------------------------------------------------------------------SECUENCIAS
CREATE SEQUENCE INC_OID_TASAS
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
CREATE SEQUENCE INC_OID_LINEA_DE_TASAS
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
CREATE SEQUENCE INC_OID_CERTIFICADOS
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
CREATE SEQUENCE INC_OID_IR
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
CREATE SEQUENCE INC_OID_REQUIERE
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
CREATE SEQUENCE INC_OID_FOTOS
 INCREMENT BY 1
 START WITH 1
 MAXVALUE 999999
 CYCLE;
 /
 -------------------------------------------------------------------------------------------------------TRIGGERS ASOCIADOS A SECUENCIAS
CREATE OR REPLACE TRIGGER GENERA_OID_TASAS BEFORE INSERT ON TASAS FOR EACH ROW
BEGIN 
 SELECT INC_OID_TASAS.NEXTVAL INTO :NEW.OID_TASA FROM  DUAL;
END;
/
CREATE OR REPLACE TRIGGER GENERA_OID_LINEA_DE_TASAS BEFORE INSERT ON LINEAS_DE_TASAS FOR EACH ROW
BEGIN 
 SELECT INC_OID_LINEA_DE_TASAS.NEXTVAL INTO :NEW.OID_LINEAS_DE_TASAS FROM  DUAL;
END;
/
CREATE OR REPLACE TRIGGER GENERA_OID_CERTIFICADOS BEFORE INSERT ON CERTIFICADOS FOR EACH ROW
BEGIN 
 SELECT INC_OID_CERTIFICADOS.NEXTVAL INTO :NEW.OID_C FROM  DUAL;
END;
/
CREATE OR REPLACE TRIGGER GENERA_OID_IR BEFORE INSERT ON INSTITUCIONES_REGULADORAS FOR EACH ROW
BEGIN 
 SELECT INC_OID_IR.NEXTVAL INTO :NEW.OID_IR FROM  DUAL;
END;
/
CREATE OR REPLACE TRIGGER GENERA_OID_REQUIERE BEFORE INSERT ON REQUIERE FOR EACH ROW
BEGIN 
 SELECT INC_OID_REQUIERE.NEXTVAL INTO :NEW.OID_R FROM  DUAL;
END;
/
CREATE OR REPLACE TRIGGER GENERA_OID_FOTOS BEFORE INSERT ON FOTOS FOR EACH ROW
BEGIN 
 SELECT INC_OID_FOTOS.NEXTVAL INTO :NEW.OID_F FROM  DUAL;
END;
/

 -------------------------------------------------------------------------------------------------------TRIGGERS NO ASOCIADOS A SECUENCIAS
-- RN-04: Establece el limite de citas por dia
CREATE OR REPLACE TRIGGER CHECK_LIM_DIA BEFORE INSERT ON CITAS FOR EACH ROW
DECLARE
 numero_cita NUMBER;
BEGIN
 SELECT COUNT (*) INTO numero_cita FROM CITAS WHERE FECHA =:NEW.FECHA;
 IF numero_cita > 25 THEN
  RAISE_APPLICATION_ERROR(-20700, 'EL LÍMITE DE CITAS DE DIARIO HA SIDO ALCANZADO');
 END IF;
END;
/

-- RN-0X: Fecha_Emision debe de ser anterior a la fecha_Validacion
CREATE OR REPLACE TRIGGER CHECK_FECHA_EMISION BEFORE INSERT ON CERTIFICADOS FOR EACH ROW
DECLARE
  w_fecha_validacion date;
BEGIN
 select FECHA_VALIDACION into w_fecha_validacion from INSTITUCIONES_REGULADORAS where :NEW.OID_IR = OID_IR;
 if :NEW.FECHA_EMISION > w_fecha_validacion then
    RAISE_APPLICATION_ERROR(-20700, 'Fecha_Emision debe de ser anterior a la fecha_Validacion');
    END IF;
END;
/

-------------------------------------------------------CONSTRAINT
BEGIN

ALTER TABLE TRABAJADORES ADD CONSTRAINT CK_TEL_TRABAJADOR CHECK (REGEXP_LIKE(TELEFONO, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'));
ALTER TABLE CLIENTES ADD CONSTRAINT CK_DNI_ClIENTES CHECK (REGEXP_LIKE(DNI, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
ALTER TABLE CLIENTES ADD CONSTRAINT CK_TEL_CLIENTES CHECK (REGEXP_LIKE(TELEFONO, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'));
ALTER TABLE TASAS ADD CONSTRAINT CK_NIF_TASAS CHECK (REGEXP_LIKE(NIF, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
ALTER TABLE CERTIFICADOS ADD CONSTRAINT CK_NIF_CERTIFICADO CHECK (REGEXP_LIKE(NIF, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
ALTER TABLE PRUEBAS_MEDICAS ADD CONSTRAINT CK_DNI_PRUEBA_MEDICA CHECK (REGEXP_LIKE(DNI, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
ALTER TABLE FOTOS ADD CONSTRAINT CK_DNI_FOTOS CHECK (REGEXP_LIKE(DNI, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
ALTER TABLE CITAS ADD CONSTRAINT CK_DNI_CITA CHECK (REGEXP_LIKE(DNI, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'));
END;
/
 -------------------------------------------------------------------------------------------------------PROCEDIMIENTO Y FUNCIONES
/***********************************************************************************
                               
Inserta una foto en el sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaFoto(w_tamaño IN fotos.tamaño%TYPE, w_formato IN fotos.formato%TYPE)
    IS
    BEGIN
        INSERT INTO Fotos(tamaño, formato) VALUES (w_tamaño, w_formato);
        COMMIT;
    END;
/
/***********************************************************************************
                                    RF-09
Permite eliminar una foto de un cliente del sistema dado su DNI y el oid de la foto a borrar
***********************************************************************************/
CREATE OR REPLACE PROCEDURE EliminaFoto (w_dni IN fotos.dni%TYPE, w_oid IN fotos.oid_f%TYPE)
    IS
    BEGIN
        DELETE FROM fotos WHERE dni=w_dni AND oid_f=w_oid;
	COMMIT;
    END;
/
/***********************************************************************************
                                   
Inserta un cliente en el sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaCliente
    (w_dni IN clientes.dni%TYPE , w_nombre IN clientes.nombre%TYPE, w_apellido IN clientes.apellido%TYPE, w_edad IN clientes.edad%TYPE, w_domicilio IN clientes.domicilio%TYPE, w_telefono IN clientes.telefono%TYPE, 
    w_tarjeta IN clientes.tarjeta_sanitaria%TYPE, w_pass IN clientes.pass%TYPE, w_fecha IN clientes.fecha_nacimiento%TYPE,
    w_email IN clientes.email%TYPE)
    IS
    BEGIN
        INSERT INTO Clientes(dni, nombre, apellido, edad, domicilio, telefono, tarjeta_sanitaria, pass, fecha_nacimiento,email) 
        VALUES (w_dni, w_nombre, w_apellido, w_edad, w_domicilio, w_telefono, w_tarjeta,w_pass,w_fecha,w_email);
        COMMIT;
    END;
/
/***********************************************************************************
                                    RF-08
Permite eliminar un cliente del sistema dado su DNI
***********************************************************************************/
CREATE OR REPLACE PROCEDURE EliminarCliente (w_dni IN clientes.dni%TYPE)
IS
BEGIN
	DELETE FROM clientes WHERE dni=w_dni;
	COMMIT;
END;
/
--Tasa
/***********************************************************************************
                                    
Inserta una tasa en el sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaTasa (w_fecha IN tasas.fecha%TYPE)
    IS
    BEGIN
        INSERT INTO tasas(fecha) VALUES (w_fecha);
        COMMIT;
    END;
/  
--LineaDeTasa
/***********************************************************************************
                                    
Inserta una linea de tasa en el sistema
***********************************************************************************/


CREATE OR REPLACE PROCEDURE InsertaLineaTasa(w_precio IN lineas_de_tasas.precio%TYPE , w_cantidad IN lineas_de_tasas.cantidad%TYPE)
    IS
    BEGIN
        INSERT INTO lineas_de_tasas(precio, cantidad) SELECT w_precio, w_cantidad FROM lineas_de_tasas WHERE w_cantidad<=1000;
        COMMIT;
    END;
/   
--Institución
/***********************************************************************************
                                   
Inserta una Institución Reguladora en el sistema
***********************************************************************************/

CREATE OR REPLACE PROCEDURE InsertaInstitucion(w_tipo IN instituciones_reguladoras.tipo_institucion%TYPE , w_fecha IN instituciones_reguladoras.fecha_validacion%TYPE)
    IS
    BEGIN
        INSERT INTO instituciones_reguladoras(tipo_institucion, fecha_validacion) VALUES (w_tipo, w_fecha);
        COMMIT;
    END;
/
--Prueba
/***********************************************************************************
                                    
Inseta una prueba en el sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaPrueba(w_nombre IN pruebas_medicas.nombre%TYPE)
    IS
    BEGIN
        INSERT INTO pruebas_medicas(nombre) VALUES (w_nombre);
        COMMIT;
    END;
    
/  
    
--Certificado
/***********************************************************************************
                                    RF-03
Devuelve el estado de un certificado
***********************************************************************************/
CREATE OR REPLACE FUNCTION ConsultaEstadoCertificado (w_oid_c IN certificados.oid_c%TYPE)   
RETURN VARCHAR
IS
    w_estado certificados.estado_certificado%TYPE;
BEGIN
    SELECT estado_certificado INTO w_estado FROM Certificados WHERE oid_c=w_oid_c;
    RETURN (w_estado);
END;    
/
/***********************************************************************************
                                    RF-06
Filtra los certificados dado un tipo
***********************************************************************************/
CREATE OR REPLACE PROCEDURE FiltroCertificadoPorTipo (w_tipo IN certificados.tipo_certificado%TYPE)   
IS
    w_oid certificados.oid_c%TYPE;
    w_fecha certificados.fecha_emision%TYPE; 
    w_precio certificados.precio%TYPE;
    w_estado certificados.estado_certificado%TYPE; 

BEGIN 
    SELECT oid_c,fecha_emision , precio, estado_certificado  INTO w_oid, w_fecha, w_precio, w_estado FROM certificados WHERE tipo_certificado=w_tipo;
    COMMIT;
END;
/
/***********************************************************************************
                                    RF-12
Calcula el precio de un certificado
***********************************************************************************/
CREATE OR REPLACE FUNCTION PrecioCertificado(w_tipo IN certificados.tipo_certificado%TYPE)
RETURN NUMBER
IS
    w_precio NUMBER;
BEGIN
    IF (w_tipo=1) THEN
        SELECT precio+38.5 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=2) THEN
        SELECT precio+60.3 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=3) THEN
        SELECT precio+15.9 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=4) THEN
        SELECT precio+15.27 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=5) THEN
        SELECT precio+46.82 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=6) THEN
        SELECT precio+42.7 INTO w_precio FROM lineas_de_tasas;
        END IF;
    IF (w_tipo=7) THEN
        SELECT precio+25.1 INTO w_precio FROM lineas_de_tasas;
        END IF;

RETURN (w_precio);
END;
/
--Citas
/***********************************************************************************

Inserta una cita en el sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaCita
    (w_fecha IN citas.fecha%TYPE, w_hora IN citas.hora%TYPE, w_tipo IN citas.tipo_cita%TYPE, w_dni IN citas.dni%TYPE, w_tcertificado IN citas.tipo_certificado%TYPE)
    IS
    BEGIN
        INSERT INTO Citas (fecha, hora, tipo_cita, dni, tipo_certificado) VALUES (w_fecha, w_hora, w_tipo, w_dni, w_tcertificado);
        COMMIT;
    END;
/    

/***********************************************************************************
                                    RF-11
Elimina una cita del sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE CancelarCita (w_dni IN citas.dni%TYPE, w_fecha IN citas.fecha%TYPE)  
IS
BEGIN
	DELETE FROM citas WHERE dni = w_dni AND fecha = w_fecha;
	COMMIT;
END;
/

/***********************************************************************************
                                    RF-02
Da información de la cita realizada por un cliente dado su dni 
***********************************************************************************/
CREATE OR REPLACE PROCEDURE ConsultaCita (w_dni IN clientes.dni%TYPE)
IS
    w_nombre clientes.nombre%TYPE;
    w_apellido clientes.apellido%TYPE;
    w_fecha citas.fecha%TYPE;
    w_hora citas.hora%TYPE;
BEGIN
        SELECT nombre, apellido, fecha, hora INTO w_nombre, w_apellido, w_fecha, w_hora FROM clientes NATURAL JOIN citas WHERE dni=w_dni;
        DBMS_OUTPUT.PUT_LINE(w_nombre||' '||w_apellido||'ha solicitado una cita el día ' ||w_fecha||' a las '||w_hora);
        COMMIT;
    
END;        
/
/***********************************************************************************
                                    RF-04
Devuelve el número de citas dada una fecha 
***********************************************************************************/
CREATE OR REPLACE FUNCTION NumCitasPorFecha(w_fecha IN citas.fecha%TYPE) --(Pensar si de una fecha dada o al completo aunq eso daría tmb de citas anteriores menor eficiencia) 
RETURN NUMBER
IS
    numCitas NUMBER;
BEGIN
    SELECT count(w_fecha) INTO numCitas FROM citas WHERE fecha=w_fecha;
    RETURN (numCitas);
END;

/
/***********************************************************************************
                                    RF-07
Filta las fechas en un periodo de tiempo dado
***********************************************************************************/
create or replace PROCEDURE RangoCitasFecha(w_fecha_inicio DATE, w_fecha_fin DATE)              
IS
    w_fecha citas.fecha%TYPE; 
    w_hora  citas.hora%TYPE; 
    w_tipo  citas.tipo_cita%TYPE;
    w_dni   citas.dni%TYPE;
    w_tcertificado citas.tipo_certificado%TYPE;
BEGIN 
    SELECT fecha, hora, tipo_cita, dni, tipo_certificado INTO w_fecha, w_hora, w_tipo, w_dni, w_tcertificado FROM CITAS NATURAL JOIN CLIENTES WHERE fecha BETWEEN w_fecha_inicio AND w_fecha_fin;
    COMMIT;
END;

        




---------Trabajadores
/***********************************************************************************
                                    
Añade un trabajador al sistema
***********************************************************************************/
CREATE OR REPLACE PROCEDURE InsertaTrabajador
    (w_nif IN trabajadores.nif%TYPE, w_nombre IN trabajadores.nombre%TYPE, 
    w_apellidos IN trabajadores.apellidos%TYPE, w_especialidad IN trabajadores.especialidad%TYPE, 
    w_telefono IN trabajadores.telefono%TYPE, w_email IN trabajadores.email%TYPE, w_pass IN trabajadores.pass%TYPE)
    IS
    BEGIN
        INSERT INTO Trabajadores (nif, nombre, apellidos, especialidad, telefono, email, pass) 
        VALUES (w_nif, w_nombre, w_apellidos, w_especialidad, w_telefono, w_email,w_pass);
        COMMIT;
    END;
/



/***********************************************************************************
                                    RF-08
Permite eliminar los datos de un trabajador del sistema mediante su NIF
***********************************************************************************/
CREATE OR REPLACE PROCEDURE EliminarTrabajador (w_NIF IN trabajadores.NIF%TYPE)
IS
BEGIN
	DELETE FROM trabajadores WHERE NIF = w_NIF;
	COMMIT;
END;
/
SET SERVEROUTPUT ON;
-- PAQUETE ASSERT_EQUALS
CREATE OR REPLACE FUNCTION ASSERT_EQUALS (SALIDA BOOLEAN, SALIDA_ESPERADA BOOLEAN) RETURN VARCHAR2 AS
BEGIN
 IF (SALIDA = SALIDA_ESPERADA) THEN
    RETURN 'ÉXITO';
 ELSE
    RETURN 'FALLO';
 END IF;
END ASSERT_EQUALS;
/
 ---------------------------------------------------------------------------PAQUETE PRUEBAS TASAS
CREATE OR REPLACE PACKAGE PRUEBAS_TASAS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_NIF IN TASAS.NIF%TYPE,
                        W_FECHA IN TASAS.FECHA%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                          W_OID_TASA IN TASAS.OID_TASA%TYPE,
                          W_NIF IN TASAS.NIF%TYPE,
                          W_FECHA IN TASAS.FECHA%TYPE,
                          SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_TASA IN TASAS.OID_TASA%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_TASAS;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_TASAS AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM TASAS;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR (NOMBRE_PRUEBA VARCHAR2,
                        W_NIF IN TASAS.NIF%TYPE,
                        W_FECHA IN TASAS.FECHA%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_TASAS TASAS%ROWTYPE;
        W_OID_TASA TASAS.OID_TASA%TYPE;
    BEGIN
        INSERT INTO TASAS(NIF,FECHA) VALUES (W_NIF,W_FECHA);
        W_OID_TASA := INC_OID_TASAS.CURRVAL;
        SELECT * INTO TIPO_TASAS FROM TASAS WHERE OID_TASA = W_OID_TASA;
        IF (TIPO_TASAS.OID_TASA <> W_OID_TASA) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
        
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                              W_OID_TASA IN TASAS.OID_TASA%TYPE,
                              W_NIF IN TASAS.NIF%TYPE,
                              W_FECHA IN TASAS.FECHA%TYPE,
                              SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_TASAS TASAS%ROWTYPE;
            
        BEGIN
            UPDATE TASAS
                SET NIF = W_NIF,
                    FECHA = W_FECHA
                WHERE OID_TASA = W_OID_TASA;
            SELECT * INTO TIPO_TASAS FROM TASAS WHERE OID_TASA = W_OID_TASA;
            IF (TIPO_TASAS.NIF <> W_NIF 
                OR TIPO_TASAS.FECHA <> W_FECHA) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                           W_OID_TASA IN TASAS.OID_TASA%TYPE,
                           SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_TASAS INTEGER;
        BEGIN
            DELETE FROM TASAS WHERE OID_TASA = W_OID_TASA;
            
            SELECT COUNT(*) INTO N_TASAS FROM TASAS WHERE OID_TASA = W_OID_TASA;
            IF(N_TASAS <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_TASAS;
    /
 ---------------------------------------------------------------------------PAQUETE PRUEBAS INSTITUCIONES_REGULADORAS
CREATE OR REPLACE PACKAGE PRUEBAS_IR AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_TIPO_INSTITUCION IN INSTITUCIONES_REGULADORAS.TIPO_INSTITUCION%TYPE,
                        W_FECHA_VALIDACION IN INSTITUCIONES_REGULADORAS.FECHA_VALIDACION%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                          W_OID_IR IN INSTITUCIONES_REGULADORAS.OID_IR%TYPE,
                          W_TIPO_INSTITUCION IN INSTITUCIONES_REGULADORAS.TIPO_INSTITUCION%TYPE,
                          W_FECHA_VALIDACION IN INSTITUCIONES_REGULADORAS.FECHA_VALIDACION%TYPE,
                          SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_IR IN INSTITUCIONES_REGULADORAS.OID_IR%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_IR;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_IR AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM INSTITUCIONES_REGULADORAS;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR ( NOMBRE_PRUEBA VARCHAR2,
                        W_TIPO_INSTITUCION IN INSTITUCIONES_REGULADORAS.TIPO_INSTITUCION%TYPE,
                        W_FECHA_VALIDACION IN INSTITUCIONES_REGULADORAS.FECHA_VALIDACION%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_INSTITUCIONES_REGULADORAS INSTITUCIONES_REGULADORAS%ROWTYPE;
        W_OID_IR INSTITUCIONES_REGULADORAS.OID_IR%TYPE;
    BEGIN
        INSERT INTO INSTITUCIONES_REGULADORAS(TIPO_INSTITUCION,FECHA_VALIDACION) VALUES (W_TIPO_INSTITUCION,W_FECHA_VALIDACION);
        W_OID_IR := INC_OID_IR.CURRVAL;
        SELECT * INTO TIPO_INSTITUCIONES_REGULADORAS FROM INSTITUCIONES_REGULADORAS WHERE OID_IR = W_OID_IR;
        IF (TIPO_INSTITUCIONES_REGULADORAS.OID_IR <> W_OID_IR) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                          W_OID_IR IN INSTITUCIONES_REGULADORAS.OID_IR%TYPE,
                          W_TIPO_INSTITUCION IN INSTITUCIONES_REGULADORAS.TIPO_INSTITUCION%TYPE,
                          W_FECHA_VALIDACION IN INSTITUCIONES_REGULADORAS.FECHA_VALIDACION%TYPE,
                          SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_INSTITUCIONES_REGULADORAS INSTITUCIONES_REGULADORAS%ROWTYPE;
            
        BEGIN
            UPDATE INSTITUCIONES_REGULADORAS
                SET TIPO_INSTITUCION = W_TIPO_INSTITUCION,
                    FECHA_VALIDACION = W_FECHA_VALIDACION
                WHERE OID_IR = W_OID_IR;
            SELECT * INTO TIPO_INSTITUCIONES_REGULADORAS FROM INSTITUCIONES_REGULADORAS WHERE OID_IR = W_OID_IR;
            IF (TIPO_INSTITUCIONES_REGULADORAS.TIPO_INSTITUCION <> W_TIPO_INSTITUCION 
                OR  TIPO_INSTITUCIONES_REGULADORAS.FECHA_VALIDACION <> W_FECHA_VALIDACION) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_IR IN INSTITUCIONES_REGULADORAS.OID_IR%TYPE,
                       SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_INSTITUCIONES_REGULADORAS INTEGER;
        BEGIN
            DELETE FROM INSTITUCIONES_REGULADORAS WHERE OID_IR = W_OID_IR;
            
            SELECT COUNT(*) INTO N_INSTITUCIONES_REGULADORAS FROM INSTITUCIONES_REGULADORAS WHERE OID_IR = W_OID_IR;
            IF(N_INSTITUCIONES_REGULADORAS <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_IR;
    /
 ---------------------------------------------------------------------------PAQUETE PRUEBAS CERTIFICADOS

CREATE OR REPLACE PACKAGE PRUEBAS_CERTIFICADOS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_TIPO_CERTIFICADO IN CERTIFICADOS.TIPO_CERTIFICADO%TYPE,
                        W_FECHA_EMISION IN CERTIFICADOS.FECHA_EMISION%TYPE,
                        W_PRECIO IN  CERTIFICADOS.PRECIO%TYPE,
                        W_ESTADO_CERTIFICADO IN CERTIFICADOS.ESTADO_CERTIFICADO%TYPE,
                        W_NIF IN CERTIFICADOS.NIF%TYPE,
                        W_OID_IR IN CERTIFICADOS.OID_IR%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_C IN CERTIFICADOS.OID_C%TYPE,
                        W_TIPO_CERTIFICADO IN CERTIFICADOS.TIPO_CERTIFICADO%TYPE,
                        W_FECHA_EMISION IN CERTIFICADOS.FECHA_EMISION%TYPE,
                        W_PRECIO IN  CERTIFICADOS.PRECIO%TYPE,
                        W_ESTADO_CERTIFICADO IN CERTIFICADOS.ESTADO_CERTIFICADO%TYPE,
                        W_NIF IN CERTIFICADOS.NIF%TYPE,
                        W_OID_IR IN CERTIFICADOS.OID_IR%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_C IN CERTIFICADOS.OID_C%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_CERTIFICADOS;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_CERTIFICADOS AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM CERTIFICADOS;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR ( NOMBRE_PRUEBA VARCHAR2,
                        W_TIPO_CERTIFICADO IN CERTIFICADOS.TIPO_CERTIFICADO%TYPE,
                        W_FECHA_EMISION IN CERTIFICADOS.FECHA_EMISION%TYPE,
                        W_PRECIO IN  CERTIFICADOS.PRECIO%TYPE,
                        W_ESTADO_CERTIFICADO IN CERTIFICADOS.ESTADO_CERTIFICADO%TYPE,
                        W_NIF IN CERTIFICADOS.NIF%TYPE,
                        W_OID_IR IN CERTIFICADOS.OID_IR%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_CERTIFICADOS CERTIFICADOS%ROWTYPE;
        W_OID_C CERTIFICADOS.OID_C%TYPE;
    BEGIN
        INSERT INTO CERTIFICADOS(TIPO_CERTIFICADO,FECHA_EMISION,PRECIO,ESTADO_CERTIFICADO,NIF,OID_IR) VALUES (W_TIPO_CERTIFICADO,W_FECHA_EMISION,W_PRECIO,W_ESTADO_CERTIFICADO,W_NIF,W_OID_IR);
        W_OID_C := INC_OID_CERTIFICADOS.CURRVAL;
        SELECT * INTO TIPO_CERTIFICADOS FROM CERTIFICADOS WHERE OID_C = W_OID_C;
        IF (TIPO_CERTIFICADOS.OID_C <> W_OID_C) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
        
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_C IN CERTIFICADOS.OID_C%TYPE,
                        W_TIPO_CERTIFICADO IN CERTIFICADOS.TIPO_CERTIFICADO%TYPE,
                        W_FECHA_EMISION IN CERTIFICADOS.FECHA_EMISION%TYPE,
                        W_PRECIO IN  CERTIFICADOS.PRECIO%TYPE,
                        W_ESTADO_CERTIFICADO IN CERTIFICADOS.ESTADO_CERTIFICADO%TYPE,
                        W_NIF IN CERTIFICADOS.NIF%TYPE,
                        W_OID_IR IN CERTIFICADOS.OID_IR%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_CERTIFICADOS CERTIFICADOS%ROWTYPE;
            
        BEGIN
            UPDATE CERTIFICADOS
                SET TIPO_CERTIFICADO = W_TIPO_CERTIFICADO,
                    FECHA_EMISION = W_FECHA_EMISION,
                    PRECIO = W_PRECIO,
                    ESTADO_CERTIFICADO = W_ESTADO_CERTIFICADO,
                    NIF = W_NIF,
                    OID_IR = W_OID_IR
                WHERE OID_C = W_OID_C;
            SELECT * INTO TIPO_CERTIFICADOS FROM CERTIFICADOS WHERE OID_C = W_OID_C;
            IF (TIPO_CERTIFICADOS.TIPO_CERTIFICADO <> W_TIPO_CERTIFICADO 
                OR TIPO_CERTIFICADOS.FECHA_EMISION <> W_FECHA_EMISION
                OR TIPO_CERTIFICADOS.PRECIO <> W_PRECIO 
                OR TIPO_CERTIFICADOS.ESTADO_CERTIFICADO <> W_ESTADO_CERTIFICADO
                OR TIPO_CERTIFICADOS.NIF <> W_NIF
                OR TIPO_CERTIFICADOS.OID_IR <> W_OID_IR) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_C IN CERTIFICADOS.OID_C%TYPE,
                       SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_CERTIFICADOS INTEGER;
        BEGIN
            DELETE FROM CERTIFICADOS WHERE OID_C = W_OID_C;
            
            SELECT COUNT(*) INTO N_CERTIFICADOS FROM CERTIFICADOS WHERE OID_C = W_OID_C;
            IF(N_CERTIFICADOS <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_CERTIFICADOS;
    /
 ---------------------------------------------------------------------------PAQUETE PRUEBAS LINEAS_DE_TASAS
CREATE OR REPLACE PACKAGE PRUEBAS_LINEAS_DE_TASAS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_PRECIO IN LINEAS_DE_TASAS.PRECIO%TYPE,
                        W_CANTIDAD IN LINEAS_DE_TASAS.CANTIDAD%TYPE,
                        W_OID_T IN LINEAS_DE_TASAS.OID_T%TYPE,
                        W_OID_C IN LINEAS_DE_TASAS.OID_C%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_LINEAS_DE_TASAS IN LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS%TYPE,
                        W_PRECIO IN LINEAS_DE_TASAS.PRECIO%TYPE,
                        W_CANTIDAD IN LINEAS_DE_TASAS.CANTIDAD%TYPE,
                        W_OID_T IN LINEAS_DE_TASAS.OID_T%TYPE,
                        W_OID_C IN LINEAS_DE_TASAS.OID_C%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_LINEAS_DE_TASAS IN LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_LINEAS_DE_TASAS;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_LINEAS_DE_TASAS AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM LINEAS_DE_TASAS;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR ( NOMBRE_PRUEBA VARCHAR2,
                        W_PRECIO IN LINEAS_DE_TASAS.PRECIO%TYPE,
                        W_CANTIDAD IN LINEAS_DE_TASAS.CANTIDAD%TYPE,
                        W_OID_T IN LINEAS_DE_TASAS.OID_T%TYPE,
                        W_OID_C IN LINEAS_DE_TASAS.OID_C%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_LINEAS_DE_TASAS LINEAS_DE_TASAS%ROWTYPE;
        W_OID_LINEAS_DE_TASAS LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS%TYPE;
    BEGIN
        INSERT INTO LINEAS_DE_TASAS(PRECIO,CANTIDAD,OID_T,OID_C) VALUES (W_PRECIO,W_CANTIDAD,W_OID_T,W_OID_C);
        W_OID_LINEAS_DE_TASAS := INC_OID_LINEA_DE_TASAS.CURRVAL;
        SELECT * INTO TIPO_LINEAS_DE_TASAS FROM LINEAS_DE_TASAS WHERE OID_LINEAS_DE_TASAS = W_OID_LINEAS_DE_TASAS;
        IF (TIPO_LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS <> W_OID_LINEAS_DE_TASAS) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
        
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_LINEAS_DE_TASAS IN LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS%TYPE,
                        W_PRECIO IN LINEAS_DE_TASAS.PRECIO%TYPE,
                        W_CANTIDAD IN LINEAS_DE_TASAS.CANTIDAD%TYPE,
                        W_OID_T IN LINEAS_DE_TASAS.OID_T%TYPE,
                        W_OID_C IN LINEAS_DE_TASAS.OID_C%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_LINEAS_DE_TASAS LINEAS_DE_TASAS%ROWTYPE;
            
        BEGIN
            UPDATE LINEAS_DE_TASAS
                SET PRECIO = W_PRECIO,
                    CANTIDAD = W_CANTIDAD,
                    OID_T = W_OID_T,
                    OID_C = W_OID_C
                WHERE OID_LINEAS_DE_TASAS = W_OID_LINEAS_DE_TASAS;
            SELECT * INTO TIPO_LINEAS_DE_TASAS FROM LINEAS_DE_TASAS WHERE OID_LINEAS_DE_TASAS = W_OID_LINEAS_DE_TASAS;
            IF (TIPO_LINEAS_DE_TASAS.PRECIO <> W_PRECIO 
                OR TIPO_LINEAS_DE_TASAS.CANTIDAD <> W_CANTIDAD
                OR TIPO_LINEAS_DE_TASAS.OID_T <> W_OID_T
                OR TIPO_LINEAS_DE_TASAS.OID_C <> W_OID_C)  THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                       W_OID_LINEAS_DE_TASAS IN LINEAS_DE_TASAS.OID_LINEAS_DE_TASAS%TYPE,
                       SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_LINEAS_DE_TASAS INTEGER;
        BEGIN
            DELETE FROM LINEAS_DE_TASAS WHERE OID_LINEAS_DE_TASAS = W_OID_LINEAS_DE_TASAS;
            
            SELECT COUNT(*) INTO N_LINEAS_DE_TASAS FROM LINEAS_DE_TASAS WHERE OID_LINEAS_DE_TASAS = W_OID_LINEAS_DE_TASAS;
            IF(N_LINEAS_DE_TASAS <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_LINEAS_DE_TASAS;
    /
 ---------------------------------------------------------------------------PAQUETE PRUEBAS REQUIERE
CREATE OR REPLACE PACKAGE PRUEBAS_REQUIERE AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_C IN REQUIERE.OID_C%TYPE,
                        W_NOMBRE IN REQUIERE.NOMBRE%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_R IN REQUIERE.OID_R%TYPE,
                        W_OID_C IN REQUIERE.OID_C%TYPE,
                        W_NOMBRE IN REQUIERE.NOMBRE%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                        W_OID_R IN REQUIERE.OID_R%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_REQUIERE;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_REQUIERE AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM REQUIERE;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR ( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_C IN REQUIERE.OID_C%TYPE,
                        W_NOMBRE IN REQUIERE.NOMBRE%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_REQUIERE REQUIERE%ROWTYPE;
        W_OID_R REQUIERE.OID_R%TYPE;
    BEGIN
        INSERT INTO REQUIERE(OID_C,NOMBRE) VALUES (W_OID_C,W_NOMBRE);
        W_OID_R := INC_OID_REQUIERE.CURRVAL;
        SELECT * INTO TIPO_REQUIERE FROM REQUIERE WHERE OID_R = W_OID_R;
        IF (TIPO_REQUIERE.OID_R <> W_OID_R) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
        
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_R IN REQUIERE.OID_R%TYPE,
                        W_OID_C IN REQUIERE.OID_C%TYPE,
                        W_NOMBRE IN REQUIERE.NOMBRE%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_REQUIERE REQUIERE%ROWTYPE;
            
        BEGIN
            UPDATE REQUIERE
                SET OID_C = W_OID_C,
                    NOMBRE = W_NOMBRE
                WHERE OID_R = W_OID_R;
            SELECT * INTO TIPO_REQUIERE FROM REQUIERE WHERE OID_R = W_OID_R;
            IF (TIPO_REQUIERE.OID_C <> W_OID_C 
                OR TIPO_REQUIERE.NOMBRE <> W_NOMBRE) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                        W_OID_R IN REQUIERE.OID_R%TYPE,
                       SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_REQUIERE INTEGER;
        BEGIN
            DELETE FROM REQUIERE WHERE OID_R = W_OID_R;
            
            SELECT COUNT(*) INTO N_REQUIERE FROM REQUIERE WHERE OID_R = W_OID_R;
            IF(N_REQUIERE <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_REQUIERE;
    /
---------------------------------------------------------------------------PAQUETE PRUEBAS FOTOS
CREATE OR REPLACE PACKAGE PRUEBAS_FOTOS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR( NOMBRE_PRUEBA VARCHAR2,
                        W_TAMAÑO IN FOTOS.TAMAÑO%TYPE,
                        W_FORMATO IN FOTOS.FORMATO%TYPE,
                        W_DNI IN FOTOS.DNI%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                        
    PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_F IN FOTOS.OID_F%TYPE,
                        W_TAMAÑO IN FOTOS.TAMAÑO%TYPE,
                        W_FORMATO IN FOTOS.FORMATO%TYPE,
                        W_DNI IN FOTOS.DNI%TYPE,
                        SALIDA_ESPERADA BOOLEAN);
                          
    PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                        W_OID_F IN FOTOS.OID_F%TYPE,
                       SALIDA_ESPERADA BOOLEAN);
    END PRUEBAS_FOTOS;
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_FOTOS AS
    PROCEDURE INICIALIZAR AS 
    BEGIN
        DELETE FROM FOTOS;
    END INICIALIZAR;
    
    PROCEDURE INSERTAR ( NOMBRE_PRUEBA VARCHAR2,
                        W_TAMAÑO IN FOTOS.TAMAÑO%TYPE,
                        W_FORMATO IN FOTOS.FORMATO%TYPE,
                        W_DNI IN FOTOS.DNI%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
    AS
        SALIDA BOOLEAN := TRUE;
        TIPO_FOTOS FOTOS%ROWTYPE;
        W_OID_F FOTOS.OID_F%TYPE;
    BEGIN
        INSERT INTO FOTOS(TAMAÑO,FORMATO,DNI) VALUES (W_TAMAÑO,W_FORMATO,W_DNI);
        W_OID_F := INC_OID_FOTOS.CURRVAL;
        SELECT * INTO TIPO_FOTOS FROM FOTOS WHERE OID_F = W_OID_F;
        IF (TIPO_FOTOS.OID_F <> W_OID_F) THEN SALIDA := FALSE;
        END IF;
        COMMIT WORK;
        
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END INSERTAR;
        
        PROCEDURE ACTUALIZAR( NOMBRE_PRUEBA VARCHAR2,
                        W_OID_F IN FOTOS.OID_F%TYPE,
                        W_TAMAÑO IN FOTOS.TAMAÑO%TYPE,
                        W_FORMATO IN FOTOS.FORMATO%TYPE,
                        W_DNI IN FOTOS.DNI%TYPE,
                        SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            TIPO_FOTOS FOTOS%ROWTYPE;
            
        BEGIN
            UPDATE FOTOS
                SET TAMAÑO = W_TAMAÑO,
                    FORMATO = W_FORMATO,
                    DNI = W_DNI
                WHERE OID_F = W_OID_F;
            SELECT * INTO TIPO_FOTOS FROM FOTOS WHERE OID_F = W_OID_F;
            IF (TIPO_FOTOS.TAMAÑO <> W_TAMAÑO 
                OR TIPO_FOTOS.FORMATO <> W_FORMATO
                OR TIPO_FOTOS.DNI <> W_DNI) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION 
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ACTUALIZAR;
        
        PROCEDURE ELIMINAR(NOMBRE_PRUEBA VARCHAR2,
                        W_OID_F IN FOTOS.OID_F%TYPE,
                       SALIDA_ESPERADA BOOLEAN)
        AS
            SALIDA BOOLEAN := TRUE;
            N_FOTOS INTEGER;
        BEGIN
            DELETE FROM FOTOS WHERE OID_F = W_OID_F;
            
            SELECT COUNT(*) INTO N_FOTOS FROM FOTOS WHERE OID_F = W_OID_F;
            IF(N_FOTOS <> 0) THEN
                SALIDA := FALSE;
            END IF;
            COMMIT WORK;
            DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
        EXCEPTION
            WHEN OTHERS THEN
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                 ROLLBACK;
        END ELIMINAR;
    END PRUEBAS_FOTOS;
    /
---------------------------------------------------------------------------PAQUETE PRUEBAS CLIENTES
CREATE OR REPLACE PACKAGE PRUEBAS_CLIENTES AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR(nombre_prueba varchar2, w_dni IN clientes.dni%TYPE , 
                    w_nombre IN clientes.nombre%TYPE, 
                    w_apellido IN clientes.apellido%TYPE, 
                    w_edad IN clientes.edad%TYPE, 
                    w_domicilio IN clientes.domicilio%TYPE, 
                    w_telefono IN clientes.telefono%TYPE, 
                    w_tarjeta IN clientes.tarjeta_sanitaria%TYPE, 
                    w_pass IN clientes.pass%TYPE,
                    w_fecha IN clientes.fecha_nacimiento%TYPE,
                    w_email IN clientes.email%TYPE,
                    salida_esperada boolean);
                
    PROCEDURE ACTUALIZAR(nombre_prueba varchar2, w_dni IN clientes.dni%TYPE , 
                    w_nombre IN clientes.nombre%TYPE, 
                    w_apellido IN clientes.apellido%TYPE, 
                    w_edad IN clientes.edad%TYPE, 
                    w_domicilio IN clientes.domicilio%TYPE, 
                    w_telefono IN clientes.telefono%TYPE, 
                    w_tarjeta IN clientes.tarjeta_sanitaria%TYPE,
                    w_pass IN clientes.pass%TYPE,
                    w_fecha IN clientes.fecha_nacimiento%TYPE,
                    w_email IN clientes.email%TYPE,
                    salida_esperada boolean);
    
    PROCEDURE ELIMINAR(nombre_prueba varchar2, 
                        w_dni IN clientes.dni%TYPE,
                        salida_esperada boolean);
    END PRUEBAS_CLIENTES;
    
     /
     
CREATE OR REPLACE PACKAGE BODY PRUEBAS_CLIENTES AS
        
    PROCEDURE INICIALIZAR AS
        BEGIN
            DELETE FROM CLIENTES;
        END INICIALIZAR;
        
    PROCEDURE INSERTAR(nombre_prueba varchar2, w_dni IN clientes.dni%TYPE , 
                    w_nombre IN clientes.nombre%TYPE, 
                    w_apellido IN clientes.apellido%TYPE, 
                    w_edad IN clientes.edad%TYPE, 
                    w_domicilio IN clientes.domicilio%TYPE, 
                    w_telefono IN clientes.telefono%TYPE, 
                    w_tarjeta IN clientes.tarjeta_sanitaria%TYPE,
                    w_pass IN clientes.pass%TYPE,
                    w_fecha IN clientes.fecha_nacimiento%TYPE,
                    w_email IN clientes.email%TYPE,
                    salida_esperada boolean)
            AS
            SALIDA BOOLEAN :=TRUE;
            TIPO_CLIENTES CLIENTES%ROWTYPE;
            
            BEGIN
                INSERT INTO CLIENTES VALUES (w_dni, w_nombre, w_apellido, w_edad, w_domicilio, w_telefono, w_tarjeta,
                w_pass,w_fecha,w_email);
                
                SELECT * INTO TIPO_CLIENTES FROM clientes WHERE dni=w_dni;
                IF (TIPO_CLIENTES.dni <> w_dni) THEN SALIDA:= FALSE;
                END IF;
                COMMIT WORK;
                
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                 
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    ROLLBACK;
            END INSERTAR;
            
    PROCEDURE ACTUALIZAR (nombre_prueba varchar2, w_dni IN clientes.dni%TYPE , 
                    w_nombre IN clientes.nombre%TYPE, 
                    w_apellido IN clientes.apellido%TYPE, 
                    w_edad IN clientes.edad%TYPE, 
                    w_domicilio IN clientes.domicilio%TYPE, 
                    w_telefono IN clientes.telefono%TYPE, 
                    w_tarjeta IN clientes.tarjeta_sanitaria%TYPE,
                    w_pass IN clientes.pass%TYPE,
                    w_fecha IN clientes.fecha_nacimiento%TYPE,
                    w_email IN clientes.email%TYPE,
                    salida_esperada boolean)
            
            AS
                SALIDA BOOLEAN := TRUE;
                TIPO_CLIENTES CLIENTES%ROWTYPE;
            
            BEGIN
                    UPDATE CLIENTES
                        SET nombre=w_nombre,
                            apellido=w_apellido,
                            edad=w_edad,
                            domicilio=w_domicilio,
                            telefono=w_telefono,
                            tarjeta_sanitaria=w_tarjeta,
                            pass = w_pass,
                            fecha_nacimiento =w_fecha,
                            email=w_email
                        WHERE dni=w_dni;
                        
                    SELECT * INTO TIPO_CLIENTES FROM clientes WHERE dni=w_dni;
                    
                    IF (TIPO_CLIENTES.dni <> w_dni
                        OR TIPO_CLIENTES.nombre <> w_nombre
                        OR TIPO_CLIENTES.apellido <> w_apellido
                        OR TIPO_CLIENTES.edad <> w_edad
                        OR TIPO_CLIENTES.domicilio <> w_domicilio
                        OR TIPO_CLIENTES.telefono <> w_telefono
                        OR TIPO_CLIENTES.tarjeta_sanitaria <> w_tarjeta
                        OR TIPO_CLIENTES.pass <> w_pass
                        OR TIPO_CLIENTES.fecha_nacimiento <> w_fecha
                        OR TIPO_CLIENTES.email <> w_email) THEN
                        
                        SALIDA := FALSE;
                    END IF;
                    COMMIT WORK;
                    
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                    
            EXCEPTION
                    WHEN OTHERS THEN
                         DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                         ROLLBACK;
            END ACTUALIZAR;
            
    PROCEDURE ELIMINAR ( nombre_prueba varchar2, w_dni in clientes.dni%TYPE, salida_esperada boolean)
             
            AS
                SALIDA BOOLEAN := TRUE;
                N_CLIENTES INTEGER;
                
            BEGIN
                DELETE FROM CLIENTES WHERE dni=w_dni;
                
                SELECT COUNT(*) INTO N_CLIENTES FROM CLIENTES WHERE dni=w_dni;
                IF (N_CLIENTES <> 0) THEN
                    SALIDA := FALSE;
                END IF;
                COMMIT WORK;
                
                DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
            
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    
                END ELIMINAR;
                
    END PRUEBAS_CLIENTES;
     /
---------------------------------------------------------------------------PAQUETE PRUEBAS PRUEBAS_MEDICAS
CREATE OR REPLACE PACKAGE PRUEBAS_PMEDICAS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR(nombre_prueba varchar2,
                w_nombre IN pruebas_medicas.nombre%TYPE, w_dni IN pruebas_medicas.dni%TYPE, 
                salida_esperada boolean);
                
    PROCEDURE ACTUALIZAR(nombre_prueba varchar2, w_dni IN pruebas_medicas.dni%TYPE, 
                w_nombre IN pruebas_medicas.nombre%TYPE,
                salida_esperada boolean);
    
    PROCEDURE ELIMINAR(nombre_prueba varchar2, 
                        w_nombre IN pruebas_medicas.nombre%TYPE,
                        salida_esperada boolean);
    END PRUEBAS_PMEDICAS;
    
    
    /
CREATE OR REPLACE PACKAGE BODY PRUEBAS_PMEDICAS AS
        
    PROCEDURE INICIALIZAR AS
        BEGIN
            DELETE FROM PRUEBAS_MEDICAS;
        END INICIALIZAR;
        
    PROCEDURE INSERTAR(nombre_prueba varchar2,
                w_nombre IN pruebas_medicas.nombre%TYPE, w_dni IN pruebas_medicas.dni%TYPE, 
                salida_esperada boolean)
            AS
            SALIDA BOOLEAN :=TRUE;
            TIPO_PMEDICAS PRUEBAS_MEDICAS%ROWTYPE;
            
            BEGIN
                INSERT INTO PRUEBAS_MEDICAS VALUES (w_nombre, w_dni);
                
                SELECT * INTO TIPO_PMEDICAS FROM PRUEBAS_MEDICAS WHERE nombre=w_nombre;
                IF (TIPO_PMEDICAS.nombre <> w_nombre) THEN SALIDA:= FALSE;
                END IF;
                COMMIT WORK;
                
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                 
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    ROLLBACK;
            END INSERTAR;
            
    PROCEDURE ACTUALIZAR (nombre_prueba varchar2, w_dni IN pruebas_medicas.dni%TYPE, 
                w_nombre IN pruebas_medicas.nombre%TYPE,
                salida_esperada boolean)
            
            AS
                SALIDA BOOLEAN := TRUE;
                TIPO_PMEDICAS PRUEBAS_MEDICAS%ROWTYPE;
            
            BEGIN
                    UPDATE PRUEBAS_MEDICAS
                        SET dni=w_dni
                        WHERE nombre=w_nombre;
                        
                    SELECT * INTO TIPO_PMEDICAS FROM PRUEBAS_MEDICAS WHERE nombre=w_nombre;
                    
                    IF (TIPO_PMEDICAS.nombre <> w_nombre
                    OR TIPO_PMEDICAS.dni <> w_dni) THEN
                        
                        SALIDA := FALSE;
                    END IF;
                    COMMIT WORK;
                    
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                    
            EXCEPTION
                    WHEN OTHERS THEN
                         DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                         ROLLBACK;
            END ACTUALIZAR;
            
    PROCEDURE ELIMINAR ( nombre_prueba varchar2,  w_nombre IN pruebas_medicas.nombre%TYPE, salida_esperada boolean)
             
            AS
                SALIDA BOOLEAN := TRUE;
                N_PMEDICAS INTEGER;
                
            BEGIN
                DELETE FROM PRUEBAS_MEDICAS WHERE nombre=w_nombre;
                
                SELECT COUNT(*) INTO N_PMEDICAS FROM PRUEBAS_MEDICAS WHERE nombre=w_nombre;
                IF (N_PMEDICAS <> 0) THEN
                    SALIDA := FALSE;
                END IF;
                COMMIT WORK;
                
                DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
            
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    
                END ELIMINAR;
                
    END PRUEBAS_PMEDICAS;
     /           
---------------------------------------------------------------------------PAQUETE PRUEBAS TRABAJADORES
CREATE OR REPLACE PACKAGE PRUEBAS_TRABAJADORES AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR(nombre_prueba varchar2, 
		w_nif IN trabajadores.nif%TYPE, 
		w_nombre IN trabajadores.nombre%TYPE,
                w_apellidos IN trabajadores.apellidos%TYPE, 
                w_especialidad IN trabajadores.especialidad%TYPE, 
                w_telefono IN trabajadores.telefono%TYPE, 
                w_email IN trabajadores.email%TYPE,
                w_pass IN trabajadores.pass%TYPE,
                salida_esperada boolean);
                
    PROCEDURE ACTUALIZAR(nombre_prueba varchar2, 
		w_nif IN trabajadores.nif%TYPE, 
		w_nombre IN trabajadores.nombre%TYPE,
                w_apellidos IN trabajadores.apellidos%TYPE, 
                w_especialidad IN trabajadores.especialidad%TYPE, 
                w_telefono IN trabajadores.telefono%TYPE, 
                w_email IN trabajadores.email%TYPE,
                w_pass IN trabajadores.pass%TYPE,
                salida_esperada boolean);
    
    PROCEDURE ELIMINAR(nombre_prueba varchar2, 
                        w_nif IN trabajadores.nif%TYPE,
                        salida_esperada boolean);
    END PRUEBAS_TRABAJADORES;
    
    /

CREATE OR REPLACE PACKAGE BODY PRUEBAS_TRABAJADORES AS
        
        PROCEDURE INICIALIZAR AS
        BEGIN
            DELETE FROM TRABAJADORES;
        END INICIALIZAR;
        
        PROCEDURE INSERTAR(nombre_prueba varchar2, 
		w_nif IN trabajadores.nif%TYPE, 
		w_nombre IN trabajadores.nombre%TYPE,
                w_apellidos IN trabajadores.apellidos%TYPE, 
                w_especialidad IN trabajadores.especialidad%TYPE, 
                w_telefono IN trabajadores.telefono%TYPE, 
                w_email IN trabajadores.email%TYPE,
                w_pass IN trabajadores.pass%TYPE,
                salida_esperada boolean)
            AS
            SALIDA BOOLEAN :=TRUE;
            TIPO_TRABAJADORES TRABAJADORES%ROWTYPE;
            
            BEGIN
                INSERT INTO TRABAJADORES VALUES (w_nif, w_nombre, w_apellidos, w_especialidad, w_telefono, w_email, w_pass);
                
                SELECT * INTO TIPO_TRABAJADORES FROM trabajadores WHERE nif=w_nif;
                IF (TIPO_TRABAJADORES.nif <> w_nif) THEN SALIDA:= FALSE;
                END IF;
                COMMIT WORK;
                
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                 
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    ROLLBACK;
            END INSERTAR;
            
        PROCEDURE ACTUALIZAR (nombre_prueba varchar2, 
		w_nif IN trabajadores.nif%TYPE, 
		w_nombre IN trabajadores.nombre%TYPE,
                w_apellidos IN trabajadores.apellidos%TYPE, 
                w_especialidad IN trabajadores.especialidad%TYPE, 
                w_telefono IN trabajadores.telefono%TYPE, 
                w_email IN trabajadores.email%TYPE,
                w_pass IN trabajadores.pass%TYPE,
                salida_esperada boolean)
            
            AS
                SALIDA BOOLEAN := TRUE;
                TIPO_TRABAJADORES TRABAJADORES%ROWTYPE;
            
            BEGIN
                    UPDATE TRABAJADORES
                        SET nombre=w_nombre,
                            apellidos=w_apellidos,
                            especialidad=w_especialidad,
                            telefono=w_telefono,
                            email=w_email,
                            pass=w_pass
                        WHERE nif=w_nif;
                        
                    SELECT * INTO TIPO_TRABAJADORES FROM TRABAJADORES WHERE nif=w_nif;
                    
                    IF (TIPO_TRABAJADORES.nif <> w_nif
                        OR TIPO_TRABAJADORES.nombre <> w_nombre
                        OR TIPO_TRABAJADORES.apellidos <> w_apellidos
                        OR TIPO_TRABAJADORES.especialidad <> w_especialidad
                        OR TIPO_TRABAJADORES.telefono <> w_telefono
                        OR TIPO_TRABAJADORES.email <> w_email
                        OR TIPO_TRABAJADORES.pass <> w_pass) THEN
                        
                        SALIDA := FALSE;
                    END IF;
                    COMMIT WORK;
                    
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                    
            EXCEPTION
                    WHEN OTHERS THEN
                         DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                         ROLLBACK;
            END ACTUALIZAR;
            
            PROCEDURE ELIMINAR ( nombre_prueba varchar2, w_nif in trabajadores.nif%TYPE, salida_esperada boolean)
             
            AS
                SALIDA BOOLEAN := TRUE;
                N_TRABAJADORES INTEGER;
                
            BEGIN
                DELETE FROM TRABAJADORES WHERE nif=w_nif;
                
                SELECT COUNT(*) INTO N_TRABAJADORES FROM TRABAJADORES WHERE nif=w_nif;
                IF (N_TRABAJADORES <> 0) THEN
                    SALIDA := FALSE;
                END IF;
                COMMIT WORK;
                
                DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
            
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    
                END ELIMINAR;
                
            END PRUEBAS_TRABAJADORES;
    /
---------------------------------------------------------------------------PAQUETE PRUEBAS CITAS
CREATE OR REPLACE PACKAGE PRUEBAS_CITAS AS
    PROCEDURE INICIALIZAR;
    PROCEDURE INSERTAR(nombre_prueba varchar2, 
	w_fecha IN citas.fecha%TYPE, 
        w_hora IN citas.hora%TYPE, 
        w_tipo IN citas.tipo_cita%TYPE, 
	w_dni IN citas.dni%TYPE, 
	w_tcertificado IN citas.tipo_certificado%TYPE,
        salida_esperada boolean);
                
    PROCEDURE ACTUALIZAR(nombre_prueba varchar2, 
	w_fecha IN citas.fecha%TYPE, 
        w_hora IN citas.hora%TYPE, 
        w_tipo IN citas.tipo_cita%TYPE, 
	w_dni IN citas.dni%TYPE, 
	w_tcertificado IN citas.tipo_certificado%TYPE, 
        salida_esperada boolean);
    
    PROCEDURE ELIMINAR(nombre_prueba varchar2, 
                        w_fecha IN citas.fecha%TYPE,
                        salida_esperada boolean);
    END PRUEBAS_CITAS;
    
     /
           
CREATE OR REPLACE PACKAGE BODY PRUEBAS_CITAS AS
        
    PROCEDURE INICIALIZAR AS
    BEGIN
        DELETE FROM CITAS;
    END INICIALIZAR;
        
    PROCEDURE INSERTAR(nombre_prueba varchar2, 
	w_fecha IN citas.fecha%TYPE, 
        w_hora IN citas.hora%TYPE, 
        w_tipo IN citas.tipo_cita%TYPE, 
	w_dni IN citas.dni%TYPE, 
	w_tcertificado IN citas.tipo_certificado%TYPE,
            salida_esperada boolean)
            
            AS
            SALIDA BOOLEAN :=TRUE;
            TIPO_CITAS CITAS%ROWTYPE;
            
            BEGIN
                INSERT INTO CITAS VALUES (w_fecha, w_hora, w_tipo, w_dni, w_tcertificado);
                
                SELECT * INTO TIPO_CITAS FROM citas WHERE fecha=w_fecha;
                IF (TIPO_CITAS.fecha <> w_fecha or tipo_citas.hora<> w_hora) THEN SALIDA:= FALSE;
                END IF;
                COMMIT WORK;
                
                 DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                 
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    ROLLBACK;
            END INSERTAR;
            
    PROCEDURE ACTUALIZAR (nombre_prueba varchar2, w_fecha IN citas.fecha%TYPE, 
        w_hora IN citas.hora%TYPE, 
        w_tipo IN citas.tipo_cita%TYPE, 
	w_dni IN citas.dni%TYPE, 
	w_tcertificado IN citas.tipo_certificado%TYPE,  
            salida_esperada boolean)
            
            AS
                SALIDA BOOLEAN := TRUE;
                TIPO_CITAS CITAS%ROWTYPE;
            
            BEGIN
                    UPDATE CITAS
                        SET hora=w_hora,
                            tipo_cita=w_tipo,
                            dni=w_dni,
                            tipo_certificado=w_tcertificado
                        WHERE fecha=w_fecha;
                        
                    SELECT * INTO TIPO_CITAS FROM citas WHERE fecha=w_fecha;
                    
                    IF (TIPO_CITAS.fecha <> w_fecha
                        OR TIPO_CITAS.TIPO_CITA <> w_tipo
                        OR TIPO_CITAS.hora <> w_hora
			OR TIPO_CITAS.dni <> w_dni
			OR TIPO_CITAS.TIPO_CERTIFICADO <> w_tcertificado) THEN
                        
                        SALIDA := FALSE;
                    END IF;
                    COMMIT WORK;
                    
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
                    
            EXCEPTION
                    WHEN OTHERS THEN
                         DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                         ROLLBACK;
            END ACTUALIZAR;
            
    PROCEDURE ELIMINAR ( nombre_prueba varchar2, w_fecha IN citas.fecha%TYPE, 
                    salida_esperada boolean)
             
            AS
                SALIDA BOOLEAN := TRUE;
                N_CITAS INTEGER;
                
            BEGIN
                DELETE FROM CITAS WHERE fecha=w_fecha;
                
                SELECT COUNT(*) INTO N_CITAS FROM CITAS WHERE fecha=w_fecha;
                IF (N_CITAS <> 0) THEN
                    SALIDA := FALSE;
                END IF;
                COMMIT WORK;
                
                DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(SALIDA, SALIDA_ESPERADA));
            
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(NOMBRE_PRUEBA || ': ' || ASSERT_EQUALS(FALSE, SALIDA_ESPERADA));
                    
                END ELIMINAR;
                
    END PRUEBAS_CITAS;
     / 


-------------------------------------------------------
    BEGIN
        PRUEBAS_IR.INICIALIZAR;
        PRUEBAS_PMEDICAS.INICIALIZAR;
        PRUEBAS_CLIENTES.INICIALIZAR;
        PRUEBAS_FOTOS.INICIALIZAR;
        PRUEBAS_TRABAJADORES.INICIALIZAR;
         PRUEBAS_CERTIFICADOS.INICIALIZAR;
        PRUEBAS_TASAS.INICIALIZAR;
         PRUEBAS_LINEAS_DE_TASAS.INICIALIZAR;
        PRUEBAS_REQUIERE.INICIALIZAR;
         PRUEBAS_CITAS.INICIALIZAR;
    END;
    /

