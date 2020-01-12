
CREATE PROCEDURE AgregarEmpleado
	@codEmpleado varchar(10),
	@dNombre varchar(50),
	@nTelefono int,
	@dDireccion varchar (100)
AS
	insert into Empleado values (@codEmpleado,@dNombre,@nTelefono,@dDireccion)
	RETURN 1 

CREATE PROCEDURE AgregarMedico
	@codEmpleado varchar(10),
	@dNombre varchar(50),
	@nTelefono int,
	@dDireccion varchar (100),

	@dEspacialidad	varchar(50),
	@nNumColegioMedico int
AS
	exec AgregarEmpleado @codEmpleado,@dNombre,@nTelefono,@dDireccion;
	insert into Medico values (@codEmpleado,@dEspacialidad,@nNumColegioMedico)
	return 1;

CREATE PROCEDURE AgregarEnfermera
	@codEmpleado varchar(10),
	@dNombre varchar(50),
	@nTelefono int,
	@dDireccion varchar (100)
AS
	exec AgregarEmpleado @codEmpleado,@dNombre,@nTelefono,@dDireccion;
	insert into Enfermera values (@codEmpleado);
	return 1;

CREATE PROCEDURE AgregarTecnicaEnfermeria
	@codEmpleado varchar(10),
	@dNombre varchar(50),
	@nTelefono int,
	@dDireccion varchar (100)
AS
	exec AgregarEmpleado @codEmpleado,@dNombre,@nTelefono,@dDireccion;
	insert into [Tecnica de enfermeria] values (@codEmpleado);
	return 1;





CREATE PROCEDURE AgregarHistoriaClinica
	@codHistoria varchar(10),
	@dGrupoSanguineo varchar (2) =NULL,
	@dFactorRH	varchar(1)=NULL,
	@nEdad NCHAR(30)=NULL,
	@bGenero VARCHAR(50)=NULL,
	@codAnt_G_Obstetrico VARCHAR(10)=NULL,
	@codExploracionFisica VARCHAR(10)=NULL
	AS
	INSERT INTO [Historia Cl�nica] 
	VALUES (@codHistoria,@dGrupoSanguineo,@dFactorRH,@nEdad,@bGenero,@codAnt_G_Obstetrico,@codExploracionFisica);

CREATE PROCEDURE AgregarResponsable
	@codPersonaResponsable varchar (10),
	@dNombre varchar (100),
	@nTelefono int,
	@dDomicilio VARCHAR (100)
	AS
	INSERT INTO [Persona Responsable] 
	VALUES (@codPersonaResponsable,@dNombre,@nTelefono,@dDomicilio)

CREATE PROCEDURE AgregarPaciente
	@codPaciente nchar(20),
	@dNombre varchar(100),
	@dDni nchar(20),
	@dLugarProcedencia varchar(100),
	@dDomicilio varchar(100),
	@codPersonaResponsable varchar(10),
	@PResponsableNombre varchar(100),
	@PResponsableTelefono int,
	@PResponsableDomicilio varchar(100),
	@codSede varchar(10),
	@codHabitacion varchar(10),
	@codSeguro varchar(10),
	@codHistoriaClinica varchar(10),
	@codMedicoActual varchar(10),
	@codEnfermera varchar(10),
	@codTecnica1 varchar(10),
	@codTecnica2 varchar(10),
	@parentescoResponsable varchar(50),
	@codDistrito int,
	@a�oLLegadaLima int
	AS
	EXEC AgregarHistoriaClinica @codHistoriaClinica;
	EXEC AgregarResponsable @codPersonaResponsable,@PResponsableNombre,@PResponsableTelefono,@PResponsableDomicilio;
	INSERT INTO Paciente 
	values (@codPaciente,@dNombre,@dDni, @dLugarProcedencia,@dDomicilio,@codPersonaResponsable,@codSede,@codHabitacion,@codSeguro,@codHistoriaClinica,@codMedicoActual,@codEnfermera,@codTecnica1,@codTecnica2,@parentescoResponsable,@codDistrito,@a�oLLegadaLima)


/*-------modificar*/
CREATE PROCEDURE ModificarExploracionFisica
	@codExploracion varchar(10),
	@dPresionArterial varchar(10)=NULL,
	@nFrecuenciaCardiaca int=NULL,
	@nFrecuenciaRespiratoria int=NULL,
	@nTemperatura float =NULL,
	@nPeso int=NULL,
	@nTalla real=NULL,
	@dDescripcionFisica varchar(200)=NULL
