<?php 

class Causa extends Validator {

    private $id = null;
    private $causa = null;

    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        } 
    }

    public function setCausa($value)
    {
        if ($this->validateString($value,1,30)) {
            $this->causa = $value;
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

    public function getCausa()
    {
        return $this->causa;
    }

    

    public function createRow()
    {
        $sql = 'INSERT INTO causaconsulta(causa )
        VALUES (?)';
        $params = array($this->causa);
        return Database::executeRow($sql, $params);
    }

    public function searchRows($value)
    {
        $sql = 'SELECT idcausaconsulta,causa 
        from causaconsulta    
        WHERE causa ILIKE ? 
        order by idcausaconsulta';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }


    public function readAll()
    {
        $sql = 'SELECT idcausaconsulta,causa 
        from causaconsulta
        order by idcausaconsulta ';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idcausaconsulta,causa 
        from causaconsulta
        where idcausaconsulta = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE causaconsulta
                SET causa = ?
                WHERE idcausaconsulta = ?';
        $params = array($this->causa, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM causaconsulta
                WHERE idcausaconsulta = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
?>