-------------------------------- Functions ------------------------------------------------------------------------------------------------

create or replace function Calculo_Cuenta(int) returns void AS $$
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
$$ 
LANGUAGE plpgsql VOLATILE;

---------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------
create or replace function Calculo_Saldo(id_p int, abono numeric) returns void AS $$
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
$$ 
LANGUAGE plpgsql VOLATILE;


----------------------------------------------- Como llamar las funciones ------------------------------------------------------

--- Para llamar una función en postgresql, se usa un llamado como si fuese un query,
---  y apartir de ello se siguen las solicitudes de entrada que se encuentran en el parentesis 
--- donde se declararon las variables de entrada. 

-- Select * from Calculo_Cuenta(1);
-- Select * from Calculo_Saldo(1,'0.00');
--------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ Triggers ----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

drop Trigger Hoja_Pagos_Tratamientos On Pagos;
drop function Historial_pagos();

Create or replace function Historial_Pagos() Returns Trigger As $$
	  Begin 	  
	  Insert into historialPagos (fecharegistro,pagodebeH,pagoabonoH,pagototalH,pagosaldoH,tratamiento,tipopago)
	  Values (current_timestamp,new.pagodebe,new.pagoabono,new.pagototal,new.pagosaldo,new.idtratamiento,new.idtipopago);	  	  
	  Return null;
end;
$$ Language plpgsql; 

Create Trigger Hoja_Pagos_Tratamientos
After Update 
on Pagos For each Row 
Execute Procedure Historial_Pagos();
---/////////--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
Create or replace function Historial_Pagos_nombres() Returns Trigger As $$
declare
idH int = (Select Tratamiento From historialPagos Where idhistorial=(Select max(idhistorial) From HistorialPagos));
nombre text =(Select nombrePaciente ||' '|| apellidoPaciente From Pagos pg Inner join Tratamientos tr on pg.idTratamiento=tr.idTratamiento Inner join PacienteAsignado pa on pa.idpacienteasignado = tr.idpacienteasignado Inner join Pacientes pc on pc.idpaciente = pa.idpaciente Where idpago=idH);
	  Begin 
      Update historialPagos set nombrePaciente =nombre Where Tratamiento=idH ;
	  Return null;
end;
$$ Language plpgsql; 

Create Trigger Hoja_Pagos_Tratamientos_nombres
After Update 
on Pagos For each Row 
Execute Procedure Historial_Pagos_nombres();

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--//
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

Create or replace function Buscar_Incoincidentes () returns setof Consultas as $$
begin
return query
SELECT * FROM consultas
WHERE idconsulta NOT IN(SELECT idconsulta FROM consultaprocedimiento);
end;
$$
language plpgsql;

-----------------------------------------------------------------------------------------
Create or replace function Actualizar_Pagos (idT int) returns void as $$
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
$$
language plpgsql;
----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Create or replace function Actualizar_Incoincidentes (idC int, costo numeric) returns void  as $$
begin
Update consultas set costoconsulta=costo Where idconsulta = idC;
return;
end;
$$
language plpgsql

-----------------------------------------------------------------------

create or replace function Buscar_Cuentas (idT int) returns table(Tr int,fecha timestamp without time zone, 
														 debe numeric, abono numeric, saldo numeric) as $$
begin
return query
Select tratamiento ,fecharegistro, pagodebeh, pagoabonoh, pagosaldoh
From historialpagos
Where pagoabonoh >=0
And tratamiento = idT;
end;
$$
language plpgsql;
---------------------------------------------------------------------------------------------------

Create or replace function Buscar_preguntas() returns void as $$
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
-------------------------------------------------------------------
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
$$
language plpgsql;



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---------------------------------- Llamar a todas las funciones  ------------------------------

-- 1- Realizar la Actualización de la tabla pagos 
Select * From Calculo_cuenta (1);
-- 2- Calcular los pagos y desencadenar trigger
Select * From Calculo_saldo(1,'49.80');
-- 3- buscar las Consultas que no estan relacionadas con ningún procedimiento
Select * from Buscar_Incoincidentes();
-- 4- Actualizar una cuenta si han habido más consultas 
Select * from Actualizar_Pagos (1);
-- 5- Usar En Caso de Necesitar actualizar el valor de una consulta que no posee un procedimiento
Select * from Actualizar_Incoincidentes(2,'25.00');
-- 6- Buscar los pagos realizados por un paciente especifico 
Select * from Buscar_Cuentas (1);
-- 7- Buscar todas las preguntas en un raise notice
Select * from buscar_preguntas();

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