AS
	if not exists (select * from [Exploraci�n F�sica] where CodExploraci�n=@codExploracion)
	begin
		INSERT INTO [Exploraci�n F�sica] VALUES
		(@codExploracion,@dPresionArterial,@nFrecuenciaCardiaca,@nFrecuenciaRespiratoria,@nTemperatura,@nPeso,@nTalla,@dDescripcionFisica)
		RETURN 1;
	end
	else
	begin
		UPDATE [Exploraci�n F�sica] 
		SET DPresionArterial=@dPresionArterial ,NFrecuenciaCardiaca=@nFrecuenciaCardiaca, NFrecuenciaRespiratoria=@nFrecuenciaRespiratoria,NTemperatura=@nTemperatura,NTalla=@nTalla,DDescripcionFisica=@dDescripcionFisica
		WHERE CodExploraci�n=@codExploracion 
		RETURN 0;
	end

CREATE PROCEDURE ModificarAntGinecoObstetrico
	@codAntecedente VARCHAR(10),
	@numGestaciones int=0,
	@numPartos int=0,
	@numAbortos int=0
AS
	if not exists(select * from [Antecedentes Gineco-Obst�tricos] WHERE CodAntecedente=@codAntecedente)
	BEGIN
		INSERT INTO [Antecedentes Gineco-Obst�tricos] 
		VALUES (@codAntecedente,@numGestaciones,@numPartos,@numAbortos)
		RETURN 1;
	END
	ELSE
	BEGIN
		UPDATE [Antecedentes Gineco-Obst�tricos] 
		SET NumGestaciones=@numGestaciones, NumPartos=@numPartos, NumAbortos=@numAbortos
		RETURN 0
	END

CREATE PROCEDURE ModificarHistoriaClinica
	@codHistoriaClinica varchar(10),
	@dGrupoSanguineo varchar(2),
	@dFactorRH VARCHAR(1),
	@nEdad nchar(20),
	@bGenero NCHAR(20),
	@codAnt_G_Obstetrico VARCHAR(10),
	@codExploracionFisica VARCHAR(10)
AS
	EXEC ModificarExploracionFisica @codExploracionFisica;
	EXEC ModificarAntGinecoObstetrico @codAnt_G_Obstetrico;
	UPDATE [Historia Cl�nica] 
	SET DGrupoSanguineo=@dGrupoSanguineo,DFactorRH=@dFactorRH, NEdad=@nEdad,BG�nero=@bGenero,CodAnt_G_Obstetrico=@codAnt_G_Obstetrico,CodExploracionFisica=@codExploracionFisica;

/*UPDATES*/


SELECT * FROM [Persona Responsable]
ALTER PROCEDURE CambiarPacienteHabitacion
	@codPaciente nchar(20),
	@codNuevaHabitacion varchar(10)
AS
	UPDATE Paciente
	SET CodHabitacion=@codNuevaHabitacion
	WHERE CodPaciente=@codPaciente;


ALTER PROCEDURE CambiarPacienteResponsable
	@codPaciente nchar(20),
	@codNuevoResponsable varchar(10)
AS
	UPDATE Paciente
	SET CodPersonaResponsable=@codNuevoResponsable
	WHERE CodPaciente=@codPaciente;

/*-----triggers on delete----*/
CREATE TRIGGER tr_Paciente
ON Paciente
FOR DELETE
AS
BEGIN
	DECLARE @codHistoria VARCHAR(20);
	DECLARE @codResponsable VARCHAR(10);

	SET @codHistoria= (SELECT CodHistoriaClinica FROM deleted)
	SET @codResponsable=(SELECT CodPersonaResponsable from deleted)

	DELETE [Historia Cl�nica] WHERE CodHistoriaClinica=@codHistoria;
	DELETE [Persona Responsable] WHERE CodPersonaResponsable=@codResponsable;
END


CREATE TRIGGER tr_HistoriaClinica
ON [Historia Cl�nica]
FOR DELETE
AS
BEGIN
	DECLARE @codExploracion VARCHAR(10);
	DECLARE @codAntGO VARCHAR(10);
	SET @codExploracion=(SELECT CodExploracionFisica FROM deleted)
	SET @codAntGO=(SELECT CodAnt_G_Obstetrico FROM deleted)

	DELETE [Exploraci�n F�sica] WHERE CodExploraci�n=@codExploracion;
	DELETE [Antecedentes Gineco-Obst�tricos] WHERE CodAntecedente=@codAntGO;
