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
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, nombrepaciente, apellidopaciente , duipaciente ,idpacienteasignado ,idtipotratamiento, idestadotratamiento , tipotratamiento, estadotratamiento
        FROM tratamientos
		INNER JOIN pacienteasignado Using(idpacienteasignado)
        INNER JOIN pacientes Using(idpaciente)
        INNER JOIN tipotratamiento Using(idtipotratamiento)
        INNER JOIN estadotratamiento Using(idestadotratamiento)
        WHERE nombrepaciente ILIKE ? OR apellidopaciente ILIKE ? OR duipaciente ILIKE ?
        ORDER BY fechainicio ASC';
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

    public function createRowsCantidad()
    {
        $sql = 'SELECT * FROM Insertar_tratamiento (?)';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readRows()
    {
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, nombrepaciente, apellidopaciente , duipaciente , idpacienteasignado ,idtipotratamiento, idestadotratamiento , tipotratamiento, estadotratamiento
        FROM tratamientos
		INNER JOIN pacienteasignado Using(idpacienteasignado)
        INNER JOIN pacientes Using(idpaciente)
        INNER JOIN tipotratamiento Using(idtipotratamiento)
        INNER JOIN estadotratamiento Using(idestadotratamiento)
        order by fechainicio ASC';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readRow()
    {
        $sql = 'SELECT idtratamiento, fechainicio, descripciontratamiento, nombrepaciente, apellidopaciente , duipaciente , idpacienteasignado ,idtipotratamiento, idestadotratamiento , tipotratamiento, estadotratamiento
        FROM tratamientos
		INNER JOIN pacienteasignado Using(idpacienteasignado)
        INNER JOIN pacientes Using(idpaciente)
        INNER JOIN tipotratamiento Using(idtipotratamiento)
        INNER JOIN estadotratamiento Using(idestadotratamiento)
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

    public function readTratamientoConsulta()
    {
        $sql = 'SELECT count(idconsulta) as Cantidad, causa
        from tratamientos
        inner join cantidadconsultas USING(idtratamiento)
        inner join consultas USING(idconsulta)
        inner join causaconsulta USING(idcausaconsulta)
        Where idtratamiento = ?
        group by causa';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }


    public function readTratamientosPorcentajes()
    {
        $sql = 'SELECT count(idtratamiento) as cantidad, tipotratamiento
        from tratamientos
        inner join tipotratamiento USING(idtipotratamiento)
        group by tipotratamiento
        order by cantidad ASC';
        $params = null;
        return Database::getRows($sql, $params);
    }


    public function readTopTratamientos()
    {
        $sql = 'SELECT count(idtratamiento) as cantidad, tipotratamiento
        from tratamientos
        inner join tipotratamiento USING(idtipotratamiento)
            where (Select count(idtratamiento) as cantidad
            from tratamientos
            inner join tipotratamiento USING(idtipotratamiento))>1
        group by tipotratamiento
        order by cantidad DESC';
        $params = null;
        return Database::getRows($sql, $params);
    }

}
