--Create database dbclinica
--Drop database dbclinica

Create table EstadoUsuario(
idEstadoUsuario serial primary key not null,
	EstadoUsuario varchar(15) not null
);

Create table TipoUsuario(
idTipoUsuario serial primary key not null,
	TipoUsuario varchar (25) not null
);

Create table Usuarios(
idUsuario serial primary key not null,
    nombreUsuario varchar (25) not null,
	apellidoUsuario varchar (25) not null,
	direccionUsuario varchar (155) not null,
	telefonoUsuario varchar (9) not null,
	correoUsuario varchar (55) not null,
	aliasUsuario varchar (15) not null,
	claveUsuario varchar (100) not null,
	idEstadoUsuario int not null references EstadoUsuario (idEstadoUsuario),
	idTipoUsuario int not null references TipoUsuario (idTipoUsuario)
);

Create table EstadoPaciente(
idEstadoPaciente serial primary key not null,
	EstadoPaciente varchar(15) not null
);

Create table Pacientes(
idPaciente serial primary key not null,
	nombrePaciente varchar(25) not null,
	apellidoPaciente varchar(25) not null,
	fechaNacimiento date not null,
	duiPaciente varchar(10) not null,
	direccionPaciente varchar(155) not null,
	telefonoPaciente varchar(9) not null,
	correoPaciente varchar(55) not null,
	fotoPaciente varchar(100),
	idEstadoPaciente int not null references EstadoPaciente(idEstadoPaciente)
);

Create table Preguntas(
idPregunta serial primary key not null,
	Pregunta varchar(69) not null
);

Create table Respuestas(
idrespuesta serial primary key not null,
	respuesta1 varchar(2) Check (respuesta1='Si' or respuesta1='No'),
	idpregunta1 int references preguntas(idpregunta),
	respuesta2 varchar(2) Check (respuesta2='Si' or respuesta2='No'),
	idpregunta2 int references preguntas(idpregunta),
	respuesta3 varchar(2) Check (respuesta3='Si' or respuesta3='No'),
	idpregunta3 int references preguntas(idpregunta),
	respuesta4 varchar(2) Check (respuesta4='Si' or respuesta4='No'),
	idpregunta4 int references preguntas(idpregunta),
	respuesta5 varchar(2) Check (respuesta5='Si' or respuesta5='No'),
	idpregunta5 int references preguntas(idpregunta),
	respuesta6 varchar(2) Check (respuesta6='Si' or respuesta6='No'),
	idpregunta6 int references preguntas(idpregunta),
	respuesta7 varchar(2) Check (respuesta7='Si' or respuesta7='No'),
	idpregunta7 int references preguntas(idpregunta),
	respuesta8 varchar(2) Check (respuesta8='Si' or respuesta8='No'),
	idpregunta8 int references preguntas(idpregunta),
	pacientemedicamento varchar(1000000) not null,
	idpaciente int not null	references Pacientes(idpaciente)
);

Create table Expedientes(
idExpediente serial primary key not null,
	notasMedicas varchar(255) not null,
	odontograma varchar(100),
	periodontograma varchar(100),
	observacionesPeriodontograma varchar (255) not null,
	idPaciente int not null references Pacientes(idPaciente)	
);


Create table EstadoDoctor(
idEstadoDoctor serial primary key not null,
	EstadoDoctor varchar(15) not null
);

Create table Especialidad(
idEspecialidad int primary key not null,
	Especialidad varchar(25) not null
);

Create table Doctores(
idDoctor serial primary key not null,
	nombreDoctor varchar(25) not null,
	apellidoDoctor varchar(25) not null,
	direccionDoctor varchar(155) not null,
	telefonoDoctor varchar(9) not null,
	correoDoctor varchar(55) not null,
	fotoDoctor varchar(100),
	aliasDoctor varchar(15) not null,
	claveDoctor varchar(100) not null,
	idEstadoDoctor int not null references EstadoDoctor(idEstadoDoctor)
);

Create table EspecialidadDoctor(
idEspecialidadDoctor serial primary key not null,
	idDoctor int not null References Doctores(idDoctor),
	idEspecialidad int not null references Especialidad(idEspecialidad)
);

Create table PacienteAsignado(
idPacienteAsignado serial primary key not null,
	idPaciente int not null references Pacientes(idPaciente),
	idDoctor int not null references Doctores(idDoctor)
);

Create table Recetas(
idReceta serial primary key not null,
	farmaco varchar(40) not null,
	fechaRegistro date not null,
	idPacienteAsignado int not null references PacienteAsignado(idPacienteAsignado)
);

Create table TipoTratamiento(
idTipoTratamiento serial primary key not null,
	TipoTratamiento varchar(25) not null
);

Create table EstadoTratamiento(
idEstadoTratamiento serial primary key not null,
	EstadoTratamiento varchar(15) not null
);

create table Tratamientos(
idTratamiento serial primary key not null,
	fechaInicio date not null,
	descripcionTratamiento varchar(155) not null,
	idPacienteAsignado int not null references PacienteAsignado(idPacienteAsignado),
	idTipoTratamiento int not null references TipoTratamiento(idTipoTratamiento),
	idEstadoTratamiento int not null references EstadoTratamiento(idEstadoTratamiento)
);


Create table Procedimientos(
idProcedimiento serial Primary key not null,
	nombreProcedimiento varchar(30) not null,
	descripcionProcedimiento varchar(155) not null,
	costoProcedimiento numeric(4,2) not null
);

Create table CausaConsulta(
idCausaConsulta serial primary key not null,
	causa varchar(30) not null 
);

create table Consultas(
idConsulta serial primary key not null,
	notasConsulta varchar(155) not null, 
	costoConsulta numeric(4,2) not null,
	fechaConsulta date, 
	horaConsulta time,
	idCausaConsulta int not null references CausaConsulta(idCausaConsulta)
);

Create table ConsultaProcedimiento(
idConsultaProcedimiento serial Primary key not null,
	idConsulta int not null references Consultas(idConsulta),
	idProcedimiento int not null references Procedimientos(idProcedimiento)
);


Create table CantidadConsultas(
idCantidadConsulta serial Primary key not null,
	idConsulta int not null references Consultas(idConsulta),
	idTratamiento int not null references Tratamientos(idTratamiento)	
);

Create table TipoPago(
idTipoPago serial primary key not null,
	TipoPago varchar(15) not null
);

Create table EstadoPago(
idEstadoPago int primary key not null,
	estadoPago varchar(15) not null
);


Create Table Pagos(
idPago serial primary key not null,
	pagoDebe numeric(5,2) not null,
	pagoAbono numeric(5,2) not null,
	pagoTotal numeric(5,2) not null,
	pagoSaldo numeric(5,2) not null,
	idTratamiento int not null references Tratamientos(idTratamiento),
	idTipoPago int not null references TipoPago(idTipoPago),
	idEstadoPago int not null references EstadoPago(idEstadoPago)
);


Create table HistorialPagos (
idhistorial serial primary key not null,
	nombrePaciente text,
	fechaRegistro timestamp,
	pagoDebeH numeric(5,2),
	pagoAbonoH numeric(5,2),
	pagoTotalH numeric(5,2),
	pagoSaldoH numeric(5,2),
	Tratamiento int,
	TipoPago int
);
--------------------- Inserts ----------------------------------------------------- 

insert into EstadoUsuario (EstadoUsuario) 
values 
('Habilitado'),
('Deshabilitado');

insert into TipoUsuario (TipoUsuario)
values 
('Root'),
('Administrador'),
('Personal Administrativo');