END



/*-----Consultas----*/

-- 1. Hacer una consulta para conocer a los pacientes con frecuencia respiratoria fuera del rango normal (13-17) 
--    Razon: En �poca de mayor fr�o en Lima se deben tener mayor precauci�n en su cuidado debido a sus 
--    antecedentes con enfermedades pulmonares. 

select P.CodPaciente, P.DNombre, EF.NFrecuenciaRespiratoria
from Paciente P
join [Historia Cl�nica] HD on P.CodHistoriaClinica=HD.CodHistoriaClinica
join [Exploraci�n F�sica] EF on HD.CodExploracionFisica=EF.CodExploraci�n
where EF.NFrecuenciaRespiratoria>17 or EF.NFrecuenciaRespiratoria<12
group by P.CodPaciente, P.DNombre, EF.NFrecuenciaRespiratoria
order by EF.NFrecuenciaRespiratoria asc


--2. Hacer una consulta para conocer los pacientes con antecedentes familiares de c�ncer y que tengan mas de 65 a�os.
--   Raz�n: Al aumentar nuestra edad, mayor es el riesgo de manifestarse algun tipo de c�ncer.
--   Esto incrementa cuando los adultos mayores tienen alg�n tipo de antecedentes familiares de esta enfermedad

select distinct P.CodPaciente, P.DNombre, AF.DParentesco, AF.DDescripcion
from Paciente P
join [Historia Cl�nica] HD on P.CodHistoriaClinica=HD.CodHistoriaClinica
join AFamiliarxHClinica AFHC on HD.CodHistoriaClinica=AFHC.CodHistoriaClinica
join [Antecedente Familiar] AF on AFHC.CodAntecedente=AF.CodAntecedenteFamiliar
where HD.NEdad>65 and AF.DDescripcion like '%c�ncer%'

 
--3. Crear una funci�n para agrupar a pacientes por tipo de enfermedad con tratamiento
--    Razon: Se puede evaluar si es necesario contratar a mas personal m�dico que trate estos tipos
--	  de enfermedad. 

create function PacientexTEnfermedad (@TEnfermedad varchar(20))
returns @PxT table
(CodPaciente varchar(20), DNombre varchar(50), CodHistoriaClinica varchar(20), DTipo varchar(20), DTratamiento varchar(50))
as
begin
insert @PxT
select P.CodPaciente , P.DNombre, P.CodHistoriaClinica, AP.DTipo, AP.DTratamiento
from Paciente P
join APatologicoxHClinica AHC on P.CodHistoriaClinica=AHC.CodHistoriaClinica
join [Antecedente Patol�gico] AP on AHC.CodAntecedente=AP.CodAntecedente
where AP.DTipo=@TEnfermedad and AP.DTratamiento is not null
return
end

select *from dbo.PacientexTEnfermedad('CARDIOVASCULAR')


--4. Hacer una consulta de los pacientes que puedan donar sangre y que cumplan con requisitos m�dicos m�nimos.
--   Tener entre 18 y 65 a�os, y no tener enfermedades cardiovasculares.
--   Razon: En caso de una donaci�n de emergencia, se desea conocer los pacientes que pueden donar y que cumplan con
--   los requisitos m�nimos.

select distinct P.CodPaciente, P.DNombre, HD.NEdad
from Paciente P
join [Historia Cl�nica] HD on P.CodHistoriaClinica=HD.CodHistoriaClinica
join APatologicoxHClinica AHC on HD.CodHistoriaClinica=AHC.CodHistoriaClinica
join [Antecedente Patol�gico] AP on AHC.CodAntecedente=AP.CodAntecedente
where HD.NEdad>=18 and HD.NEdad<=72 and AP.DTipo not in ('CARDIOVASCULAR');


--5. Crear una funci�n para saber los pacientes que provienen de un determinado distrito
--   Razon: Se puede evaluar si es necesario y rentable la construcci�n de una nueva sede en las
--   regiones con una mayor poblaci�n de audltos mayores

