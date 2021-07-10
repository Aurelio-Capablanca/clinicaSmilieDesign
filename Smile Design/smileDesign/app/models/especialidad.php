<?php 

class Especialidad extends Validator {

    private $id = null;
    private $especialidad = null;

    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        } 
    }

    public function setEspecialidad($value)
    {
        if ($this->validateString($value,1,30)) {
            $this->especialidad = $value;
            return true;
        } else {
            return false;
        }
    }

  
    
    /*
    *   Métodos para obtener valores de los atributos.
    */
    public function getId()
    {
        return $this->id;
    }

    public function getEspecialidad()
    {
        return $this->especialidad;
    }

    

    public function createRow()
    {
        $sql = 'INSERT INTO especialidad (especialidad)
                VALUES (?)';
        $params = array($this->especialidad);
        return Database::executeRow($sql, $params);
    }

    public function searchRows($value)
    {
        $sql = 'SELECT idespecialidad,especialidad 
                from especialidad
                WHERE especialidad ILIKE ? 
                order by idespecialidad ';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }


    public function readAll()
    {
        $sql = 'SELECT idespecialidad,especialidad 
        from especialidad
        order by idespecialidad ';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idespecialidad,especialidad 
        from especialidad
        where idespecialidad = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE especialidad
                SET especialidad = ?
                WHERE idespecialidad = ?';
        $params = array($this->especialidad, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM especialidad
                WHERE idespecialidad = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
?>