Insert Into Usuarios 
(nombreUsuario,apellidoUsuario,direccionUsuario,telefonoUsuario,correoUsuario,aliasUsuario,claveUsuario,idEstadoUsuario,idTipoUsuario)
values
('Adalberto Francisco','Aguilar Paredes','San Salvador','7898-3045','adalberto@gmail.com','arwen','1233453',1,1);
INSERT INTO Usuarios (idUsuario,nombreUsuario,apellidoUsuario,direccionUsuario,telefonoUsuario,correoUsuario,aliasUsuario,claveUsuario,idEstadoUsuario,idTipoUsuario) VALUES (2,'Gretchen','Mitchell','P.O. Box 594, 673 Sociis Street','1559-8859','nascetur.ridiculus@Integervitae.com','sollicitudin','PUS35NBY3ML',1,3),(3,'Todd','Vang','P.O. Box 101, 157 Sed Av.','8081-8891','bibendum@nequevenenatis.net','pede.','JFU04ERX1OB',2,2),(4,'Jeremy','Maldonado','Ap #337-1553 Enim. Ave','5169-9756','malesuada.vel.convallis@consectetuer.co.uk','Integer','FDC69UJF8EB',1,2),(5,'Irma','Gay','Ap #859-2484 In Street','2897-3293','elit.pellentesque.a@sit.ca','nisi.','FNF20MBV1XG',1,1),(6,'Ezra','Rios','9130 Mauris Av.','8109-1848','egestas@ac.org','nulla.','JBD60KSY9BJ',1,1),(7,'Isabella','Merritt','3505 Non, Avenue','8819-3589','et.magna@semPellentesqueut.ca','aliquet,','NXP62MSA7TG',2,3),(8,'Malik','Swanson','Ap #901-9510 Varius Av.','8050-2849','aliquet.odio@sagittisDuis.org','magna.','BBQ47JWL4HK',2,3),(9,'Jelani','Stokes','627-4977 Condimentum. Rd.','5168-1990','vitae.erat@consectetuer.org','odio','UAV32MJC1NW',2,2),(10,'Chanda','Stevens','768-3642 Placerat, St.','2652-3873','dolor.nonummy@libero.ca','nisl','YKZ59KEP6LM',2,1),(11,'Fritz','Nunez','5203 Nunc Road','0464-8022','Curabitur@perinceptos.co.uk','tellus.','YFL08JDY5RM',1,1),(12,'Edward','Cortez','Ap #594-6503 Est Rd.','1174-4309','sit.amet.ornare@ornareelitelit.org','vitae,','FOS97FUU4UP',2,3),(13,'Phyllis','Bridges','8801 Suspendisse Avenue','9047-8716','litora.torquent@uterat.edu','iaculis','SAD32QKI4PZ',1,2),(14,'Harrison','Charles','5927 Felis. St.','5448-0612','Nunc.ac.sem@ametfaucibus.com','orci.','NPS88ICX2JV',2,1),(15,'Caesar','Wiley','Ap #496-380 Ridiculus Rd.','9797-1033','sollicitudin.adipiscing.ligula@duiaugueeu.co.uk','non','PTB76SXE3CH',2,3),(16,'Aidan','Mason','P.O. Box 158, 9630 Diam Av.','3676-1575','pellentesque.massa.lobortis@acmetusvitae.net','odio','ZCK11EBJ9AP',1,1),(17,'Garth','Chase','P.O. Box 202, 499 Ac St.','9152-3274','in.felis@apurus.org','odio.','TNG93RPP3XF',2,2),(18,'Orlando','Molina','4485 Amet Rd.','0665-9919','tempor.bibendum.Donec@orci.ca','Nunc','BNL03ZOO0TV',2,1),(19,'Kelsey','Harmon','P.O. Box 134, 7979 Lorem Rd.','8086-8272','sem@urna.co.uk','fames','KEV98LRP0PG',1,3),(20,'Cyrus','Winters','P.O. Box 387, 1368 Litora Ave','7960-4610','nostra@augue.co.uk','Donec','MZI53JJH5QE',1,2),(21,'Driscoll','Wynn','803-3728 Curabitur Rd.','6951-7702','Proin.sed.turpis@eratinconsectetuer.ca','luctus.','BBL82HQG6QF',1,1),(22,'Kylie','Newton','Ap #177-3953 Pharetra Avenue','4219-6785','orci.Donec@Donecnon.co.uk','Proin','KXK99AGB1BI',1,1),(23,'Zachery','Bullock','P.O. Box 237, 1225 Eget St.','5924-4441','sed.orci@NullaaliquetProin.ca','erat.','KZU88HRQ9DV',2,2),(24,'Amena','Sharpe','Ap #573-5511 Ut Ave','2827-5012','dolor.Nulla.semper@pellentesquetellussem.net','pellentesque','ZOD33QEU7MT',2,1),(25,'Armando','Case','850-3314 Volutpat Ave','7980-7778','luctus.vulputate@seddictum.com','Pellentesque','HJA67UJO7TQ',2,2),(26,'Samuel','Booth','Ap #207-1575 Pellentesque, St.','4620-1747','Integer@liberomauris.org','sed','QVG27AKH0JS',1,1),(27,'Karina','Mitchell','P.O. Box 594, 1665 Augue Rd.','2755-8920','mus.Proin.vel@lectuspede.co.uk','interdum','IIZ09GEF0SD',2,1),(28,'Clark','Small','9194 Tincidunt Street','9459-5259','est.congue@liberoet.com','amet','AZS07XAL9ZP',2,1),(29,'Kylie','Ellison','Ap #876-9146 Dictum Street','4263-6443','magna.a.neque@rhoncus.edu','ultricies','WLL76FIY2AX',1,3),(30,'Bertha','Gonzales','Ap #664-2368 Fermentum Road','0046-6273','magna.Ut@nequesed.ca','id','UXW28TNB4MY',2,2),(31,'Magee','Stephenson','525-9382 Semper. Rd.','6038-1024','mauris.sapien@natoquepenatibuset.com','fringilla.','WUX98DSA4XC',2,1),(32,'Bell','Warren','Ap #906-4989 Arcu. St.','7839-0739','velit.Aliquam.nisl@tellusNunc.ca','Fusce','UMR12YXB3MK',1,3),(33,'Leo','Hopkins','5246 Auctor Rd.','7090-7436','Vivamus.nisi@eu.co.uk','velit.','EWS47FYD6MV',2,2),(34,'Travis','Sellers','7258 Cras Av.','3901-0954','ipsum.leo@atiaculisquis.com','ac','PWQ32DFD5PZ',1,3),(35,'Dillon','Bright','5279 Donec St.','7975-8425','ut@antebibendum.co.uk','Suspendisse','JXH26FIA9RI',1,3),(36,'Noah','Gilliam','6301 Quisque St.','4834-0764','a.nunc@hendreritid.org','pretium','GRH71BRD1FO',2,3),(37,'Jana','Dixon','220-6293 Nullam Road','5871-7911','sed.est@amet.com','dui.','QGO34MOP5MD',1,2),(38,'Bruce','Kerr','1749 Tortor, Ave','2902-5852','molestie.arcu.Sed@lacusQuisqueimperdiet.co.uk','ac','IIV02IAK7MY',2,1),(39,'Zenaida','Wooten','P.O. Box 393, 4584 Non, St.','0507-6541','ut.pharetra@atpretiumaliquet.net','gravida','WZL02OSR7SE',2,2),(40,'Anthony','Savage','Ap #657-1292 Auctor Rd.','0661-5506','odio@nibhsit.com','Morbi','XNI60NCG3CX',2,3),(41,'Raven','Sutton','Ap #809-4854 Blandit St.','7136-5831','enim.Suspendisse.aliquet@Sedauctor.edu','purus','AJQ35MXY5EI',2,2),(42,'Ray','Winters','7998 Sit Av.','6784-2148','magna.Praesent@magnaDuisdignissim.co.uk','augue','FBV16PTO0ZD',1,2),(43,'Myra','Vazquez','P.O. Box 221, 6166 Vivamus St.','3312-9139','urna@Aeneanegetmetus.ca','quis','YUE07EQV5UH',2,1),(44,'Alea','Sheppard','820-7568 Quis Road','1957-1803','magna@nequetellusimperdiet.co.uk','enim','KFT97ZSM9SI',2,2),(45,'Emmanuel','Barrera','679-3229 Suspendisse Road','6787-7644','Duis@Namporttitor.com','Vestibulum','ABK94LUS8FJ',2,3),(46,'Brody','Dennis','186-2016 Non Av.','7800-3859','a.magna@vellectus.co.uk','elementum','HIC80UXV9LW',2,1),(47,'Veronica','Delgado','197-4146 Ante. St.','4460-0526','ipsum@dolornonummyac.ca','id,','IVS54QUB3CH',1,2),(48,'Patrick','Mccullough','197 Sagittis Rd.','2722-0123','ac.nulla@consequatlectussit.net','Sed','ILS08ZZS7JA',2,2),(49,'Ivory','Woodward','5859 Eros. Av.','7568-5726','enim@Seddiam.co.uk','lectus.','SVJ14KMB0YZ',2,2),(50,'Tate','Carney','300-1601 Fusce Road','7555-7349','dignissim.Maecenas.ornare@Proinvel.com','eget','KMR75YVG7GO',2,3),(51,'Gillian','Schroeder','Ap #825-4842 Eu Avenue','6977-8232','augue.eu.tempor@eratvel.net','Maecenas','GCC44UOB4FV',2,1),(52,'Anne','Bailey','Ap #734-1444 Parturient Road','8544-2719','egestas@Etiambibendumfermentum.edu','Suspendisse','OXY75ZTM7AP',2,1),(53,'Gary','Spence','P.O. Box 624, 2743 Metus. St.','1492-3046','diam.luctus.lobortis@eratvitaerisus.ca','dui','RIQ25LQE8TP',1,1),(54,'Hayfa','Raymond','196-3689 Accumsan Ave','5013-3343','elementum.at.egestas@elementumlorem.edu','Quisque','BDX15HIL5NC',2,1),(55,'Bethany','Finley','Ap #261-9977 Amet St.','1577-2496','a.tortor.Nunc@non.edu','lacinia','MDG38ORO0NY',1,1),(56,'Ulric','Little','471-6940 Eget St.','5993-7995','tellus.Nunc@euplacerateget.org','sociis','CFP80HCN1BD',1,2),(57,'Angelica','Humphrey','842-2972 Mauris. St.','7236-3340','ut@inconsectetueripsum.org','lacus.','DZX11PJM2PO',2,1),(58,'Lillith','Mccullough','3071 Aenean St.','0115-9746','tincidunt.tempus.risus@Pellentesque.com','amet,','NIL89LEX6RK',2,3),(59,'Rashad','Jensen','P.O. Box 635, 2254 Et Road','5142-9484','per.conubia@enim.org','sodales','PMZ45JLI5XH',1,2),(60,'Ina','Davis','5478 Dolor. Avenue','1118-4186','magna.Suspendisse.tristique@apurus.net','penatibus','HZT08OSC8WW',2,2),(61,'Colin','Mason','9353 Aliquam Ave','3188-4320','laoreet@est.net','ante.','MKF38ATW7ED',2,1),(62,'Alvin','Maddox','Ap #907-3571 Ut Rd.','1245-1839','Quisque@Quisqueporttitoreros.com','dui','UBA08PPZ7WG',1,2),(63,'Aspen','Gross','223-9228 Phasellus Road','1171-7969','Suspendisse@massa.ca','vel','QFY00MMR5VW',2,1),(64,'Bethany','Benson','581-7356 At Av.','7439-8714','a.auctor.non@ornarelibero.edu','Vivamus','EHF10KMZ2XN',1,3),(65,'Lionel','Guerra','P.O. Box 326, 846 Vestibulum Ave','8693-1003','aliquet.metus@ridiculusmusDonec.com','neque.','MAE97VKD1AS',2,3),(66,'Zoe','Ruiz','368-8864 Lectus Rd.','0551-2094','non.sapien.molestie@In.org','non,','TSG96HVO4ZV',2,3),(67,'Vaughan','Keith','3816 A Rd.','0623-2616','aliquam@nuncInat.ca','hendrerit.','ZRQ20NXX2CV',1,2),(68,'Lacey','Hebert','P.O. Box 588, 3780 Lobortis, Ave','8047-4909','lorem.lorem@nondui.ca','fames','TAR84SBZ4VB',2,2),(69,'Vivien','English','P.O. Box 636, 8607 Lobortis, St.','4489-2861','eu.tempor.erat@acsem.org','magna.','CWZ77ESB6GP',2,2),(70,'Maya','George','P.O. Box 461, 6889 Erat Av.','5032-3052','diam.eu@musDonecdignissim.edu','scelerisque','CLI56CXG5OC',2,2),(71,'Sonia','Farley','P.O. Box 364, 3975 Id Av.','0374-8447','Nunc@dictumeleifendnunc.edu','Donec','FPA35VIM2YQ',2,1),(72,'Buckminster','Rivera','135-4675 Penatibus Road','5961-4505','arcu@massaSuspendisse.org','nisl','VDS68RGH7XL',2,3),(73,'Madeline','Page','P.O. Box 240, 4538 Suspendisse Rd.','6759-2696','sed.dictum@mieleifend.co.uk','dictum','DMQ23AEN7XS',2,2),(74,'Judith','Huff','Ap #897-5684 Lectus Rd.','0481-6926','a@condimentum.co.uk','gravida','UAD05GZQ9GY',2,2),(75,'Kristen','Garcia','4722 Tristique Ave','4010-7993','mi.lacinia.mattis@bibendumsed.co.uk','non,','MSM24FXW1WT',2,3),(76,'Martha','Mejia','5542 Ut St.','9719-8700','nec@metus.org','lobortis,','WLE53NLQ1RB',2,1),(77,'Hayfa','Gallegos','971-6528 Pharetra, St.','3208-8806','blandit.congue.In@nisisem.edu','porttitor','NNJ20YUV9QT',1,1),(78,'Wing','Finch','5326 Aliquet Avenue','0996-7372','mollis@feugiat.co.uk','ut','YET62IVS9VS',2,1),(79,'Irma','Contreras','Ap #510-5257 Dis Street','8963-1730','primis@lectusconvallis.ca','vehicula','XYG51WSU3VQ',2,3),(80,'Galvin','Houston','962-5624 Commodo Street','7997-3317','at@iaculis.org','malesuada','WRE59VLV0JC',2,1),(81,'Leroy','Neal','Ap #804-3657 Curabitur Street','8073-8876','rutrum.urna@risusDuis.ca','ante','NVG57WWG6HI',2,3),(82,'Ariel','Whitfield','9876 Ligula. Street','4125-4188','interdum.ligula.eu@nonduinec.ca','diam.','LZP92JVT6WL',2,2),(83,'Nero','Wade','5599 Luctus St.','1838-6483','vel.nisl.Quisque@suscipit.org','cursus','HRF01SQY4KX',2,3),(84,'Keiko','Luna','Ap #557-240 Est, Avenue','3093-0930','purus.Nullam@nostraperinceptos.ca','sociis','LEP02IXA7SN',1,3),(85,'Raja','Ewing','P.O. Box 443, 5628 Lorem Ave','7808-4731','malesuada.fames.ac@placerat.ca','Cum','MQZ93GCS1FE',1,2),(86,'Nero','Nunez','Ap #337-8499 Nam Rd.','2061-4586','dolor@noncursus.net','libero.','GHZ47RYH1MR',2,1),(87,'Mara','Levine','4661 Donec Road','0941-3623','velit.in.aliquet@quam.com','ut','AEE81DOL0DJ',2,2),(88,'Ronan','Gilmore','Ap #342-8077 Nascetur Street','2076-5956','tristique.ac.eleifend@Integervitaenibh.co.uk','enim','XUY16WQY6ET',1,3),(89,'Ezra','Wilkins','815-4403 Phasellus Street','9654-9102','Nulla@aliquetlobortis.ca','Proin','RRR99YYX4JP',1,3),(90,'Wynne','Collier','6207 Mauris Ave','4951-2442','adipiscing.Mauris.molestie@Nuncullamcorpervelit.edu','sagittis','SMM48MVA6KB',2,2),(91,'Leandra','Donovan','9243 Vulputate, Avenue','6653-9415','massa@etmagnis.org','In','ZWW49NQU2EI',2,3),(92,'Tanner','Hale','947-3555 Sodales Rd.','0502-3907','diam@congue.ca','sit','FVJ75EHB7QH',1,1),(93,'Scarlett','Mcconnell','5373 Ac Rd.','2994-0365','parturient.montes@arcuimperdietullamcorper.co.uk','pede','XQH99EFB4QH',1,1),(94,'Helen','Knox','545-803 Nec, Road','6209-7645','sem.ut.cursus@ornarelibero.edu','nec','GNZ46VOB7MG',1,1),(95,'Kylie','Sexton','913-6834 Quis Av.','2598-3540','orci.in@orcisem.com','Pellentesque','TEW99SWI1DR',1,1),(96,'Todd','Dickson','Ap #371-3829 Ac Avenue','6779-6650','Aliquam.nisl@dolornonummy.ca','Cras','SSH80VWJ1BM',2,3),(97,'Donna','Melton','986-506 Gravida. St.','8546-7108','cursus@pharetranibhAliquam.org','nisi','DON32PMQ5BE',2,1),(98,'Tate','Grant','9362 Nunc St.','1151-9913','magna.a@leo.net','gravida','OWT47RFJ1CS',1,2),(99,'Coby','Lambert','P.O. Box 921, 6464 Mauris Rd.','4718-4695','Donec@Donecnibh.org','a,','LJW31BYQ0XH',1,2),(100,'Faith','Lamb','Ap #438-5221 Pellentesque Rd.','7051-1284','dictum@aliquamerosturpis.net','vestibulum,','ZFC97YME1NV',2,3);

Insert Into EstadoPaciente 
values 
(1,'Activo'),
(2,'Inactivo');


Insert into Preguntas values
(1,'¿Padece de migrañas o dolores de cabeza frecuentes?'),
(2,'¿Padece de ataques de epilepsia o convulsiones?'),
(3,'¿Padece de problemas cardiacos?'),
(4,'¿Padece de gastritis, úlceras, diarreas frecuentes?'),
(5,'¿Padece de azúcar en la sangre(Diabetes)?'),
(6,'¿Ha padecido de hepatitis?'),
(7,'¿Padece de alguna alergia a mediacamentos?'),
(8,'¿Toma algún medicamento permanente?');