create function Paciente_Distrit2 (@PacDistrit varchar(50))
returns @PxD table
(CodDistrito int, Nombre varchar(50), CodPaciente varchar(20), DNombre varchar(50), DDomicilio varchar(100))
as
begin
insert @PxD
select D.CodDistrito, D.DNombre, P.CodPaciente , P.DNombre, P.DDomicilio
from Paciente P
join Distrito D on P.CodDistrito=D.CodDistrito
where @PacDistrit=D.DNombre and D.DNombre <> 'Lima'
AND D.DNombre <> 'Miraflores'
AND D.DNombre <> 'Pueblo Libre'
return
end

select *from dbo.Paciente_Distrit2('Callao')



--6. Conocer el grupo sangu�neo y factor RH de pacientes que reciben tratamiento de anticoagulantes (pacientes post-operados de v�lvula cardiaca) 
--//Agregar A. Patol�gico de tipo quir�rgico O, pacientes con trombosis venosa o arterial (A. Patol�gico cardiovascular) 
-- Debido a que hay pacientes que son m�s propensos a sangrar m�s que otros. Por tal motivo, 
--se necesita llevar un control con respecto a dichos pacientes.


select P.CodPaciente, P.DNombre,(HC.DGrupoSanguineo + ' ' + HC.DFactorRH) as 'TIPO SANGUINEO'
from Paciente P
join [Historia Cl�nica] HC on P.CodHistoriaClinica = HC.CodHistoriaClinica 
join APatologicoxHClinica APHC on HC.CodHistoriaClinica = APHC.CodHistoriaClinica
join [Antecedente Patol�gico] AP on APHC.CodAntecedente = AP.CodAntecedente 
where AP.DTratamiento like '%ANTICOAGULANTES%'



--7. Conocer la cantidad de espacios libres de cada casa de reposo
--Esto sirve para llevar un control riguroso con respecto a las camas discponibles que hay por sede.

create view Capacidad_Total 
as
select H.CodSede as 'Codigo Sede', sum(H.NNumeroCamas) as 'Capacidad'
from Habitaci�n H
join Sede S on H.CodSede = S.CodSede
group by H.CodSede

create view Espacios_Ocupados
as
select S.CodSede, count(P.CodPaciente) as 'Espacios Ocupados'
from Capacidad_Total CT
join Sede S on CT.CodSede = S.CodSede
join Paciente P on S.CodSede = P.CodSede
group by 2 asc

select S.CodSede, CT.Capacidad - EO.[Espacios Disponibles] as 'Espacios Disponibles'
from Sede S
join Capacidad_Total CT on S.CodSede = CT.CodSede
join Espacios_Ocupados EO on S.CodSede = EO.CodSede
order by 2 desc


--8. Mostrar cantidad de pacientes A. Patol�gico que padezca, 
--ordenados de mayor a menor, para saber que pedidos de medicamentos deben hacerse. 
--Sirve para saber que pedidos deber�an hacerse m�s seguidos, ya que si los pacientes no cuentan con el tratamiento debido podr�an llegar a
--tener complicaciones en sus evoluciones.

select AP.DTratamiento, count(P.CodPaciente) as 'Cantidad de Pacientes'
from Paciente P
join [Historia Cl�nica] HC on P.CodHistoriaClinica = HC.CodHistoriaClinica 
join APatologicoxHClinica APHC on HC.CodHistoriaClinica = APHC.CodHistoriaClinica
join [Antecedente Patol�gico] AP on APHC.CodAntecedente = AP.CodAntecedente
where AP.DTratamiento is not null
group by AP.DTratamiento
order by 2 desc


--9. Crear una funcion que reciba medico y mes para saber si cumple con todas las evoluciones que debio completar en dicho mes.
--Esto sirve par llevar un control sobre las evoluciones dadas por los m�dicos.

create function dbo.Medico_Mes(@mes int, @codigo varchar(10)) returns table
as
return (select M.CodEmpleado as 'Codigo Medico',
		E.Fecha as 'Mes'
		from Medico M
		join Evoluci�n E on M.CodEmpleado = E.CodMedico 
		where month(E.Fecha)=@mes
		and M.CodEmpleado = @codigo)
go
select * from Medico_Mes(08 ,'MEDMED0001')
SELECT* FROM Evoluci�n


--10. Crear un trigger para realizar un cambio de m�dico a un determinado paciente

