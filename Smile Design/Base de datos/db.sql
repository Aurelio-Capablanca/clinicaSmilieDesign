--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

-- Started on 2021-07-07 16:15:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 271 (class 1255 OID 49878)
-- Name: actualizar_cuentas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_cuentas() RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
idH int = (Select Tratamiento From historialPagos Where idhistorial=(Select max(idhistorial) From HistorialPagos));
nombre text =(Select nombrePaciente ||' '|| apellidoPaciente From Pagos pg Inner join Tratamientos tr on pg.idTratamiento=tr.idTratamiento Inner join PacienteAsignado pa on pa.idpacienteasignado = tr.idpacienteasignado Inner join Pacientes pc on pc.idpaciente = pa.idpaciente Where idpago=idH);
	  Begin 
      Update historialPagos set nombrePaciente =nombre Where Tratamiento=idH ;
return nombre;	  
End;
$$;


ALTER FUNCTION public.actualizar_cuentas() OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 58224)
-- Name: actualizar_pagos(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_pagos(idt integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
Pagado numeric;
TotalAc numeric ;
begin
Pagado = (Select sum(pagoabonoh) - (sum(pagoabonoh) - pagototalh) as TotalPagado From historialpagos Where tratamiento=idT And pagodebeh >= 0 Group by pagototalh);
TotalAc = (Select Sum(costoprocedimiento) as CostoTotal from CantidadConsultas cc inner join Tratamientos tr on tr.idTratamiento=cc.idTratamiento inner join Consultas cl on cl.idConsulta=cc.idConsulta inner join ConsultaProcedimiento co on co.idConsulta=cl.idConsulta inner join Procedimientos pr on pr.idProcedimiento=co.idProcedimiento 
		   Where tr.idTratamiento=idT);
RAISE NOTICE 'Resultado ((%)) ',TotalAC - Pagado;
Update pagos set pagototal =(TotalAc-Pagado) , pagodebe=(TotalAc-Pagado), idestadopago=1  Where idpago =idT;
return; 
end;
$$;


ALTER FUNCTION public.actualizar_pagos(idt integer) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 74606)
-- Name: buscar_cuentas(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buscar_cuentas(idt integer) RETURNS TABLE(tr integer, fecha timestamp without time zone, debe numeric, abono numeric, saldo numeric)
    LANGUAGE plpgsql
    AS $$
begin
return query
Select tratamiento ,fecharegistro, pagodebeh, pagoabonoh, pagosaldoh
From historialpagos
Where pagoabonoh >=0
And tratamiento = idT;
end;
$$;


ALTER FUNCTION public.buscar_cuentas(idt integer) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 49826)
-- Name: buscar_id_paciente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buscar_id_paciente() RETURNS TABLE(nombrecompleto text)
    LANGUAGE plpgsql
    AS $$
declare
idH int = (Select Tratamiento From historialPagos Where idhistorial=(Select max(idhistorial) From HistorialPagos)) ;
begin
Return query
Select nombrePaciente ||' '|| apellidoPaciente
From Pagos pg 
Inner join Tratamientos tr on pg.idTratamiento=tr.idTratamiento 
Inner join PacienteAsignado pa on pa.idpacienteasignado = tr.idpacienteasignado
Inner join Pacientes pc on pc.idpaciente = pa.idpaciente 
Where idpago=idH;
end;
$$;


ALTER FUNCTION public.buscar_id_paciente() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 253 (class 1259 OID 58209)
-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultas (
    idconsulta integer NOT NULL,
    notasconsulta character varying(155) NOT NULL,
    costoconsulta numeric(4,2) NOT NULL,
    fechaconsulta date,
    horaconsulta time without time zone,
    idcausaconsulta integer NOT NULL
);


ALTER TABLE public.consultas OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 58220)
-- Name: buscar_incoincidentes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buscar_incoincidentes() RETURNS SETOF public.consultas
    LANGUAGE plpgsql
    AS $$
begin
return query
SELECT * FROM consultas
WHERE idconsulta NOT IN(SELECT idconsulta FROM consultaprocedimiento);
end;
$$;


ALTER FUNCTION public.buscar_incoincidentes() OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 58078)
-- Name: buscar_preguntas(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.buscar_preguntas() RETURNS void
    LANGUAGE plpgsql
    AS $$
declare 
p1  varchar;
p2  varchar;
p3  varchar;
p4  varchar;
p5  varchar;
p6  varchar;
p7  varchar;
p8  varchar;
begin
p1  = (Select pregunta from Preguntas Where idpregunta = 1);
p2  = (Select pregunta from Preguntas Where idpregunta = 2);
p3  = (Select pregunta from Preguntas Where idpregunta = 3);
p4  = (Select pregunta from Preguntas Where idpregunta = 4);
p5  = (Select pregunta from Preguntas Where idpregunta = 5);
p6  = (Select pregunta from Preguntas Where idpregunta = 6);
p7  = (Select pregunta from Preguntas Where idpregunta = 7);
p8  = (Select pregunta from Preguntas Where idpregunta = 8);

RAISE NOTICE 'Pregunta #1 ((%)) ',p1;
RAISE NOTICE 'Pregunta #2 ((%)) ',p2;
RAISE NOTICE 'Pregunta #3 ((%)) ',p3;
RAISE NOTICE 'Pregunta #4 ((%)) ',p4;
RAISE NOTICE 'Pregunta #5 ((%)) ',p5;
RAISE NOTICE 'Pregunta #6 ((%)) ',p6;
RAISE NOTICE 'Pregunta #7 ((%)) ',p7;
RAISE NOTICE 'Pregunta #8 ((%)) ',p8;
return;
end;
$$;


ALTER FUNCTION public.buscar_preguntas() OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 50804)
-- Name: calculo_cuenta(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculo_cuenta(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
begin
Update Pagos set pagoTotal=(Select Sum(costoprocedimiento)
from CantidadConsultas cc
inner join Tratamientos tr on tr.idTratamiento=cc.idTratamiento
inner join Consultas cl on cl.idConsulta=cc.idConsulta
inner join ConsultaProcedimiento co on co.idConsulta=cl.idConsulta
inner join Procedimientos pr on pr.idProcedimiento=co.idProcedimiento
Where tr.idTratamiento=$1),pagoDebe=(Select Sum(costoprocedimiento)
from CantidadConsultas cc
inner join Tratamientos tr on tr.idTratamiento=cc.idTratamiento
inner join Consultas cl on cl.idConsulta=cc.idConsulta
inner join ConsultaProcedimiento co on co.idConsulta=cl.idConsulta
inner join Procedimientos pr on pr.idProcedimiento=co.idProcedimiento
Where tr.idTratamiento=$1), idestadopago=1 where idTratamiento=$1;
Return;
END;
$_$;


ALTER FUNCTION public.calculo_cuenta(integer) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 50805)
-- Name: calculo_saldo(integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculo_saldo(id_p integer, abono numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
Update Pagos set pagoAbono=abono, pagodebe=(pagodebe-abono), pagosaldo=(pagodebe-abono) where idPago=id_p;
	if (Select abono < pagoDebe from Pagos  where idPago=id_p)
		then
		Raise Notice 'Aún no se completa la cuenta';
	    Return;
	end if;
	if (Select pagoDebe<=0 from Pagos where idPago=id_p)
		then 
		Update Pagos set pagoDebe=0, pagosaldo = 0 where idPago=id_p;
		Update Pagos set idEstadoPago=2 where idPago=id_p;
		Raise Notice 'Pago completo la cuenta';
	end if;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Error al Tratar de Modificar el valor ((%)) ((%)) ',id_p,abono;
        RAISE NOTICE 'Error al Tratar de Modificar el valor ((%)) ((%)) ',id_p, abono;
        RETURN;
    END IF;
Return;
END;
$$;


ALTER FUNCTION public.calculo_saldo(id_p integer, abono numeric) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 58092)
-- Name: historial_pagos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.historial_pagos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	  Begin 	  
	  Insert into historialPagos (fecharegistro,pagodebeH,pagoabonoH,pagototalH,pagosaldoH,tratamiento,tipopago)
	  Values (current_timestamp,new.pagodebe,new.pagoabono,new.pagototal,new.pagosaldo,new.idtratamiento,new.idtipopago);	  	  
	  Return null;
end;
$$;


ALTER FUNCTION public.historial_pagos() OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 50808)
-- Name: historial_pagos_nombres(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.historial_pagos_nombres() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
idH int = (Select Tratamiento From historialPagos Where idhistorial=(Select max(idhistorial) From HistorialPagos));
nombre text =(Select nombrePaciente ||' '|| apellidoPaciente From Pagos pg Inner join Tratamientos tr on pg.idTratamiento=tr.idTratamiento Inner join PacienteAsignado pa on pa.idpacienteasignado = tr.idpacienteasignado Inner join Pacientes pc on pc.idpaciente = pa.idpaciente Where idpago=idH);
	  Begin 
      Update historialPagos set nombrePaciente =nombre Where Tratamiento=idH ;
	  Return null;
end;
$$;


ALTER FUNCTION public.historial_pagos_nombres() OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 50741)
-- Name: cantidadconsultas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cantidadconsultas (
    idcantidadconsulta integer NOT NULL,
    idconsulta integer NOT NULL,
    idtratamiento integer NOT NULL
);


ALTER TABLE public.cantidadconsultas OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 50739)
-- Name: cantidadconsultas_idcantidadconsulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cantidadconsultas_idcantidadconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cantidadconsultas_idcantidadconsulta_seq OWNER TO postgres;

--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 239
-- Name: cantidadconsultas_idcantidadconsulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cantidadconsultas_idcantidadconsulta_seq OWNED BY public.cantidadconsultas.idcantidadconsulta;


--
-- TOC entry 236 (class 1259 OID 50702)
-- Name: causaconsulta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.causaconsulta (
    idcausaconsulta integer NOT NULL,
    causa character varying(30) NOT NULL
);


ALTER TABLE public.causaconsulta OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 50700)
-- Name: causaconsulta_idcausaconsulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.causaconsulta_idcausaconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.causaconsulta_idcausaconsulta_seq OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 235
-- Name: causaconsulta_idcausaconsulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.causaconsulta_idcausaconsulta_seq OWNED BY public.causaconsulta.idcausaconsulta;


--
-- TOC entry 238 (class 1259 OID 50723)
-- Name: consultaprocedimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultaprocedimiento (
    idconsultaprocedimiento integer NOT NULL,
    idconsulta integer NOT NULL,
    idprocedimiento integer NOT NULL
);


ALTER TABLE public.consultaprocedimiento OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 50721)
-- Name: consultaprocedimiento_idconsultaprocedimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultaprocedimiento_idconsultaprocedimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consultaprocedimiento_idconsultaprocedimiento_seq OWNER TO postgres;

--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 237
-- Name: consultaprocedimiento_idconsultaprocedimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultaprocedimiento_idconsultaprocedimiento_seq OWNED BY public.consultaprocedimiento.idconsultaprocedimiento;


--
-- TOC entry 252 (class 1259 OID 58207)
-- Name: consultas_idconsulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultas_idconsulta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consultas_idconsulta_seq OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 252
-- Name: consultas_idconsulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultas_idconsulta_seq OWNED BY public.consultas.idconsulta;


--
-- TOC entry 220 (class 1259 OID 50593)
-- Name: doctores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctores (
    iddoctor integer NOT NULL,
    nombredoctor character varying(25) NOT NULL,
    apellidodoctor character varying(25) NOT NULL,
    direcciondoctor character varying(155) NOT NULL,
    telefonodoctor character varying(9) NOT NULL,
    correodoctor character varying(55) NOT NULL,
    fotodoctor character varying(100),
    aliasdoctor character varying(15) NOT NULL,
    clavedoctor character varying(100) NOT NULL,
    idestadodoctor integer NOT NULL
);


ALTER TABLE public.doctores OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 50591)
-- Name: doctores_iddoctor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctores_iddoctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctores_iddoctor_seq OWNER TO postgres;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 219
-- Name: doctores_iddoctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctores_iddoctor_seq OWNED BY public.doctores.iddoctor;


--
-- TOC entry 218 (class 1259 OID 50586)
-- Name: especialidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especialidad (
    idespecialidad integer NOT NULL,
    especialidad character varying(25) NOT NULL
);


ALTER TABLE public.especialidad OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 50606)
-- Name: especialidaddoctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especialidaddoctor (
    idespecialidaddoctor integer NOT NULL,
    iddoctor integer NOT NULL,
    idespecialidad integer NOT NULL
);


ALTER TABLE public.especialidaddoctor OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 50604)
-- Name: especialidaddoctor_idespecialidaddoctor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especialidaddoctor_idespecialidaddoctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.especialidaddoctor_idespecialidaddoctor_seq OWNER TO postgres;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 221
-- Name: especialidaddoctor_idespecialidaddoctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especialidaddoctor_idespecialidaddoctor_seq OWNED BY public.especialidaddoctor.idespecialidaddoctor;


--
-- TOC entry 217 (class 1259 OID 50580)
-- Name: estadodoctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadodoctor (
    idestadodoctor integer NOT NULL,
    estadodoctor character varying(15) NOT NULL
);


ALTER TABLE public.estadodoctor OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 50578)
-- Name: estadodoctor_idestadodoctor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadodoctor_idestadodoctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadodoctor_idestadodoctor_seq OWNER TO postgres;

--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 216
-- Name: estadodoctor_idestadodoctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadodoctor_idestadodoctor_seq OWNED BY public.estadodoctor.idestadodoctor;


--
-- TOC entry 211 (class 1259 OID 50513)
-- Name: estadopaciente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadopaciente (
    idestadopaciente integer NOT NULL,
    estadopaciente character varying(15) NOT NULL
);


ALTER TABLE public.estadopaciente OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 50511)
-- Name: estadopaciente_idestadopaciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadopaciente_idestadopaciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadopaciente_idestadopaciente_seq OWNER TO postgres;

--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 210
-- Name: estadopaciente_idestadopaciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadopaciente_idestadopaciente_seq OWNED BY public.estadopaciente.idestadopaciente;


--
-- TOC entry 243 (class 1259 OID 50765)
-- Name: estadopago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadopago (
    idestadopago integer NOT NULL,
    estadopago character varying(15) NOT NULL
);


ALTER TABLE public.estadopago OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 50663)
-- Name: estadotratamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadotratamiento (
    idestadotratamiento integer NOT NULL,
    estadotratamiento character varying(15) NOT NULL
);


ALTER TABLE public.estadotratamiento OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 50661)
-- Name: estadotratamiento_idestadotratamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadotratamiento_idestadotratamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadotratamiento_idestadotratamiento_seq OWNER TO postgres;

--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 229
-- Name: estadotratamiento_idestadotratamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadotratamiento_idestadotratamiento_seq OWNED BY public.estadotratamiento.idestadotratamiento;


--
-- TOC entry 205 (class 1259 OID 50479)
-- Name: estadousuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadousuario (
    idestadousuario integer NOT NULL,
    estadousuario character varying(15) NOT NULL
);


ALTER TABLE public.estadousuario OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 50477)
-- Name: estadousuario_idestadousuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadousuario_idestadousuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadousuario_idestadousuario_seq OWNER TO postgres;

--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 204
-- Name: estadousuario_idestadousuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadousuario_idestadousuario_seq OWNED BY public.estadousuario.idestadousuario;


--
-- TOC entry 215 (class 1259 OID 50564)
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expedientes (
    idexpediente integer NOT NULL,
    notasmedicas character varying(255) NOT NULL,
    odontograma character varying(100),
    periodontograma character varying(100),
    observacionesperiodontograma character varying(255) NOT NULL,
    idpaciente integer NOT NULL
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 50562)
-- Name: expedientes_idexpediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expedientes_idexpediente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expedientes_idexpediente_seq OWNER TO postgres;

--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 214
-- Name: expedientes_idexpediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expedientes_idexpediente_seq OWNED BY public.expedientes.idexpediente;


--
-- TOC entry 247 (class 1259 OID 50795)
-- Name: historialpagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historialpagos (
    idhistorial integer NOT NULL,
    nombrepaciente text,
    fecharegistro timestamp without time zone,
    pagodebeh numeric(5,2),
    pagoabonoh numeric(5,2),
    pagototalh numeric(5,2),
    pagosaldoh numeric(5,2),
    tratamiento integer,
    tipopago integer
);


ALTER TABLE public.historialpagos OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 50793)
-- Name: historialpagos_idhistorial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historialpagos_idhistorial_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historialpagos_idhistorial_seq OWNER TO postgres;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 246
-- Name: historialpagos_idhistorial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historialpagos_idhistorial_seq OWNED BY public.historialpagos.idhistorial;


--
-- TOC entry 224 (class 1259 OID 50624)
-- Name: pacienteasignado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacienteasignado (
    idpacienteasignado integer NOT NULL,
    idpaciente integer NOT NULL,
    iddoctor integer NOT NULL
);


ALTER TABLE public.pacienteasignado OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 50622)
-- Name: pacienteasignado_idpacienteasignado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacienteasignado_idpacienteasignado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pacienteasignado_idpacienteasignado_seq OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 223
-- Name: pacienteasignado_idpacienteasignado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacienteasignado_idpacienteasignado_seq OWNED BY public.pacienteasignado.idpacienteasignado;


--
-- TOC entry 213 (class 1259 OID 50521)
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    idpaciente integer NOT NULL,
    nombrepaciente character varying(25) NOT NULL,
    apellidopaciente character varying(25) NOT NULL,
    fechanacimiento date NOT NULL,
    duipaciente character varying(10) NOT NULL,
    direccionpaciente character varying(155) NOT NULL,
    telefonopaciente character varying(9) NOT NULL,
    correopaciente character varying(55) NOT NULL,
    fotopaciente character varying(100),
    idestadopaciente integer NOT NULL
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 50519)
-- Name: pacientes_idpaciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_idpaciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pacientes_idpaciente_seq OWNER TO postgres;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 212
-- Name: pacientes_idpaciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_idpaciente_seq OWNED BY public.pacientes.idpaciente;


--
-- TOC entry 245 (class 1259 OID 50772)
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    idpago integer NOT NULL,
    pagodebe numeric(5,2) NOT NULL,
    pagoabono numeric(5,2) NOT NULL,
    pagototal numeric(5,2) NOT NULL,
    pagosaldo numeric(5,2) NOT NULL,
    idtratamiento integer NOT NULL,
    idtipopago integer NOT NULL,
    idestadopago integer NOT NULL
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 50770)
-- Name: pagos_idpago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_idpago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pagos_idpago_seq OWNER TO postgres;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 244
-- Name: pagos_idpago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_idpago_seq OWNED BY public.pagos.idpago;


--
-- TOC entry 249 (class 1259 OID 58096)
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas (
    idpregunta integer NOT NULL,
    pregunta character varying(69) NOT NULL
);


ALTER TABLE public.preguntas OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 58094)
-- Name: preguntas_idpregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_idpregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preguntas_idpregunta_seq OWNER TO postgres;

--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 248
-- Name: preguntas_idpregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_idpregunta_seq OWNED BY public.preguntas.idpregunta;


--
-- TOC entry 234 (class 1259 OID 50694)
-- Name: procedimientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedimientos (
    idprocedimiento integer NOT NULL,
    nombreprocedimiento character varying(30) NOT NULL,
    descripcionprocedimiento character varying(155) NOT NULL,
    costoprocedimiento numeric(4,2) NOT NULL
);