INSERT INTO Pacientes (idPaciente,nombrePaciente,apellidoPaciente,fechaNacimiento,duiPaciente,direccionPaciente,telefonoPaciente,correoPaciente,idEstadoPaciente) VALUES (1,'Evangeline','Berry','11/09/2021','43691164-5','Ap #125-5231 Sed Ave','3234-7607','libero.Donec@Integeraliquam.co.uk',2),(2,'Zephr','Reilly','24/07/2021','8199274-6','Ap #828-7231 Euismod Road','1762-5694','Nullam@porttitorinterdum.edu',2),(3,'Venus','West','27/04/2022','44713578-7','7565 Nam Rd.','1047-7830','mauris.Morbi.non@quisdiamPellentesque.co.uk',1),(4,'Cain','Wright','26/07/2020','10282048-7','679-4288 Vitae Street','6094-4050','lorem.vehicula.et@orciPhasellus.com',1),(5,'Gil','Case','31/03/2021','32908003-k','8605 Odio. Avenue','7811-5475','mauris.id.sapien@veliteu.org',1),(6,'Warren','Bishop','24/08/2021','6224261-2','131-2303 Et Road','9169-3943','semper.Nam.tempor@sempercursusInteger.ca',1),(7,'Ivor','Reynolds','26/12/2020','30055112-2','P.O. Box 258, 4217 Sed Rd.','8317-1422','In.nec.orci@Vivamusnibh.com',2),(8,'Rooney','Mooney','20/12/2022','15782535-6','242-7023 Auctor, Av.','1592-9087','diam.luctus@ornareegestas.com',1),(9,'Hadley','Gonzalez','26/03/2022','10802011-3','Ap #403-8124 Risus. Av.','4840-2483','et@eunequepellentesque.com',2),(10,'Emma','Henson','29/10/2020','9920305-6','3347 In Street','2696-1332','augue.porttitor@scelerisque.edu',2),(11,'Tanek','Dalton','04/05/2020','21560355-5','231-6160 Sed Street','0176-1518','In@Nullamvitae.org',2),(12,'Velma','Duncan','28/07/2020','30472907-4','Ap #837-6397 Posuere St.','1162-9752','primis.in.faucibus@placerataugue.net',1),(13,'Aaron','Spencer','28/10/2020','17138788-4','309-145 Risus. Rd.','3147-9042','amet.lorem.semper@nislNulla.co.uk',2),(14,'Damon','Dillon','17/08/2020','38791571-0','P.O. Box 724, 6134 Libero St.','9524-3752','Fusce.aliquet@acorciUt.org',2),(15,'Sybil','Ochoa','28/06/2021','16491854-8','734-3940 Vulputate St.','9361-0237','condimentum.Donec.at@id.net',2),(16,'Declan','Galloway','02/08/2020','5808161-2','Ap #128-5697 Mauris Street','8385-1201','et.rutrum.non@blandit.edu',2),(17,'Christen','Harrington','22/08/2021','20545300-8','Ap #890-6837 Magna Rd.','4504-5999','Lorem.ipsum.dolor@per.edu',1),(18,'Abra','House','27/07/2020','8644310-4','Ap #468-2326 Eu Av.','6029-3793','libero.est@maurissapiencursus.ca',2),(19,'Lara','Kim','15/08/2022','20868156-7','607-7424 In Street','6637-7927','Vivamus@Loremipsum.net',2),(20,'Kasimir','Brown','04/05/2020','8807053-4','P.O. Box 526, 6462 Eget, Rd.','0962-9902','blandit@tellusNunclectus.co.uk',1),(21,'Piper','Blackwell','21/12/2022','27119274-6','8160 Adipiscing Av.','8147-2715','at@lectusrutrum.com',1),(22,'Gannon','Atkinson','04/09/2020','29458218-5','Ap #591-1643 Augue Road','9983-0325','libero.Proin.mi@necorciDonec.edu',2),(23,'Madaline','Garza','04/09/2021','45180174-0','P.O. Box 656, 4478 Pede. Street','4230-0478','Pellentesque@tellus.ca',1),(24,'Darius','Nichols','03/03/2022','7159687-7','3822 Eu Street','0952-6301','arcu@pretium.com',1),(25,'Xenos','Gill','28/09/2022','23823718-1','P.O. Box 575, 2531 Eget Avenue','8842-2799','elit@eu.ca',1),(26,'Chantale','Valenzuela','12/03/2021','7671189-5','2034 Rutrum Avenue','7812-1214','ut@et.org',2),(27,'Clayton','Vinson','24/03/2021','15697602-4','454-515 Duis St.','6520-0921','arcu.eu@euismodin.com',2),(28,'Rooney','Britt','15/01/2021','20218156-2','Ap #245-1261 Aliquet Ave','5741-9291','ipsum.primis.in@consectetuercursuset.co.uk',2),(29,'Pandora','Torres','23/12/2021','39303660-5','Ap #242-5050 Dui. Road','7862-3099','sodales.nisi.magna@tempus.com',2),(30,'Timon','Graham','28/08/2021','30417354-8','P.O. Box 477, 428 Consectetuer Street','0305-8647','Aliquam@odioEtiamligula.org',1),(31,'Chava','Calhoun','19/05/2020','44174035-2','P.O. Box 490, 8340 Lacinia Road','7419-7419','In.tincidunt.congue@arcu.com',2),(32,'Linus','Bradley','03/03/2021','42111241-k','P.O. Box 807, 2065 Fusce St.','1881-6136','Vestibulum.ut.eros@nequevitae.ca',2),(33,'Cara','Fox','15/10/2022','29532460-0','Ap #800-5384 Convallis St.','2851-7157','ipsum@ametdiam.ca',2),(34,'Brody','Waller','10/06/2021','19282238-6','151-4546 Tincidunt Rd.','8318-5461','a@Aenean.co.uk',2),(35,'Dacey','Fox','20/07/2021','5622496-3','6531 Duis Street','1688-7801','neque@lectusCumsociis.co.uk',1),(36,'Cody','Jensen','09/11/2020','5724979-k','5093 Netus Av.','1534-0807','elit@fringilla.net',2),(37,'Neil','Baxter','06/09/2021','15273033-0','793-6830 Magna, Rd.','0868-6707','nulla.vulputate.dui@vitaerisus.org',2),(38,'Zane','Gaines','01/10/2022','15937110-7','Ap #702-9509 Nunc St.','1452-5071','amet.risus.Donec@luctus.co.uk',2),(39,'Tad','Hoffman','21/09/2022','23570810-8','721-5264 Massa Rd.','5668-2118','amet.metus@lobortistellusjusto.org',1),(40,'Brianna','Schneider','01/12/2020','28344623-9','Ap #302-6056 Nulla Ave','4192-3154','erat.vitae.risus@feugiat.com',2),(41,'Ezekiel','Head','22/03/2021','39691608-8','Ap #395-8338 Morbi St.','3851-6689','volutpat.ornare.facilisis@at.com',2),(42,'Aquila','Winters','09/08/2021','45834120-6','687-9152 Quam. St.','6681-8503','aliquam.eu.accumsan@diamSeddiam.org',1),(43,'Henry','Cervantes','16/07/2022','21763914-k','Ap #854-6948 Aliquam Road','0865-8233','penatibus.et@habitantmorbitristique.net',1),(44,'Nehru','Prince','14/08/2021','24754557-3','Ap #838-689 Mus. Ave','1151-9973','eu.lacus@mattisCras.ca',1),(45,'Kareem','Walls','26/05/2021','14850313-3','Ap #614-4505 Mattis. Rd.','6109-5656','Aenean@quamafelis.edu',2),(46,'Mercedes','Roberts','23/10/2020','29150269-5','P.O. Box 365, 3488 Erat. Av.','0599-2631','lobortis.mauris.Suspendisse@Cras.com',1),(47,'Mariam','Shepard','14/07/2022','26918763-8','P.O. Box 140, 2918 Donec Avenue','1035-7167','felis.Nulla.tempor@tristiquealiquet.org',2),(48,'Jescie','Patel','05/06/2020','47150014-3','8040 Fringilla Ave','3225-5369','tincidunt@faucibuslectus.co.uk',1),(49,'Barrett','Mejia','29/07/2022','49093401-4','219-4791 Senectus Av.','9094-1779','feugiat.Lorem@fringilla.org',1),(50,'Hamish','Morales','18/03/2022','19474233-9','Ap #994-3421 Arcu. Av.','2178-3394','ligula.Aenean.gravida@acturpisegestas.ca',2),(51,'Kieran','Wiley','17/07/2020','40348105-k','2109 Sed Avenue','3860-9347','turpis.egestas@pede.org',1),(52,'Bradley','Boyle','18/08/2022','8770652-4','Ap #374-3307 Mauris, Rd.','5072-1981','in.aliquet.lobortis@Curabitur.ca',2),(53,'Finn','Combs','26/09/2020','43262248-7','Ap #799-8224 Metus Ave','8308-7772','Aliquam.erat.volutpat@nonenimMauris.co.uk',2),(54,'Kevin','Barrera','21/04/2021','50202308-k','Ap #239-4474 Vivamus St.','8954-9111','sit.amet@Aliquam.ca',1),(55,'Leroy','Joyner','29/05/2021','42646637-6','141-8652 Lorem Ave','7997-2314','Quisque.ornare@utlacusNulla.co.uk',2),(56,'Odessa','Sykes','30/11/2022','32436503-6','421-5319 Elit Av.','8607-3646','velit.in@dictum.ca',1),(57,'Paki','Hunter','27/02/2021','12892767-0','Ap #184-8804 Velit. Ave','4418-7816','ac.eleifend@rutrumnon.org',2),(58,'Hayfa','Joyce','12/08/2022','45298128-9','496-7222 Nullam Road','5253-1540','Sed.nunc@elitCurabitur.edu',1),(59,'Ronan','Mccray','21/11/2020','9875194-7','Ap #661-9711 Neque Road','4641-8297','eget@Suspendissecommodotincidunt.co.uk',2),(60,'Malachi','Harper','23/05/2021','13704045-k','P.O. Box 717, 6688 Luctus Av.','8969-0876','fringilla@elitNulla.edu',2),(61,'Paloma','Frank','09/06/2020','21012479-9','912 In Street','5186-6335','Donec.sollicitudin@ornaretortor.edu',2),(62,'Gemma','Benson','26/06/2020','38386968-4','Ap #532-4427 At St.','9837-5920','sociosqu.ad.litora@estcongue.ca',1),(63,'Cassandra','Chandler','07/12/2021','25478821-k','239-3091 Gravida Av.','7990-4183','nulla@Namnulla.org',2),(64,'Moses','Robles','03/12/2021','12687795-1','Ap #655-6225 Risus. St.','4474-9480','tincidunt@sedorcilobortis.com',1),(65,'Abra','Griffith','16/04/2021','11282164-3','8837 Magna Rd.','9304-2397','ac.turpis@dictum.edu',2),(66,'Jocelyn','Christensen','28/12/2021','50392167-7','703-400 Maecenas St.','0716-8307','purus.gravida.sagittis@NullafacilisisSuspendisse.org',1),(67,'Kiona','Aguirre','16/05/2020','14165613-9','P.O. Box 218, 2693 Arcu Ave','7521-9354','mi.felis@quis.edu',1),(68,'Rhiannon','Hood','26/06/2021','9493488-5','P.O. Box 413, 9416 Sapien, Road','9538-3922','sit@porttitorscelerisque.org',2),(69,'Geoffrey','Lyons','04/09/2020','35317276-k','P.O. Box 368, 4444 Fringilla. Av.','5529-4655','urna.Nunc@sitamet.ca',2),(70,'Holmes','Crosby','25/08/2022','18092618-6','Ap #527-4946 Imperdiet Street','7279-5242','consequat@sem.net',2),(71,'Aline','Chang','30/11/2021','5878386-2','8187 Volutpat Road','3823-1604','vestibulum.nec.euismod@Donec.net',1),(72,'Xander','Lyons','16/04/2021','29614747-8','509-5909 Lorem Rd.','5894-6835','vel.venenatis@ametfaucibusut.edu',2),(73,'Bevis','Wyatt','07/08/2022','14234268-5','4701 Vel Rd.','9827-2857','placerat.eget.venenatis@enimNuncut.com',2),(74,'Marny','Hays','17/05/2020','43246176-9','7632 Mi Avenue','1807-1863','vitae.erat.Vivamus@metusIn.com',2),(75,'Erica','Brown','19/12/2021','44641917-k','826-1809 At, Avenue','6616-1752','pede@ipsum.ca',2),(76,'Tad','Mejia','08/10/2021','39918492-4','1671 Aliquam St.','7621-8057','rhoncus@nequesed.co.uk',2),(77,'Barclay','Sanchez','12/09/2021','42871939-5','2364 Luctus. Street','2944-5849','Integer@idnuncinterdum.net',1),(78,'Tucker','Beach','30/10/2022','15462694-8','849-467 Sed Av.','4055-6393','ac.risus.Morbi@nisi.co.uk',2),(79,'Quemby','Byers','09/11/2020','48517032-4','3930 Sit Rd.','8160-2295','Duis.elementum@laoreetposuere.ca',1),(80,'Carson','Nelson','24/09/2021','50842564-3','P.O. Box 701, 8295 Nec Rd.','4702-1531','natoque.penatibus@dictumProineget.ca',2),(81,'Alma','Bartlett','03/06/2021','47614540-6','Ap #448-953 Lorem Road','2252-5131','nunc@dictumPhasellusin.net',2),(82,'Melissa','Dennis','25/11/2021','43761544-6','Ap #891-5642 Ac St.','2598-7014','Sed@necmalesuada.org',1),(83,'Jermaine','Workman','21/09/2022','31713742-7','Ap #705-6058 Vestibulum Road','9390-7648','euismod@malesuadavel.ca',1),(84,'Mariam','Cobb','24/09/2022','40606472-7','8152 In, St.','3224-5894','ut.ipsum.ac@dignissimlacus.edu',1),(85,'Prescott','Hurley','18/03/2022','13555532-0','P.O. Box 209, 6109 Nulla St.','9202-1093','purus.sapien.gravida@ornare.ca',1),(86,'Ocean','Vang','01/10/2022','24639833-k','Ap #941-2916 Arcu. Av.','4700-4183','eget@ligulaelitpretium.net',2),(87,'Kuame','Cooley','05/05/2021','7780791-8','Ap #543-7180 Massa. Road','9734-1378','ac.tellus.Suspendisse@ametconsectetuer.org',2),(88,'Jerome','Hayes','16/09/2021','16361315-8','P.O. Box 476, 4889 Primis Rd.','2780-5433','Donec.at@loremvehicula.co.uk',2),(89,'Carter','King','18/08/2021','39210520-4','177-8314 Sed Avenue','4161-0738','cursus@Donec.com',1),(90,'Sawyer','Spencer','05/10/2020','37293725-4','P.O. Box 826, 205 Turpis Av.','2150-7965','tincidunt.neque@Vivamusnon.co.uk',1),(91,'Rebekah','Powell','19/05/2022','37075178-1','Ap #812-555 Aliquam St.','5474-4487','In.faucibus@nisl.org',2),(92,'Valentine','Reid','09/08/2021','10922375-1','9075 Pede. Rd.','9612-2987','sapien.molestie@dictum.edu',1),(93,'Fay','Decker','12/07/2021','45558308-k','Ap #124-2897 Enim. St.','1485-2196','imperdiet.erat.nonummy@orciadipiscing.ca',1),(94,'Gisela','Leonard','16/09/2021','16050308-4','5199 Vitae St.','5322-3577','ultrices.mauris@tempor.net',2),(95,'Britanney','Summers','10/07/2022','44249705-2','Ap #121-3044 Mi Street','1424-7297','montes@actellusSuspendisse.co.uk',1),(96,'Anjolie','Fulton','23/11/2021','42876299-1','172-3899 Vel, Avenue','5549-4575','porttitor@augue.com',2),(97,'Wanda','House','01/01/2021','11887462-5','Ap #103-148 Tincidunt St.','6245-7191','sapien@Etiamimperdiet.org',2),(98,'Charde','Wagner','18/11/2022','44863742-5','P.O. Box 788, 4290 Aenean Road','4229-8761','Fusce.diam.nunc@Maurisvel.net',2),(99,'Xyla','Valdez','19/04/2021','26986863-5','Ap #329-7612 Lorem, Av.','5080-6942','non.sollicitudin@rutrum.org',1),(100,'Blossom','Hickman','30/05/2022','24017277-1','P.O. Box 402, 9929 Velit Ave','7581-1394','nisi@sodales.co.uk',1);