select * from Paciente

create trigger Tx_CambioMedico on Paciente
for update
as
begin
		if update(CodMedicoActual)
		begin 
			declare @codigo varchar(10)
			declare @nuevo varchar(10)
			declare @viejo varchar(10)
			select @nuevo = CodMedicoActual from inserted
			select @viejo = CodMedicoActual from deleted
			update Paciente
			set CodPaciente = @codigo
			where CodPaciente = @codigo
		end
end
update Paciente
set CodMedicoActual = 'MEDMED0003'
where CodPaciente = 'PACPAC0002'
--

-- 11. Hacer consulta de la cantidad de pacientes que hay seg�n padecimiento para tener en cuenta a qu� especialistas se contactar� para realizar las debidas interconsultas: por ejemplo pacientes con hipertensi�n no controlada: CARDIOLOGO, fibrosis pulmonar senil: NEUMOLOGO 

SELECT AP.DTipo,COUNT(P.CodPaciente) as 'Cantidad de Pacientes'
FROM Paciente P
JOIN [Historia Cl�nica] HC ON P.CodHistoriaClinica=HC.CodHistoriaClinica
JOIN APatologicoxHClinica APHC ON HC.CodHistoriaClinica=APHC.CodHistoriaClinica
JOIN [Antecedente Patol�gico] AP ON APHC.CodAntecedente=AP.CodAntecedente
GROUP BY AP.DTipo
ORDER BY 2 DESC

-- 12. Hacer una consulta ya que se desea conocer una lista de los pacientes ordenados por edad, con su respectivo seguro y que tengan una frecuencia cardiaca por encima de lo normal.  

select P.DNombre, HC.NEdad, EF.NFrecuenciaCardiaca, S.CodSeguro
from Paciente P 
JOIN [Historia Cl�nica] HC ON P.CodHistoriaClinica=HC.CodHistoriaClinica
JOIN [Exploraci�n F�sica] EF ON HC.CodExploracionFisica=EF.CodExploraci�n
JOIN Seguro S ON P.CodSeguro=S.CodSeguro
WHERE EF.NFrecuenciaCardiaca > 60
order by HC.NEdad desc


-- 13. Se desea saber qui�n es la persona encargada de cada paciente con su respectiva direcci�n ordenando por prioridad de parentesco, es decir familiares primero. Esto para notificar el status del paciente por mensajes diarios.

select PR.DNombre, PR.NTel�fono, PR.DDomicilio,P.ParentescoConResponsable, P.CodPaciente
from [Persona Responsable] PR
JOIN Paciente P ON PR.CodPersonaResponsable=P.CodPersonaResponsable
where ParentescoConResponsable like '%ADRE'
ORDER BY PR.DNombre

-- 14. Mostrar las habitaciones con la cantidad de camas disponibles de cada sede, con el objetivo de llevar un control de la disponibilidad al cambio de pacientes a otras habitaciones. 


select H.CodHabitaci�n, H.NNumeroCamas, P.CodPaciente, P.DNombre
from Habitaci�n H
JOIN Paciente P ON H.CodHabitaci�n=P.CodHabitacion
where CodHabitacion like 'LIMLIMH001'

create trigger TRIGGER3_Habitacion on Habitaci�n
for update
as
set nocount on
declare @NNumeroCamas int
select @NNumeroCamas=@NNumeroCamas from inserted
go
update Habitaci�n
set NNumeroCamas = 2
where NPiso= 1
AND CodHabitaci�n ='LIMLIMH00%'

select * from Habitaci�n

-- 15. Hacer una funci�n donde se desea conocer el lugar de procedencia de determinados pacientes llegados en el 2018 seg�n el departamento que requiera, con el fin de tratar medicamente de acuerdo a la zona.


create function LugarxProcedencia0 (@Lugar varchar (20))
returns @Pacientes table
(CodPaciente varchar(20), DNombre varchar(50),FA�oLlegadaLima int, DLugarprocedencia varchar(20))
as
begin
Insert @Pacientes select CodPaciente, DNombre,FA�oLlegadaLima, DLugarProcedencia
 from Paciente 
where DLugarProcedencia=@Lugar
and FA�oLLegadaLima = 2018 
Order By DNombre 
return 
end
--
select * from dbo.LugarxProcedencia0('MADRE DE DIOS') -- madre de dios, puerto maldonado

