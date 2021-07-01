<?php 

class Consultas extends Validator{

private $id = null;
private $notasconsulta = null;
private $costoconsulta = null;
private $fechaconsulta = null;
private $horaconsulta = null;
private $causa = null;
private $idprocedimiento = null;


    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setNotas($value)
    {
        if ($this->validateString($value, 1, 550)) {
            $this->notasconsulta = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setCosto($value)
    {
        if ($this->validateMoney($value)) {
            $this->costoconsulta = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setFecha($value)
    {
        if ($this->validateDate($value)) {
            $this->fechaconsulta = $value;
            return true;
        } else {
            return false;
        }
    }
    
    public function setHora($value)
    {
        if ($this->validateString($value, 1, 550)) {
            $this->horaconsulta = $value;
            return true;
        } else {
            return false;
        }       
    }

    public function setCausa($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->causa = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setProcedimiento($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->idprocedimiento = $value;
            return true;
        } else {
            return false;
        }
    }

    public function getId()
    {
        return $this->id;
    }

    public function getNotas()
    {
        return $this->notasconsulta;
    }

    public function getCosto()
    {
        return $this->costoconsulta;
    }

    public function getFecha()
    {
        return $this->fechaconsulta;
    }

    public function getHora()
    {
        return $this->horaconsulta;
    }

    public function getCausa()
    {
        return $this->causa;
    }

    public function getProcedimiento()
    {
        return $this->idprocedimiento;
    }


    public function readAll()
    {
        $sql = 'SELECT idconsulta, notasconsulta, costoconsulta, fechaconsulta ,horaconsulta, idcausaconsulta, causa
                FROM consultas 
                INNER JOIN causaconsulta USING(idcausaconsulta)                                                              
                ORDER BY horaconsulta DESC'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function searchRows($value)
    {
        $sql = 'SELECT idconsulta, notasconsulta, costoconsulta, fechaconsulta, horaconsulta, idcausaconsulta, causa
                FROM consultas 
                INNER JOIN causaconsulta USING(idcausaconsulta) 
                WHERE notasconsulta ILIKE ?';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO consultas(notasconsulta, costoconsulta, fechaconsulta, horaconsulta, idcausaconsulta)
                VALUES (?, ?, ?, ?, ?);';
        $params = array($this->notasconsulta,$this->costoconsulta,$this->fechaconsulta,$this->horaconsulta,$this->causa);
        return Database::executeRow($sql, $params);
    }

    public function readAllCAUSA()
    {
        $sql = 'SELECT idcausaconsulta, causa
                FROM causaconsulta'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idconsulta, notasconsulta, costoconsulta, fechaconsulta ,horaconsulta, idcausaconsulta, causa
                FROM consultas 
                INNER JOIN causaconsulta USING(idcausaconsulta)
                WHERE idconsulta = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {        
        $sql = 'UPDATE consultas 
                SET notasconsulta = ?, costoconsulta = ?,  fechaconsulta= ? ,horaconsulta=? ,  idcausaconsulta = ? 
                WHERE  idconsulta = ?';
        $params = array($this->notasconsulta, $this->costoconsulta,$this->fechaconsulta, $this->horaconsulta ,$this->causa, $this->id);
        return Database::executeRow($sql, $params);
    }  

    public function deleteRow()
    {
        $sql = 'DELETE FROM consultas
                WHERE idconsulta = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readOneProcedure()
    {
        $sql = 'SELECT idconsulta, idprocedimiento, idconsultaprocedimiento ,notasconsulta, nombreprocedimiento, descripcionprocedimiento
                FROM consultaprocedimiento
                INNER JOIN procedimientos USING(idprocedimiento)
                INNER JOIN consultas USING(idconsulta)
                WHERE idconsulta = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function searchOneProcedure($value)
    {
        $sql = 'SELECT idconsulta, idprocedimiento, idconsultaprocedimiento, notasconsulta ,horaconsulta, nombreprocedimiento, descripcionprocedimiento
                FROM consultaprocedimiento
                INNER JOIN procedimientos USING(idprocedimiento)
                INNER JOIN consultas USING(idconsulta)
                WHERE notasconsulta ILIKE ?';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }
    
    public function readAllProcedure()
    {
        $sql = 'SELECT idconsulta, idprocedimiento, idconsultaprocedimiento, notasconsulta ,horaconsulta, nombreprocedimiento, descripcionprocedimiento
                FROM consultaprocedimiento
                INNER JOIN procedimientos USING(idprocedimiento)
                INNER JOIN consultas USING(idconsulta)';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOneProcedure1()
    {
        $sql = 'SELECT idconsulta, idprocedimiento, idconsultaprocedimiento, notasconsulta ,horaconsulta, nombreprocedimiento, descripcionprocedimiento
                FROM consultaprocedimiento
                INNER JOIN procedimientos USING(idprocedimiento)
                INNER JOIN consultas USING(idconsulta)
                WHERE idconsultaprocedimiento = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readAllPROCEDIMIENTO()
    {
        $sql = 'SELECT idprocedimiento, nombreprocedimiento
                FROM procedimientos'; 
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function updateRowprocedure()
    {        
        $sql = 'UPDATE consultaprocedimiento SET idprocedimiento = ? WHERE idconsultaprocedimiento = ?';
        $params = array( $this->idprocedimiento, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function createRowprocedure()
    {
        $sql = 'INSERT INTO consultaprocedimiento(idconsulta, idprocedimiento) 
                VALUES (?,?)';
        $params = array($this->id, $this->idprocedimiento);
        return Database::executeRow($sql, $params);
    }
}