INSERT INTO Expedientes (idExpediente,notasMedicas,ObservacionesPeriodontograma,idPaciente) VALUES (1,'semper tellus id nunc interdum feugiat. Sed nec metus facilisis','arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim.',1),(2,'semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices','vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur',2),(3,'pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod','hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim.',3),(4,'elit elit fermentum risus, at fringilla purus mauris a nunc.','Donec non justo. Proin non massa non ante bibendum ullamcorper.',4),(5,'vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce','Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate,',5),(6,'facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus','adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor',6),(7,'magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu','eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis',7),(8,'Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales purus,','ipsum primis in faucibus orci luctus et ultrices posuere cubilia',8),(9,'quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque','vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy',9),(10,'ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci','purus. Maecenas libero est, congue a, aliquet vel, vulputate eu,',10),(11,'Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis','mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris',11),(12,'ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat','ipsum leo elementum sem, vitae aliquam eros turpis non enim.',12),(13,'lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod','lectus convallis est, vitae sodales nisi magna sed dui. Fusce',13),(14,'sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci','luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc',14),(15,'aptent taciti sociosqu ad litora torquent per conubia nostra, per','massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit',15),(16,'hendrerit neque. In ornare sagittis felis. Donec tempor, est ac','nunc. Quisque ornare tortor at risus. Nunc ac sem ut',16),(17,'sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra,','consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim',17),(18,'vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum dolor','neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc',18),(19,'erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse','eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat',19),(20,'ante ipsum primis in faucibus orci luctus et ultrices posuere','sagittis augue, eu tempor erat neque non quam. Pellentesque habitant',20),(21,'nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor','urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim.',21),(22,'tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam','orci, in consequat enim diam vel arcu. Curabitur ut odio',22),(23,'nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis','Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut',23),(24,'ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci','arcu. Vestibulum ante ipsum primis in faucibus orci luctus et',24),(25,'lorem, eget mollis lectus pede et risus. Quisque libero lacus,','amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor',25),(26,'mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin','Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit',26),(27,'sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra,','parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique',27),(28,'In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum','mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida',28),(29,'amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus.','euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget',29),(30,'dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus','sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue',30),(31,'lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante','Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat.',31),(32,'Donec at arcu. Vestibulum ante ipsum primis in faucibus orci','Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus',32),(33,'nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris','ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam',33),(34,'varius et, euismod et, commodo at, libero. Morbi accumsan laoreet','nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras',34),(35,'Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis','Suspendisse non leo. Vivamus nibh dolor, nonummy ac, feugiat non,',35),(36,'eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut','imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at',36),(37,'odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa.','per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel',37),(38,'ut aliquam iaculis, lacus pede sagittis augue, eu tempor erat','vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue',38),(39,'quis, pede. Praesent eu dui. Cum sociis natoque penatibus et','Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi',39),(40,'eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis','Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.',40),(41,'ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,','Mauris blandit enim consequat purus. Maecenas libero est, congue a,',41),(42,'Nulla semper tellus id nunc interdum feugiat. Sed nec metus','Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut',42),(43,'Ut tincidunt vehicula risus. Nulla eget metus eu erat semper','rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed,',43),(44,'vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie','nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis',44),(45,'ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam','Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh',45),(46,'odio. Phasellus at augue id ante dictum cursus. Nunc mauris','enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.',46),(47,'vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie','purus mauris a nunc. In at pede. Cras vulputate velit',47),(48,'vel est tempor bibendum. Donec felis orci, adipiscing non, luctus','et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat,',48),(49,'malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam','augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed,',49),(50,'consequat, lectus sit amet luctus vulputate, nisi sem semper erat,','facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo',50),(51,'amet ultricies sem magna nec quam. Curabitur vel lectus. Cum','placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna',51),(52,'nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus','scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed',52),(53,'lectus sit amet luctus vulputate, nisi sem semper erat, in','Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,',53),(54,'Donec feugiat metus sit amet ante. Vivamus non lorem vitae','tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id,',54),(55,'eget nisi dictum augue malesuada malesuada. Integer id magna et','tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet,',55),(56,'Donec at arcu. Vestibulum ante ipsum primis in faucibus orci','vitae risus. Duis a mi fringilla mi lacinia mattis. Integer',56),(57,'dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et','adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut',57),(58,'arcu eu odio tristique pharetra. Quisque ac libero nec ligula','sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque',58),(59,'porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris','id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque',59),(60,'Maecenas libero est, congue a, aliquet vel, vulputate eu, odio.','ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt',60),(61,'cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam','nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque',61),(62,'Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla.','amet, risus. Donec nibh enim, gravida sit amet, dapibus id,',62),(63,'Donec tincidunt. Donec vitae erat vel pede blandit congue. In','nunc. Quisque ornare tortor at risus. Nunc ac sem ut',63),(64,'Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,','nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce',64),(65,'semper pretium neque. Morbi quis urna. Nunc quis arcu vel','et tristique pellentesque, tellus sem mollis dui, in sodales elit',65),(66,'lacus pede sagittis augue, eu tempor erat neque non quam.','Pellentesque habitant morbi tristique senectus et netus et malesuada fames',66),(67,'pede. Praesent eu dui. Cum sociis natoque penatibus et magnis','dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum',67),(68,'ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam','sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut',68),(69,'Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non,','dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus',69),(70,'turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis','Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est.',70),(71,'enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.','mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id',71),(72,'ac turpis egestas. Fusce aliquet magna a neque. Nullam ut','netus et malesuada fames ac turpis egestas. Fusce aliquet magna',72),(73,'et netus et malesuada fames ac turpis egestas. Aliquam fringilla','vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante.',73),(74,'Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus.','cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit',74),(75,'in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla','nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo',75),(76,'aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend','odio a purus. Duis elementum, dui quis accumsan convallis, ante',76),(77,'facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc','odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam',77),(78,'Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit,','mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae,',78),(79,'amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus','Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus',79),(80,'nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat.','arcu iaculis enim, sit amet ornare lectus justo eu arcu.',80),(81,'mi lorem, vehicula et, rutrum eu, ultrices sit amet, risus.','fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin',81),(82,'nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus','Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque',82),(83,'lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate','ut nisi a odio semper cursus. Integer mollis. Integer tincidunt',83),(84,'feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam','nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque',84),(85,'lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet','lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis',85),(86,'malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit.','Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie',86),(87,'enim. Nunc ut erat. Sed nunc est, mollis non, cursus','Proin non massa non ante bibendum ullamcorper. Duis cursus, diam',87),(88,'sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam','massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero.',88),(89,'malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna.','neque. Nullam ut nisi a odio semper cursus. Integer mollis.',89),(90,'ut, nulla. Cras eu tellus eu augue porttitor interdum. Sed','tellus eu augue porttitor interdum. Sed auctor odio a purus.',90),(91,'Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra.','Donec at arcu. Vestibulum ante ipsum primis in faucibus orci',91),(92,'parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor.','egestas hendrerit neque. In ornare sagittis felis. Donec tempor, est',92),(93,'est, congue a, aliquet vel, vulputate eu, odio. Phasellus at','Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue',93),(94,'elit, a feugiat tellus lorem eu metus. In lorem. Donec','mattis ornare, lectus ante dictum mi, ac mattis velit justo',94),(95,'vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet','porttitor tellus non magna. Nam ligula elit, pretium et, rutrum',95),(96,'Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum eu,','risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non',96),(97,'Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum','lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis',97),(98,'in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus','suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis',98),(99,'nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet','vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy',99),(100,'Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue.','mollis lectus pede et risus. Quisque libero lacus, varius et,',100);


insert into EstadoDoctor Values 
(1,'Activo'),
(2,'Inactivo');

insert into Especialidad values
(1,'Periodontologo'),
(2,'Endodoncista'),
(3,'Ortodoncista'),
(4,'Cariologo'),
(5,'Odontopediatria'),
(6,'Implantología'),
(7,'Odontología Estetica'),
(8,'Blanqueamiento Dental'),
(9,'Tratamiento sin Metal');

