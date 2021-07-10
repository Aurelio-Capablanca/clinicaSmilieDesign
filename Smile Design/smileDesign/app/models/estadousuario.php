<?php
/*
*	Clase para manejar la tabla categorias de la base de datos. Es clase hija de Validator.
*/
class Categorias extends Validator
{
    public function readAll()
    {
        $sql = 'SELECT idestadousuario,estadousuario 
        FROM estadousuario';
        $params = null;
        return Database::getRows($sql, $params);
    }
}
