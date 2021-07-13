<?php
/*
*	Clase para manejar la tabla categorias de la base de datos. Es clase hija de Validator.
*/
class Categorias extends Validator
{
    public function readAll()
    {
        $sql = 'SELECT idpacienteasignado, duipaciente
        from pacienteasignado
        inner join pacientes using(idpaciente)';
        $params = null;
        return Database::getRows($sql, $params);
    }
}