ALTER TABLE public.procedimientos OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 50692)
-- Name: procedimientos_idprocedimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procedimientos_idprocedimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procedimientos_idprocedimiento_seq OWNER TO postgres;

--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 233
-- Name: procedimientos_idprocedimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procedimientos_idprocedimiento_seq OWNED BY public.procedimientos.idprocedimiento;


--
-- TOC entry 226 (class 1259 OID 50642)
-- Name: recetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recetas (
    idreceta integer NOT NULL,
    farmaco character varying(40) NOT NULL,
    fecharegistro date NOT NULL,
    idpacienteasignado integer NOT NULL
);


ALTER TABLE public.recetas OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 50640)
-- Name: recetas_idreceta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recetas_idreceta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recetas_idreceta_seq OWNER TO postgres;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 225
-- Name: recetas_idreceta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recetas_idreceta_seq OWNED BY public.recetas.idreceta;


--
-- TOC entry 251 (class 1259 OID 58145)
-- Name: respuestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas (
    idrespuesta integer NOT NULL,
    respuesta1 character varying(2),
    idpregunta1 integer,
    respuesta2 character varying(2),
    idpregunta2 integer,
    respuesta3 character varying(2),
    idpregunta3 integer,
    respuesta4 character varying(2),
    idpregunta4 integer,
    respuesta5 character varying(2),
    idpregunta5 integer,
    respuesta6 character varying(2),
    idpregunta6 integer,
    respuesta7 character varying(2),
    idpregunta7 integer,
    respuesta8 character varying(2),
    idpregunta8 integer,
    pacientemedicamento character varying(1000000) NOT NULL,
    idpaciente integer NOT NULL,
    CONSTRAINT respuestas_respuesta1_check CHECK ((((respuesta1)::text = 'Si'::text) OR ((respuesta1)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta2_check CHECK ((((respuesta2)::text = 'Si'::text) OR ((respuesta2)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta3_check CHECK ((((respuesta3)::text = 'Si'::text) OR ((respuesta3)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta4_check CHECK ((((respuesta4)::text = 'Si'::text) OR ((respuesta4)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta5_check CHECK ((((respuesta5)::text = 'Si'::text) OR ((respuesta5)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta6_check CHECK ((((respuesta6)::text = 'Si'::text) OR ((respuesta6)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta7_check CHECK ((((respuesta7)::text = 'Si'::text) OR ((respuesta7)::text = 'No'::text))),
    CONSTRAINT respuestas_respuesta8_check CHECK ((((respuesta8)::text = 'Si'::text) OR ((respuesta8)::text = 'No'::text)))
);


ALTER TABLE public.respuestas OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 58143)
-- Name: respuestas_idr_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuestas_idr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.respuestas_idr_seq OWNER TO postgres;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 250
-- Name: respuestas_idr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuestas_idr_seq OWNED BY public.respuestas.idrespuesta;


--
-- TOC entry 255 (class 1259 OID 66430)
-- Name: test12; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test12 (
    idtest integer NOT NULL,
    dates time without time zone,
    CONSTRAINT test12_dates_check CHECK (((dates >= '07:00:00'::time without time zone) AND (dates <= '18:59:59'::time without time zone)))
);


ALTER TABLE public.test12 OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 66428)
-- Name: test12_idtest_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test12_idtest_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test12_idtest_seq OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 254
-- Name: test12_idtest_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test12_idtest_seq OWNED BY public.test12.idtest;


--
-- TOC entry 242 (class 1259 OID 50759)
-- Name: tipopago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipopago (
    idtipopago integer NOT NULL,
    tipopago character varying(15) NOT NULL
);


ALTER TABLE public.tipopago OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 50757)
-- Name: tipopago_idtipopago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipopago_idtipopago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipopago_idtipopago_seq OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 241
-- Name: tipopago_idtipopago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipopago_idtipopago_seq OWNED BY public.tipopago.idtipopago;


--
-- TOC entry 228 (class 1259 OID 50655)
-- Name: tipotratamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipotratamiento (
    idtipotratamiento integer NOT NULL,
    tipotratamiento character varying(25) NOT NULL
);


ALTER TABLE public.tipotratamiento OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 50653)
-- Name: tipotratamiento_idtipotratamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipotratamiento_idtipotratamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipotratamiento_idtipotratamiento_seq OWNER TO postgres;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 227
-- Name: tipotratamiento_idtipotratamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipotratamiento_idtipotratamiento_seq OWNED BY public.tipotratamiento.idtipotratamiento;


--
-- TOC entry 207 (class 1259 OID 50487)
-- Name: tipousuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipousuario (
    idtipousuario integer NOT NULL,
    tipousuario character varying(25) NOT NULL
);


ALTER TABLE public.tipousuario OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 50485)
-- Name: tipousuario_idtipousuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipousuario_idtipousuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipousuario_idtipousuario_seq OWNER TO postgres;

--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 206
-- Name: tipousuario_idtipousuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipousuario_idtipousuario_seq OWNED BY public.tipousuario.idtipousuario;


--
-- TOC entry 232 (class 1259 OID 50671)
-- Name: tratamientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tratamientos (
    idtratamiento integer NOT NULL,
    fechainicio date NOT NULL,
    descripciontratamiento character varying(155) NOT NULL,
    idpacienteasignado integer NOT NULL,
    idtipotratamiento integer NOT NULL,
    idestadotratamiento integer NOT NULL
);


ALTER TABLE public.tratamientos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 50669)
-- Name: tratamientos_idtratamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tratamientos_idtratamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamientos_idtratamiento_seq OWNER TO postgres;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 231
-- Name: tratamientos_idtratamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tratamientos_idtratamiento_seq OWNED BY public.tratamientos.idtratamiento;


--
-- TOC entry 209 (class 1259 OID 50495)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    idusuario integer NOT NULL,
    nombreusuario character varying(25) NOT NULL,
    apellidousuario character varying(25) NOT NULL,
    direccionusuario character varying(155) NOT NULL,
    telefonousuario character varying(9) NOT NULL,
    correousuario character varying(55) NOT NULL,
    aliasusuario character varying(15) NOT NULL,
    claveusuario character varying(100) NOT NULL,
    idestadousuario integer NOT NULL,
    idtipousuario integer NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 50493)
-- Name: usuarios_idusuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_idusuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_idusuario_seq OWNER TO postgres;

--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 208
-- Name: usuarios_idusuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_idusuario_seq OWNED BY public.usuarios.idusuario;


--
-- TOC entry 2871 (class 2604 OID 50744)
-- Name: cantidadconsultas idcantidadconsulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cantidadconsultas ALTER COLUMN idcantidadconsulta SET DEFAULT nextval('public.cantidadconsultas_idcantidadconsulta_seq'::regclass);


--
-- TOC entry 2869 (class 2604 OID 50705)
-- Name: causaconsulta idcausaconsulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causaconsulta ALTER COLUMN idcausaconsulta SET DEFAULT nextval('public.causaconsulta_idcausaconsulta_seq'::regclass);


--
-- TOC entry 2870 (class 2604 OID 50726)
-- Name: consultaprocedimiento idconsultaprocedimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultaprocedimiento ALTER COLUMN idconsultaprocedimiento SET DEFAULT nextval('public.consultaprocedimiento_idconsultaprocedimiento_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 58212)
-- Name: consultas idconsulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas ALTER COLUMN idconsulta SET DEFAULT nextval('public.consultas_idconsulta_seq'::regclass);


--
-- TOC entry 2861 (class 2604 OID 50596)
-- Name: doctores iddoctor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctores ALTER COLUMN iddoctor SET DEFAULT nextval('public.doctores_iddoctor_seq'::regclass);


--
-- TOC entry 2862 (class 2604 OID 50609)
-- Name: especialidaddoctor idespecialidaddoctor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidaddoctor ALTER COLUMN idespecialidaddoctor SET DEFAULT nextval('public.especialidaddoctor_idespecialidaddoctor_seq'::regclass);


--
-- TOC entry 2860 (class 2604 OID 50583)
-- Name: estadodoctor idestadodoctor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadodoctor ALTER COLUMN idestadodoctor SET DEFAULT nextval('public.estadodoctor_idestadodoctor_seq'::regclass);


--
-- TOC entry 2857 (class 2604 OID 50516)
-- Name: estadopaciente idestadopaciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadopaciente ALTER COLUMN idestadopaciente SET DEFAULT nextval('public.estadopaciente_idestadopaciente_seq'::regclass);


--
-- TOC entry 2866 (class 2604 OID 50666)
-- Name: estadotratamiento idestadotratamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadotratamiento ALTER COLUMN idestadotratamiento SET DEFAULT nextval('public.estadotratamiento_idestadotratamiento_seq'::regclass);


--
-- TOC entry 2854 (class 2604 OID 50482)
-- Name: estadousuario idestadousuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadousuario ALTER COLUMN idestadousuario SET DEFAULT nextval('public.estadousuario_idestadousuario_seq'::regclass);


--
-- TOC entry 2859 (class 2604 OID 50567)
-- Name: expedientes idexpediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes ALTER COLUMN idexpediente SET DEFAULT nextval('public.expedientes_idexpediente_seq'::regclass);


--
-- TOC entry 2874 (class 2604 OID 50798)
-- Name: historialpagos idhistorial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historialpagos ALTER COLUMN idhistorial SET DEFAULT nextval('public.historialpagos_idhistorial_seq'::regclass);


--
-- TOC entry 2863 (class 2604 OID 50627)
-- Name: pacienteasignado idpacienteasignado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacienteasignado ALTER COLUMN idpacienteasignado SET DEFAULT nextval('public.pacienteasignado_idpacienteasignado_seq'::regclass);


--
-- TOC entry 2858 (class 2604 OID 50524)
-- Name: pacientes idpaciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN idpaciente SET DEFAULT nextval('public.pacientes_idpaciente_seq'::regclass);


--
-- TOC entry 2873 (class 2604 OID 50775)
-- Name: pagos idpago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos ALTER COLUMN idpago SET DEFAULT nextval('public.pagos_idpago_seq'::regclass);


--
-- TOC entry 2875 (class 2604 OID 58099)
-- Name: preguntas idpregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas ALTER COLUMN idpregunta SET DEFAULT nextval('public.preguntas_idpregunta_seq'::regclass);


--
-- TOC entry 2868 (class 2604 OID 50697)
-- Name: procedimientos idprocedimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimientos ALTER COLUMN idprocedimiento SET DEFAULT nextval('public.procedimientos_idprocedimiento_seq'::regclass);


--
-- TOC entry 2864 (class 2604 OID 50645)
-- Name: recetas idreceta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas ALTER COLUMN idreceta SET DEFAULT nextval('public.recetas_idreceta_seq'::regclass);


--
-- TOC entry 2876 (class 2604 OID 58148)
-- Name: respuestas idrespuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas ALTER COLUMN idrespuesta SET DEFAULT nextval('public.respuestas_idr_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 66433)
-- Name: test12 idtest; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test12 ALTER COLUMN idtest SET DEFAULT nextval('public.test12_idtest_seq'::regclass);


--
-- TOC entry 2872 (class 2604 OID 50762)
-- Name: tipopago idtipopago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipopago ALTER COLUMN idtipopago SET DEFAULT nextval('public.tipopago_idtipopago_seq'::regclass);


--
-- TOC entry 2865 (class 2604 OID 50658)
-- Name: tipotratamiento idtipotratamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipotratamiento ALTER COLUMN idtipotratamiento SET DEFAULT nextval('public.tipotratamiento_idtipotratamiento_seq'::regclass);


--
-- TOC entry 2855 (class 2604 OID 50490)
-- Name: tipousuario idtipousuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipousuario ALTER COLUMN idtipousuario SET DEFAULT nextval('public.tipousuario_idtipousuario_seq'::regclass);


--
-- TOC entry 2867 (class 2604 OID 50674)
-- Name: tratamientos idtratamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos ALTER COLUMN idtratamiento SET DEFAULT nextval('public.tratamientos_idtratamiento_seq'::regclass);


--
-- TOC entry 2856 (class 2604 OID 50498)
-- Name: usuarios idusuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN idusuario SET DEFAULT nextval('public.usuarios_idusuario_seq'::regclass);


--
-- TOC entry 3142 (class 0 OID 50741)
-- Dependencies: 240
-- Data for Name: cantidadconsultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cantidadconsultas (idcantidadconsulta, idconsulta, idtratamiento) FROM stdin;
1	84	26
2	42	18
3	88	74
4	82	78
5	87	33
6	40	1
7	57	87
8	89	82
9	59	34
10	87	48
11	67	14
12	36	77
13	73	6
14	34	46
15	3	55
16	49	33
17	40	77
18	72	55
19	86	87
20	4	72
21	94	13
22	93	74
23	84	90
24	73	52
25	96	58
26	40	40
27	37	27
28	100	71
29	29	78
30	65	91
31	53	2
32	86	92
33	80	52
34	59	84
35	70	28
36	36	98
37	81	83
38	35	16
39	10	8
40	46	67
41	94	42
42	45	11
43	56	82
44	6	88
45	51	41
46	81	11
47	10	18
48	76	26
49	61	93
50	11	8
51	32	5
52	1	26
53	82	38
54	47	43
55	50	16
56	95	69
57	11	82
58	85	14
59	22	59
60	41	78
61	63	5
62	19	17
63	35	95
64	13	42
65	49	35
66	77	50
67	83	39
68	6	93
69	88	7
70	38	41
71	94	27
72	93	9
73	54	34
74	26	42
75	33	87
76	93	39
77	49	47
78	39	2
79	72	28
80	84	7
81	12	59
82	67	67
83	79	17
84	52	86
85	44	16
86	31	22
87	62	31
88	50	84
89	18	10
90	38	54
91	74	42
92	36	77
93	87	35
94	63	35
95	97	32
96	65	83
97	33	39
98	15	18
99	97	74
100	61	4
101	78	97
102	66	100
103	15	73
104	12	93
105	54	66
106	31	69
107	72	55
108	33	54
109	75	96
110	30	22
111	29	90
112	14	11
113	21	62
114	68	71
115	81	100
116	46	87
117	9	91
118	52	47
119	25	40
120	54	90
121	20	6
122	10	38
123	42	10
124	52	3
125	17	20
126	4	59
127	62	39
128	17	40
129	61	13
130	82	31
131	58	5
132	26	45
133	44	18
134	76	14
135	73	93
136	55	36
137	23	94
138	54	75
139	6	19
140	67	32
141	87	72
142	88	19
143	1	94
144	23	75
145	98	46
146	22	89
147	69	74
148	6	57
149	72	87
150	35	83
151	43	1
152	76	90
153	90	24
154	49	72
155	11	18
156	54	17
157	45	55
158	74	37
159	10	53
160	79	19
161	76	23
162	24	45
163	90	87
164	1	50
165	30	23
166	32	60
167	84	99
168	4	86
169	31	84
170	60	84
171	47	73
172	39	68
173	79	10
174	75	98
175	33	78
176	57	74
177	96	40
178	38	98
179	43	43
180	88	47
181	44	76
182	49	41
183	70	41
184	65	98
185	14	61
186	16	52
187	33	100
188	69	63
189	58	53
190	50	51
191	92	91
192	73	36
193	68	49
194	81	19
195	67	24
196	94	97
197	78	51
198	97	41
199	14	94
200	25	31
201	94	56
202	14	55
203	59	51
204	4	88
205	92	36
206	51	1
207	40	35
208	50	20
209	35	46
210	76	68
211	63	75
212	85	72
213	59	86
214	61	39
215	53	73
216	11	42
217	2	24
218	88	40
219	9	27
220	32	36
221	32	73
222	66	37
223	45	6
224	15	38
225	84	26
226	38	22
227	87	80
228	74	19
229	54	86
230	43	11
231	12	17
232	87	24
233	71	59
234	88	4
235	81	44
236	28	44
237	18	34
238	72	4
239	3	38
240	49	71
241	86	67
242	24	86
243	90	38
244	100	70
245	57	19
246	12	78
247	43	23
248	25	2
249	21	54
250	8	61
251	35	80
252	15	74
253	49	43
254	89	94
255	63	71
256	32	30
257	25	91
258	78	16
259	98	35
260	97	46
261	5	88
262	85	70
263	43	100
264	77	97
265	15	26
266	66	41
267	18	93
268	34	71
269	89	9
270	62	69
271	15	74
272	39	91
273	30	8
274	17	83
275	58	14
276	55	76
277	92	33
278	91	59
279	100	76
280	14	9
281	83	18
282	7	89
283	53	75
284	11	89
285	61	32
286	53	95
287	90	98
288	53	21
289	78	82
290	3	33
291	88	15
292	7	79
293	55	7
294	14	65
295	72	47
296	69	38
297	70	26
298	86	60
299	30	85
300	73	12
301	52	21
302	47	42
303	62	17
304	90	71
305	36	90
306	56	34
307	69	48
308	87	89
309	45	53
310	65	20
311	88	7
312	80	40
313	65	62
314	32	19
315	25	5
316	38	51
317	15	5
318	53	97
319	73	93
320	41	93
321	69	9
322	59	50
323	54	22
324	82	32
325	63	73
326	70	43
327	24	26
328	28	86
329	91	1
330	61	1
331	6	14
332	45	19
333	13	75
334	71	52
335	41	27
336	85	39
337	91	68
338	54	78
339	99	59
340	101	31
341	4	90
342	66	15
343	99	20
344	19	19
345	1	61
346	18	50
347	79	13
348	89	87
349	30	71
350	97	69
351	83	85
352	64	36
353	57	78
354	49	92
355	80	86
356	34	33
357	31	61
358	44	27
359	7	47
360	96	29
361	14	44
362	59	5
363	24	73
364	65	61
365	11	20
366	25	2
367	21	34
368	31	75
369	103	85
370	94	3
371	98	44
372	67	54
373	54	100
374	67	90
375	31	65
376	72	30
377	8	84
378	14	81
379	36	82
380	81	44
381	70	98
382	41	27
383	41	39
384	11	91
385	84	72
386	61	7
387	9	47
388	106	60
389	82	91
390	105	6
391	67	18
392	17	57
393	17	54
394	96	40
395	98	67
396	61	71
397	74	34
398	35	73
399	20	45
\.


--
-- TOC entry 3138 (class 0 OID 50702)
-- Dependencies: 236
-- Data for Name: causaconsulta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.causaconsulta (idcausaconsulta, causa) FROM stdin;
1	Higiene Oral
2	Sensibilidad Oral
3	Nefrosis
4	Visita al Dentista
\.


--
-- TOC entry 3140 (class 0 OID 50723)
-- Dependencies: 238
-- Data for Name: consultaprocedimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultaprocedimiento (idconsultaprocedimiento, idconsulta, idprocedimiento) FROM stdin;
1	65	8
2	14	3
3	64	7
4	18	6
5	55	8
6	16	6
7	64	7
8	81	3
9	3	8
10	81	6
11	59	6
12	70	1
13	61	1
14	90	5
15	40	3
16	55	5
17	81	2
18	21	7
19	14	8
20	55	7
21	55	3
22	54	3
23	73	1
24	9	3
25	1	4
26	57	3
27	65	5
28	82	4
29	55	2
30	70	1
31	41	5
32	49	2
33	44	2
34	41	7
35	40	7
36	98	2
37	26	6
38	22	7
39	27	7
40	46	1
41	37	4
42	3	5
43	83	3
44	87	3
45	80	4
46	84	8
47	73	4
48	73	5
49	18	6
50	7	3
51	12	2
52	3	4
53	72	2
54	75	7
55	44	6
56	16	2
57	43	3
58	42	2
59	44	6
60	88	8
61	82	1
62	1	6
63	22	5
64	94	7
65	86	8
66	42	2
67	93	4
68	83	1
69	16	4
70	28	1
71	25	6
72	10	7
73	44	8
74	69	1
75	31	8
76	46	3
77	26	7
78	35	1
79	20	2
80	31	1
81	52	7
82	21	8
83	94	4
84	73	5
85	36	6
86	82	4
87	57	7
88	37	4
89	42	4
90	69	6
91	44	2
92	72	2
93	89	1
94	13	7
95	53	5
96	89	5
97	18	8
98	5	8
99	94	2
100	84	8
101	66	5
102	49	7
103	90	1
104	7	4
105	7	7
106	21	3
107	14	5
108	75	7
109	77	7
110	14	8
111	24	8
112	64	1
113	68	2
114	95	6
115	92	2
116	51	4
117	13	7
118	90	8
119	72	5
120	63	5
121	3	4
122	55	4
123	30	8
124	4	8
125	66	1
126	94	5
127	24	2
128	26	7
129	52	6
130	93	7
131	55	7
132	75	7
133	50	7
134	54	4
135	12	7
136	80	2
137	5	4
138	26	1
139	20	5
140	35	7
141	41	1
142	51	4
143	65	4
144	4	8
145	48	4
146	31	6
147	10	5
148	94	2
149	32	2
150	11	6
151	4	7
152	79	6
153	17	5
154	71	1
155	73	4
156	53	2
157	33	8
158	9	5
159	54	6
160	36	6
161	1	3
162	91	8
163	87	1
164	29	4
165	3	5
166	16	5
167	74	5
168	89	6
169	41	3
170	93	2
171	88	2
172	41	8
173	75	8
174	100	2
175	7	1
176	80	5
177	45	6
178	14	4
179	21	8
180	29	8
181	35	4
182	47	4
183	44	7
184	81	7
185	52	7
186	61	8
187	95	7
188	41	2
189	75	4
190	6	2
191	70	5
192	41	5
193	68	6
194	58	5
195	69	2
196	38	3
197	88	3
198	8	1
199	56	1
200	68	7
201	98	4
202	8	4
203	36	2
204	9	2
205	88	5
206	44	4
207	26	1
208	32	4
209	92	8
210	9	8
211	94	3
212	81	6
213	91	2
214	16	3
215	63	6
216	96	7
217	4	3
218	26	5
219	100	7
220	7	6
221	57	3
222	8	8
223	81	3
224	61	1
225	69	1
226	7	1
227	83	2
228	36	1
229	12	1
230	44	8
231	22	5
232	15	1
233	86	7
234	42	3
235	12	4
236	9	2
237	50	3
238	16	8
239	15	5
240	44	3
241	70	5
242	90	7
243	39	4
244	6	5
245	60	1
246	30	5
247	55	4
248	81	1
249	35	4
250	11	8
251	7	2
252	56	6
253	34	7
254	75	4
255	81	7
256	16	3
257	56	3
258	92	8
259	29	8
260	95	3
261	12	6
262	69	8
263	89	8
264	40	8
265	35	7
266	14	6
267	80	2
268	43	4
269	99	8
270	83	6
271	77	8
272	43	1
273	58	8
274	60	3
275	96	2
276	69	8
277	62	1
278	92	2
279	84	4
280	35	6
281	8	1
282	33	2
283	84	6
284	55	3
285	32	7
286	36	5
287	90	3
288	28	4
289	31	3
290	52	2
291	83	3
292	44	4
293	3	1
294	50	4
295	51	8
296	54	3
297	49	7
298	25	6
299	58	5
300	64	6
302	67	5
303	3	6
304	100	1
305	87	5
306	57	1
307	70	6
308	52	8
309	60	5
310	6	4
311	18	6
312	26	3
313	86	6
314	40	2
315	33	3
316	45	6
317	9	4
318	57	8
319	102	1
320	66	5
321	43	6
322	36	5
323	103	8
324	48	7
325	67	7
326	22	5
327	92	4
328	21	7
329	27	6
330	96	5
331	91	4
332	29	6
333	85	3
334	26	1
335	64	2
336	15	2
337	51	1
338	78	4
339	86	6
340	80	5
341	78	7
342	67	6
343	46	6
344	47	6
345	68	5
346	55	6
347	15	4
348	14	4
349	73	8
350	55	5
351	14	4
352	52	6
353	14	4
354	1	1
355	68	8
356	27	2
357	77	4
358	92	1
359	60	7
360	4	8
361	4	1
362	63	6
363	72	3
364	7	6
365	90	6
366	2	5
367	7	5
368	17	4
369	36	1
370	101	4
371	7	1
372	78	5
373	6	7
374	42	5
375	14	5
376	31	7
377	79	6
378	29	2
379	77	4
380	98	2
381	41	5
382	60	2
383	91	8
384	56	7
385	2	1
386	30	8
387	28	7
388	23	8
389	36	2
390	61	2
391	48	2
392	98	2
393	5	4
394	24	7
395	69	5
396	73	4
397	99	1
398	74	7
399	48	2
400	7	8
401	4	4
407	97	4
408	5	4
\.


--
-- TOC entry 3155 (class 0 OID 58209)
-- Dependencies: 253
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultas (idconsulta, notasconsulta, costoconsulta, fechaconsulta, horaconsulta, idcausaconsulta) FROM stdin;
2	Nam nulla magna,	0.00	2021-10-11	\N	1
3	eu	0.00	2021-03-15	\N	3
4	Integer aliquam adipiscing	0.00	2021-12-10	\N	1
5	diam. Sed diam	0.00	2022-01-28	\N	1
6	imperdiet ullamcorper. Duis	0.00	2022-02-17	\N	4
7	consectetuer adipiscing	0.00	2021-01-14	\N	4
8	nibh	0.00	2021-09-30	\N	4
9	ligula consectetuer	0.00	2021-04-12	\N	4
10	lectus quis massa.	0.00	2021-07-26	\N	4
11	laoreet,	0.00	2021-10-26	\N	1
12	nunc	0.00	2021-01-24	\N	4
13	lorem, luctus	0.00	2021-11-11	\N	4
14	ut lacus.	0.00	2021-02-03	\N	2
15	pede blandit	0.00	2021-08-27	\N	3
16	mattis semper, dui	0.00	2021-09-24	\N	1
17	Nam	0.00	2021-04-16	\N	3
18	ultrices. Vivamus rhoncus.	0.00	2021-04-07	\N	3
19	arcu	0.00	2021-08-27	\N	4
20	eleifend vitae,	0.00	2021-04-08	\N	1
21	Phasellus	0.00	2021-01-09	\N	4
22	Nulla	0.00	2021-10-12	\N	2
23	Sed	0.00	2021-11-06	\N	4
24	lacus.	0.00	2021-12-17	\N	2
25	quis, pede. Praesent	0.00	2022-02-14	\N	1
26	quis turpis vitae	0.00	2021-09-14	\N	3
27	faucibus orci luctus	0.00	2021-02-26	\N	4
28	turpis	0.00	2021-12-27	\N	1
29	fermentum	0.00	2022-01-30	\N	3
30	sem mollis	0.00	2021-08-06	\N	4
31	eu arcu. Morbi	0.00	2021-02-03	\N	1
32	primis	0.00	2022-01-17	\N	4
33	nascetur ridiculus	0.00	2021-06-08	\N	1
34	urna. Vivamus	0.00	2021-10-31	\N	3
35	Praesent	0.00	2021-12-08	\N	1
36	est	0.00	2021-07-10	\N	4
37	vehicula.	0.00	2021-11-18	\N	4
38	blandit mattis. Cras	0.00	2022-02-25	\N	4
39	Proin non	0.00	2021-03-07	\N	2
40	habitant morbi tristique	0.00	2021-12-25	\N	4
41	Nunc commodo	0.00	2021-03-27	\N	3
42	dolor. Fusce	0.00	2021-07-02	\N	1
43	massa. Quisque porttitor	0.00	2021-03-24	\N	2
44	tortor. Nunc commodo	0.00	2021-04-01	\N	1
45	Pellentesque	0.00	2021-01-19	\N	4
46	ac mi	0.00	2021-06-02	\N	3
47	netus	0.00	2021-08-30	\N	3
48	in	0.00	2021-10-22	\N	1
49	consequat,	0.00	2021-06-13	\N	4
50	penatibus et magnis	0.00	2021-09-15	\N	1
51	ipsum. Phasellus vitae	0.00	2021-10-08	\N	2
52	gravida sit amet,	0.00	2021-12-19	\N	3
53	lorem	0.00	2021-01-21	\N	4
54	Suspendisse ac metus	0.00	2021-09-13	\N	4
55	sit	0.00	2021-05-16	\N	4
56	justo.	0.00	2022-01-16	\N	1
57	urna convallis	0.00	2022-01-02	\N	2
58	elementum sem, vitae	0.00	2021-06-27	\N	4
59	fringilla ornare placerat,	0.00	2021-05-05	\N	2
60	sapien. Cras	0.00	2021-11-14	\N	2
61	mauris elit,	0.00	2021-08-01	\N	1
62	ullamcorper eu, euismod	0.00	2021-12-22	\N	1
63	enim. Suspendisse	0.00	2021-11-21	\N	4
64	in consectetuer	0.00	2021-09-15	\N	4
65	elementum	0.00	2021-09-10	\N	2
66	Donec nibh	0.00	2022-01-17	\N	2
67	eu, ligula. Aenean	0.00	2021-11-06	\N	1
68	in,	0.00	2021-08-27	\N	4
69	Donec sollicitudin	0.00	2021-05-21	\N	4
70	non lorem	0.00	2022-01-08	\N	3
71	elementum, lorem ut	0.00	2021-07-13	\N	2
72	lorem vitae odio	0.00	2021-07-29	\N	4
73	leo elementum	0.00	2021-11-07	\N	3
74	risus. Morbi metus.	0.00	2021-06-07	\N	1
75	ac, fermentum	0.00	2021-07-24	\N	3
76	luctus lobortis.	0.00	2022-01-09	\N	1
77	dolor,	0.00	2021-05-11	\N	1
78	eu odio	0.00	2021-01-29	\N	4
79	nec ligula consectetuer	0.00	2021-03-09	\N	3
80	faucibus orci luctus	0.00	2022-02-05	\N	1
81	orci tincidunt adipiscing.	0.00	2021-07-20	\N	1
82	gravida sit amet,	0.00	2021-10-26	\N	4
83	sociis natoque penatibus	0.00	2021-12-14	\N	1
84	pede.	0.00	2021-08-16	\N	4
85	sapien,	0.00	2021-08-24	\N	3
86	vitae	0.00	2021-03-31	\N	1
87	neque. Morbi	0.00	2021-07-22	\N	1
88	gravida non,	0.00	2021-02-12	\N	3
89	a felis	0.00	2021-05-26	\N	1
90	Curabitur	0.00	2021-06-07	\N	4
91	morbi	0.00	2021-12-19	\N	2
92	euismod	0.00	2021-11-25	\N	1
93	eleifend, nunc	0.00	2021-02-02	\N	3
94	turpis vitae purus	0.00	2021-01-22	\N	2
95	mollis vitae, posuere	0.00	2021-08-22	\N	2
96	nascetur	0.00	2021-12-05	\N	2
98	orci.	0.00	2021-09-09	\N	1
99	sed	0.00	2021-09-21	\N	3
100	egestas nunc sed	0.00	2021-06-19	\N	2
101	asdasd	0.01	2021-06-09	18:26:00	3
1	Curabitur vel lectus.	0.01	2021-03-14	20:09:00	1
97	Aliquam nec	25.00	2021-07-03	\N	1
\.


--
-- TOC entry 3122 (class 0 OID 50593)
-- Dependencies: 220
-- Data for Name: doctores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctores (iddoctor, nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor, correodoctor, fotodoctor, aliasdoctor, clavedoctor, idestadodoctor) FROM stdin;
1	Hasad	Richards	303-2329 Malesuada Rd.	6291-8778	Phasellus@dolorDonecfringilla.org	\N	egestas.	KFU86ZIT8TK	2
2	Kelly	Mccarthy	Ap #343-2698 Vel Road	2760-4821	Donec@interdumfeugiat.org	\N	tristique	GYM17KCP4ZL	2
3	Charles	Kinney	8080 Vulputate St.	8814-7185	eget.magna.Suspendisse@enimmitempor.ca	\N	id	NDQ16EPT7BN	2
4	Galena	Rios	P.O. Box 635, 9127 Tempor Rd.	7971-8041	metus@malesuada.net	\N	tellus	WIE80FSV5PQ	2
5	Ingrid	Ferguson	Ap #695-4446 Velit. Road	5823-6821	diam.Pellentesque.habitant@nullaInteger.edu	\N	lorem	HJM13IPZ4BD	2
6	Reese	Cobb	Ap #452-3245 Neque Rd.	3559-3765	eu.tellus@nibh.org	\N	justo	KKZ33AKF1FI	1
7	Boris	Mccarty	8739 Morbi Ave	6106-1424	consectetuer@adipiscing.edu	\N	adipiscing	UDQ34OOG9GV	1
8	Valentine	Sweet	131 At Rd.	1892-1977	orci.Donec@egestasAliquam.net	\N	mollis	EEL05MGR7HU	1
9	Silas	Hooper	Ap #674-2978 Porttitor Rd.	3868-9717	ut.quam.vel@fringilla.com	\N	ac,	KDI50FYZ8NW	1
10	Alexa	Schneider	162 Nibh Av.	4002-8872	fringilla.purus.mauris@vitaeerat.co.uk	\N	malesuada	AKS71MCU7ZX	2
11	Odette	Mason	Ap #694-9352 Vehicula. St.	5882-5648	urna@Quisquenonummyipsum.edu	\N	enim	SDK30XQI1UC	2
12	Unity	Alvarez	888-1338 Duis Rd.	1917-3814	Donec.nibh.enim@nonummyacfeugiat.com	\N	suscipit	QFM95DNU0KP	1
13	Lucius	Church	182-6745 In Rd.	9055-2342	ridiculus.mus@loremacrisus.ca	\N	dolor	WLQ05LQP3VO	2
14	Finn	Nash	P.O. Box 697, 4290 In Av.	4464-7979	vel.est.tempor@venenatis.org	\N	eu	EWE72OVR3ZD	1
15	Shea	Hicks	3505 Integer Av.	6173-3558	lectus@malesuadaid.org	\N	et,	RVF22YXL2VS	2
16	Jasmine	Davidson	362-2662 Odio. Rd.	2786-0003	a@arcuiaculisenim.net	\N	mollis	CUL13UJT3ZK	1
17	Freya	Lucas	Ap #451-5333 At Ave	3589-0886	bibendum.ullamcorper@duinectempus.edu	\N	mauris	JOH52KRZ6XQ	1
18	Quincy	Hutchinson	Ap #131-5671 Pede. St.	9498-2153	odio@Crasvulputatevelit.ca	\N	metus.	LBO48OZQ2UR	1
19	Karina	Hawkins	9307 Accumsan Rd.	9084-4979	nisi.nibh.lacinia@eliterat.com	\N	amet	ZXH85RBG7PH	2
20	Wylie	Mullins	Ap #442-7647 Neque. Ave	2235-0450	et.tristique@Phasellusfermentumconvallis.edu	\N	cursus	ORY59XWI0RM	2
21	Aimee	Carr	503-4172 Vitae Rd.	8634-6346	auctor@nonjustoProin.ca	\N	molestie.	HJV42XQD5HJ	2
22	Mason	Walker	P.O. Box 152, 4774 At Rd.	8792-8294	Nam.ac.nulla@vitaerisus.ca	\N	tristique	GSN76EKN2OA	1
23	Hiroko	Cochran	871-293 Massa. St.	5256-8041	Donec@ipsumnon.org	\N	libero	YNQ69RLN4ZL	2
24	Lucian	Becker	P.O. Box 173, 7899 Erat, Street	9847-5967	in@nibh.net	\N	vel	LBG92EQX8PX	1
25	Declan	Weeks	P.O. Box 320, 7336 Ut St.	2995-7873	erat.eget@tortor.co.uk	\N	sagittis.	YMH83MCM6CB	1
26	Shay	Galloway	6626 Mauris Rd.	5696-6254	luctus.Curabitur.egestas@lacus.co.uk	\N	ipsum	DGT73NLB8AE	2
27	Maia	Wade	639-1270 A Avenue	0792-8525	nibh@ProindolorNulla.ca	\N	augue	YPY02AES8IY	2
28	Vivien	Morris	Ap #663-9690 Integer Rd.	6459-8035	ligula.elit.pretium@egestaslaciniaSed.ca	\N	In	SKT30IFM9RX	1
29	Harrison	Potts	302-7187 Tempor, Rd.	9277-8524	magna.sed.dui@Proinsedturpis.com	\N	purus.	TRK67RAF0NY	1
30	Casey	Russell	P.O. Box 379, 5114 Dis Street	4894-3862	sagittis@nonummyFuscefermentum.com	\N	pretium	CTY51ARB5NH	1
31	Ariana	Hancock	433 Ullamcorper, St.	7974-9151	montes@lacusEtiam.ca	\N	amet,	HRS69AQW0WY	1
32	Abbot	Murphy	Ap #714-149 Diam Street	0652-5301	metus.Aenean.sed@dignissim.org	\N	amet	EQK25HXS1QS	2
33	Akeem	Dawson	P.O. Box 826, 5313 Auctor. Road	9212-0342	leo@eudui.net	\N	nisi	IWE10WEQ8WQ	2
34	Harding	Alvarado	P.O. Box 482, 1569 Ornare, St.	5809-2256	Sed.congue.elit@aliquetnecimperdiet.net	\N	justo	CHM88GMF5MF	1
35	Aspen	Conrad	594-3308 Ut Street	9312-2530	varius.et.euismod@sed.net	\N	ac	PYK41UYC8AR	2
36	Charissa	Kim	2010 Turpis Avenue	8212-6032	nisl@semNullainterdum.ca	\N	malesuada	BNV85BYU8UM	1
37	Jessica	Peck	4844 Et, St.	5908-1349	arcu.Nunc@eleifend.co.uk	\N	nec	XRJ96LYC0DG	2
38	Anthony	Murphy	5841 Mauris, St.	3741-0218	lectus@convallisconvallis.ca	\N	orci	MBA21MKP1GJ	2
39	Yardley	Terrell	P.O. Box 637, 5741 Fringilla Street	2417-4964	semper@luctus.org	\N	amet	OTV01ATB7FX	1
40	Whilemina	Sheppard	P.O. Box 570, 2593 Sociosqu Ave	2979-8492	tempor@acrisus.ca	\N	lectus	XCU01JRH6SL	2
41	Patricia	Ramirez	939 Quam. Ave	4734-5900	tincidunt.aliquam@parturientmontesnascetur.ca	\N	Nunc	ZXD23NZS4UD	2
42	Adam	Vaughn	1167 Commodo Ave	7016-0127	ut.nulla.Cras@quamPellentesque.com	\N	id,	ODA48BLR2ZK	1
43	Karen	Benton	589-6668 Et, Street	0195-7859	semper.auctor@vitae.edu	\N	Proin	YZK13HHE1YY	1
44	Keely	Strong	5285 At Road	3874-8973	luctus.et@ut.com	\N	habitant	RMF13QRX7AQ	2
45	Mufutau	Sharp	523-6850 Ante. Av.	3101-8308	in.dolor.Fusce@ullamcorper.edu	\N	fringilla	ILS37ROD0RZ	2
46	Berk	Vega	P.O. Box 872, 7519 Integer Street	3057-1893	Duis@vulputaterisus.ca	\N	Aliquam	YVL43GNG1UP	1
47	Ross	Benjamin	898-8984 Morbi St.	6907-2731	turpis.nec.mauris@ligula.co.uk	\N	suscipit	SIX13RYJ4RF	1
48	Connor	Lloyd	Ap #802-9150 Eu Rd.	7883-8308	lectus.Nullam.suscipit@iderat.com	\N	felis,	OCU27DUC5KC	2
49	Cade	Nicholson	2446 Sed Street	9188-4182	aliquet.metus@consectetuer.ca	\N	Fusce	KMG44DJU1EA	1
50	Eugenia	Long	Ap #998-1659 Cras Av.	0842-8733	posuere.at.velit@nunc.net	\N	adipiscing	PRC52VAK4HG	2
51	Barry	Sargent	Ap #458-3813 Tellus St.	2694-8922	Phasellus.libero.mauris@eget.ca	\N	vel	RHB55ZXL5AG	2
52	Anika	Warner	P.O. Box 943, 6949 Proin Rd.	1765-3700	lorem.eget.mollis@rhoncusNullam.org	\N	et	VPT82BTA4JP	2
53	Quinn	Baxter	P.O. Box 628, 9544 Sit Road	5149-7686	Phasellus.dapibus.quam@ornarelectus.edu	\N	lobortis	DXF57FYW7XY	2
54	Iris	Velasquez	P.O. Box 442, 3541 Lorem Rd.	6134-2365	eu.tellus.Phasellus@eusem.co.uk	\N	lorem	ANI95BLE4AN	1
55	Cailin	Chase	Ap #647-3126 Ornare Av.	2407-6458	pede.blandit@eteuismod.net	\N	eu,	FMA28LJP3XR	2
56	Grant	Hoffman	Ap #886-4567 Lectus, Av.	2602-5751	auctor@pellentesquemassa.edu	\N	neque	REX50CPB4HD	1
57	Darrel	Fields	857-8013 Et St.	5890-7769	molestie@actellusSuspendisse.co.uk	\N	dui,	BRR28YFC6CV	2
58	Erasmus	Rosa	481-2162 Urna. Rd.	8808-9010	dolor@in.org	\N	ante.	XDU34IBF7ZU	1
59	Hunter	Miller	P.O. Box 150, 1731 Nulla. Avenue	1109-7403	sodales.nisi.magna@Fuscediamnunc.ca	\N	montes,	ZRO15OBD8DR	1
60	Cadman	Albert	750-2199 Augue Rd.	2033-4459	leo.Vivamus@a.com	\N	purus	HWR67QSR2YX	2
61	Mannix	Callahan	Ap #933-1940 Nunc St.	9392-9336	In@a.org	\N	enim	ZYV52BND4PU	1
62	Alfreda	Golden	Ap #150-3082 Suspendisse Av.	1440-4572	nonummy.ipsum@Donecatarcu.ca	\N	In	NBP67MMW7AI	2
63	Keiko	Stephenson	Ap #266-4982 Vitae Avenue	9583-0930	orci@velitegetlaoreet.edu	\N	sociosqu	HCG64WCZ3KL	1
64	Hasad	Barlow	2834 Nunc Street	4578-7215	accumsan.neque.et@pharetra.ca	\N	vitae	MRB94SUS2ZE	1
65	Zephania	Landry	Ap #987-7959 Hendrerit Rd.	9127-7174	metus@Aeneansedpede.co.uk	\N	eu	UAW05FRL5SJ	1
66	Glenna	Clark	556-8701 Mollis. St.	7028-3427	accumsan@Nullamsuscipitest.edu	\N	mollis	ECX98OXV2BK	1
67	Sonya	George	6594 Lorem, St.	1524-5244	magna.tellus@Sedet.ca	\N	luctus,	UUP33HPX2XB	1
68	Brandon	Mason	Ap #478-251 Laoreet, Av.	3181-3973	amet@nuncinterdum.net	\N	tincidunt	UAG45NZI9PX	1
69	Anthony	Woods	Ap #889-2387 Amet Rd.	5330-8678	Cras.vulputate@acnulla.edu	\N	dolor	APX40CAC7SX	2
70	India	Downs	P.O. Box 338, 8802 Sagittis Rd.	6995-8555	semper.erat.in@magnisdis.com	\N	Donec	FXF87MLN7JT	2
71	Samson	Roberson	Ap #631-4617 Elit Ave	2802-9745	a.tortor.Nunc@dis.org	\N	egestas.	NOR39ULC0DR	1
72	Joy	Dorsey	Ap #148-4450 Auctor Av.	5882-5103	augue@ligulaeu.co.uk	\N	hymenaeos.	JPZ89MSA1ZQ	2
73	Chase	Lane	Ap #307-1804 Metus Ave	1105-0320	Nulla.aliquet.Proin@ornaresagittis.net	\N	dictum	HVQ16YVN3WZ	2
74	Sacha	Gutierrez	2277 Morbi Street	8890-3919	taciti.sociosqu.ad@imperdietullamcorperDuis.org	\N	ante	AIS85WVT1NU	1
75	Xavier	Britt	Ap #982-9188 Sed Av.	2100-6401	Cras.vehicula@urnaNunc.co.uk	\N	blandit	URB67OHK8LK	2
76	Sydney	Cervantes	P.O. Box 729, 8047 Lacus. Avenue	1196-5152	erat.volutpat@suscipitnonummyFusce.com	\N	et,	ZWO51GPD1DH	2
77	Brady	Hanson	Ap #121-1575 Mauris St.	9248-6524	non.lacinia.at@cursuset.co.uk	\N	parturient	QFJ50XEC0TI	1
78	Anne	Craft	Ap #772-6131 Vulputate, Rd.	5011-5922	sem.ut.dolor@lacus.org	\N	velit	AZQ69HBK9BN	2
79	Ali	Acosta	Ap #820-4232 Nec Road	3808-3280	fringilla@enimcondimentumeget.net	\N	nunc	HCN43UIE1ZZ	1
80	Debra	Holcomb	9406 Congue, Rd.	3487-1448	vitae.aliquam@dictumultricies.com	\N	Duis	ITD39OMK5VG	1
81	Macey	Baker	525-182 Interdum. Street	7414-3296	lacinia.mattis@aliquetmagna.ca	\N	mus.	YQL68EFK4KT	2
82	Reed	Francis	P.O. Box 211, 6989 Quisque Avenue	9824-4180	tortor.Integer.aliquam@maurisaliquameu.org	\N	elementum	NCB12PYA1VK	1
83	Lila	Brock	3940 In, Av.	0138-9042	amet.risus.Donec@Naminterdum.edu	\N	massa.	AVO34YRV2BC	1
84	Blaine	Valdez	246-2358 Massa. St.	6768-0217	Aliquam.vulputate.ullamcorper@egestas.ca	\N	id	OUW69EGF3TC	1
85	Venus	Bender	Ap #175-9832 Aenean Rd.	6464-7271	Donec@Etiam.com	\N	id	TFI00DYU3QA	1
86	Linus	Stevens	856-9547 Nisi. Avenue	3650-8416	aliquet.magna@diamat.edu	\N	diam.	PQD27RQS9RK	2
87	Hannah	Byers	948-570 Vel Rd.	2820-9251	dolor.nonummy.ac@blanditmattis.net	\N	Nullam	NVJ75EGQ7XL	1
88	Yuli	Stout	P.O. Box 127, 2903 Vitae St.	1441-5345	lobortis.tellus.justo@Aliquamtincidunt.edu	\N	tellus	NRS26BYR0ER	1
89	Oliver	Hoffman	670 Curabitur Rd.	6965-9276	leo@Nulla.co.uk	\N	Nullam	MUN71JJQ8UC	2
90	Lars	Everett	Ap #119-8658 Lorem Ave	4057-6696	risus.odio@liberoProinmi.ca	\N	In	QDU31ZDB4RG	2
91	Liberty	Sellers	948-3915 Aliquam, Road	2288-1867	tincidunt.dui@cursus.org	\N	urna.	ORX34NOQ4FA	2
92	Ariana	Fowler	P.O. Box 100, 8315 Nam Avenue	0513-9014	pharetra.Nam@eu.org	\N	ut	XVJ93XZC9XU	1
93	Bert	Aguilar	6266 Fermentum Avenue	0681-3771	at.arcu.Vestibulum@quispedeSuspendisse.ca	\N	ante.	QXS31YIE6KH	2
94	Martena	Schmidt	6348 Proin Rd.	9251-4325	Nulla@liberoduinec.co.uk	\N	inceptos	BPH87MHW5IU	1
95	Anika	Pratt	P.O. Box 414, 1115 Lorem Av.	9938-7292	eu@augueidante.ca	\N	vehicula.	VCN11XFB5XO	1
96	Malcolm	Hester	5758 Sed Street	6487-6232	vitae@eutelluseu.com	\N	odio	WWR21WCI6XM	1
97	Tanek	Rasmussen	Ap #933-1036 Odio, St.	4621-5687	non.hendrerit@augueutlacus.ca	\N	Nunc	VCX32KIS6DL	2
98	Damon	Schultz	120-4278 Suspendisse Av.	4358-7975	non.dapibus@euplacerat.org	\N	posuere	OGC00SQG0UG	1
99	Peter	Workman	4312 Amet Av.	1566-9933	libero@rhoncusidmollis.net	\N	ipsum	QQJ37YOU3XA	1
100	India	Parker	Ap #985-1700 Mollis Av.	4884-9094	euismod@dapibus.com	\N	consectetuer	HHD51GNT7AR	1
\.


--
-- TOC entry 3120 (class 0 OID 50586)
-- Dependencies: 218
-- Data for Name: especialidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especialidad (idespecialidad, especialidad) FROM stdin;
1	Periodontologo
2	Endodoncista
3	Ortodoncista
4	Cariologo
5	Odontopediatria
6	Implantología
7	Odontología Estetica
8	Blanqueamiento Dental
9	Tratamiento sin Metal
\.


--
-- TOC entry 3124 (class 0 OID 50606)
-- Dependencies: 222
-- Data for Name: especialidaddoctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especialidaddoctor (idespecialidaddoctor, iddoctor, idespecialidad) FROM stdin;
1	55	8
2	65	4
3	48	2
4	24	6
5	84	7
6	65	5
7	23	9
8	7	7
9	50	4
10	16	4
11	6	5
12	99	1
13	4	3
14	43	4
15	98	7
16	71	3
17	15	8
18	45	2
19	51	9
20	95	7
21	2	6
22	79	1
23	42	7
24	99	8
25	27	2
26	78	3
27	8	1
28	8	3
29	68	6
30	70	9
31	60	4
32	96	8
33	3	6
34	75	5
35	47	1
36	58	6
37	100	8
38	5	9
39	51	4
40	70	5
41	31	3
42	76	4
43	16	3
44	97	1
45	22	3
46	47	1
47	17	8
48	37	8
49	22	2
50	91	3
51	84	7
52	53	9
53	17	3
54	24	8
55	90	3
56	32	3
57	90	4
58	89	8
59	82	3
60	69	2
61	88	5
62	39	9
63	69	2
64	66	4
65	35	4
66	38	3
67	94	8
68	69	4
69	43	4
70	75	2
71	63	5
72	92	1
73	51	8
74	14	9
75	30	8
76	2	4
77	13	3
78	93	9
79	21	7
80	82	5
81	42	9
82	73	8
83	78	7
84	33	6
85	2	7
86	40	4
87	34	2
88	19	8
89	92	8
90	90	6
91	23	2
92	86	3
93	12	6
94	9	4
95	87	6
96	93	9
97	88	4
98	58	7
99	11	1
100	32	1
\.


--
-- TOC entry 3119 (class 0 OID 50580)
-- Dependencies: 217
-- Data for Name: estadodoctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadodoctor (idestadodoctor, estadodoctor) FROM stdin;
1	Activo
2	Inactivo
\.


--
-- TOC entry 3113 (class 0 OID 50513)
-- Dependencies: 211
-- Data for Name: estadopaciente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadopaciente (idestadopaciente, estadopaciente) FROM stdin;
1	Activo
2	Inactivo
\.


--
-- TOC entry 3145 (class 0 OID 50765)
-- Dependencies: 243
-- Data for Name: estadopago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadopago (idestadopago, estadopago) FROM stdin;
1	En Proceso
2	Finalizado
3	Suspendido
\.


--
-- TOC entry 3132 (class 0 OID 50663)
-- Dependencies: 230
-- Data for Name: estadotratamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadotratamiento (idestadotratamiento, estadotratamiento) FROM stdin;
1	En Proceso
2	Finalizado
3	Suspendido
\.


--
-- TOC entry 3107 (class 0 OID 50479)
-- Dependencies: 205
-- Data for Name: estadousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadousuario (idestadousuario, estadousuario) FROM stdin;
1	Habilitado
2	Deshabilitado
\.


--
-- TOC entry 3117 (class 0 OID 50564)
-- Dependencies: 215
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expedientes (idexpediente, notasmedicas, odontograma, periodontograma, observacionesperiodontograma, idpaciente) FROM stdin;
1	semper tellus id nunc interdum feugiat. Sed nec metus facilisis	\N	\N	arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim.	1
2	semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices	\N	\N	vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur	2
3	pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod	\N	\N	hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim.	3
4	elit elit fermentum risus, at fringilla purus mauris a nunc.	\N	\N	Donec non justo. Proin non massa non ante bibendum ullamcorper.	4
5	vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce	\N	\N	Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate,	5
6	facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus	\N	\N	adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor	6
7	magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu	\N	\N	eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis	7
8	Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales purus,	\N	\N	ipsum primis in faucibus orci luctus et ultrices posuere cubilia	8
9	quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque	\N	\N	vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy	9
10	ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci	\N	\N	purus. Maecenas libero est, congue a, aliquet vel, vulputate eu,	10
11	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis	\N	\N	mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris	11
12	ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat	\N	\N	ipsum leo elementum sem, vitae aliquam eros turpis non enim.	12
13	lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod	\N	\N	lectus convallis est, vitae sodales nisi magna sed dui. Fusce	13
14	sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci	\N	\N	luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc	14
15	aptent taciti sociosqu ad litora torquent per conubia nostra, per	\N	\N	massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit	15
16	hendrerit neque. In ornare sagittis felis. Donec tempor, est ac	\N	\N	nunc. Quisque ornare tortor at risus. Nunc ac sem ut	16
17	sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra,	\N	\N	consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim	17
18	vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum dolor	\N	\N	neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc	18
19	erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse	\N	\N	eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat	19
20	ante ipsum primis in faucibus orci luctus et ultrices posuere	\N	\N	sagittis augue, eu tempor erat neque non quam. Pellentesque habitant	20
21	nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor	\N	\N	urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim.	21
22	tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam	\N	\N	orci, in consequat enim diam vel arcu. Curabitur ut odio	22
23	nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis	\N	\N	Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut	23
24	ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci	\N	\N	arcu. Vestibulum ante ipsum primis in faucibus orci luctus et	24
25	lorem, eget mollis lectus pede et risus. Quisque libero lacus,	\N	\N	amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor	25
26	mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin	\N	\N	Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit	26
27	sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra,	\N	\N	parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique	27
28	In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum	\N	\N	mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida	28
29	amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus.	\N	\N	euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget	29
30	dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus	\N	\N	sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue	30
31	lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante	\N	\N	Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat.	31
32	Donec at arcu. Vestibulum ante ipsum primis in faucibus orci	\N	\N	Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus	32
33	nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris	\N	\N	ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam	33
34	varius et, euismod et, commodo at, libero. Morbi accumsan laoreet	\N	\N	nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras	34
35	Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis	\N	\N	Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non,	35
36	eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut	\N	\N	imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at	36
37	odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa.	\N	\N	per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel	37
38	ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat	\N	\N	vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue	38
39	quis, pede. Praesent eu dui. Cum sociis natoque penatibus et	\N	\N	Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi	39
40	eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis	\N	\N	Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.	40
41	ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,	\N	\N	Mauris blandit enim consequat purus. Maecenas libero est, congue a,	41
42	Nulla semper tellus id nunc interdum feugiat. Sed nec metus	\N	\N	Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut	42
43	Ut tincidunt vehicula risus. Nulla eget metus eu erat semper	\N	\N	rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed,	43
44	vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie	\N	\N	nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis	44
45	ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam	\N	\N	Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh	45
46	odio. Phasellus at augue id ante dictum cursus. Nunc mauris	\N	\N	enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.	46
47	vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie	\N	\N	purus mauris a nunc. In at pede. Cras vulputate velit	47
48	vel est tempor bibendum. Donec felis orci, adipiscing non, luctus	\N	\N	et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat,	48
49	malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam	\N	\N	augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed,	49
50	consequat, lectus sit amet luctus vulputate, nisi sem semper erat,	\N	\N	facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo	50
51	amet ultricies sem magna nec quam. Curabitur vel lectus. Cum	\N	\N	placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna	51
52	nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus	\N	\N	scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed	52
53	lectus sit amet luctus vulputate, nisi sem semper erat, in	\N	\N	Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,	53
54	Donec feugiat metus sit amet ante. Vivamus non lorem vitae	\N	\N	tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id,	54
55	eget nisi dictum augue malesuada malesuada. Integer id magna et	\N	\N	tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet,	55
56	Donec at arcu. Vestibulum ante ipsum primis in faucibus orci	\N	\N	vitae risus. Duis a mi fringilla mi lacinia mattis. Integer	56
57	dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et	\N	\N	adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	57
58	arcu eu odio tristique pharetra. Quisque ac libero nec ligula	\N	\N	sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque	58
59	porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris	\N	\N	id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque	59
60	Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.	\N	\N	ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt	60
61	cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam	\N	\N	nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque	61
62	Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla.	\N	\N	amet, risus. Donec nibh enim, gravida sit amet, dapibus id,	62
63	Donec tincidunt. Donec vitae erat vel pede blandit congue. In	\N	\N	nunc. Quisque ornare tortor at risus. Nunc ac sem ut	63
64	Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,	\N	\N	nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce	64
65	semper pretium neque. Morbi quis urna. Nunc quis arcu vel	\N	\N	et tristique pellentesque, tellus sem mollis dui, in sodales elit	65
66	lacus pede sagittis augue, eu tempor erat neque non quam.	\N	\N	Pellentesque habitant morbi tristique senectus et netus et malesuada fames	66
67	pede. Praesent eu dui. Cum sociis natoque penatibus et magnis	\N	\N	dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum	67
68	ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam	\N	\N	sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut	68
69	Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non,	\N	\N	dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus	69
70	turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis	\N	\N	Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est.	70
71	enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.	\N	\N	mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id	71
72	ac turpis egestas. Fusce aliquet magna a neque. Nullam ut	\N	\N	netus et malesuada fames ac turpis egestas. Fusce aliquet magna	72
73	et netus et malesuada fames ac turpis egestas. Aliquam fringilla	\N	\N	vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante.	73
74	Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus.	\N	\N	cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit	74
75	in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla	\N	\N	nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo	75
76	aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend	\N	\N	odio a purus. Duis elementum, dui quis accumsan convallis, ante	76
77	facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc	\N	\N	odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam	77
78	Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit,	\N	\N	mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae,	78
79	amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus	\N	\N	Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus	79
80	nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat.	\N	\N	arcu iaculis enim, sit amet ornare lectus justo eu arcu.	80
81	mi lorem, vehicula et, rutrum eu, ultrices sit amet, risus.	\N	\N	fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin	81
82	nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus	\N	\N	Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque	82
83	lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate	\N	\N	ut nisi a odio semper cursus. Integer mollis. Integer tincidunt	83
84	feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam	\N	\N	nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque	84
85	lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet	\N	\N	lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis	85
86	malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit.	\N	\N	Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie	86
87	enim. Nunc ut erat. Sed nunc est, mollis non, cursus	\N	\N	Proin non massa non ante bibendum ullamcorper. Duis cursus, diam	87
88	sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam	\N	\N	massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero.	88
89	malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna.	\N	\N	neque. Nullam ut nisi a odio semper cursus. Integer mollis.	89
90	ut, nulla. Cras eu tellus eu augue porttitor interdum. Sed	\N	\N	tellus eu augue porttitor interdum. Sed auctor odio a purus.	90
91	Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra.	\N	\N	Donec at arcu. Vestibulum ante ipsum primis in faucibus orci	91
92	parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor.	\N	\N	egestas hendrerit neque. In ornare sagittis felis. Donec tempor, est	92
93	est, congue a, aliquet vel, vulputate eu, odio. Phasellus at	\N	\N	Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue	93
94	elit, a feugiat tellus lorem eu metus. In lorem. Donec	\N	\N	mattis ornare, lectus ante dictum mi, ac mattis velit justo	94
95	vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet	\N	\N	porttitor tellus non magna. Nam ligula elit, pretium et, rutrum	95
96	Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum eu,	\N	\N	risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non	96
97	Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum	\N	\N	lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis	97
98	in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus	\N	\N	suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis	98
99	nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet	\N	\N	vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy	99
100	Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue.	\N	\N	mollis lectus pede et risus. Quisque libero lacus, varius et,	100
\.


--
-- TOC entry 3149 (class 0 OID 50795)
-- Dependencies: 247
-- Data for Name: historialpagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historialpagos (idhistorial, nombrepaciente, fecharegistro, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, tipopago) FROM stdin;
445	Gemma Benson	2021-07-07 14:47:25.99202	206.41	0.00	206.41	0.00	2	1
446	Gemma Benson	2021-07-07 14:48:01.771234	-0.02	206.43	206.41	-0.02	2	1
447	Gemma Benson	2021-07-07 14:48:01.771234	0.00	206.43	206.41	0.00	2	1
448	Gemma Benson	2021-07-07 14:48:01.771234	0.00	206.43	206.41	0.00	2	1
439	Rhiannon Hood	2021-07-07 14:05:03.268283	388.09	0.00	388.09	0.00	1	2
440	Rhiannon Hood	2021-07-07 14:05:03.268283	337.64	50.45	388.09	337.64	1	2
441	Rhiannon Hood	2021-07-07 14:05:03.268283	297.06	40.58	388.09	297.06	1	2
442	Rhiannon Hood	2021-07-07 14:05:03.268283	260.47	36.59	388.09	260.47	1	2
443	Rhiannon Hood	2021-07-07 14:05:03.268283	210.67	49.80	388.09	210.67	1	2
444	Rhiannon Hood	2021-07-07 14:05:03.268283	206.87	3.80	388.09	206.87	1	2
449	Rhiannon Hood	2021-07-07 14:53:00.235172	206.87	3.80	388.09	206.87	1	2
450	Rhiannon Hood	2021-07-07 14:55:26.766583	201.86	5.01	388.09	201.86	1	2
451	Rhiannon Hood	2021-07-07 16:07:43.389406	201.86	5.01	388.09	201.86	1	2
452	Rhiannon Hood	2021-07-07 16:07:51.357633	201.86	5.01	388.09	201.86	1	2
\.


--
-- TOC entry 3126 (class 0 OID 50624)
-- Dependencies: 224
-- Data for Name: pacienteasignado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacienteasignado (idpacienteasignado, idpaciente, iddoctor) FROM stdin;
1	57	34
2	57	44
3	41	79
4	61	100
5	85	63
6	21	91
7	48	47
8	26	88
9	33	86
10	44	51
11	84	41
12	36	82
13	76	61
14	49	71
15	69	80
16	50	60
17	62	49
18	97	14
19	44	31
20	61	94
21	98	100
22	62	80
23	17	70
24	60	81
25	61	80
26	16	19
27	80	6
28	78	25
29	43	92
30	32	75
31	55	44
32	95	28
33	54	53
34	33	54
35	46	55
36	69	16
37	63	23
38	74	15
39	31	91
40	47	26
41	89	88
42	93	37
43	38	10
44	82	73
45	95	84
46	44	67
47	46	67
48	57	36
49	56	72
50	87	31
51	53	71
52	23	38
53	69	74
54	76	81
55	59	31
56	61	49
57	50	84
58	37	87
59	48	31
60	17	56
61	40	52
62	94	76
63	17	76
64	83	65
65	48	8
66	87	15
67	28	85
68	84	60
69	50	16
70	80	72
71	8	64
73	45	59
74	59	17
75	66	87
76	54	62
77	22	4
78	15	66
79	32	56
80	36	45
81	62	48
82	3	43
83	81	44
84	54	12
85	37	11
86	38	32
87	41	93
88	83	8
89	73	72
90	93	44
91	71	34
92	91	53
93	74	38
94	4	19
95	37	55
96	45	83
97	91	56
98	7	62
99	36	93
100	4	38
101	68	84
72	68	4
102	68	12
103	96	73
104	13	36
105	13	34
106	18	22
107	97	19
108	13	28
109	13	3
110	13	3
\.


--
-- TOC entry 3115 (class 0 OID 50521)
-- Dependencies: 213
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacientes (idpaciente, nombrepaciente, apellidopaciente, fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente) FROM stdin;
1	Evangeline	Berry	2021-09-11	43691164-5	Ap #125-5231 Sed Ave	3234-7607	libero.Donec@Integeraliquam.co.uk	\N	2
2	Zephr	Reilly	2021-07-24	8199274-6	Ap #828-7231 Euismod Road	1762-5694	Nullam@porttitorinterdum.edu	\N	2
3	Venus	West	2022-04-27	44713578-7	7565 Nam Rd.	1047-7830	mauris.Morbi.non@quisdiamPellentesque.co.uk	\N	1
4	Cain	Wright	2020-07-26	10282048-7	679-4288 Vitae Street	6094-4050	lorem.vehicula.et@orciPhasellus.com	\N	1
5	Gil	Case	2021-03-31	32908003-k	8605 Odio. Avenue	7811-5475	mauris.id.sapien@veliteu.org	\N	1
6	Warren	Bishop	2021-08-24	6224261-2	131-2303 Et Road	9169-3943	semper.Nam.tempor@sempercursusInteger.ca	\N	1
7	Ivor	Reynolds	2020-12-26	30055112-2	P.O. Box 258, 4217 Sed Rd.	8317-1422	In.nec.orci@Vivamusnibh.com	\N	2
8	Rooney	Mooney	2022-12-20	15782535-6	242-7023 Auctor, Av.	1592-9087	diam.luctus@ornareegestas.com	\N	1
9	Hadley	Gonzalez	2022-03-26	10802011-3	Ap #403-8124 Risus. Av.	4840-2483	et@eunequepellentesque.com	\N	2
10	Emma	Henson	2020-10-29	9920305-6	3347 In Street	2696-1332	augue.porttitor@scelerisque.edu	\N	2
11	Tanek	Dalton	2020-05-04	21560355-5	231-6160 Sed Street	0176-1518	In@Nullamvitae.org	\N	2
12	Velma	Duncan	2020-07-28	30472907-4	Ap #837-6397 Posuere St.	1162-9752	primis.in.faucibus@placerataugue.net	\N	1
14	Damon	Dillon	2020-08-17	38791571-0	P.O. Box 724, 6134 Libero St.	9524-3752	Fusce.aliquet@acorciUt.org	\N	2
15	Sybil	Ochoa	2021-06-28	16491854-8	734-3940 Vulputate St.	9361-0237	condimentum.Donec.at@id.net	\N	2
16	Declan	Galloway	2020-08-02	5808161-2	Ap #128-5697 Mauris Street	8385-1201	et.rutrum.non@blandit.edu	\N	2
17	Christen	Harrington	2021-08-22	20545300-8	Ap #890-6837 Magna Rd.	4504-5999	Lorem.ipsum.dolor@per.edu	\N	1
19	Lara	Kim	2022-08-15	20868156-7	607-7424 In Street	6637-7927	Vivamus@Loremipsum.net	\N	2
20	Kasimir	Brown	2020-05-04	8807053-4	P.O. Box 526, 6462 Eget, Rd.	0962-9902	blandit@tellusNunclectus.co.uk	\N	1
21	Piper	Blackwell	2022-12-21	27119274-6	8160 Adipiscing Av.	8147-2715	at@lectusrutrum.com	\N	1
22	Gannon	Atkinson	2020-09-04	29458218-5	Ap #591-1643 Augue Road	9983-0325	libero.Proin.mi@necorciDonec.edu	\N	2
23	Madaline	Garza	2021-09-04	45180174-0	P.O. Box 656, 4478 Pede. Street	4230-0478	Pellentesque@tellus.ca	\N	1
24	Darius	Nichols	2022-03-03	7159687-7	3822 Eu Street	0952-6301	arcu@pretium.com	\N	1
25	Xenos	Gill	2022-09-28	23823718-1	P.O. Box 575, 2531 Eget Avenue	8842-2799	elit@eu.ca	\N	1
26	Chantale	Valenzuela	2021-03-12	7671189-5	2034 Rutrum Avenue	7812-1214	ut@et.org	\N	2
27	Clayton	Vinson	2021-03-24	15697602-4	454-515 Duis St.	6520-0921	arcu.eu@euismodin.com	\N	2
28	Rooney	Britt	2021-01-15	20218156-2	Ap #245-1261 Aliquet Ave	5741-9291	ipsum.primis.in@consectetuercursuset.co.uk	\N	2
29	Pandora	Torres	2021-12-23	39303660-5	Ap #242-5050 Dui. Road	7862-3099	sodales.nisi.magna@tempus.com	\N	2
30	Timon	Graham	2021-08-28	30417354-8	P.O. Box 477, 428 Consectetuer Street	0305-8647	Aliquam@odioEtiamligula.org	\N	1
31	Chava	Calhoun	2020-05-19	44174035-2	P.O. Box 490, 8340 Lacinia Road	7419-7419	In.tincidunt.congue@arcu.com	\N	2
32	Linus	Bradley	2021-03-03	42111241-k	P.O. Box 807, 2065 Fusce St.	1881-6136	Vestibulum.ut.eros@nequevitae.ca	\N	2
33	Cara	Fox	2022-10-15	29532460-0	Ap #800-5384 Convallis St.	2851-7157	ipsum@ametdiam.ca	\N	2
34	Brody	Waller	2021-06-10	19282238-6	151-4546 Tincidunt Rd.	8318-5461	a@Aenean.co.uk	\N	2
35	Dacey	Fox	2021-07-20	5622496-3	6531 Duis Street	1688-7801	neque@lectusCumsociis.co.uk	\N	1
36	Cody	Jensen	2020-11-09	5724979-k	5093 Netus Av.	1534-0807	elit@fringilla.net	\N	2
37	Neil	Baxter	2021-09-06	15273033-0	793-6830 Magna, Rd.	0868-6707	nulla.vulputate.dui@vitaerisus.org	\N	2
38	Zane	Gaines	2022-10-01	15937110-7	Ap #702-9509 Nunc St.	1452-5071	amet.risus.Donec@luctus.co.uk	\N	2
39	Tad	Hoffman	2022-09-21	23570810-8	721-5264 Massa Rd.	5668-2118	amet.metus@lobortistellusjusto.org	\N	1
40	Brianna	Schneider	2020-12-01	28344623-9	Ap #302-6056 Nulla Ave	4192-3154	erat.vitae.risus@feugiat.com	\N	2
41	Ezekiel	Head	2021-03-22	39691608-8	Ap #395-8338 Morbi St.	3851-6689	volutpat.ornare.facilisis@at.com	\N	2
42	Aquila	Winters	2021-08-09	45834120-6	687-9152 Quam. St.	6681-8503	aliquam.eu.accumsan@diamSeddiam.org	\N	1
43	Henry	Cervantes	2022-07-16	21763914-k	Ap #854-6948 Aliquam Road	0865-8233	penatibus.et@habitantmorbitristique.net	\N	1
44	Nehru	Prince	2021-08-14	24754557-3	Ap #838-689 Mus. Ave	1151-9973	eu.lacus@mattisCras.ca	\N	1
45	Kareem	Walls	2021-05-26	14850313-3	Ap #614-4505 Mattis. Rd.	6109-5656	Aenean@quamafelis.edu	\N	2
46	Mercedes	Roberts	2020-10-23	29150269-5	P.O. Box 365, 3488 Erat. Av.	0599-2631	lobortis.mauris.Suspendisse@Cras.com	\N	1
47	Mariam	Shepard	2022-07-14	26918763-8	P.O. Box 140, 2918 Donec Avenue	1035-7167	felis.Nulla.tempor@tristiquealiquet.org	\N	2
48	Jescie	Patel	2020-06-05	47150014-3	8040 Fringilla Ave	3225-5369	tincidunt@faucibuslectus.co.uk	\N	1
49	Barrett	Mejia	2022-07-29	49093401-4	219-4791 Senectus Av.	9094-1779	feugiat.Lorem@fringilla.org	\N	1
50	Hamish	Morales	2022-03-18	19474233-9	Ap #994-3421 Arcu. Av.	2178-3394	ligula.Aenean.gravida@acturpisegestas.ca	\N	2
51	Kieran	Wiley	2020-07-17	40348105-k	2109 Sed Avenue	3860-9347	turpis.egestas@pede.org	\N	1
52	Bradley	Boyle	2022-08-18	8770652-4	Ap #374-3307 Mauris, Rd.	5072-1981	in.aliquet.lobortis@Curabitur.ca	\N	2
53	Finn	Combs	2020-09-26	43262248-7	Ap #799-8224 Metus Ave	8308-7772	Aliquam.erat.volutpat@nonenimMauris.co.uk	\N	2
54	Kevin	Barrera	2021-04-21	50202308-k	Ap #239-4474 Vivamus St.	8954-9111	sit.amet@Aliquam.ca	\N	1
55	Leroy	Joyner	2021-05-29	42646637-6	141-8652 Lorem Ave	7997-2314	Quisque.ornare@utlacusNulla.co.uk	\N	2
56	Odessa	Sykes	2022-11-30	32436503-6	421-5319 Elit Av.	8607-3646	velit.in@dictum.ca	\N	1
57	Paki	Hunter	2021-02-27	12892767-0	Ap #184-8804 Velit. Ave	4418-7816	ac.eleifend@rutrumnon.org	\N	2
58	Hayfa	Joyce	2022-08-12	45298128-9	496-7222 Nullam Road	5253-1540	Sed.nunc@elitCurabitur.edu	\N	1
18	Abra	House	2020-07-27	86443190-4	Ap #468-2326 Eu Av.	6029-3793	libero.est@maurissapiencursus.ca	\N	1
59	Ronan	Mccray	2020-11-21	9875194-7	Ap #661-9711 Neque Road	4641-8297	eget@Suspendissecommodotincidunt.co.uk	\N	2
60	Malachi	Harper	2021-05-23	13704045-k	P.O. Box 717, 6688 Luctus Av.	8969-0876	fringilla@elitNulla.edu	\N	2
61	Paloma	Frank	2020-06-09	21012479-9	912 In Street	5186-6335	Donec.sollicitudin@ornaretortor.edu	\N	2
62	Gemma	Benson	2020-06-26	38386968-4	Ap #532-4427 At St.	9837-5920	sociosqu.ad.litora@estcongue.ca	\N	1
63	Cassandra	Chandler	2021-12-07	25478821-k	239-3091 Gravida Av.	7990-4183	nulla@Namnulla.org	\N	2
64	Moses	Robles	2021-12-03	12687795-1	Ap #655-6225 Risus. St.	4474-9480	tincidunt@sedorcilobortis.com	\N	1
65	Abra	Griffith	2021-04-16	11282164-3	8837 Magna Rd.	9304-2397	ac.turpis@dictum.edu	\N	2
66	Jocelyn	Christensen	2021-12-28	50392167-7	703-400 Maecenas St.	0716-8307	purus.gravida.sagittis@NullafacilisisSuspendisse.org	\N	1
67	Kiona	Aguirre	2020-05-16	14165613-9	P.O. Box 218, 2693 Arcu Ave	7521-9354	mi.felis@quis.edu	\N	1
68	Rhiannon	Hood	2021-06-26	9493488-5	P.O. Box 413, 9416 Sapien, Road	9538-3922	sit@porttitorscelerisque.org	\N	2
69	Geoffrey	Lyons	2020-09-04	35317276-k	P.O. Box 368, 4444 Fringilla. Av.	5529-4655	urna.Nunc@sitamet.ca	\N	2
70	Holmes	Crosby	2022-08-25	18092618-6	Ap #527-4946 Imperdiet Street	7279-5242	consequat@sem.net	\N	2
71	Aline	Chang	2021-11-30	5878386-2	8187 Volutpat Road	3823-1604	vestibulum.nec.euismod@Donec.net	\N	1
72	Xander	Lyons	2021-04-16	29614747-8	509-5909 Lorem Rd.	5894-6835	vel.venenatis@ametfaucibusut.edu	\N	2
73	Bevis	Wyatt	2022-08-07	14234268-5	4701 Vel Rd.	9827-2857	placerat.eget.venenatis@enimNuncut.com	\N	2
74	Marny	Hays	2020-05-17	43246176-9	7632 Mi Avenue	1807-1863	vitae.erat.Vivamus@metusIn.com	\N	2
75	Erica	Brown	2021-12-19	44641917-k	826-1809 At, Avenue	6616-1752	pede@ipsum.ca	\N	2
76	Tad	Mejia	2021-10-08	39918492-4	1671 Aliquam St.	7621-8057	rhoncus@nequesed.co.uk	\N	2
77	Barclay	Sanchez	2021-09-12	42871939-5	2364 Luctus. Street	2944-5849	Integer@idnuncinterdum.net	\N	1
78	Tucker	Beach	2022-10-30	15462694-8	849-467 Sed Av.	4055-6393	ac.risus.Morbi@nisi.co.uk	\N	2
79	Quemby	Byers	2020-11-09	48517032-4	3930 Sit Rd.	8160-2295	Duis.elementum@laoreetposuere.ca	\N	1
80	Carson	Nelson	2021-09-24	50842564-3	P.O. Box 701, 8295 Nec Rd.	4702-1531	natoque.penatibus@dictumProineget.ca	\N	2
81	Alma	Bartlett	2021-06-03	47614540-6	Ap #448-953 Lorem Road	2252-5131	nunc@dictumPhasellusin.net	\N	2
82	Melissa	Dennis	2021-11-25	43761544-6	Ap #891-5642 Ac St.	2598-7014	Sed@necmalesuada.org	\N	1
83	Jermaine	Workman	2022-09-21	31713742-7	Ap #705-6058 Vestibulum Road	9390-7648	euismod@malesuadavel.ca	\N	1
84	Mariam	Cobb	2022-09-24	40606472-7	8152 In, St.	3224-5894	ut.ipsum.ac@dignissimlacus.edu	\N	1
85	Prescott	Hurley	2022-03-18	13555532-0	P.O. Box 209, 6109 Nulla St.	9202-1093	purus.sapien.gravida@ornare.ca	\N	1
86	Ocean	Vang	2022-10-01	24639833-k	Ap #941-2916 Arcu. Av.	4700-4183	eget@ligulaelitpretium.net	\N	2
87	Kuame	Cooley	2021-05-05	7780791-8	Ap #543-7180 Massa. Road	9734-1378	ac.tellus.Suspendisse@ametconsectetuer.org	\N	2
88	Jerome	Hayes	2021-09-16	16361315-8	P.O. Box 476, 4889 Primis Rd.	2780-5433	Donec.at@loremvehicula.co.uk	\N	2
89	Carter	King	2021-08-18	39210520-4	177-8314 Sed Avenue	4161-0738	cursus@Donec.com	\N	1
90	Sawyer	Spencer	2020-10-05	37293725-4	P.O. Box 826, 205 Turpis Av.	2150-7965	tincidunt.neque@Vivamusnon.co.uk	\N	1
91	Rebekah	Powell	2022-05-19	37075178-1	Ap #812-555 Aliquam St.	5474-4487	In.faucibus@nisl.org	\N	2
92	Valentine	Reid	2021-08-09	10922375-1	9075 Pede. Rd.	9612-2987	sapien.molestie@dictum.edu	\N	1
93	Fay	Decker	2021-07-12	45558308-k	Ap #124-2897 Enim. St.	1485-2196	imperdiet.erat.nonummy@orciadipiscing.ca	\N	1
94	Gisela	Leonard	2021-09-16	16050308-4	5199 Vitae St.	5322-3577	ultrices.mauris@tempor.net	\N	2
95	Britanney	Summers	2022-07-10	44249705-2	Ap #121-3044 Mi Street	1424-7297	montes@actellusSuspendisse.co.uk	\N	1
96	Anjolie	Fulton	2021-11-23	42876299-1	172-3899 Vel, Avenue	5549-4575	porttitor@augue.com	\N	2
98	Charde	Wagner	2022-11-18	44863742-5	P.O. Box 788, 4290 Aenean Road	4229-8761	Fusce.diam.nunc@Maurisvel.net	\N	2
99	Xyla	Valdez	2021-04-19	26986863-5	Ap #329-7612 Lorem, Av.	5080-6942	non.sollicitudin@rutrum.org	\N	1
100	Blossom	Hickman	2022-05-30	24017277-1	P.O. Box 402, 9929 Velit Ave	7581-1394	nisi@sodales.co.uk	\N	1
103	s	a	2021-01-22	12345678-9	a	2344-4545	a@gmail.com	60d276e374129.jpg	2
107	Ronald	Wittman	2000-01-03	23123456-4	as	2344-4545	a@gmail.com	60d27bae44182.jpg	2
13	Aaron	Spencer	2020-10-28	17138788-4	Ap #468-2326 Eu Av.	2147-9042	amet.lorem.semper@nislNulla.co.uk	\N	1
97	Gregory	House	2021-01-01	11887462-5	A	6245-7191	sapien@Etiamimperdiet.org	\N	1
\.


--
-- TOC entry 3147 (class 0 OID 50772)
-- Dependencies: 245
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos (idpago, pagodebe, pagoabono, pagototal, pagosaldo, idtratamiento, idtipopago, idestadopago) FROM stdin;
2	0.00	206.43	206.41	0.00	2	1	2
1	201.86	5.01	388.09	201.86	1	2	3
7	0.00	0.00	0.00	0.00	7	2	1
8	0.00	0.00	0.00	0.00	8	2	1
9	0.00	0.00	0.00	0.00	9	2	1
10	0.00	0.00	0.00	0.00	10	2	1
11	0.00	0.00	0.00	0.00	11	2	1
12	0.00	0.00	0.00	0.00	12	1	1
13	0.00	0.00	0.00	0.00	13	2	1
14	0.00	0.00	0.00	0.00	14	1	1
15	0.00	0.00	0.00	0.00	15	2	1
16	0.00	0.00	0.00	0.00	16	1	1
17	0.00	0.00	0.00	0.00	17	2	1
18	0.00	0.00	0.00	0.00	18	2	1
19	0.00	0.00	0.00	0.00	19	1	1
20	0.00	0.00	0.00	0.00	20	2	1
21	0.00	0.00	0.00	0.00	21	1	1
22	0.00	0.00	0.00	0.00	22	2	1
23	0.00	0.00	0.00	0.00	23	2	1
24	0.00	0.00	0.00	0.00	24	2	1
25	0.00	0.00	0.00	0.00	25	2	1
26	0.00	0.00	0.00	0.00	26	2	1
27	0.00	0.00	0.00	0.00	27	1	1
81	0.00	0.00	0.00	0.00	81	1	1
82	0.00	0.00	0.00	0.00	82	2	1
83	0.00	0.00	0.00	0.00	83	1	1
84	0.00	0.00	0.00	0.00	84	1	1
85	0.00	0.00	0.00	0.00	85	1	1
86	0.00	0.00	0.00	0.00	86	2	1
87	0.00	0.00	0.00	0.00	87	1	1
88	0.00	0.00	0.00	0.00	88	2	1
89	0.00	0.00	0.00	0.00	89	1	1
90	0.00	0.00	0.00	0.00	90	1	1
91	0.00	0.00	0.00	0.00	91	2	1
92	0.00	0.00	0.00	0.00	92	2	1
93	0.00	0.00	0.00	0.00	93	1	1
94	0.00	0.00	0.00	0.00	94	2	1
95	0.00	0.00	0.00	0.00	95	2	1
96	0.00	0.00	0.00	0.00	96	1	1
97	0.00	0.00	0.00	0.00	97	2	1
98	0.00	0.00	0.00	0.00	98	2	1
99	0.00	0.00	0.00	0.00	99	1	1
100	0.00	0.00	0.00	0.00	100	1	1
4	0.00	0.00	0.00	0.00	4	2	2
6	0.00	0.00	0.00	0.00	6	2	1
5	0.00	0.00	0.00	0.00	5	1	1
30	0.00	0.00	0.00	0.00	30	1	1
3	0.00	0.00	0.00	0.00	3	1	1
28	0.00	0.00	0.00	0.00	28	2	1
29	0.00	0.00	0.00	0.00	29	1	1
31	0.00	0.00	0.00	0.00	31	1	1
32	0.00	0.00	0.00	0.00	32	2	1
33	0.00	0.00	0.00	0.00	33	1	1
34	0.00	0.00	0.00	0.00	34	2	1
35	0.00	0.00	0.00	0.00	35	2	1
36	0.00	0.00	0.00	0.00	36	2	1
37	0.00	0.00	0.00	0.00	37	2	1
38	0.00	0.00	0.00	0.00	38	1	1
39	0.00	0.00	0.00	0.00	39	1	1
40	0.00	0.00	0.00	0.00	40	2	1
41	0.00	0.00	0.00	0.00	41	1	1
42	0.00	0.00	0.00	0.00	42	1	1
43	0.00	0.00	0.00	0.00	43	2	1
44	0.00	0.00	0.00	0.00	44	1	1
45	0.00	0.00	0.00	0.00	45	2	1
46	0.00	0.00	0.00	0.00	46	1	1
47	0.00	0.00	0.00	0.00	47	1	1
48	0.00	0.00	0.00	0.00	48	1	1
49	0.00	0.00	0.00	0.00	49	1	1
50	0.00	0.00	0.00	0.00	50	2	1
51	0.00	0.00	0.00	0.00	51	1	1
52	0.00	0.00	0.00	0.00	52	1	1
53	0.00	0.00	0.00	0.00	53	1	1
54	0.00	0.00	0.00	0.00	54	2	1
55	0.00	0.00	0.00	0.00	55	1	1
56	0.00	0.00	0.00	0.00	56	2	1
57	0.00	0.00	0.00	0.00	57	2	1
58	0.00	0.00	0.00	0.00	58	2	1
59	0.00	0.00	0.00	0.00	59	1	1
60	0.00	0.00	0.00	0.00	60	2	1
61	0.00	0.00	0.00	0.00	61	2	1
62	0.00	0.00	0.00	0.00	62	2	1
63	0.00	0.00	0.00	0.00	63	1	1
64	0.00	0.00	0.00	0.00	64	2	1
65	0.00	0.00	0.00	0.00	65	1	1
66	0.00	0.00	0.00	0.00	66	2	1
67	0.00	0.00	0.00	0.00	67	1	1
68	0.00	0.00	0.00	0.00	68	2	1
69	0.00	0.00	0.00	0.00	69	2	1
70	0.00	0.00	0.00	0.00	70	1	1
71	0.00	0.00	0.00	0.00	71	2	1
72	0.00	0.00	0.00	0.00	72	1	1
73	0.00	0.00	0.00	0.00	73	2	1
74	0.00	0.00	0.00	0.00	74	2	1
75	0.00	0.00	0.00	0.00	75	1	1
76	0.00	0.00	0.00	0.00	76	1	1
77	0.00	0.00	0.00	0.00	77	1	1
78	0.00	0.00	0.00	0.00	78	2	1
79	0.00	0.00	0.00	0.00	79	2	1
80	0.00	0.00	0.00	0.00	80	2	1
\.


--
-- TOC entry 3151 (class 0 OID 58096)
-- Dependencies: 249
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas (idpregunta, pregunta) FROM stdin;
1	¿Padece de migrañas o dolores de cabeza frecuentes?
2	¿Padece de ataques de epilepsia o convulsiones?
3	¿Padece de problemas cardiacos?
4	¿Padece de gastritis, úlceras, diarreas frecuentes?
5	¿Padece de azúcar en la sangre(Diabetes)?
6	¿Ha padecido de hepatitis?
7	¿Padece de alguna alergia a mediacamentos?
8	¿Toma algún medicamento permanente?
\.


--
-- TOC entry 3136 (class 0 OID 50694)
-- Dependencies: 234
-- Data for Name: procedimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procedimientos (idprocedimiento, nombreprocedimiento, descripcionprocedimiento, costoprocedimiento) FROM stdin;
1	Endodoncias	Maecenas ornare egestas	20.99
2	Escalado y Alisado Radicular	non ante bibendum ullamcorper	14.99
3	Ortodoncia	sapien imperdiet	30.99
4	Extracción	ac metus vitae velit	10.50
5	Restauraciones	magna. Lorem ipsum dolor si	35.56
6	Restauración con Amalgama	consectetuer adipiscing elit	36.34
7	Restauración Compuesta	Vivamus euismod urna. Nullam	34.94
8	Selladores	itae risus. Duis a mi fringilla m	16.78
\.


--
-- TOC entry 3128 (class 0 OID 50642)
-- Dependencies: 226
-- Data for Name: recetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recetas (idreceta, farmaco, fecharegistro, idpacienteasignado) FROM stdin;
1	dolor	2021-05-30	22
2	vestibulum,	2021-06-10	81
3	cursus	2021-05-22	17
4	metus. Vivamus	2021-03-10	30
5	pharetra. Nam	2021-06-17	13
6	quis, pede.	2021-07-19	53
7	magna. Nam	2021-07-19	51
8	elementum	2021-06-11	53
9	mauris	2021-06-03	66
10	eleifend vitae,	2021-08-10	31
11	lobortis	2021-08-27	34
12	nec,	2021-07-08	98
13	congue. In	2021-06-17	27
14	aliquet libero.	2021-12-04	22
15	magna tellus	2021-07-16	79
16	eu dolor	2021-12-10	13
17	et tristique	2021-07-22	49
18	massa	2021-07-03	51
19	mollis dui,	2021-03-11	47
20	In	2021-04-24	91
21	dictum	2021-02-10	67
22	urna.	2021-03-04	49
23	tellus. Nunc	2021-07-20	36
24	sit	2021-05-21	54
25	Nunc commodo	2021-07-28	72
26	nibh dolor,	2021-11-08	27
27	id risus	2021-11-23	62
28	aliquet	2021-07-02	7
29	sem. Pellentesque	2021-09-10	59
30	magna tellus	2021-06-20	61
31	diam.	2021-12-09	17
32	dolor. Quisque	2021-01-11	86
33	consectetuer	2021-09-01	57
34	diam vel	2021-08-15	18
35	erat nonummy	2021-07-31	51
36	commodo at,	2021-08-23	56
37	congue	2021-06-02	19
38	nunc nulla	2021-05-04	95
39	Morbi vehicula.	2021-09-23	3
40	lobortis	2021-10-17	51
41	Curabitur ut	2021-11-03	79
42	mauris, rhoncus	2021-03-05	13
43	Integer	2021-09-10	39
44	vulputate,	2021-05-07	2
45	non	2021-01-10	67
46	Curabitur	2021-05-20	25
47	sit	2021-09-11	86
48	bibendum ullamcorper.	2021-07-30	21
49	augue scelerisque	2021-07-21	79
50	dignissim	2021-06-15	51
51	ridiculus mus.	2021-05-29	31
52	nunc.	2021-06-27	92
53	lorem.	2021-03-23	83
54	turpis	2021-05-19	28
55	scelerisque	2021-05-10	7
56	parturient	2021-08-28	91
57	eget laoreet	2021-06-04	3
58	dictum	2021-07-03	88
59	dictum placerat,	2021-10-17	23
60	orci,	2021-10-01	42
61	aliquam eu,	2021-07-12	11
62	Morbi	2021-09-01	14
63	tincidunt,	2021-11-07	56
64	amet, faucibus	2021-10-13	14
65	orci. Ut	2021-08-09	12
66	pede,	2021-12-19	37
67	justo faucibus	2021-09-12	100
68	nunc	2021-11-14	8
69	sit amet	2021-12-06	50
70	cubilia	2021-07-10	53
71	nulla. In	2021-08-29	52
72	mauris	2021-05-09	13
73	Mauris molestie	2021-05-17	29
74	vulputate,	2021-07-07	8
75	mus.	2021-07-16	77
76	augue	2021-12-11	91
77	faucibus. Morbi	2021-02-12	47
78	ultricies dignissim	2021-01-08	16
79	Suspendisse non	2021-04-16	20
80	erat	2021-10-16	67
81	eget	2021-07-28	13
82	Cras vehicula	2021-07-09	71
83	laoreet,	2021-03-15	3
84	Ut	2021-05-02	33
85	massa.	2021-05-31	4
86	erat semper	2021-03-17	17
87	purus.	2021-10-31	72
88	Vivamus euismod	2021-05-26	85
89	sed	2021-03-27	60
90	augue id	2021-07-03	49
91	Mauris	2021-04-06	49
92	nec	2021-09-25	71
93	Praesent	2021-02-06	9
94	orci	2021-09-01	40
95	blandit	2021-09-10	98
96	metus.	2021-02-10	64
97	dui. Cum	2021-07-13	4
98	ante.	2021-03-16	97
99	eu	2021-05-14	24
100	congue. In	2021-07-16	17
\.


--
-- TOC entry 3153 (class 0 OID 58145)
-- Dependencies: 251
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuestas (idrespuesta, respuesta1, idpregunta1, respuesta2, idpregunta2, respuesta3, idpregunta3, respuesta4, idpregunta4, respuesta5, idpregunta5, respuesta6, idpregunta6, respuesta7, idpregunta7, respuesta8, idpregunta8, pacientemedicamento, idpaciente) FROM stdin;
1	Si	1	Si	2	Si	3	Si	4	Si	5	Si	6	Si	7	Si	8	s	13
2	Si	1	No	2	Si	3	No	4	Si	5	Si	6	Si	7	No	8	fdasdsa	13
3	Si	1	Si	2	Si	3	Si	4	Si	5	No	6	No	7	No	8	-	13
\.


--
-- TOC entry 3157 (class 0 OID 66430)
-- Dependencies: 255
-- Data for Name: test12; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test12 (idtest, dates) FROM stdin;
2	13:56:13
\.


--
-- TOC entry 3144 (class 0 OID 50759)
-- Dependencies: 242
-- Data for Name: tipopago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipopago (idtipopago, tipopago) FROM stdin;
1	Al Credito
2	A Plazos
\.


--
-- TOC entry 3130 (class 0 OID 50655)
-- Dependencies: 228
-- Data for Name: tipotratamiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipotratamiento (idtipotratamiento, tipotratamiento) FROM stdin;
1	Limpieza Dental
2	Pullido de Dientes
3	Tratamiento de Braquets
\.


--
-- TOC entry 3109 (class 0 OID 50487)
-- Dependencies: 207
-- Data for Name: tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipousuario (idtipousuario, tipousuario) FROM stdin;
1	Root
2	Administrador
3	Personal Administrativo
\.


--
-- TOC entry 3134 (class 0 OID 50671)
-- Dependencies: 232
-- Data for Name: tratamientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tratamientos (idtratamiento, fechainicio, descripciontratamiento, idpacienteasignado, idtipotratamiento, idestadotratamiento) FROM stdin;
1	2020-09-01	ullamcorper eu, euismod ac, fermentum	72	3	3
2	2020-09-03	Praesent interdum ligula eu enim.	22	3	2
3	2019-05-15	Suspendisse aliquet molestie tellus. Aenean	94	1	3
4	2020-05-22	dis parturient montes, nascetur ridiculus	72	3	2
5	2021-06-15	gravida. Praesent eu nulla at	27	3	1
6	2019-06-13	Cum sociis natoque penatibus et	39	3	2
7	2019-09-10	Sed diam lorem, auctor quis,	95	3	2
8	2019-07-04	velit eget laoreet posuere, enim	15	1	2
9	2019-06-06	dignissim. Maecenas ornare egestas ligula.	5	1	3
10	2019-12-16	ultricies ligula. Nullam enim. Sed	7	3	3
11	2021-07-15	Nulla eu neque pellentesque massa	22	2	1
12	2020-12-20	Mauris molestie pharetra nibh. Aliquam	97	3	2
13	2019-12-21	Mauris nulla. Integer urna. Vivamus	57	2	2
14	2020-04-24	lectus convallis est, vitae sodales	47	1	2
15	2021-09-04	vel sapien imperdiet ornare. In	71	1	1
16	2020-05-19	Nulla interdum. Curabitur dictum. Phasellus	29	3	1
17	2019-03-04	dolor. Quisque tincidunt pede ac	73	2	3
18	2020-07-30	nec mauris blandit mattis. Cras	14	2	2
19	2020-11-11	morbi tristique senectus et netus	57	1	3
20	2021-01-31	enim. Suspendisse aliquet, sem ut	78	2	2
21	2021-01-07	tristique aliquet. Phasellus fermentum convallis	11	3	1
22	2020-05-22	Aliquam gravida mauris ut mi.	84	2	1
23	2021-04-18	sollicitudin commodo ipsum. Suspendisse non	33	1	2
24	2021-08-11	molestie tortor nibh sit amet	68	1	3
25	2019-05-24	at pretium aliquet, metus urna	34	3	3
26	2019-04-04	suscipit nonummy. Fusce fermentum fermentum	7	2	3
27	2019-03-14	adipiscing lacus. Ut nec urna	40	2	1
28	2020-06-24	Sed auctor odio a purus.	65	3	3
29	2020-03-25	quam. Curabitur vel lectus. Cum	83	3	3
30	2020-02-09	felis ullamcorper viverra. Maecenas iaculis	2	2	1
31	2020-01-26	velit egestas lacinia. Sed congue,	61	1	2
32	2020-04-04	sagittis augue, eu tempor erat	84	1	3
33	2020-03-18	dolor. Quisque tincidunt pede ac	22	1	1
34	2019-10-22	dictum sapien. Aenean massa. Integer	24	1	1
35	2020-04-26	eu arcu. Morbi sit amet	20	1	1
36	2019-11-16	tempus risus. Donec egestas. Duis	67	2	3
37	2021-05-31	dolor sit amet, consectetuer adipiscing	23	1	3
38	2019-03-14	vitae aliquam eros turpis non	99	2	1
39	2019-12-24	at risus. Nunc ac sem	34	1	3
40	2019-12-06	a, facilisis non, bibendum sed,	91	2	2
41	2021-07-18	Nullam velit dui, semper et,	3	2	1
42	2019-09-07	neque. Nullam ut nisi a	16	3	3
43	2021-08-28	Donec felis orci, adipiscing non,	93	1	3
44	2020-10-09	consequat auctor, nunc nulla vulputate	86	1	1
45	2019-06-30	Praesent interdum ligula eu enim.	3	2	2
46	2020-06-20	dui. Fusce diam nunc, ullamcorper	93	3	3
47	2019-03-18	non dui nec urna suscipit	83	1	2
48	2019-03-06	quis urna. Nunc quis arcu	18	1	2
49	2019-07-11	mauris, aliquam eu, accumsan sed,	52	2	2
50	2021-03-26	Nullam suscipit, est ac facilisis	64	1	2
51	2020-02-06	eros. Proin ultrices. Duis volutpat	85	1	2
52	2020-07-25	posuere, enim nisl elementum purus,	7	1	1
53	2020-10-24	Sed eget lacus. Mauris non	1	1	3
54	2020-04-17	tincidunt tempus risus. Donec egestas.	76	2	1
55	2020-10-11	adipiscing non, luctus sit amet,	92	2	1
56	2021-03-01	consectetuer ipsum nunc id enim.	80	2	1
57	2021-03-12	et magnis dis parturient montes,	71	3	1
58	2020-04-28	Duis sit amet diam eu	91	2	3
59	2020-11-08	et, magna. Praesent interdum ligula	56	1	2
60	2019-07-19	arcu. Nunc mauris. Morbi non	52	1	2
61	2021-07-12	ipsum nunc id enim. Curabitur	62	2	3
62	2019-11-11	leo elementum sem, vitae aliquam	78	1	3
63	2020-06-30	orci luctus et ultrices posuere	76	1	1
64	2020-02-15	id, erat. Etiam vestibulum massa	90	1	1
65	2020-02-11	justo nec ante. Maecenas mi	28	3	3
66	2019-04-08	enim nec tempus scelerisque, lorem	58	2	2
67	2020-08-22	non, lacinia at, iaculis quis,	14	3	3
68	2019-03-20	metus. Aenean sed pede nec	27	2	2
69	2020-05-06	ut lacus. Nulla tincidunt, neque	51	2	1
70	2021-01-31	tellus. Nunc lectus pede, ultrices	100	1	3
71	2021-08-01	placerat, augue. Sed molestie. Sed	15	3	3
72	2019-09-14	tempus, lorem fringilla ornare placerat,	79	1	3
73	2021-09-21	odio. Nam interdum enim non	96	2	3
74	2020-10-23	adipiscing non, luctus sit amet,	82	2	3
75	2020-01-15	lorem. Donec elementum, lorem ut	21	2	1
76	2019-04-03	Vestibulum ut eros non enim	11	1	2
77	2020-08-11	Donec elementum, lorem ut aliquam	36	2	3
78	2021-02-09	Integer vitae nibh. Donec est	47	2	2
79	2020-10-21	sem molestie sodales. Mauris blandit	71	2	2
80	2021-05-10	Suspendisse tristique neque venenatis lacus.	91	1	2
81	2021-01-28	nec luctus felis purus ac	75	3	2
82	2019-11-16	congue. In scelerisque scelerisque dui.	55	3	3
83	2021-02-26	libero at auctor ullamcorper, nisl	37	3	1
84	2021-04-10	interdum. Nunc sollicitudin commodo ipsum.	4	2	3
85	2019-06-14	mi. Duis risus odio, auctor	8	1	1
86	2020-07-06	iaculis odio. Nam interdum enim	70	3	2
87	2019-08-05	sed dictum eleifend, nunc risus	14	1	1
88	2021-06-28	Proin vel nisl. Quisque fringilla	41	2	1
89	2020-07-21	faucibus leo, in lobortis tellus	43	3	1
90	2019-04-28	non, lacinia at, iaculis quis,	69	2	1
91	2021-05-21	pellentesque, tellus sem mollis dui,	7	3	1
92	2020-03-21	libero lacus, varius et, euismod	1	1	1
93	2019-05-29	in felis. Nulla tempor augue	88	3	3
94	2020-11-23	pretium neque. Morbi quis urna.	92	2	1
95	2019-04-27	purus ac tellus. Suspendisse sed	45	2	3
96	2019-05-13	sagittis augue, eu tempor erat	86	3	3
97	2021-01-20	luctus ut, pellentesque eget, dictum	54	2	1
98	2019-09-18	Cras vulputate velit eu sem.	59	3	3
99	2021-05-06	nisl sem, consequat nec, mollis	43	1	2
100	2019-04-13	sem egestas blandit. Nam nulla	56	1	1
\.


--
-- TOC entry 3111 (class 0 OID 50495)
-- Dependencies: 209
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (idusuario, nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario) FROM stdin;
1	Adalberto Francisco	Aguilar Paredes	San Salvador	7898-3045	adalberto@gmail.com	arwen	1233453	1	1
2	Gretchen	Mitchell	P.O. Box 594, 673 Sociis Street	1559-8859	nascetur.ridiculus@Integervitae.com	sollicitudin	PUS35NBY3ML	1	3
3	Todd	Vang	P.O. Box 101, 157 Sed Av.	8081-8891	bibendum@nequevenenatis.net	pede.	JFU04ERX1OB	2	2
4	Jeremy	Maldonado	Ap #337-1553 Enim. Ave	5169-9756	malesuada.vel.convallis@consectetuer.co.uk	Integer	FDC69UJF8EB	1	2
5	Irma	Gay	Ap #859-2484 In Street	2897-3293	elit.pellentesque.a@sit.ca	nisi.	FNF20MBV1XG	1	1
6	Ezra	Rios	9130 Mauris Av.	8109-1848	egestas@ac.org	nulla.	JBD60KSY9BJ	1	1
7	Isabella	Merritt	3505 Non, Avenue	8819-3589	et.magna@semPellentesqueut.ca	aliquet,	NXP62MSA7TG	2	3
8	Malik	Swanson	Ap #901-9510 Varius Av.	8050-2849	aliquet.odio@sagittisDuis.org	magna.	BBQ47JWL4HK	2	3
9	Jelani	Stokes	627-4977 Condimentum. Rd.	5168-1990	vitae.erat@consectetuer.org	odio	UAV32MJC1NW	2	2
10	Chanda	Stevens	768-3642 Placerat, St.	2652-3873	dolor.nonummy@libero.ca	nisl	YKZ59KEP6LM	2	1
11	Fritz	Nunez	5203 Nunc Road	0464-8022	Curabitur@perinceptos.co.uk	tellus.	YFL08JDY5RM	1	1
12	Edward	Cortez	Ap #594-6503 Est Rd.	1174-4309	sit.amet.ornare@ornareelitelit.org	vitae,	FOS97FUU4UP	2	3
13	Phyllis	Bridges	8801 Suspendisse Avenue	9047-8716	litora.torquent@uterat.edu	iaculis	SAD32QKI4PZ	1	2
14	Harrison	Charles	5927 Felis. St.	5448-0612	Nunc.ac.sem@ametfaucibus.com	orci.	NPS88ICX2JV	2	1
15	Caesar	Wiley	Ap #496-380 Ridiculus Rd.	9797-1033	sollicitudin.adipiscing.ligula@duiaugueeu.co.uk	non	PTB76SXE3CH	2	3
16	Aidan	Mason	P.O. Box 158, 9630 Diam Av.	3676-1575	pellentesque.massa.lobortis@acmetusvitae.net	odio	ZCK11EBJ9AP	1	1
17	Garth	Chase	P.O. Box 202, 499 Ac St.	9152-3274	in.felis@apurus.org	odio.	TNG93RPP3XF	2	2
18	Orlando	Molina	4485 Amet Rd.	0665-9919	tempor.bibendum.Donec@orci.ca	Nunc	BNL03ZOO0TV	2	1
19	Kelsey	Harmon	P.O. Box 134, 7979 Lorem Rd.	8086-8272	sem@urna.co.uk	fames	KEV98LRP0PG	1	3
20	Cyrus	Winters	P.O. Box 387, 1368 Litora Ave	7960-4610	nostra@augue.co.uk	Donec	MZI53JJH5QE	1	2
21	Driscoll	Wynn	803-3728 Curabitur Rd.	6951-7702	Proin.sed.turpis@eratinconsectetuer.ca	luctus.	BBL82HQG6QF	1	1
22	Kylie	Newton	Ap #177-3953 Pharetra Avenue	4219-6785	orci.Donec@Donecnon.co.uk	Proin	KXK99AGB1BI	1	1
23	Zachery	Bullock	P.O. Box 237, 1225 Eget St.	5924-4441	sed.orci@NullaaliquetProin.ca	erat.	KZU88HRQ9DV	2	2
24	Amena	Sharpe	Ap #573-5511 Ut Ave	2827-5012	dolor.Nulla.semper@pellentesquetellussem.net	pellentesque	ZOD33QEU7MT	2	1
25	Armando	Case	850-3314 Volutpat Ave	7980-7778	luctus.vulputate@seddictum.com	Pellentesque	HJA67UJO7TQ	2	2
26	Samuel	Booth	Ap #207-1575 Pellentesque, St.	4620-1747	Integer@liberomauris.org	sed	QVG27AKH0JS	1	1
27	Karina	Mitchell	P.O. Box 594, 1665 Augue Rd.	2755-8920	mus.Proin.vel@lectuspede.co.uk	interdum	IIZ09GEF0SD	2	1
28	Clark	Small	9194 Tincidunt Street	9459-5259	est.congue@liberoet.com	amet	AZS07XAL9ZP	2	1
29	Kylie	Ellison	Ap #876-9146 Dictum Street	4263-6443	magna.a.neque@rhoncus.edu	ultricies	WLL76FIY2AX	1	3
30	Bertha	Gonzales	Ap #664-2368 Fermentum Road	0046-6273	magna.Ut@nequesed.ca	id	UXW28TNB4MY	2	2
31	Magee	Stephenson	525-9382 Semper. Rd.	6038-1024	mauris.sapien@natoquepenatibuset.com	fringilla.	WUX98DSA4XC	2	1
32	Bell	Warren	Ap #906-4989 Arcu. St.	7839-0739	velit.Aliquam.nisl@tellusNunc.ca	Fusce	UMR12YXB3MK	1	3
33	Leo	Hopkins	5246 Auctor Rd.	7090-7436	Vivamus.nisi@eu.co.uk	velit.	EWS47FYD6MV	2	2
34	Travis	Sellers	7258 Cras Av.	3901-0954	ipsum.leo@atiaculisquis.com	ac	PWQ32DFD5PZ	1	3
35	Dillon	Bright	5279 Donec St.	7975-8425	ut@antebibendum.co.uk	Suspendisse	JXH26FIA9RI	1	3
36	Noah	Gilliam	6301 Quisque St.	4834-0764	a.nunc@hendreritid.org	pretium	GRH71BRD1FO	2	3
37	Jana	Dixon	220-6293 Nullam Road	5871-7911	sed.est@amet.com	dui.	QGO34MOP5MD	1	2
38	Bruce	Kerr	1749 Tortor, Ave	2902-5852	molestie.arcu.Sed@lacusQuisqueimperdiet.co.uk	ac	IIV02IAK7MY	2	1
39	Zenaida	Wooten	P.O. Box 393, 4584 Non, St.	0507-6541	ut.pharetra@atpretiumaliquet.net	gravida	WZL02OSR7SE	2	2
40	Anthony	Savage	Ap #657-1292 Auctor Rd.	0661-5506	odio@nibhsit.com	Morbi	XNI60NCG3CX	2	3
41	Raven	Sutton	Ap #809-4854 Blandit St.	7136-5831	enim.Suspendisse.aliquet@Sedauctor.edu	purus	AJQ35MXY5EI	2	2
42	Ray	Winters	7998 Sit Av.	6784-2148	magna.Praesent@magnaDuisdignissim.co.uk	augue	FBV16PTO0ZD	1	2
43	Myra	Vazquez	P.O. Box 221, 6166 Vivamus St.	3312-9139	urna@Aeneanegetmetus.ca	quis	YUE07EQV5UH	2	1
44	Alea	Sheppard	820-7568 Quis Road	1957-1803	magna@nequetellusimperdiet.co.uk	enim	KFT97ZSM9SI	2	2
45	Emmanuel	Barrera	679-3229 Suspendisse Road	6787-7644	Duis@Namporttitor.com	Vestibulum	ABK94LUS8FJ	2	3
46	Brody	Dennis	186-2016 Non Av.	7800-3859	a.magna@vellectus.co.uk	elementum	HIC80UXV9LW	2	1
47	Veronica	Delgado	197-4146 Ante. St.	4460-0526	ipsum@dolornonummyac.ca	id,	IVS54QUB3CH	1	2
48	Patrick	Mccullough	197 Sagittis Rd.	2722-0123	ac.nulla@consequatlectussit.net	Sed	ILS08ZZS7JA	2	2
49	Ivory	Woodward	5859 Eros. Av.	7568-5726	enim@Seddiam.co.uk	lectus.	SVJ14KMB0YZ	2	2
50	Tate	Carney	300-1601 Fusce Road	7555-7349	dignissim.Maecenas.ornare@Proinvel.com	eget	KMR75YVG7GO	2	3
51	Gillian	Schroeder	Ap #825-4842 Eu Avenue	6977-8232	augue.eu.tempor@eratvel.net	Maecenas	GCC44UOB4FV	2	1
52	Anne	Bailey	Ap #734-1444 Parturient Road	8544-2719	egestas@Etiambibendumfermentum.edu	Suspendisse	OXY75ZTM7AP	2	1
53	Gary	Spence	P.O. Box 624, 2743 Metus. St.	1492-3046	diam.luctus.lobortis@eratvitaerisus.ca	dui	RIQ25LQE8TP	1	1
54	Hayfa	Raymond	196-3689 Accumsan Ave	5013-3343	elementum.at.egestas@elementumlorem.edu	Quisque	BDX15HIL5NC	2	1
55	Bethany	Finley	Ap #261-9977 Amet St.	1577-2496	a.tortor.Nunc@non.edu	lacinia	MDG38ORO0NY	1	1
56	Ulric	Little	471-6940 Eget St.	5993-7995	tellus.Nunc@euplacerateget.org	sociis	CFP80HCN1BD	1	2
57	Angelica	Humphrey	842-2972 Mauris. St.	7236-3340	ut@inconsectetueripsum.org	lacus.	DZX11PJM2PO	2	1
58	Lillith	Mccullough	3071 Aenean St.	0115-9746	tincidunt.tempus.risus@Pellentesque.com	amet,	NIL89LEX6RK	2	3
59	Rashad	Jensen	P.O. Box 635, 2254 Et Road	5142-9484	per.conubia@enim.org	sodales	PMZ45JLI5XH	1	2
60	Ina	Davis	5478 Dolor. Avenue	1118-4186	magna.Suspendisse.tristique@apurus.net	penatibus	HZT08OSC8WW	2	2
61	Colin	Mason	9353 Aliquam Ave	3188-4320	laoreet@est.net	ante.	MKF38ATW7ED	2	1
62	Alvin	Maddox	Ap #907-3571 Ut Rd.	1245-1839	Quisque@Quisqueporttitoreros.com	dui	UBA08PPZ7WG	1	2
63	Aspen	Gross	223-9228 Phasellus Road	1171-7969	Suspendisse@massa.ca	vel	QFY00MMR5VW	2	1
64	Bethany	Benson	581-7356 At Av.	7439-8714	a.auctor.non@ornarelibero.edu	Vivamus	EHF10KMZ2XN	1	3
65	Lionel	Guerra	P.O. Box 326, 846 Vestibulum Ave	8693-1003	aliquet.metus@ridiculusmusDonec.com	neque.	MAE97VKD1AS	2	3
66	Zoe	Ruiz	368-8864 Lectus Rd.	0551-2094	non.sapien.molestie@In.org	non,	TSG96HVO4ZV	2	3
67	Vaughan	Keith	3816 A Rd.	0623-2616	aliquam@nuncInat.ca	hendrerit.	ZRQ20NXX2CV	1	2
68	Lacey	Hebert	P.O. Box 588, 3780 Lobortis, Ave	8047-4909	lorem.lorem@nondui.ca	fames	TAR84SBZ4VB	2	2
69	Vivien	English	P.O. Box 636, 8607 Lobortis, St.	4489-2861	eu.tempor.erat@acsem.org	magna.	CWZ77ESB6GP	2	2
70	Maya	George	P.O. Box 461, 6889 Erat Av.	5032-3052	diam.eu@musDonecdignissim.edu	scelerisque	CLI56CXG5OC	2	2
71	Sonia	Farley	P.O. Box 364, 3975 Id Av.	0374-8447	Nunc@dictumeleifendnunc.edu	Donec	FPA35VIM2YQ	2	1
72	Buckminster	Rivera	135-4675 Penatibus Road	5961-4505	arcu@massaSuspendisse.org	nisl	VDS68RGH7XL	2	3
73	Madeline	Page	P.O. Box 240, 4538 Suspendisse Rd.	6759-2696	sed.dictum@mieleifend.co.uk	dictum	DMQ23AEN7XS	2	2
74	Judith	Huff	Ap #897-5684 Lectus Rd.	0481-6926	a@condimentum.co.uk	gravida	UAD05GZQ9GY	2	2
75	Kristen	Garcia	4722 Tristique Ave	4010-7993	mi.lacinia.mattis@bibendumsed.co.uk	non,	MSM24FXW1WT	2	3
76	Martha	Mejia	5542 Ut St.	9719-8700	nec@metus.org	lobortis,	WLE53NLQ1RB	2	1
77	Hayfa	Gallegos	971-6528 Pharetra, St.	3208-8806	blandit.congue.In@nisisem.edu	porttitor	NNJ20YUV9QT	1	1
78	Wing	Finch	5326 Aliquet Avenue	0996-7372	mollis@feugiat.co.uk	ut	YET62IVS9VS	2	1
79	Irma	Contreras	Ap #510-5257 Dis Street	8963-1730	primis@lectusconvallis.ca	vehicula	XYG51WSU3VQ	2	3
80	Galvin	Houston	962-5624 Commodo Street	7997-3317	at@iaculis.org	malesuada	WRE59VLV0JC	2	1
81	Leroy	Neal	Ap #804-3657 Curabitur Street	8073-8876	rutrum.urna@risusDuis.ca	ante	NVG57WWG6HI	2	3
82	Ariel	Whitfield	9876 Ligula. Street	4125-4188	interdum.ligula.eu@nonduinec.ca	diam.	LZP92JVT6WL	2	2
83	Nero	Wade	5599 Luctus St.	1838-6483	vel.nisl.Quisque@suscipit.org	cursus	HRF01SQY4KX	2	3
84	Keiko	Luna	Ap #557-240 Est, Avenue	3093-0930	purus.Nullam@nostraperinceptos.ca	sociis	LEP02IXA7SN	1	3
85	Raja	Ewing	P.O. Box 443, 5628 Lorem Ave	7808-4731	malesuada.fames.ac@placerat.ca	Cum	MQZ93GCS1FE	1	2
86	Nero	Nunez	Ap #337-8499 Nam Rd.	2061-4586	dolor@noncursus.net	libero.	GHZ47RYH1MR	2	1
87	Mara	Levine	4661 Donec Road	0941-3623	velit.in.aliquet@quam.com	ut	AEE81DOL0DJ	2	2
88	Ronan	Gilmore	Ap #342-8077 Nascetur Street	2076-5956	tristique.ac.eleifend@Integervitaenibh.co.uk	enim	XUY16WQY6ET	1	3
89	Ezra	Wilkins	815-4403 Phasellus Street	9654-9102	Nulla@aliquetlobortis.ca	Proin	RRR99YYX4JP	1	3
90	Wynne	Collier	6207 Mauris Ave	4951-2442	adipiscing.Mauris.molestie@Nuncullamcorpervelit.edu	sagittis	SMM48MVA6KB	2	2
91	Leandra	Donovan	9243 Vulputate, Avenue	6653-9415	massa@etmagnis.org	In	ZWW49NQU2EI	2	3
92	Tanner	Hale	947-3555 Sodales Rd.	0502-3907	diam@congue.ca	sit	FVJ75EHB7QH	1	1
93	Scarlett	Mcconnell	5373 Ac Rd.	2994-0365	parturient.montes@arcuimperdietullamcorper.co.uk	pede	XQH99EFB4QH	1	1
94	Helen	Knox	545-803 Nec, Road	6209-7645	sem.ut.cursus@ornarelibero.edu	nec	GNZ46VOB7MG	1	1
95	Kylie	Sexton	913-6834 Quis Av.	2598-3540	orci.in@orcisem.com	Pellentesque	TEW99SWI1DR	1	1
96	Todd	Dickson	Ap #371-3829 Ac Avenue	6779-6650	Aliquam.nisl@dolornonummy.ca	Cras	SSH80VWJ1BM	2	3
97	Donna	Melton	986-506 Gravida. St.	8546-7108	cursus@pharetranibhAliquam.org	nisi	DON32PMQ5BE	2	1
98	Tate	Grant	9362 Nunc St.	1151-9913	magna.a@leo.net	gravida	OWT47RFJ1CS	1	2
99	Coby	Lambert	P.O. Box 921, 6464 Mauris Rd.	4718-4695	Donec@Donecnibh.org	a,	LJW31BYQ0XH	1	2
100	Faith	Lamb	Ap #438-5221 Pellentesque Rd.	7051-1284	dictum@aliquamerosturpis.net	vestibulum,	ZFC97YME1NV	2	3
\.


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 239
-- Name: cantidadconsultas_idcantidadconsulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cantidadconsultas_idcantidadconsulta_seq', 1, false);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 235
-- Name: causaconsulta_idcausaconsulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.causaconsulta_idcausaconsulta_seq', 1, false);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 237
-- Name: consultaprocedimiento_idconsultaprocedimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultaprocedimiento_idconsultaprocedimiento_seq', 408, true);


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 252
-- Name: consultas_idconsulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultas_idconsulta_seq', 101, true);


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 219
-- Name: doctores_iddoctor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctores_iddoctor_seq', 1, false);


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 221
-- Name: especialidaddoctor_idespecialidaddoctor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especialidaddoctor_idespecialidaddoctor_seq', 1, false);


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 216
-- Name: estadodoctor_idestadodoctor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadodoctor_idestadodoctor_seq', 1, false);


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 210
-- Name: estadopaciente_idestadopaciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadopaciente_idestadopaciente_seq', 1, false);


--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 229
-- Name: estadotratamiento_idestadotratamiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadotratamiento_idestadotratamiento_seq', 1, false);


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 204
-- Name: estadousuario_idestadousuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadousuario_idestadousuario_seq', 1, false);


--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 214
-- Name: expedientes_idexpediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expedientes_idexpediente_seq', 1, false);


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 246
-- Name: historialpagos_idhistorial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historialpagos_idhistorial_seq', 452, true);


--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 223
-- Name: pacienteasignado_idpacienteasignado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacienteasignado_idpacienteasignado_seq', 110, true);


--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 212
-- Name: pacientes_idpaciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_idpaciente_seq', 107, true);


--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 244
-- Name: pagos_idpago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_idpago_seq', 1, false);


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 248
-- Name: preguntas_idpregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_idpregunta_seq', 1, false);


--
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 233
-- Name: procedimientos_idprocedimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procedimientos_idprocedimiento_seq', 1, false);


--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 225
-- Name: recetas_idreceta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recetas_idreceta_seq', 1, false);


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 250
-- Name: respuestas_idr_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuestas_idr_seq', 3, true);


--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 254
-- Name: test12_idtest_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test12_idtest_seq', 2, true);


--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 241
-- Name: tipopago_idtipopago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipopago_idtipopago_seq', 1, false);


--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 227
-- Name: tipotratamiento_idtipotratamiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipotratamiento_idtipotratamiento_seq', 1, false);


--
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 206
-- Name: tipousuario_idtipousuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipousuario_idtipousuario_seq', 1, false);


--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 231
-- Name: tratamientos_idtratamiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tratamientos_idtratamiento_seq', 1, false);


--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 208
-- Name: usuarios_idusuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_idusuario_seq', 1, false);


--
-- TOC entry 2930 (class 2606 OID 50746)
-- Name: cantidadconsultas cantidadconsultas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cantidadconsultas
    ADD CONSTRAINT cantidadconsultas_pkey PRIMARY KEY (idcantidadconsulta);


--
-- TOC entry 2926 (class 2606 OID 50707)
-- Name: causaconsulta causaconsulta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causaconsulta
    ADD CONSTRAINT causaconsulta_pkey PRIMARY KEY (idcausaconsulta);


--
-- TOC entry 2928 (class 2606 OID 50728)
-- Name: consultaprocedimiento consultaprocedimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultaprocedimiento
    ADD CONSTRAINT consultaprocedimiento_pkey PRIMARY KEY (idconsultaprocedimiento);


--
-- TOC entry 2946 (class 2606 OID 58214)
-- Name: consultas consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_pkey PRIMARY KEY (idconsulta);


--
-- TOC entry 2908 (class 2606 OID 50598)
-- Name: doctores doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (iddoctor);


--
-- TOC entry 2906 (class 2606 OID 50590)
-- Name: especialidad especialidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (idespecialidad);


--
-- TOC entry 2911 (class 2606 OID 50611)
-- Name: especialidaddoctor especialidaddoctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidaddoctor
    ADD CONSTRAINT especialidaddoctor_pkey PRIMARY KEY (idespecialidaddoctor);


--
-- TOC entry 2904 (class 2606 OID 50585)
-- Name: estadodoctor estadodoctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadodoctor
    ADD CONSTRAINT estadodoctor_pkey PRIMARY KEY (idestadodoctor);


--
-- TOC entry 2895 (class 2606 OID 50518)
-- Name: estadopaciente estadopaciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadopaciente
    ADD CONSTRAINT estadopaciente_pkey PRIMARY KEY (idestadopaciente);


--
-- TOC entry 2934 (class 2606 OID 50769)
-- Name: estadopago estadopago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadopago
    ADD CONSTRAINT estadopago_pkey PRIMARY KEY (idestadopago);


--
-- TOC entry 2919 (class 2606 OID 50668)
-- Name: estadotratamiento estadotratamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadotratamiento
    ADD CONSTRAINT estadotratamiento_pkey PRIMARY KEY (idestadotratamiento);


--
-- TOC entry 2889 (class 2606 OID 50484)
-- Name: estadousuario estadousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadousuario
    ADD CONSTRAINT estadousuario_pkey PRIMARY KEY (idestadousuario);


--
-- TOC entry 2901 (class 2606 OID 50572)
-- Name: expedientes expedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes
    ADD CONSTRAINT expedientes_pkey PRIMARY KEY (idexpediente);


--
-- TOC entry 2939 (class 2606 OID 50803)
-- Name: historialpagos historialpagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historialpagos
    ADD CONSTRAINT historialpagos_pkey PRIMARY KEY (idhistorial);


--
-- TOC entry 2913 (class 2606 OID 50629)
-- Name: pacienteasignado pacienteasignado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacienteasignado
    ADD CONSTRAINT pacienteasignado_pkey PRIMARY KEY (idpacienteasignado);


--
-- TOC entry 2899 (class 2606 OID 50526)
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (idpaciente);


--
-- TOC entry 2937 (class 2606 OID 50777)
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (idpago);


--
-- TOC entry 2942 (class 2606 OID 58101)
-- Name: preguntas preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (idpregunta);


--
-- TOC entry 2924 (class 2606 OID 50699)
-- Name: procedimientos procedimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimientos
    ADD CONSTRAINT procedimientos_pkey PRIMARY KEY (idprocedimiento);


--
-- TOC entry 2915 (class 2606 OID 50647)
-- Name: recetas recetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT recetas_pkey PRIMARY KEY (idreceta);


--
-- TOC entry 2944 (class 2606 OID 58161)
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (idrespuesta);


--
-- TOC entry 2949 (class 2606 OID 66436)
-- Name: test12 test12_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test12
    ADD CONSTRAINT test12_pkey PRIMARY KEY (idtest);


--
-- TOC entry 2932 (class 2606 OID 50764)
-- Name: tipopago tipopago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipopago
    ADD CONSTRAINT tipopago_pkey PRIMARY KEY (idtipopago);


--
-- TOC entry 2917 (class 2606 OID 50660)
-- Name: tipotratamiento tipotratamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipotratamiento
    ADD CONSTRAINT tipotratamiento_pkey PRIMARY KEY (idtipotratamiento);


--
-- TOC entry 2891 (class 2606 OID 50492)
-- Name: tipousuario tipousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipousuario
    ADD CONSTRAINT tipousuario_pkey PRIMARY KEY (idtipousuario);


--
-- TOC entry 2922 (class 2606 OID 50676)
-- Name: tratamientos tratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (idtratamiento);


--
-- TOC entry 2893 (class 2606 OID 50500)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (idusuario);


--
-- TOC entry 2896 (class 1259 OID 58071)
-- Name: dui_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dui_paciente ON public.pacientes USING btree (duipaciente);


--
-- TOC entry 2947 (class 1259 OID 58226)
-- Name: indiceconsultas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indiceconsultas ON public.consultas USING btree (notasconsulta);


--
-- TOC entry 2940 (class 1259 OID 58228)
-- Name: indicehistorial; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicehistorial ON public.historialpagos USING btree (fecharegistro, nombrepaciente, pagodebeh, pagoabonoh, pagosaldoh);


--
-- TOC entry 2897 (class 1259 OID 58225)
-- Name: indicepacientes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicepacientes ON public.pacientes USING btree (nombrepaciente, apellidopaciente);


--
-- TOC entry 2935 (class 1259 OID 58227)
-- Name: indicepagos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicepagos ON public.pagos USING btree (pagoabono, pagototal, pagosaldo, pagodebe);


--
-- TOC entry 2909 (class 1259 OID 58231)
-- Name: indicesdoctores; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicesdoctores ON public.doctores USING btree (nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor);


--
-- TOC entry 2902 (class 1259 OID 58230)
-- Name: indicesexpedientes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicesexpedientes ON public.expedientes USING btree (notasmedicas, odontograma, periodontograma);


--
-- TOC entry 2920 (class 1259 OID 58229)
-- Name: indicetratamientos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX indicetratamientos ON public.tratamientos USING btree (fechainicio, descripciontratamiento);


--
-- TOC entry 2979 (class 2620 OID 58093)
-- Name: pagos hoja_pagos_tratamientos; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hoja_pagos_tratamientos AFTER UPDATE ON public.pagos FOR EACH ROW EXECUTE FUNCTION public.historial_pagos();


--
-- TOC entry 2978 (class 2620 OID 50809)
-- Name: pagos hoja_pagos_tratamientos_nombres; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER hoja_pagos_tratamientos_nombres AFTER UPDATE ON public.pagos FOR EACH ROW EXECUTE FUNCTION public.historial_pagos_nombres();


--
-- TOC entry 2964 (class 2606 OID 50752)
-- Name: cantidadconsultas cantidadconsultas_idtratamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cantidadconsultas
    ADD CONSTRAINT cantidadconsultas_idtratamiento_fkey FOREIGN KEY (idtratamiento) REFERENCES public.tratamientos(idtratamiento);


--
-- TOC entry 2963 (class 2606 OID 50734)
-- Name: consultaprocedimiento consultaprocedimiento_idprocedimiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultaprocedimiento
    ADD CONSTRAINT consultaprocedimiento_idprocedimiento_fkey FOREIGN KEY (idprocedimiento) REFERENCES public.procedimientos(idprocedimiento);


--
-- TOC entry 2977 (class 2606 OID 58215)
-- Name: consultas consultas_idcausaconsulta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_idcausaconsulta_fkey FOREIGN KEY (idcausaconsulta) REFERENCES public.causaconsulta(idcausaconsulta);


--
-- TOC entry 2954 (class 2606 OID 50599)
-- Name: doctores doctores_idestadodoctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctores
    ADD CONSTRAINT doctores_idestadodoctor_fkey FOREIGN KEY (idestadodoctor) REFERENCES public.estadodoctor(idestadodoctor);


--
-- TOC entry 2955 (class 2606 OID 50612)
-- Name: especialidaddoctor especialidaddoctor_iddoctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidaddoctor
    ADD CONSTRAINT especialidaddoctor_iddoctor_fkey FOREIGN KEY (iddoctor) REFERENCES public.doctores(iddoctor);


--
-- TOC entry 2956 (class 2606 OID 50617)
-- Name: especialidaddoctor especialidaddoctor_idespecialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidaddoctor
    ADD CONSTRAINT especialidaddoctor_idespecialidad_fkey FOREIGN KEY (idespecialidad) REFERENCES public.especialidad(idespecialidad);


--
-- TOC entry 2953 (class 2606 OID 50573)
-- Name: expedientes expedientes_idpaciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expedientes
    ADD CONSTRAINT expedientes_idpaciente_fkey FOREIGN KEY (idpaciente) REFERENCES public.pacientes(idpaciente);


--
-- TOC entry 2976 (class 2606 OID 58202)
-- Name: respuestas fk_idpaciente_respuestas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT fk_idpaciente_respuestas FOREIGN KEY (idpaciente) REFERENCES public.pacientes(idpaciente);


--
-- TOC entry 2958 (class 2606 OID 50635)
-- Name: pacienteasignado pacienteasignado_iddoctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacienteasignado
    ADD CONSTRAINT pacienteasignado_iddoctor_fkey FOREIGN KEY (iddoctor) REFERENCES public.doctores(iddoctor);


--
-- TOC entry 2957 (class 2606 OID 50630)
-- Name: pacienteasignado pacienteasignado_idpaciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacienteasignado
    ADD CONSTRAINT pacienteasignado_idpaciente_fkey FOREIGN KEY (idpaciente) REFERENCES public.pacientes(idpaciente);


--
-- TOC entry 2952 (class 2606 OID 50527)
-- Name: pacientes pacientes_idestadopaciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_idestadopaciente_fkey FOREIGN KEY (idestadopaciente) REFERENCES public.estadopaciente(idestadopaciente);


--
-- TOC entry 2967 (class 2606 OID 50788)
-- Name: pagos pagos_idestadopago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_idestadopago_fkey FOREIGN KEY (idestadopago) REFERENCES public.estadopago(idestadopago);


--
-- TOC entry 2966 (class 2606 OID 50783)
-- Name: pagos pagos_idtipopago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_idtipopago_fkey FOREIGN KEY (idtipopago) REFERENCES public.tipopago(idtipopago);


--
-- TOC entry 2965 (class 2606 OID 50778)
-- Name: pagos pagos_idtratamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_idtratamiento_fkey FOREIGN KEY (idtratamiento) REFERENCES public.tratamientos(idtratamiento);


--
-- TOC entry 2959 (class 2606 OID 50648)
-- Name: recetas recetas_idpacienteasignado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recetas
    ADD CONSTRAINT recetas_idpacienteasignado_fkey FOREIGN KEY (idpacienteasignado) REFERENCES public.pacienteasignado(idpacienteasignado);


--
-- TOC entry 2968 (class 2606 OID 58162)
-- Name: respuestas respuestas_idpregunta1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta1_fkey FOREIGN KEY (idpregunta1) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2969 (class 2606 OID 58167)
-- Name: respuestas respuestas_idpregunta2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta2_fkey FOREIGN KEY (idpregunta2) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2970 (class 2606 OID 58172)
-- Name: respuestas respuestas_idpregunta3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta3_fkey FOREIGN KEY (idpregunta3) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2971 (class 2606 OID 58177)
-- Name: respuestas respuestas_idpregunta4_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta4_fkey FOREIGN KEY (idpregunta4) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2972 (class 2606 OID 58182)
-- Name: respuestas respuestas_idpregunta5_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta5_fkey FOREIGN KEY (idpregunta5) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2973 (class 2606 OID 58187)
-- Name: respuestas respuestas_idpregunta6_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta6_fkey FOREIGN KEY (idpregunta6) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2974 (class 2606 OID 58192)
-- Name: respuestas respuestas_idpregunta7_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta7_fkey FOREIGN KEY (idpregunta7) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2975 (class 2606 OID 58197)
-- Name: respuestas respuestas_idpregunta8_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_idpregunta8_fkey FOREIGN KEY (idpregunta8) REFERENCES public.preguntas(idpregunta);


--
-- TOC entry 2962 (class 2606 OID 50687)
-- Name: tratamientos tratamientos_idestadotratamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_idestadotratamiento_fkey FOREIGN KEY (idestadotratamiento) REFERENCES public.estadotratamiento(idestadotratamiento);


--
-- TOC entry 2960 (class 2606 OID 50677)
-- Name: tratamientos tratamientos_idpacienteasignado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_idpacienteasignado_fkey FOREIGN KEY (idpacienteasignado) REFERENCES public.pacienteasignado(idpacienteasignado);


--
-- TOC entry 2961 (class 2606 OID 50682)
-- Name: tratamientos tratamientos_idtipotratamiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_idtipotratamiento_fkey FOREIGN KEY (idtipotratamiento) REFERENCES public.tipotratamiento(idtipotratamiento);


--
-- TOC entry 2950 (class 2606 OID 50501)
-- Name: usuarios usuarios_idestadousuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_idestadousuario_fkey FOREIGN KEY (idestadousuario) REFERENCES public.estadousuario(idestadousuario);


--
-- TOC entry 2951 (class 2606 OID 50506)
-- Name: usuarios usuarios_idtipousuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_idtipousuario_fkey FOREIGN KEY (idtipousuario) REFERENCES public.tipousuario(idtipousuario);


-- Completed on 2021-07-07 16:15:04

--
-- PostgreSQL database dump complete
--

