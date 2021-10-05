<?php 

class Pacientes extends Validator{

    private $id = null;
    private $nombre = null;
    private $apellido = null;
    private $fecha = null;
    private $dui = null;
    private $direccion=null;
    private $telefono = null;
    private $correo = null;
    private $foto = null;
    private $estado = null;
    private $imagen = null;
    private $ruta = '../../../resources/img/productos/';    
    private $iddoctor = null;
    private $r1 = null;
    private $p1 = null;
    private $r2 = null;
    private $p2 = null;
    private $r3 = null;
    private $p3 = null;
    private $r4 = null;
    private $p4 = null;
    private $r5 = null;
    private $p5 = null;
    private $r6 = null;
    private $p6 = null;
    private $r7 = null;
    private $p7 = null;
    private $r8 = null;
    private $p8 = null;
    private $respuesta =null;

    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setNombre($value)
    {
        if ($this->validateAlphanumeric($value, 1, 50)) {
            $this->nombre = $value;
            return true;
        } else {
            return false;
        }
    }


    public function setApellido($value)
    {
        if ($this->validateAlphanumeric($value, 1, 50)) {
            $this->apellido = $value;
            return true;
        } else {
            return false;
        }
    }


    public function setFecha($value)
    {
        if ($this->validateDate($value)) {
            $this->fecha = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDireccion($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->direccion = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDUI($value)
    {
        if ($this->validateDUI($value)) {
            $this->dui = $value;
            return true;
        } else {
            return false;
        }
    }   

    public function setTelefono($value)
    {
        if ($this->validatePhone($value)) {
            $this->telefono = $value;
            return true;
        } else {
            return false;
        }
    }
   
    public function setCorreo($value)
    {
        if ($this->validateEmail($value)) {
            $this->correo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setImagen($file)
    {
        if ($this->validateImageFile($file, 500, 500)) {
            $this->imagen = $this->getImageName();
            return true;
        } else {
            return false;
        }
    }
   

    public function setEstado($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->estado = $value;
            return true;
        } else {
            return false;
        }
    }


    public function setidDoctor($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->iddoctor = $value;
            return true;
        } else {
            return false;
        }
    }


    public function setRespuesta($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->respuesta = $value;
            return true;
        } else {
            return false;
        }
    }

 // -----------------------------------------------------------------------------------------

    public function setP1($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p1 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP2($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p2 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP3($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p3 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP4($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p4 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP5($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p5 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP6($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p6 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setP7($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p7 = $value;
            return true;
        } else {
            return false;
        }
    }
    
    public function setP8($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->p8 = $value;
            return true;
        } else {
            return false;
        }
    }



// -----------------------------------------------------------------

    public function setR1($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r1 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR2($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r2 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR3($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r3 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR4($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r4 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR5($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r5 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR6($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r6 = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setR7($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r7 = $value;
            return true;
        } else {
            return false;
        }
    }
    
    public function setR8($value)
    {
        if ($this->validateString($value, 1, 50)) {
            $this->r8 = $value;
            return true;
        } else {
            return false;
        }
    }


  // Llamados de get para concatenar con el backend  
   
    public function getId()
    {
        return $this->id;
    }

    public function getNombre()
    {
        return $this->nombre;
    }

    public function getApellido()
    {
        return $this->apellido;
    }

    public function getFecha()
    {
        return $this->fecha;
    }

    public function getDUI()
    {
        return $this->dui;
    }

    public function getDireccion()
    {
        return $this ->direccion;
    }

    public function getTelefono()
    {
        return $this ->telefono;
    }

    public function getCorreo()
    {
        return $this ->correo;
    }

    public function getImagen()
    {
        return $this->imagen;
    }

    public function getRuta()
    {
        return $this->ruta;
    }


    public function getEstado()
    {
        return $this ->estado;
    }

    public function getRespuesta()
    {
        return $this ->respuesta;
    }

    public function getIdDoctor()
    {
        return $this ->iddoctor;
    }

    //-------------------------------------

    public function getP1()
    {
        return $this ->p1;
    }

    public function getP2()
    {
        return $this ->p2;
    }

    public function getP3()
    {
        return $this ->p3;
    }

    public function getP4()
    {
        return $this ->p4;
    }

    public function getP5()
    {
        return $this ->p5;
    }

    public function getP6()
    {
        return $this ->p6;
    }

    public function getP7()
    {
        return $this ->p7;
    }

    public function getP8()
    {
        return $this ->p8;
    }


    // ---------------------------

    public function getR1()
    {
        return $this ->r1;
    }

    public function getR2()
    {
        return $this ->r2;
    }

    public function getR3()
    {
        return $this ->r3;
    }

    public function getR4()
    {
        return $this ->r4;
    }

    public function getR5()
    {
        return $this ->r5;
    }

    public function getR6()
    {
        return $this ->r6;
    }

    public function getR7()
    {
        return $this ->r7;
    }

    public function getR8()
    {
        return $this ->r8;
    }

    /// ---------------------------------------------------------------------------------------

    public function searchRows($value)
    {
        $sql = 'SELECT idpaciente, nombrepaciente, apellidopaciente, fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente, estadopaciente
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                WHERE nombrepaciente ILIKE ? OR apellidopaciente ILIKE ? OR duipaciente ILIKE ?';
        $params = array("%$value%", "%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO pacientes(nombrepaciente, apellidopaciente, fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombre,$this->apellido,$this->fecha,$this->dui,$this->direccion,$this->telefono,$this->correo,$this->imagen,$this->estado);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = "SELECT idpaciente, nombrepaciente , apellidopaciente , fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente, estadopaciente
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                ORDER BY nombrepaciente"; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllESTADO()
    {
        $sql = 'SELECT idestadopaciente, estadopaciente
                FROM estadopaciente'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllDOCTOR()
    {
        $sql = "SELECT iddoctor, nombredoctor ||' '|| apellidodoctor As NombreDoctor
                FROM doctores
                INNER JOIN estadodoctor USING (idestadodoctor)
                WHERE idestadodoctor=1"; 
        $params = null;
        return Database::getRows($sql, $params);
    }
    
    public function readAllDOCTORI()
    {
        $sql = "SELECT iddoctor, nombredoctor ||' '|| apellidodoctor As NombreDoctor
                FROM doctores
                INNER JOIN estadodoctor USING (idestadodoctor)
                WHERE idestadodoctor=1"; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idpaciente, nombrepaciente, apellidopaciente, fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente, estadopaciente
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                WHERE idpaciente = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readOneDUI()
    {
        $sql = 'SELECT idpaciente, nombrepaciente, apellidopaciente, fechanacimiento, duipaciente, direccionpaciente, telefonopaciente, correopaciente, fotopaciente, idestadopaciente, estadopaciente
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                WHERE duipaciente != ?';
        $params = array($this->dui);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {        
        $sql = 'UPDATE pacientes
                SET    nombrepaciente = ?, apellidopaciente = ?, fechanacimiento=?, duipaciente=?, direccionpaciente=?, telefonopaciente=?, correopaciente=?, idestadopaciente=?
                WHERE  idpaciente = ?';
        $params = array($this->nombre, $this->apellido, $this->fecha, $this->dui, $this->direccion, $this->telefono, $this->correo, $this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }  

    public function deleteRow()
    {
        $sql = 'DELETE FROM pacientes
                WHERE idpaciente = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    //-------------------------------
    public function readOneDoctor()
    {
        $sql = 'SELECT idpaciente, idpacienteasignado, nombrepaciente, nombredoctor, apellidodoctor , duipaciente
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                INNER JOIN pacienteasignado USING (idpaciente)
                INNER JOIN doctores USING (iddoctor)
                WHERE idpaciente = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }
    //-------------------------

    public function searchOneDoctor($value)
    {
        $sql = 'SELECT idpaciente, idpacienteasignado, nombrepaciente, nombredoctor, apellidodoctor, duipaciente 
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                INNER JOIN pacienteasignado USING (idpaciente)
                INNER JOIN doctores USING (iddoctor)
                WHERE  duipaciente ILIKE ?';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }
    
    public function readAllAsignado()
    {
        $sql = 'SELECT idpacienteasignado, idpaciente, iddoctor, nombrepaciente, nombredoctor
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                INNER JOIN PacienteAsignado USING (idpaciente)
                INNER JOIN doctores USING (iddoctor)';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOneAsignado1()
    {
        $sql = 'SELECT idpacienteasignado, idpaciente, iddoctor, nombrepaciente, nombredoctor
                FROM pacientes
                INNER JOIN estadopaciente USING (idestadopaciente)
                INNER JOIN PacienteAsignado USING (idpaciente)
                INNER JOIN doctores USING (iddoctor)
                WHERE idpacienteasignado = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }


    public function updateRowassignement()
    {        
        $sql = 'UPDATE pacienteasignado SET iddoctor = ? WHERE idpacienteasignado = ?';
        $params = array( $this->iddoctor, $this -> id);
        return Database::executeRow($sql, $params);
    }

    public function createRowassignement()
    {
        $sql = 'INSERT INTO pacienteasignado(idpaciente, iddoctor)
                VALUES (?,?)';
        $params = array($this -> id, $this ->iddoctor);
        return Database::executeRow($sql, $params);
    }

    public function readAllP1()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 1'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP2()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 2'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP3()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 3'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP4()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 4'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP5()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 5'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP6()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 6'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP7()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 7'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllP8()
    {
        $sql = 'SELECT idpregunta, pregunta FROM Preguntas WHERE idpregunta = 8'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function createRowRespuesta()
    {
        $sql = 'INSERT INTO respuestas(respuesta1, idpregunta1, respuesta2, idpregunta2, respuesta3, idpregunta3, respuesta4, idpregunta4, respuesta5, idpregunta5, respuesta6, idpregunta6, respuesta7, idpregunta7, respuesta8, idpregunta8, pacientemedicamento, idpaciente)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);';
        $params = array($this->r1,$this->p1,$this->r2,$this->p2,$this->r3,$this->p3,$this->r4,$this->p4,$this->r5,$this->p5,$this->r6,$this->p6,$this->r7,$this->p7,$this->r8,$this->p8,$this->respuesta,$this->id);
        return Database::executeRow($sql, $params);
    }

    public function readExpedientes()
    {
        $sql = "SELECT ah.idarchivo, ex.idexpediente, aa.idpacienteasignado ,nombrepaciente ||' '|| apellidopaciente as nombrepaciente, notas, 
                        		observacionesperiodontograma, odontograma, periodontograma, nombredoctor ||' '|| apellidodoctor as nombredoctor
                From pacientes pc
                inner join expedientes ex on ex.idpaciente = pc.idpaciente
                inner join archivos ah on ah.idexpediente = ex.idexpediente
                inner join pacienteasignado aa on aa.idpaciente = pc.idpaciente
                inner join doctores dr on dr.iddoctor = aa.iddoctor
                Where pc.idpaciente= ?";
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readPacientesTipos()
    {
        $sql = "SELECT count(idtratamiento) as cantidad , tipotratamiento, idpaciente
                from pacientes 
                inner join pacienteasignado using(idpaciente)
                inner join tratamientos using(idpacienteasignado)
                inner join tipotratamiento using(idtipotratamiento)
                where idpaciente = ?
                group by tipotratamiento, idpaciente
                order by idpaciente";
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readPaciente()
    {
        $sql = "SELECT idpaciente, CONCAT(nombrepaciente,' ',apellidopaciente) as paciente from pacientes";
        $params = null;
        return Database::getRows($sql, $params);
    }

    
    public function readConsultas()
    {
        $sql = " SELECT CONCAT(p.nombrepaciente,' ', p.apellidopaciente) as paciente, CONCAT(d.nombredoctor,' ',d.apellidodoctor) as doctor,
        t.fechainicio, pa.idpacienteasignado, t.descripciontratamiento,cc.causa, ct.idcantidadconsulta, c.idconsulta, c.fechaconsulta,
        c.costoconsulta, c.notasconsulta, c.horaconsulta
        from pacienteasignado pa, tratamientos t, pacientes p, doctores d,cantidadconsultas ct, consultas c, causaconsulta cc
        where pa.idpaciente=p.idpaciente and pa.iddoctor=pa.iddoctor and t.idpacienteasignado=pa.idpacienteasignado
        and ct.idconsulta=c.idconsulta and ct.idtratamiento=t.idtratamiento and c.idcausaconsulta=cc.idcausaconsulta
        and p.idpaciente=?";
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readOneQuestion()
    {
        $sql = 'SELECT idrespuesta,pr1.pregunta as pregunta1, respuesta1, 
                        pr2.pregunta as pregunta2, respuesta2, 
                        pr3.pregunta as pregunta3, respuesta3, 
                        pr4.pregunta as pregunta4,respuesta4, 
                        pr5.pregunta as pregunta5,respuesta5, 
                        pr6.pregunta as pregunta6,respuesta6, 
                        pr7.pregunta as pregunta7,respuesta7, 
                        pr8.pregunta as pregunta8,respuesta8,
                        pacientemedicamento,idpaciente,duipaciente
                        from pacientes pt
                Inner join respuestas rp using(idpaciente)
                Inner join preguntas pr1 on pr1.idpregunta = rp.idpregunta1
                Inner join preguntas pr2 on pr2.idpregunta = rp.idpregunta2
                Inner join preguntas pr3 on pr3.idpregunta = rp.idpregunta3
                Inner join preguntas pr4 on pr4.idpregunta = rp.idpregunta4
                Inner join preguntas pr5 on pr5.idpregunta = rp.idpregunta5
                Inner join preguntas pr6 on pr6.idpregunta = rp.idpregunta6
                Inner join preguntas pr7 on pr7.idpregunta = rp.idpregunta7
                Inner join preguntas pr8 on pr8.idpregunta = rp.idpregunta8
                Where pt.idpaciente = ? Order by idrespuesta ASC';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readOneQuestion1()
    {
        $sql = 'SELECT  rp.idrespuesta,
                        pr1.pregunta as pregunta1, respuesta1, 
                        pr2.pregunta as pregunta2, respuesta2, 
                        pr3.pregunta as pregunta3, respuesta3, 
                        pr4.pregunta as pregunta4,respuesta4, 
                        pr5.pregunta as pregunta5,respuesta5, 
                        pr6.pregunta as pregunta6,respuesta6, 
                        pr7.pregunta as pregunta7,respuesta7, 
                        pr8.pregunta as pregunta8,respuesta8,
                        pacientemedicamento,idpaciente,duipaciente
                    from pacientes pt
                    Inner join respuestas rp using(idpaciente)
                    Inner join preguntas pr1 on pr1.idpregunta = rp.idpregunta1
                    Inner join preguntas pr2 on pr2.idpregunta = rp.idpregunta2
                    Inner join preguntas pr3 on pr3.idpregunta = rp.idpregunta3
                    Inner join preguntas pr4 on pr4.idpregunta = rp.idpregunta4
                    Inner join preguntas pr5 on pr5.idpregunta = rp.idpregunta5
                    Inner join preguntas pr6 on pr6.idpregunta = rp.idpregunta6
                    Inner join preguntas pr7 on pr7.idpregunta = rp.idpregunta7
                    Inner join preguntas pr8 on pr8.idpregunta = rp.idpregunta8
                    Where rp.idrespuesta = ? Order by idrespuesta ASC';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function searchOneQuestion($value)
    {
        $sql = 'SELECT idrespuesta,pr1.pregunta as pregunta1, respuesta1, 
                       pr2.pregunta as pregunta2, respuesta2, 
                       pr3.pregunta as pregunta3, respuesta3, 
                       pr4.pregunta as pregunta4,respuesta4, 
                       pr5.pregunta as pregunta5,respuesta5, 
                       pr6.pregunta as pregunta6,respuesta6, 
                       pr7.pregunta as pregunta7,respuesta7, 
                       pr8.pregunta as pregunta8,respuesta8,
                       pacientemedicamento,idpaciente,duipaciente	   
                from pacientes pt
                Inner join respuestas rp using(idpaciente)
                Inner join preguntas pr1 on pr1.idpregunta = rp.idpregunta1
                Inner join preguntas pr2 on pr2.idpregunta = rp.idpregunta2
                Inner join preguntas pr3 on pr3.idpregunta = rp.idpregunta3
                Inner join preguntas pr4 on pr4.idpregunta = rp.idpregunta4
                Inner join preguntas pr5 on pr5.idpregunta = rp.idpregunta5
                Inner join preguntas pr6 on pr6.idpregunta = rp.idpregunta6
                Inner join preguntas pr7 on pr7.idpregunta = rp.idpregunta7
                Inner join preguntas pr8 on pr8.idpregunta = rp.idpregunta8
                Where pt.duipaciente ILIKE ? Order by idrespuesta ASC';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }

    public function updateRowRespuesta()
    {
        $sql = 'UPDATE respuestas set pacientemedicamento = ? Where idrespuesta = ?';
        $params = array($this->respuesta,$this->id);
        return Database::executeRow($sql, $params);
    }
}