<?php

/**
 * Clasae modelo de operaciones SCRUD para proceadimientos
 */



class Procedimientos extends Validator
{
    //Declaración de atributos

    private $id = null;
    private $nombre = null;
    private $descripcion = null;
    private $costo = null;

    /*
    *   Métodos para asignar valores a los atributos.
    */

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

    // public function setDescripcion($value)
    // {

    //     if ($this->validateString($value, 1, 250)) {
    //         $this->descripcion = $value;
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }

    public function setDescripcion($value)
    {
        if ($this->validateString($value, 1, 250)) {
            $this->descripcion = $value;
            return true;
        } else {
            return false;
        }
    }


    public function setCosto($value)
    {

        if ($this->validateMoney($value)) {
            $this->costo = $value;
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

    public function getNombre()
    {
        return $this->nombre;
    }

    public function getDescripcion()
    {
        return $this->descripcion;
    }

    public function getCosto()
    {
        return $this->costo;
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */

    public function searchRows($value) {

        $sql = 'SELECT idprocedimiento, nombreprocedimiento, descripcionprocedimiento, costoprocedimiento
                FROM procedimientos
                WHERE nombreprocedimiento ILIKE ?
                ORDER BY nombreprocedimiento';
            $params = array("%$value%");
            return Database::getRows($sql, $params);
    }

    public function createRow() {

        $sql = 'INSERT INTO procedimientos(nombreprocedimiento, descripcionprocedimiento, costoprocedimiento)
                VALUES(?, ?, ?)';
        $params = array($this->nombre, $this->descripcion, $this->costo);
        return Database::executeRow($sql, $params);
    }

    public function readAll() {

        $sql = 'SELECT idprocedimiento, nombreprocedimiento, descripcionprocedimiento, costoprocedimiento
                FROM procedimientos                 
                ORDER BY nombreprocedimiento';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne() {

        $sql = 'SELECT idprocedimiento, nombreprocedimiento, descripcionprocedimiento, costoprocedimiento
                FROM procedimientos
                WHERE idprocedimiento = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow() {                

        $sql = 'UPDATE procedimientos
                SET nombreprocedimiento = ?, descripcionprocedimiento = ?, costoprocedimiento = ?
                WHERE idprocedimiento = ?';
        $params = array($this->nombre, $this->descripcion, $this->costo, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow() {

        $sql = 'DELETE FROM procedimientos
                WHERE idprocedimiento = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