INSERT INTO Doctores (idDoctor,nombreDoctor,apellidoDoctor,direccionDoctor,telefonoDoctor,correoDoctor,aliasDoctor,claveDoctor,idEstadoDoctor) VALUES (1,'Hasad','Richards','303-2329 Malesuada Rd.','6291-8778','Phasellus@dolorDonecfringilla.org','egestas.','KFU86ZIT8TK',2),(2,'Kelly','Mccarthy','Ap #343-2698 Vel Road','2760-4821','Donec@interdumfeugiat.org','tristique','GYM17KCP4ZL',2),(3,'Charles','Kinney','8080 Vulputate St.','8814-7185','eget.magna.Suspendisse@enimmitempor.ca','id','NDQ16EPT7BN',2),(4,'Galena','Rios','P.O. Box 635, 9127 Tempor Rd.','7971-8041','metus@malesuada.net','tellus','WIE80FSV5PQ',2),(5,'Ingrid','Ferguson','Ap #695-4446 Velit. Road','5823-6821','diam.Pellentesque.habitant@nullaInteger.edu','lorem','HJM13IPZ4BD',2),(6,'Reese','Cobb','Ap #452-3245 Neque Rd.','3559-3765','eu.tellus@nibh.org','justo','KKZ33AKF1FI',1),(7,'Boris','Mccarty','8739 Morbi Ave','6106-1424','consectetuer@adipiscing.edu','adipiscing','UDQ34OOG9GV',1),(8,'Valentine','Sweet','131 At Rd.','1892-1977','orci.Donec@egestasAliquam.net','mollis','EEL05MGR7HU',1),(9,'Silas','Hooper','Ap #674-2978 Porttitor Rd.','3868-9717','ut.quam.vel@fringilla.com','ac,','KDI50FYZ8NW',1),(10,'Alexa','Schneider','162 Nibh Av.','4002-8872','fringilla.purus.mauris@vitaeerat.co.uk','malesuada','AKS71MCU7ZX',2),(11,'Odette','Mason','Ap #694-9352 Vehicula. St.','5882-5648','urna@Quisquenonummyipsum.edu','enim','SDK30XQI1UC',2),(12,'Unity','Alvarez','888-1338 Duis Rd.','1917-3814','Donec.nibh.enim@nonummyacfeugiat.com','suscipit','QFM95DNU0KP',1),(13,'Lucius','Church','182-6745 In Rd.','9055-2342','ridiculus.mus@loremacrisus.ca','dolor','WLQ05LQP3VO',2),(14,'Finn','Nash','P.O. Box 697, 4290 In Av.','4464-7979','vel.est.tempor@venenatis.org','eu','EWE72OVR3ZD',1),(15,'Shea','Hicks','3505 Integer Av.','6173-3558','lectus@malesuadaid.org','et,','RVF22YXL2VS',2),(16,'Jasmine','Davidson','362-2662 Odio. Rd.','2786-0003','a@arcuiaculisenim.net','mollis','CUL13UJT3ZK',1),(17,'Freya','Lucas','Ap #451-5333 At Ave','3589-0886','bibendum.ullamcorper@duinectempus.edu','mauris','JOH52KRZ6XQ',1),(18,'Quincy','Hutchinson','Ap #131-5671 Pede. St.','9498-2153','odio@Crasvulputatevelit.ca','metus.','LBO48OZQ2UR',1),(19,'Karina','Hawkins','9307 Accumsan Rd.','9084-4979','nisi.nibh.lacinia@eliterat.com','amet','ZXH85RBG7PH',2),(20,'Wylie','Mullins','Ap #442-7647 Neque. Ave','2235-0450','et.tristique@Phasellusfermentumconvallis.edu','cursus','ORY59XWI0RM',2),(21,'Aimee','Carr','503-4172 Vitae Rd.','8634-6346','auctor@nonjustoProin.ca','molestie.','HJV42XQD5HJ',2),(22,'Mason','Walker','P.O. Box 152, 4774 At Rd.','8792-8294','Nam.ac.nulla@vitaerisus.ca','tristique','GSN76EKN2OA',1),(23,'Hiroko','Cochran','871-293 Massa. St.','5256-8041','Donec@ipsumnon.org','libero','YNQ69RLN4ZL',2),(24,'Lucian','Becker','P.O. Box 173, 7899 Erat, Street','9847-5967','in@nibh.net','vel','LBG92EQX8PX',1),(25,'Declan','Weeks','P.O. Box 320, 7336 Ut St.','2995-7873','erat.eget@tortor.co.uk','sagittis.','YMH83MCM6CB',1),(26,'Shay','Galloway','6626 Mauris Rd.','5696-6254','luctus.Curabitur.egestas@lacus.co.uk','ipsum','DGT73NLB8AE',2),(27,'Maia','Wade','639-1270 A Avenue','0792-8525','nibh@ProindolorNulla.ca','augue','YPY02AES8IY',2),(28,'Vivien','Morris','Ap #663-9690 Integer Rd.','6459-8035','ligula.elit.pretium@egestaslaciniaSed.ca','In','SKT30IFM9RX',1),(29,'Harrison','Potts','302-7187 Tempor, Rd.','9277-8524','magna.sed.dui@Proinsedturpis.com','purus.','TRK67RAF0NY',1),(30,'Casey','Russell','P.O. Box 379, 5114 Dis Street','4894-3862','sagittis@nonummyFuscefermentum.com','pretium','CTY51ARB5NH',1),(31,'Ariana','Hancock','433 Ullamcorper, St.','7974-9151','montes@lacusEtiam.ca','amet,','HRS69AQW0WY',1),(32,'Abbot','Murphy','Ap #714-149 Diam Street','0652-5301','metus.Aenean.sed@dignissim.org','amet','EQK25HXS1QS',2),(33,'Akeem','Dawson','P.O. Box 826, 5313 Auctor. Road','9212-0342','leo@eudui.net','nisi','IWE10WEQ8WQ',2),(34,'Harding','Alvarado','P.O. Box 482, 1569 Ornare, St.','5809-2256','Sed.congue.elit@aliquetnecimperdiet.net','justo','CHM88GMF5MF',1),(35,'Aspen','Conrad','594-3308 Ut Street','9312-2530','varius.et.euismod@sed.net','ac','PYK41UYC8AR',2),(36,'Charissa','Kim','2010 Turpis Avenue','8212-6032','nisl@semNullainterdum.ca','malesuada','BNV85BYU8UM',1),(37,'Jessica','Peck','4844 Et, St.','5908-1349','arcu.Nunc@eleifend.co.uk','nec','XRJ96LYC0DG',2),(38,'Anthony','Murphy','5841 Mauris, St.','3741-0218','lectus@convallisconvallis.ca','orci','MBA21MKP1GJ',2),(39,'Yardley','Terrell','P.O. Box 637, 5741 Fringilla Street','2417-4964','semper@luctus.org','amet','OTV01ATB7FX',1),(40,'Whilemina','Sheppard','P.O. Box 570, 2593 Sociosqu Ave','2979-8492','tempor@acrisus.ca','lectus','XCU01JRH6SL',2),(41,'Patricia','Ramirez','939 Quam. Ave','4734-5900','tincidunt.aliquam@parturientmontesnascetur.ca','Nunc','ZXD23NZS4UD',2),(42,'Adam','Vaughn','1167 Commodo Ave','7016-0127','ut.nulla.Cras@quamPellentesque.com','id,','ODA48BLR2ZK',1),(43,'Karen','Benton','589-6668 Et, Street','0195-7859','semper.auctor@vitae.edu','Proin','YZK13HHE1YY',1),(44,'Keely','Strong','5285 At Road','3874-8973','luctus.et@ut.com','habitant','RMF13QRX7AQ',2),(45,'Mufutau','Sharp','523-6850 Ante. Av.','3101-8308','in.dolor.Fusce@ullamcorper.edu','fringilla','ILS37ROD0RZ',2),(46,'Berk','Vega','P.O. Box 872, 7519 Integer Street','3057-1893','Duis@vulputaterisus.ca','Aliquam','YVL43GNG1UP',1),(47,'Ross','Benjamin','898-8984 Morbi St.','6907-2731','turpis.nec.mauris@ligula.co.uk','suscipit','SIX13RYJ4RF',1),(48,'Connor','Lloyd','Ap #802-9150 Eu Rd.','7883-8308','lectus.Nullam.suscipit@iderat.com','felis,','OCU27DUC5KC',2),(49,'Cade','Nicholson','2446 Sed Street','9188-4182','aliquet.metus@consectetuer.ca','Fusce','KMG44DJU1EA',1),(50,'Eugenia','Long','Ap #998-1659 Cras Av.','0842-8733','posuere.at.velit@nunc.net','adipiscing','PRC52VAK4HG',2),(51,'Barry','Sargent','Ap #458-3813 Tellus St.','2694-8922','Phasellus.libero.mauris@eget.ca','vel','RHB55ZXL5AG',2),(52,'Anika','Warner','P.O. Box 943, 6949 Proin Rd.','1765-3700','lorem.eget.mollis@rhoncusNullam.org','et','VPT82BTA4JP',2),(53,'Quinn','Baxter','P.O. Box 628, 9544 Sit Road','5149-7686','Phasellus.dapibus.quam@ornarelectus.edu','lobortis','DXF57FYW7XY',2),(54,'Iris','Velasquez','P.O. Box 442, 3541 Lorem Rd.','6134-2365','eu.tellus.Phasellus@eusem.co.uk','lorem','ANI95BLE4AN',1),(55,'Cailin','Chase','Ap #647-3126 Ornare Av.','2407-6458','pede.blandit@eteuismod.net','eu,','FMA28LJP3XR',2),(56,'Grant','Hoffman','Ap #886-4567 Lectus, Av.','2602-5751','auctor@pellentesquemassa.edu','neque','REX50CPB4HD',1),(57,'Darrel','Fields','857-8013 Et St.','5890-7769','molestie@actellusSuspendisse.co.uk','dui,','BRR28YFC6CV',2),(58,'Erasmus','Rosa','481-2162 Urna. Rd.','8808-9010','dolor@in.org','ante.','XDU34IBF7ZU',1),(59,'Hunter','Miller','P.O. Box 150, 1731 Nulla. Avenue','1109-7403','sodales.nisi.magna@Fuscediamnunc.ca','montes,','ZRO15OBD8DR',1),(60,'Cadman','Albert','750-2199 Augue Rd.','2033-4459','leo.Vivamus@a.com','purus','HWR67QSR2YX',2),(61,'Mannix','Callahan','Ap #933-1940 Nunc St.','9392-9336','In@a.org','enim','ZYV52BND4PU',1),(62,'Alfreda','Golden','Ap #150-3082 Suspendisse Av.','1440-4572','nonummy.ipsum@Donecatarcu.ca','In','NBP67MMW7AI',2),(63,'Keiko','Stephenson','Ap #266-4982 Vitae Avenue','9583-0930','orci@velitegetlaoreet.edu','sociosqu','HCG64WCZ3KL',1),(64,'Hasad','Barlow','2834 Nunc Street','4578-7215','accumsan.neque.et@pharetra.ca','vitae','MRB94SUS2ZE',1),(65,'Zephania','Landry','Ap #987-7959 Hendrerit Rd.','9127-7174','metus@Aeneansedpede.co.uk','eu','UAW05FRL5SJ',1),(66,'Glenna','Clark','556-8701 Mollis. St.','7028-3427','accumsan@Nullamsuscipitest.edu','mollis','ECX98OXV2BK',1),(67,'Sonya','George','6594 Lorem, St.','1524-5244','magna.tellus@Sedet.ca','luctus,','UUP33HPX2XB',1),(68,'Brandon','Mason','Ap #478-251 Laoreet, Av.','3181-3973','amet@nuncinterdum.net','tincidunt','UAG45NZI9PX',1),(69,'Anthony','Woods','Ap #889-2387 Amet Rd.','5330-8678','Cras.vulputate@acnulla.edu','dolor','APX40CAC7SX',2),(70,'India','Downs','P.O. Box 338, 8802 Sagittis Rd.','6995-8555','semper.erat.in@magnisdis.com','Donec','FXF87MLN7JT',2),(71,'Samson','Roberson','Ap #631-4617 Elit Ave','2802-9745','a.tortor.Nunc@dis.org','egestas.','NOR39ULC0DR',1),(72,'Joy','Dorsey','Ap #148-4450 Auctor Av.','5882-5103','augue@ligulaeu.co.uk','hymenaeos.','JPZ89MSA1ZQ',2),(73,'Chase','Lane','Ap #307-1804 Metus Ave','1105-0320','Nulla.aliquet.Proin@ornaresagittis.net','dictum','HVQ16YVN3WZ',2),(74,'Sacha','Gutierrez','2277 Morbi Street','8890-3919','taciti.sociosqu.ad@imperdietullamcorperDuis.org','ante','AIS85WVT1NU',1),(75,'Xavier','Britt','Ap #982-9188 Sed Av.','2100-6401','Cras.vehicula@urnaNunc.co.uk','blandit','URB67OHK8LK',2),(76,'Sydney','Cervantes','P.O. Box 729, 8047 Lacus. Avenue','1196-5152','erat.volutpat@suscipitnonummyFusce.com','et,','ZWO51GPD1DH',2),(77,'Brady','Hanson','Ap #121-1575 Mauris St.','9248-6524','non.lacinia.at@cursuset.co.uk','parturient','QFJ50XEC0TI',1),(78,'Anne','Craft','Ap #772-6131 Vulputate, Rd.','5011-5922','sem.ut.dolor@lacus.org','velit','AZQ69HBK9BN',2),(79,'Ali','Acosta','Ap #820-4232 Nec Road','3808-3280','fringilla@enimcondimentumeget.net','nunc','HCN43UIE1ZZ',1),(80,'Debra','Holcomb','9406 Congue, Rd.','3487-1448','vitae.aliquam@dictumultricies.com','Duis','ITD39OMK5VG',1),(81,'Macey','Baker','525-182 Interdum. Street','7414-3296','lacinia.mattis@aliquetmagna.ca','mus.','YQL68EFK4KT',2),(82,'Reed','Francis','P.O. Box 211, 6989 Quisque Avenue','9824-4180','tortor.Integer.aliquam@maurisaliquameu.org','elementum','NCB12PYA1VK',1),(83,'Lila','Brock','3940 In, Av.','0138-9042','amet.risus.Donec@Naminterdum.edu','massa.','AVO34YRV2BC',1),(84,'Blaine','Valdez','246-2358 Massa. St.','6768-0217','Aliquam.vulputate.ullamcorper@egestas.ca','id','OUW69EGF3TC',1),(85,'Venus','Bender','Ap #175-9832 Aenean Rd.','6464-7271','Donec@Etiam.com','id','TFI00DYU3QA',1),(86,'Linus','Stevens','856-9547 Nisi. Avenue','3650-8416','aliquet.magna@diamat.edu','diam.','PQD27RQS9RK',2),(87,'Hannah','Byers','948-570 Vel Rd.','2820-9251','dolor.nonummy.ac@blanditmattis.net','Nullam','NVJ75EGQ7XL',1),(88,'Yuli','Stout','P.O. Box 127, 2903 Vitae St.','1441-5345','lobortis.tellus.justo@Aliquamtincidunt.edu','tellus','NRS26BYR0ER',1),(89,'Oliver','Hoffman','670 Curabitur Rd.','6965-9276','leo@Nulla.co.uk','Nullam','MUN71JJQ8UC',2),(90,'Lars','Everett','Ap #119-8658 Lorem Ave','4057-6696','risus.odio@liberoProinmi.ca','In','QDU31ZDB4RG',2),(91,'Liberty','Sellers','948-3915 Aliquam, Road','2288-1867','tincidunt.dui@cursus.org','urna.','ORX34NOQ4FA',2),(92,'Ariana','Fowler','P.O. Box 100, 8315 Nam Avenue','0513-9014','pharetra.Nam@eu.org','ut','XVJ93XZC9XU',1),(93,'Bert','Aguilar','6266 Fermentum Avenue','0681-3771','at.arcu.Vestibulum@quispedeSuspendisse.ca','ante.','QXS31YIE6KH',2),(94,'Martena','Schmidt','6348 Proin Rd.','9251-4325','Nulla@liberoduinec.co.uk','inceptos','BPH87MHW5IU',1),(95,'Anika','Pratt','P.O. Box 414, 1115 Lorem Av.','9938-7292','eu@augueidante.ca','vehicula.','VCN11XFB5XO',1),(96,'Malcolm','Hester','5758 Sed Street','6487-6232','vitae@eutelluseu.com','odio','WWR21WCI6XM',1),(97,'Tanek','Rasmussen','Ap #933-1036 Odio, St.','4621-5687','non.hendrerit@augueutlacus.ca','Nunc','VCX32KIS6DL',2),(98,'Damon','Schultz','120-4278 Suspendisse Av.','4358-7975','non.dapibus@euplacerat.org','posuere','OGC00SQG0UG',1),(99,'Peter','Workman','4312 Amet Av.','1566-9933','libero@rhoncusidmollis.net','ipsum','QQJ37YOU3XA',1),(100,'India','Parker','Ap #985-1700 Mollis Av.','4884-9094','euismod@dapibus.com','consectetuer','HHD51GNT7AR',1);

INSERT INTO EspecialidadDoctor (idEspecialidadDoctor,idDoctor,idEspecialidad) VALUES (1,55,8),(2,65,4),(3,48,2),(4,24,6),(5,84,7),(6,65,5),(7,23,9),(8,7,7),(9,50,4),(10,16,4),(11,6,5),(12,99,1),(13,4,3),(14,43,4),(15,98,7),(16,71,3),(17,15,8),(18,45,2),(19,51,9),(20,95,7),(21,2,6),(22,79,1),(23,42,7),(24,99,8),(25,27,2),(26,78,3),(27,8,1),(28,8,3),(29,68,6),(30,70,9),(31,60,4),(32,96,8),(33,3,6),(34,75,5),(35,47,1),(36,58,6),(37,100,8),(38,5,9),(39,51,4),(40,70,5),(41,31,3),(42,76,4),(43,16,3),(44,97,1),(45,22,3),(46,47,1),(47,17,8),(48,37,8),(49,22,2),(50,91,3),(51,84,7),(52,53,9),(53,17,3),(54,24,8),(55,90,3),(56,32,3),(57,90,4),(58,89,8),(59,82,3),(60,69,2),(61,88,5),(62,39,9),(63,69,2),(64,66,4),(65,35,4),(66,38,3),(67,94,8),(68,69,4),(69,43,4),(70,75,2),(71,63,5),(72,92,1),(73,51,8),(74,14,9),(75,30,8),(76,2,4),(77,13,3),(78,93,9),(79,21,7),(80,82,5),(81,42,9),(82,73,8),(83,78,7),(84,33,6),(85,2,7),(86,40,4),(87,34,2),(88,19,8),(89,92,8),(90,90,6),(91,23,2),(92,86,3),(93,12,6),(94,9,4),(95,87,6),(96,93,9),(97,88,4),(98,58,7),(99,11,1),(100,32,1);

