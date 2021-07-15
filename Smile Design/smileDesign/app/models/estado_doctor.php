<?php
/*
    Clase que maneja el combobox de estado usuarios
*/
class Categorias extends Validator
{
    public function readAll()
    {
        $sql = 'SELECT * FROM estadodoctor';
        $params = null;
        return Database::getRows($sql, $params);
    }
} 