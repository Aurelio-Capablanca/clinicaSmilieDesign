<?php

class Productos extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $inicio = null;
    private $descripcion = null;
    private $estado = null;
    private $tipo = null;
    private $asignado = null;


    //METODOS PARA ASIGNAR EL VALOR A LOS ATRIBUTOS
    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setInicio($value)
    {
        if ($this->validateDate($value)) {
            $this->inicio = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDescripcion($value)
    {
        if ($this->validateString($value, 1, 100)) {
            $this->descripcion = $value;
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

    public function setTipo($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->tipo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setAsignado($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->asignado = $value;
            return true;
        } else {
            return false;
        }
    }

    // METODOS GET PARA OBTENER EL VALOR DE LAS VARIABLES 
    public function getId()
    {
        return $this->id;
    }

    public function getInicio()
    {
        return $this->inicio;
    }

    public function getDescripcion()
    {
        return $this->descripcion;
    }

    public function getEstado()
    {
        return $this->estado;
    }

    public function getTipo()
    {
        return $this->tipo;
    }

    public function getAsignado()
    {
        return $this->asignado;
    }

    // METODOS PARA REALIZAR LAS OPERACIONES SCRUD 

    public function searchRows($value)
    {
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, p.nombrepaciente,p.apellidopaciente, p.duipaciente,ti.tipotratamiento, es.estadotratamiento
        FROM tratamientos t
        INNER JOIN pacientes p ON t.idpacienteasignado = p.idpaciente
        INNER JOIN tipotratamiento ti ON ti.idtipotratamiento = t.idtipotratamiento
        INNER JOIN estadotratamiento es ON es.idestadotratamiento = t.idestadotratamiento
        WHERE p.nombrepaciente ILIKE ? OR p.apellidopaciente ILIKE ? OR p.duipaciente ILIKE ?
        ORDER BY fechainicio';
        $params = array("%$value%", "%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tratamientos(
             fechainicio, descripciontratamiento, idpacienteasignado, idtipotratamiento, idestadotratamiento)
            VALUES ( ?, ?, ?, ?, ?);';
        $params = array($this->inicio, $this->descripcion, $this->asignado , $this->tipo , $this->estado);
        return Database::executeRow($sql, $params);
    }

    public function readRows()
    {
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, p.nombrepaciente,p.apellidopaciente, p.duipaciente,ti.tipotratamiento, es.estadotratamiento
        FROM tratamientos t
        INNER JOIN pacientes p ON t.idpacienteasignado = p.idpaciente
        INNER JOIN tipotratamiento ti ON ti.idtipotratamiento = t.idtipotratamiento
        INNER JOIN estadotratamiento es ON es.idestadotratamiento = t.idestadotratamiento
        order by fechainicio';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readRow()
    {
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, p.duipaciente,ti.tipotratamiento, es.estadotratamiento
        FROM tratamientos t
        INNER JOIN pacientes p ON t.idpacienteasignado = p.idpaciente
        INNER JOIN tipotratamiento ti ON ti.idtipotratamiento = t.idtipotratamiento
        INNER JOIN estadotratamiento es ON es.idestadotratamiento = t.idestadotratamiento
		WHERE idtratamiento = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tratamientos
        SET fechainicio=?, descripciontratamiento=?, idpacienteasignado=?, idtipotratamiento=?, idestadotratamiento=?
        WHERE idtratamiento = ?';
        $params = array($this->inicio, $this->descripcion, $this->asignado, $this->tipo, $this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tratamientos where idtratamiento = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