INSERT INTO PacienteAsignado (idPacienteAsignado,idPaciente,idDoctor) VALUES (1,57,34),(2,57,44),(3,41,79),(4,61,100),(5,85,63),(6,21,91),(7,48,47),(8,26,88),(9,33,86),(10,44,51),(11,84,41),(12,36,82),(13,76,61),(14,49,71),(15,69,80),(16,50,60),(17,62,49),(18,97,14),(19,44,31),(20,61,94),(21,98,100),(22,62,80),(23,17,70),(24,60,81),(25,61,80),(26,16,19),(27,80,6),(28,78,25),(29,43,92),(30,32,75),(31,55,44),(32,95,28),(33,54,53),(34,33,54),(35,46,55),(36,69,16),(37,63,23),(38,74,15),(39,31,91),(40,47,26),(41,89,88),(42,93,37),(43,38,10),(44,82,73),(45,95,84),(46,44,67),(47,46,67),(48,57,36),(49,56,72),(50,87,31),(51,53,71),(52,23,38),(53,69,74),(54,76,81),(55,59,31),(56,61,49),(57,50,84),(58,37,87),(59,48,31),(60,17,56),(61,40,52),(62,94,76),(63,17,76),(64,83,65),(65,48,8),(66,87,15),(67,28,85),(68,84,60),(69,50,16),(70,80,72),(71,8,64),(72,68,73),(73,45,59),(74,59,17),(75,66,87),(76,54,62),(77,22,4),(78,15,66),(79,32,56),(80,36,45),(81,62,48),(82,3,43),(83,81,44),(84,54,12),(85,37,11),(86,38,32),(87,41,93),(88,83,8),(89,73,72),(90,93,44),(91,71,34),(92,91,53),(93,74,38),(94,4,19),(95,37,55),(96,45,83),(97,91,56),(98,7,62),(99,36,93),(100,4,38);

INSERT INTO Recetas (idReceta,Farmaco,FechaRegistro,idPacienteAsignado) VALUES (1,'dolor','30/05/2021',22),(2,'vestibulum,','10/06/2021',81),(3,'cursus','22/05/2021',17),(4,'metus. Vivamus','10/03/2021',30),(5,'pharetra. Nam','17/06/2021',13),(6,'quis, pede.','19/07/2021',53),(7,'magna. Nam','19/07/2021',51),(8,'elementum','11/06/2021',53),(9,'mauris','03/06/2021',66),(10,'eleifend vitae,','10/08/2021',31),(11,'lobortis','27/08/2021',34),(12,'nec,','08/07/2021',98),(13,'congue. In','17/06/2021',27),(14,'aliquet libero.','04/12/2021',22),(15,'magna tellus','16/07/2021',79),(16,'eu dolor','10/12/2021',13),(17,'et tristique','22/07/2021',49),(18,'massa','03/07/2021',51),(19,'mollis dui,','11/03/2021',47),(20,'In','24/04/2021',91),(21,'dictum','10/02/2021',67),(22,'urna.','04/03/2021',49),(23,'tellus. Nunc','20/07/2021',36),(24,'sit','21/05/2021',54),(25,'Nunc commodo','28/07/2021',72),(26,'nibh dolor,','08/11/2021',27),(27,'id risus','23/11/2021',62),(28,'aliquet','02/07/2021',7),(29,'sem. Pellentesque','10/09/2021',59),(30,'magna tellus','20/06/2021',61),(31,'diam.','09/12/2021',17),(32,'dolor. Quisque','11/01/2021',86),(33,'consectetuer','01/09/2021',57),(34,'diam vel','15/08/2021',18),(35,'erat nonummy','31/07/2021',51),(36,'commodo at,','23/08/2021',56),(37,'congue','02/06/2021',19),(38,'nunc nulla','04/05/2021',95),(39,'Morbi vehicula.','23/09/2021',3),(40,'lobortis','17/10/2021',51),(41,'Curabitur ut','03/11/2021',79),(42,'mauris, rhoncus','05/03/2021',13),(43,'Integer','10/09/2021',39),(44,'vulputate,','07/05/2021',2),(45,'non','10/01/2021',67),(46,'Curabitur','20/05/2021',25),(47,'sit','11/09/2021',86),(48,'bibendum ullamcorper.','30/07/2021',21),(49,'augue scelerisque','21/07/2021',79),(50,'dignissim','15/06/2021',51),(51,'ridiculus mus.','29/05/2021',31),(52,'nunc.','27/06/2021',92),(53,'lorem.','23/03/2021',83),(54,'turpis','19/05/2021',28),(55,'scelerisque','10/05/2021',7),(56,'parturient','28/08/2021',91),(57,'eget laoreet','04/06/2021',3),(58,'dictum','03/07/2021',88),(59,'dictum placerat,','17/10/2021',23),(60,'orci,','01/10/2021',42),(61,'aliquam eu,','12/07/2021',11),(62,'Morbi','01/09/2021',14),(63,'tincidunt,','07/11/2021',56),(64,'amet, faucibus','13/10/2021',14),(65,'orci. Ut','09/08/2021',12),(66,'pede,','19/12/2021',37),(67,'justo faucibus','12/09/2021',100),(68,'nunc','14/11/2021',8),(69,'sit amet','06/12/2021',50),(70,'cubilia','10/07/2021',53),(71,'nulla. In','29/08/2021',52),(72,'mauris','09/05/2021',13),(73,'Mauris molestie','17/05/2021',29),(74,'vulputate,','07/07/2021',8),(75,'mus.','16/07/2021',77),(76,'augue','11/12/2021',91),(77,'faucibus. Morbi','12/02/2021',47),(78,'ultricies dignissim','08/01/2021',16),(79,'Suspendisse non','16/04/2021',20),(80,'erat','16/10/2021',67),(81,'eget','28/07/2021',13),(82,'Cras vehicula','09/07/2021',71),(83,'laoreet,','15/03/2021',3),(84,'Ut','02/05/2021',33),(85,'massa.','31/05/2021',4),(86,'erat semper','17/03/2021',17),(87,'purus.','31/10/2021',72),(88,'Vivamus euismod','26/05/2021',85),(89,'sed','27/03/2021',60),(90,'augue id','03/07/2021',49),(91,'Mauris','06/04/2021',49),(92,'nec','25/09/2021',71),(93,'Praesent','06/02/2021',9),(94,'orci','01/09/2021',40),(95,'blandit','10/09/2021',98),(96,'metus.','10/02/2021',64),(97,'dui. Cum','13/07/2021',4),(98,'ante.','16/03/2021',97),(99,'eu','14/05/2021',24),(100,'congue. In','16/07/2021',17);


INSERT INTO TipoTratamiento
values
(1,'Limpieza Dental'),
(2,'Pullido de Dientes'),
(3,'Tratamiento de Braquets');

Insert Into EstadoTratamiento
values
(1,'En Proceso'),
(2,'Finalizado'),
(3,'Suspendido');


INSERT INTO Tratamientos (idTratamiento,fechaInicio,descripcionTratamiento,idPacienteAsignado,idTipoTratamiento,idEstadoTratamiento) VALUES (1,'01/09/2020','ullamcorper eu, euismod ac, fermentum',72,3,3),(2,'03/09/2020','Praesent interdum ligula eu enim.',22,3,2),(3,'15/05/2019','Suspendisse aliquet molestie tellus. Aenean',94,1,3),(4,'22/05/2020','dis parturient montes, nascetur ridiculus',72,3,2),(5,'15/06/2021','gravida. Praesent eu nulla at',27,3,1),(6,'13/06/2019','Cum sociis natoque penatibus et',39,3,2),(7,'10/09/2019','Sed diam lorem, auctor quis,',95,3,2),(8,'04/07/2019','velit eget laoreet posuere, enim',15,1,2),(9,'06/06/2019','dignissim. Maecenas ornare egestas ligula.',5,1,3),(10,'16/12/2019','ultricies ligula. Nullam enim. Sed',7,3,3),(11,'15/07/2021','Nulla eu neque pellentesque massa',22,2,1),(12,'20/12/2020','Mauris molestie pharetra nibh. Aliquam',97,3,2),(13,'21/12/2019','Mauris nulla. Integer urna. Vivamus',57,2,2),(14,'24/04/2020','lectus convallis est, vitae sodales',47,1,2),(15,'04/09/2021','vel sapien imperdiet ornare. In',71,1,1),(16,'19/05/2020','Nulla interdum. Curabitur dictum. Phasellus',29,3,1),(17,'04/03/2019','dolor. Quisque tincidunt pede ac',73,2,3),(18,'30/07/2020','nec mauris blandit mattis. Cras',14,2,2),(19,'11/11/2020','morbi tristique senectus et netus',57,1,3),(20,'31/01/2021','enim. Suspendisse aliquet, sem ut',78,2,2),(21,'07/01/2021','tristique aliquet. Phasellus fermentum convallis',11,3,1),(22,'22/05/2020','Aliquam gravida mauris ut mi.',84,2,1),(23,'18/04/2021','sollicitudin commodo ipsum. Suspendisse non',33,1,2),(24,'11/08/2021','molestie tortor nibh sit amet',68,1,3),(25,'24/05/2019','at pretium aliquet, metus urna',34,3,3),(26,'04/04/2019','suscipit nonummy. Fusce fermentum fermentum',7,2,3),(27,'14/03/2019','adipiscing lacus. Ut nec urna',40,2,1),(28,'24/06/2020','Sed auctor odio a purus.',65,3,3),(29,'25/03/2020','quam. Curabitur vel lectus. Cum',83,3,3),(30,'09/02/2020','felis ullamcorper viverra. Maecenas iaculis',2,2,1),(31,'26/01/2020','velit egestas lacinia. Sed congue,',61,1,2),(32,'04/04/2020','sagittis augue, eu tempor erat',84,1,3),(33,'18/03/2020','dolor. Quisque tincidunt pede ac',22,1,1),(34,'22/10/2019','dictum sapien. Aenean massa. Integer',24,1,1),(35,'26/04/2020','eu arcu. Morbi sit amet',20,1,1),(36,'16/11/2019','tempus risus. Donec egestas. Duis',67,2,3),(37,'31/05/2021','dolor sit amet, consectetuer adipiscing',23,1,3),(38,'14/03/2019','vitae aliquam eros turpis non',99,2,1),(39,'24/12/2019','at risus. Nunc ac sem',34,1,3),(40,'06/12/2019','a, facilisis non, bibendum sed,',91,2,2),(41,'18/07/2021','Nullam velit dui, semper et,',3,2,1),(42,'07/09/2019','neque. Nullam ut nisi a',16,3,3),(43,'28/08/2021','Donec felis orci, adipiscing non,',93,1,3),(44,'09/10/2020','consequat auctor, nunc nulla vulputate',86,1,1),(45,'30/06/2019','Praesent interdum ligula eu enim.',3,2,2),(46,'20/06/2020','dui. Fusce diam nunc, ullamcorper',93,3,3),(47,'18/03/2019','non dui nec urna suscipit',83,1,2),(48,'06/03/2019','quis urna. Nunc quis arcu',18,1,2),(49,'11/07/2019','mauris, aliquam eu, accumsan sed,',52,2,2),(50,'26/03/2021','Nullam suscipit, est ac facilisis',64,1,2),(51,'06/02/2020','eros. Proin ultrices. Duis volutpat',85,1,2),(52,'25/07/2020','posuere, enim nisl elementum purus,',7,1,1),(53,'24/10/2020','Sed eget lacus. Mauris non',1,1,3),(54,'17/04/2020','tincidunt tempus risus. Donec egestas.',76,2,1),(55,'11/10/2020','adipiscing non, luctus sit amet,',92,2,1),(56,'01/03/2021','consectetuer ipsum nunc id enim.',80,2,1),(57,'12/03/2021','et magnis dis parturient montes,',71,3,1),(58,'28/04/2020','Duis sit amet diam eu',91,2,3),(59,'08/11/2020','et, magna. Praesent interdum ligula',56,1,2),(60,'19/07/2019','arcu. Nunc mauris. Morbi non',52,1,2),(61,'12/07/2021','ipsum nunc id enim. Curabitur',62,2,3),(62,'11/11/2019','leo elementum sem, vitae aliquam',78,1,3),(63,'30/06/2020','orci luctus et ultrices posuere',76,1,1),(64,'15/02/2020','id, erat. Etiam vestibulum massa',90,1,1),(65,'11/02/2020','justo nec ante. Maecenas mi',28,3,3),(66,'08/04/2019','enim nec tempus scelerisque, lorem',58,2,2),(67,'22/08/2020','non, lacinia at, iaculis quis,',14,3,3),(68,'20/03/2019','metus. Aenean sed pede nec',27,2,2),(69,'06/05/2020','ut lacus. Nulla tincidunt, neque',51,2,1),(70,'31/01/2021','tellus. Nunc lectus pede, ultrices',100,1,3),(71,'01/08/2021','placerat, augue. Sed molestie. Sed',15,3,3),(72,'14/09/2019','tempus, lorem fringilla ornare placerat,',79,1,3),(73,'21/09/2021','odio. Nam interdum enim non',96,2,3),(74,'23/10/2020','adipiscing non, luctus sit amet,',82,2,3),(75,'15/01/2020','lorem. Donec elementum, lorem ut',21,2,1),(76,'03/04/2019','Vestibulum ut eros non enim',11,1,2),(77,'11/08/2020','Donec elementum, lorem ut aliquam',36,2,3),(78,'09/02/2021','Integer vitae nibh. Donec est',47,2,2),(79,'21/10/2020','sem molestie sodales. Mauris blandit',71,2,2),(80,'10/05/2021','Suspendisse tristique neque venenatis lacus.',91,1,2),(81,'28/01/2021','nec luctus felis purus ac',75,3,2),(82,'16/11/2019','congue. In scelerisque scelerisque dui.',55,3,3),(83,'26/02/2021','libero at auctor ullamcorper, nisl',37,3,1),(84,'10/04/2021','interdum. Nunc sollicitudin commodo ipsum.',4,2,3),(85,'14/06/2019','mi. Duis risus odio, auctor',8,1,1),(86,'06/07/2020','iaculis odio. Nam interdum enim',70,3,2),(87,'05/08/2019','sed dictum eleifend, nunc risus',14,1,1),(88,'28/06/2021','Proin vel nisl. Quisque fringilla',41,2,1),(89,'21/07/2020','faucibus leo, in lobortis tellus',43,3,1),(90,'28/04/2019','non, lacinia at, iaculis quis,',69,2,1),(91,'21/05/2021','pellentesque, tellus sem mollis dui,',7,3,1),(92,'21/03/2020','libero lacus, varius et, euismod',1,1,1),(93,'29/05/2019','in felis. Nulla tempor augue',88,3,3),(94,'23/11/2020','pretium neque. Morbi quis urna.',92,2,1),(95,'27/04/2019','purus ac tellus. Suspendisse sed',45,2,3),(96,'13/05/2019','sagittis augue, eu tempor erat',86,3,3),(97,'20/01/2021','luctus ut, pellentesque eget, dictum',54,2,1),(98,'18/09/2019','Cras vulputate velit eu sem.',59,3,3),(99,'06/05/2021','nisl sem, consequat nec, mollis',43,1,2),(100,'13/04/2019','sem egestas blandit. Nam nulla',56,1,1);


insert into Procedimientos 
values 
(1,'Endodoncias','Maecenas ornare egestas',20.99),
(2,'Escalado y Alisado Radicular','non ante bibendum ullamcorper',14.99),
(3,'Ortodoncia','sapien imperdiet',30.99),
(4,'Extracción','ac metus vitae velit',10.50),
(5,'Restauraciones','magna. Lorem ipsum dolor si',35.56),
(6,'Restauración con Amalgama','consectetuer adipiscing elit',36.34),
(7,'Restauración Compuesta','Vivamus euismod urna. Nullam',34.94),
(8,'Selladores','itae risus. Duis a mi fringilla m',16.78);


insert into CausaConsulta
values
(1,'Higiene Oral'),
(2,'Sensibilidad Oral'),
(3,'Nefrosis'),
(4,'Visita al Dentista');


INSERT INTO Consultas (idConsulta,notasConsulta,fechaConsulta,costoConsulta,idCausaConsulta) VALUES (1,'Curabitur vel lectus.','2021-03-14 01:02:53','0.00',1),(2,'Nam nulla magna,','2021-10-11 06:06:19','0.00',1),(3,'eu','2021-03-15 23:17:01','0.00',3),(4,'Integer aliquam adipiscing','2021-12-10 16:53:41','0.00',1),(5,'diam. Sed diam','2022-01-28 07:05:44','0.00',1),(6,'imperdiet ullamcorper. Duis','2022-02-17 16:57:35','0.00',4),(7,'consectetuer adipiscing','2021-01-14 15:58:22','0.00',4),(8,'nibh','2021-09-30 07:48:11','0.00',4),(9,'ligula consectetuer','2021-04-12 22:04:49','0.00',4),(10,'lectus quis massa.','2021-07-26 23:12:18','0.00',4),(11,'laoreet,','2021-10-26 19:39:08','0.00',1),(12,'nunc','2021-01-24 05:55:01','0.00',4),(13,'lorem, luctus','2021-11-11 17:37:41','0.00',4),(14,'ut lacus.','2021-02-03 06:54:50','0.00',2),(15,'pede blandit','2021-08-27 19:24:56','0.00',3),(16,'mattis semper, dui','2021-09-24 09:37:13','0.00',1),(17,'Nam','2021-04-16 07:35:37','0.00',3),(18,'ultrices. Vivamus rhoncus.','2021-04-07 16:07:53','0.00',3),(19,'arcu','2021-08-27 08:49:34','0.00',4),(20,'eleifend vitae,','2021-04-08 18:29:39','0.00',1),(21,'Phasellus','2021-01-09 12:15:34','0.00',4),(22,'Nulla','2021-10-12 21:18:51','0.00',2),(23,'Sed','2021-11-06 07:11:59','0.00',4),(24,'lacus.','2021-12-17 09:20:25','0.00',2),(25,'quis, pede. Praesent','2022-02-14 15:52:58','0.00',1),(26,'quis turpis vitae','2021-09-14 14:55:59','0.00',3),(27,'faucibus orci luctus','2021-02-26 21:17:35','0.00',4),(28,'turpis','2021-12-27 22:52:49','0.00',1),(29,'fermentum','2022-01-30 10:01:49','0.00',3),(30,'sem mollis','2021-08-06 06:33:02','0.00',4),(31,'eu arcu. Morbi','2021-02-03 21:13:19','0.00',1),(32,'primis','2022-01-17 12:43:57','0.00',4),(33,'nascetur ridiculus','2021-06-08 11:46:43','0.00',1),(34,'urna. Vivamus','2021-10-31 03:52:30','0.00',3),(35,'Praesent','2021-12-08 06:53:19','0.00',1),(36,'est','2021-07-10 08:16:13','0.00',4),(37,'vehicula.','2021-11-18 04:27:43','0.00',4),(38,'blandit mattis. Cras','2022-02-25 06:21:17','0.00',4),(39,'Proin non','2021-03-07 17:11:07','0.00',2),(40,'habitant morbi tristique','2021-12-25 21:19:05','0.00',4),(41,'Nunc commodo','2021-03-27 12:10:39','0.00',3),(42,'dolor. Fusce','2021-07-02 22:16:45','0.00',1),(43,'massa. Quisque porttitor','2021-03-24 15:34:45','0.00',2),(44,'tortor. Nunc commodo','2021-04-01 21:24:00','0.00',1),(45,'Pellentesque','2021-01-19 15:20:51','0.00',4),(46,'ac mi','2021-06-02 06:06:18','0.00',3),(47,'netus','2021-08-30 17:19:22','0.00',3),(48,'in','2021-10-22 10:18:44','0.00',1),(49,'consequat,','2021-06-13 13:50:21','0.00',4),(50,'penatibus et magnis','2021-09-15 13:44:59','0.00',1),(51,'ipsum. Phasellus vitae','2021-10-08 09:09:34','0.00',2),(52,'gravida sit amet,','2021-12-19 05:54:55','0.00',3),(53,'lorem','2021-01-21 04:27:53','0.00',4),(54,'Suspendisse ac metus','2021-09-13 07:06:25','0.00',4),(55,'sit','2021-05-16 05:57:25','0.00',4),(56,'justo.','2022-01-16 03:10:41','0.00',1),(57,'urna convallis','2022-01-02 05:29:33','0.00',2),(58,'elementum sem, vitae','2021-06-27 13:58:51','0.00',4),(59,'fringilla ornare placerat,','2021-05-05 14:54:09','0.00',2),(60,'sapien. Cras','2021-11-14 00:35:20','0.00',2),(61,'mauris elit,','2021-08-01 03:10:31','0.00',1),(62,'ullamcorper eu, euismod','2021-12-22 17:57:42','0.00',1),(63,'enim. Suspendisse','2021-11-21 06:46:33','0.00',4),(64,'in consectetuer','2021-09-15 09:38:10','0.00',4),(65,'elementum','2021-09-10 21:43:02','0.00',2),(66,'Donec nibh','2022-01-17 16:10:54','0.00',2),(67,'eu, ligula. Aenean','2021-11-06 21:32:38','0.00',1),(68,'in,','2021-08-27 10:42:48','0.00',4),(69,'Donec sollicitudin','2021-05-21 06:50:34','0.00',4),(70,'non lorem','2022-01-08 09:47:48','0.00',3),(71,'elementum, lorem ut','2021-07-13 12:35:25','0.00',2),(72,'lorem vitae odio','2021-07-29 14:00:05','0.00',4),(73,'leo elementum','2021-11-07 06:01:52','0.00',3),(74,'risus. Morbi metus.','2021-06-07 18:52:30','0.00',1),(75,'ac, fermentum','2021-07-24 16:08:59','0.00',3),(76,'luctus lobortis.','2022-01-09 16:45:29','0.00',1),(77,'dolor,','2021-05-11 20:48:30','0.00',1),(78,'eu odio','2021-01-29 16:51:10','0.00',4),(79,'nec ligula consectetuer','2021-03-09 02:31:07','0.00',3),(80,'faucibus orci luctus','2022-02-05 04:39:46','0.00',1),(81,'orci tincidunt adipiscing.','2021-07-20 12:50:00','0.00',1),(82,'gravida sit amet,','2021-10-26 10:41:51','0.00',4),(83,'sociis natoque penatibus','2021-12-14 04:41:46','0.00',1),(84,'pede.','2021-08-16 19:39:05','0.00',4),(85,'sapien,','2021-08-24 11:24:01','0.00',3),(86,'vitae','2021-03-31 17:20:47','0.00',1),(87,'neque. Morbi','2021-07-22 11:58:59','0.00',1),(88,'gravida non,','2021-02-12 20:14:54','0.00',3),(89,'a felis','2021-05-26 03:37:29','0.00',1),(90,'Curabitur','2021-06-07 00:09:08','0.00',4),(91,'morbi','2021-12-19 05:05:54','0.00',2),(92,'euismod','2021-11-25 22:55:22','0.00',1),(93,'eleifend, nunc','2021-02-02 10:12:08','0.00',3),(94,'turpis vitae purus','2021-01-22 07:10:08','0.00',2),(95,'mollis vitae, posuere','2021-08-22 17:00:41','0.00',2),(96,'nascetur','2021-12-05 07:04:05','0.00',2),(97,'Aliquam nec','2021-07-03 04:27:44','0.00',1),(98,'orci.','2021-09-09 04:25:38','0.00',1),(99,'sed','2021-09-21 05:51:50','0.00',3),(100,'egestas nunc sed','2021-06-19 05:14:58','0.00',2);

INSERT INTO ConsultaProcedimiento (idConsultaProcedimiento,idConsulta,idProcedimiento) VALUES (1,65,8),(2,14,3),(3,64,7),(4,18,6),(5,55,8),(6,16,6),(7,64,7),(8,81,3),(9,3,8),(10,81,6),(11,59,6),(12,70,1),(13,61,1),(14,90,5),(15,40,3),(16,55,5),(17,81,2),(18,21,7),(19,14,8),(20,55,7),(21,55,3),(22,54,3),(23,73,1),(24,9,3),(25,1,4),(26,57,3),(27,65,5),(28,82,4),(29,55,2),(30,70,1),(31,41,5),(32,49,2),(33,44,2),(34,41,7),(35,40,7),(36,98,2),(37,26,6),(38,22,7),(39,27,7),(40,46,1),(41,37,4),(42,3,5),(43,83,3),(44,87,3),(45,80,4),(46,84,8),(47,73,4),(48,73,5),(49,18,6),(50,7,3),(51,12,2),(52,3,4),(53,72,2),(54,75,7),(55,44,6),(56,16,2),(57,43,3),(58,42,2),(59,44,6),(60,88,8),(61,82,1),(62,1,6),(63,22,5),(64,94,7),(65,86,8),(66,42,2),(67,93,4),(68,83,1),(69,16,4),(70,28,1),(71,25,6),(72,10,7),(73,44,8),(74,69,1),(75,31,8),(76,46,3),(77,26,7),(78,35,1),(79,20,2),(80,31,1),(81,52,7),(82,21,8),(83,94,4),(84,73,5),(85,36,6),(86,82,4),(87,57,7),(88,37,4),(89,42,4),(90,69,6),(91,44,2),(92,72,2),(93,89,1),(94,13,7),(95,53,5),(96,89,5),(97,18,8),(98,5,8),(99,94,2),(100,84,8);
INSERT INTO ConsultaProcedimiento (idConsultaProcedimiento,idConsulta,idProcedimiento) VALUES (101,66,5),(102,49,7),(103,90,1),(104,7,4),(105,7,7),(106,21,3),(107,14,5),(108,75,7),(109,77,7),(110,14,8),(111,24,8),(112,64,1),(113,68,2),(114,95,6),(115,92,2),(116,51,4),(117,13,7),(118,90,8),(119,72,5),(120,63,5),(121,3,4),(122,55,4),(123,30,8),(124,4,8),(125,66,1),(126,94,5),(127,24,2),(128,26,7),(129,52,6),(130,93,7),(131,55,7),(132,75,7),(133,50,7),(134,54,4),(135,12,7),(136,80,2),(137,5,4),(138,26,1),(139,20,5),(140,35,7),(141,41,1),(142,51,4),(143,65,4),(144,4,8),(145,48,4),(146,31,6),(147,10,5),(148,94,2),(149,32,2),(150,11,6),(151,4,7),(152,79,6),(153,17,5),(154,71,1),(155,73,4),(156,53,2),(157,33,8),(158,9,5),(159,54,6),(160,36,6),(161,1,3),(162,91,8),(163,87,1),(164,29,4),(165,3,5),(166,16,5),(167,74,5),(168,89,6),(169,41,3),(170,93,2),(171,88,2),(172,41,8),(173,75,8),(174,100,2),(175,7,1),(176,80,5),(177,45,6),(178,14,4),(179,21,8),(180,29,8),(181,35,4),(182,47,4),(183,44,7),(184,81,7),(185,52,7),(186,61,8),(187,95,7),(188,41,2),(189,75,4),(190,6,2),(191,70,5),(192,41,5),(193,68,6),(194,58,5),(195,69,2),(196,38,3),(197,88,3),(198,8,1),(199,56,1),(200,68,7);
INSERT INTO ConsultaProcedimiento (idConsultaProcedimiento,idConsulta,idProcedimiento) VALUES (201,98,4),(202,8,4),(203,36,2),(204,9,2),(205,88,5),(206,44,4),(207,26,1),(208,32,4),(209,92,8),(210,9,8),(211,94,3),(212,81,6),(213,91,2),(214,16,3),(215,63,6),(216,96,7),(217,4,3),(218,26,5),(219,100,7),(220,7,6),(221,57,3),(222,8,8),(223,81,3),(224,61,1),(225,69,1),(226,7,1),(227,83,2),(228,36,1),(229,12,1),(230,44,8),(231,22,5),(232,15,1),(233,86,7),(234,42,3),(235,12,4),(236,9,2),(237,50,3),(238,16,8),(239,15,5),(240,44,3),(241,70,5),(242,90,7),(243,39,4),(244,6,5),(245,60,1),(246,30,5),(247,55,4),(248,81,1),(249,35,4),(250,11,8),(251,7,2),(252,56,6),(253,34,7),(254,75,4),(255,81,7),(256,16,3),(257,56,3),(258,92,8),(259,29,8),(260,95,3),(261,12,6),(262,69,8),(263,89,8),(264,40,8),(265,35,7),(266,14,6),(267,80,2),(268,43,4),(269,99,8),(270,83,6),(271,77,8),(272,43,1),(273,58,8),(274,60,3),(275,96,2),(276,69,8),(277,62,1),(278,92,2),(279,84,4),(280,35,6),(281,8,1),(282,33,2),(283,84,6),(284,55,3),(285,32,7),(286,36,5),(287,90,3),(288,28,4),(289,31,3),(290,52,2),(291,83,3),(292,44,4),(293,3,1),(294,50,4),(295,51,8),(296,54,3),(297,49,7),(298,25,6),(299,58,5),(300,64,6);

INSERT INTO CantidadConsultas (idCantidadConsulta,idConsulta,idTratamiento) VALUES (1,84,26),(2,42,18),(3,88,74),(4,82,78),(5,87,33),(6,40,1),(7,57,87),(8,89,82),(9,59,34),(10,87,48),(11,67,14),(12,36,77),(13,73,6),(14,34,46),(15,3,55),(16,49,33),(17,40,77),(18,72,55),(19,86,87),(20,4,72),(21,94,13),(22,93,74),(23,84,90),(24,73,52),(25,96,58),(26,40,40),(27,37,27),(28,100,71),(29,29,78),(30,65,91),(31,53,2),(32,86,92),(33,80,52),(34,59,84),(35,70,28),(36,36,98),(37,81,83),(38,35,16),(39,10,8),(40,46,67),(41,94,42),(42,45,11),(43,56,82),(44,6,88),(45,51,41),(46,81,11),(47,10,18),(48,76,26),(49,61,93),(50,11,8),(51,32,5),(52,1,26),(53,82,38),(54,47,43),(55,50,16),(56,95,69),(57,11,82),(58,85,14),(59,22,59),(60,41,78),(61,63,5),(62,19,17),(63,35,95),(64,13,42),(65,49,35),(66,77,50),(67,83,39),(68,6,93),(69,88,7),(70,38,41),(71,94,27),(72,93,9),(73,54,34),(74,26,42),(75,33,87),(76,93,39),(77,49,47),(78,39,2),(79,72,28),(80,84,7),(81,12,59),(82,67,67),(83,79,17),(84,52,86),(85,44,16),(86,31,22),(87,62,31),(88,50,84),(89,18,10),(90,38,54),(91,74,42),(92,36,77),(93,87,35),(94,63,35),(95,97,32),(96,65,83),(97,33,39),(98,15,18),(99,97,74),(100,61,4);
INSERT INTO CantidadConsultas (idCantidadConsulta,idConsulta,idTratamiento) VALUES (101,78,97),(102,66,100),(103,15,73),(104,12,93),(105,54,66),(106,31,69),(107,72,55),(108,33,54),(109,75,96),(110,30,22),(111,29,90),(112,14,11),(113,21,62),(114,68,71),(115,81,100),(116,46,87),(117,9,91),(118,52,47),(119,25,40),(120,54,90),(121,20,6),(122,10,38),(123,42,10),(124,52,3),(125,17,20),(126,4,59),(127,62,39),(128,17,40),(129,61,13),(130,82,31),(131,58,5),(132,26,45),(133,44,18),(134,76,14),(135,73,93),(136,55,36),(137,23,94),(138,54,75),(139,6,19),(140,67,32),(141,87,72),(142,88,19),(143,1,94),(144,23,75),(145,98,46),(146,22,89),(147,69,74),(148,6,57),(149,72,87),(150,35,83),(151,43,1),(152,76,90),(153,90,24),(154,49,72),(155,11,18),(156,54,17),(157,45,55),(158,74,37),(159,10,53),(160,79,19),(161,76,23),(162,24,45),(163,90,87),(164,1,50),(165,30,23),(166,32,60),(167,84,99),(168,4,86),(169,31,84),(170,60,84),(171,47,73),(172,39,68),(173,79,10),(174,75,98),(175,33,78),(176,57,74),(177,96,40),(178,38,98),(179,43,43),(180,88,47),(181,44,76),(182,49,41),(183,70,41),(184,65,98),(185,14,61),(186,16,52),(187,33,100),(188,69,63),(189,58,53),(190,50,51),(191,92,91),(192,73,36),(193,68,49),(194,81,19),(195,67,24),(196,94,97),(197,78,51),(198,97,41),(199,14,94);
INSERT INTO CantidadConsultas (idCantidadConsulta,idConsulta,idTratamiento) VALUES (200,25,31),(201,94,56),(202,14,55),(203,59,51),(204,4,88),(205,92,36),(206,51,1),(207,40,35),(208,50,20),(209,35,46),(210,76,68),(211,63,75),(212,85,72),(213,59,86),(214,61,39),(215,53,73),(216,11,42),(217,2,24),(218,88,40),(219,9,27),(220,32,36),(221,32,73),(222,66,37),(223,45,6),(224,15,38),(225,84,26),(226,38,22),(227,87,80),(228,74,19),(229,54,86),(230,43,11),(231,12,17),(232,87,24),(233,71,59),(234,88,4),(235,81,44),(236,28,44),(237,18,34),(238,72,4),(239,3,38),(240,49,71),(241,86,67),(242,24,86),(243,90,38),(244,100,70),(245,57,19),(246,12,78),(247,43,23),(248,25,2),(249,21,54),(250,8,61),(251,35,80),(252,15,74),(253,49,43),(254,89,94),(255,63,71),(256,32,30),(257,25,91),(258,78,16),(259,98,35),(260,97,46),(261,5,88),(262,85,70),(263,43,100),(264,77,97),(265,15,26),(266,66,41),(267,18,93),(268,34,71),(269,89,9),(270,62,69),(271,15,74),(272,39,91),(273,30,8),(274,17,83),(275,58,14),(276,55,76),(277,92,33),(278,91,59),(279,100,76),(280,14,9),(281,83,18),(282,7,89),(283,53,75),(284,11,89),(285,61,32),(286,53,95),(287,90,98),(288,53,21),(289,78,82),(290,3,33),(291,88,15),(292,7,79),(293,55,7),(294,14,65),(295,72,47),(296,69,38),(297,70,26),(298,86,60),(299,30,85);


insert into TipoPago 
values 
(1,'Al Credito'),
(2,'A Plazos');

insert into EstadoPago
values
(1,'En Proceso'),
(2,'Finalizado'),
(3,'Suspendido');


INSERT INTO Pagos (idPago,pagoDebe,pagoAbono,pagoTotal,pagoSaldo,idTratamiento,idTipoPago,idEstadoPago) VALUES (1,'0.00','0.00','0.00','0.00',1,1,1),(2,'0.00','0.00','0.00','0.00',2,1,1),(3,'0.00','0.00','0.00','0.00',3,1,1),(4,'0.00','0.00','0.00','0.00',4,2,1),(5,'0.00','0.00','0.00','0.00',5,1,1),(6,'0.00','0.00','0.00','0.00',6,2,1),(7,'0.00','0.00','0.00','0.00',7,2,1),(8,'0.00','0.00','0.00','0.00',8,2,1),(9,'0.00','0.00','0.00','0.00',9,2,1),(10,'0.00','0.00','0.00','0.00',10,2,1),(11,'0.00','0.00','0.00','0.00',11,2,1),(12,'0.00','0.00','0.00','0.00',12,1,1),(13,'0.00','0.00','0.00','0.00',13,2,1),(14,'0.00','0.00','0.00','0.00',14,1,1),(15,'0.00','0.00','0.00','0.00',15,2,1),(16,'0.00','0.00','0.00','0.00',16,1,1),(17,'0.00','0.00','0.00','0.00',17,2,1),(18,'0.00','0.00','0.00','0.00',18,2,1),(19,'0.00','0.00','0.00','0.00',19,1,1),(20,'0.00','0.00','0.00','0.00',20,2,1),(21,'0.00','0.00','0.00','0.00',21,1,1),(22,'0.00','0.00','0.00','0.00',22,2,1),(23,'0.00','0.00','0.00','0.00',23,2,1),(24,'0.00','0.00','0.00','0.00',24,2,1),(25,'0.00','0.00','0.00','0.00',25,2,1),(26,'0.00','0.00','0.00','0.00',26,2,1),(27,'0.00','0.00','0.00','0.00',27,1,1),(28,'0.00','0.00','0.00','0.00',28,2,1),(29,'0.00','0.00','0.00','0.00',29,1,1),(30,'0.00','0.00','0.00','0.00',30,1,1),(31,'0.00','0.00','0.00','0.00',31,1,1),(32,'0.00','0.00','0.00','0.00',32,2,1),(33,'0.00','0.00','0.00','0.00',33,1,1),(34,'0.00','0.00','0.00','0.00',34,2,1),(35,'0.00','0.00','0.00','0.00',35,2,1),(36,'0.00','0.00','0.00','0.00',36,2,1),(37,'0.00','0.00','0.00','0.00',37,2,1),(38,'0.00','0.00','0.00','0.00',38,1,1),(39,'0.00','0.00','0.00','0.00',39,1,1),(40,'0.00','0.00','0.00','0.00',40,2,1),(41,'0.00','0.00','0.00','0.00',41,1,1),(42,'0.00','0.00','0.00','0.00',42,1,1),(43,'0.00','0.00','0.00','0.00',43,2,1),(44,'0.00','0.00','0.00','0.00',44,1,1),(45,'0.00','0.00','0.00','0.00',45,2,1),(46,'0.00','0.00','0.00','0.00',46,1,1),(47,'0.00','0.00','0.00','0.00',47,1,1),(48,'0.00','0.00','0.00','0.00',48,1,1),(49,'0.00','0.00','0.00','0.00',49,1,1),(50,'0.00','0.00','0.00','0.00',50,2,1),(51,'0.00','0.00','0.00','0.00',51,1,1),(52,'0.00','0.00','0.00','0.00',52,1,1),(53,'0.00','0.00','0.00','0.00',53,1,1),(54,'0.00','0.00','0.00','0.00',54,2,1),(55,'0.00','0.00','0.00','0.00',55,1,1),(56,'0.00','0.00','0.00','0.00',56,2,1),(57,'0.00','0.00','0.00','0.00',57,2,1),(58,'0.00','0.00','0.00','0.00',58,2,1),(59,'0.00','0.00','0.00','0.00',59,1,1),(60,'0.00','0.00','0.00','0.00',60,2,1),(61,'0.00','0.00','0.00','0.00',61,2,1),(62,'0.00','0.00','0.00','0.00',62,2,1),(63,'0.00','0.00','0.00','0.00',63,1,1),(64,'0.00','0.00','0.00','0.00',64,2,1),(65,'0.00','0.00','0.00','0.00',65,1,1),(66,'0.00','0.00','0.00','0.00',66,2,1),(67,'0.00','0.00','0.00','0.00',67,1,1),(68,'0.00','0.00','0.00','0.00',68,2,1),(69,'0.00','0.00','0.00','0.00',69,2,1),(70,'0.00','0.00','0.00','0.00',70,1,1),(71,'0.00','0.00','0.00','0.00',71,2,1),(72,'0.00','0.00','0.00','0.00',72,1,1),(73,'0.00','0.00','0.00','0.00',73,2,1),(74,'0.00','0.00','0.00','0.00',74,2,1),(75,'0.00','0.00','0.00','0.00',75,1,1),(76,'0.00','0.00','0.00','0.00',76,1,1),(77,'0.00','0.00','0.00','0.00',77,1,1),(78,'0.00','0.00','0.00','0.00',78,2,1),(79,'0.00','0.00','0.00','0.00',79,2,1),(80,'0.00','0.00','0.00','0.00',80,2,1),(81,'0.00','0.00','0.00','0.00',81,1,1),(82,'0.00','0.00','0.00','0.00',82,2,1),(83,'0.00','0.00','0.00','0.00',83,1,1),(84,'0.00','0.00','0.00','0.00',84,1,1),(85,'0.00','0.00','0.00','0.00',85,1,1),(86,'0.00','0.00','0.00','0.00',86,2,1),(87,'0.00','0.00','0.00','0.00',87,1,1),(88,'0.00','0.00','0.00','0.00',88,2,1),(89,'0.00','0.00','0.00','0.00',89,1,1),(90,'0.00','0.00','0.00','0.00',90,1,1),(91,'0.00','0.00','0.00','0.00',91,2,1),(92,'0.00','0.00','0.00','0.00',92,2,1),(93,'0.00','0.00','0.00','0.00',93,1,1),(94,'0.00','0.00','0.00','0.00',94,2,1),(95,'0.00','0.00','0.00','0.00',95,2,1),(96,'0.00','0.00','0.00','0.00',96,1,1),(97,'0.00','0.00','0.00','0.00',97,2,1),(98,'0.00','0.00','0.00','0.00',98,2,1),(99,'0.00','0.00','0.00','0.00',99,1,1),(100,'0.00','0.00','0.00','0.00',100,1,1);

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