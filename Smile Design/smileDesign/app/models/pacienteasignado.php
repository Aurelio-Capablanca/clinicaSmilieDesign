<?php
/*
*	Clase para manejar la tabla categorias de la base de datos. Es clase hija de Validator.
*/
class Categorias extends Validator
{
    public function readAll()
    {
        $sql = "SELECT idpacienteasignado, duipaciente ||', '|| nombrepaciente ||' '|| apellidopaciente 
        from pacienteasignado
        inner join pacientes using(idpaciente)
        Order by nombrepaciente ASC";
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllPaciente()
    {
        $sql = "SELECT idpaciente, duipaciente ||', '|| nombrepaciente ||' '|| apellidopaciente 
        from pacientes        
        Order by nombrepaciente ASC";
        $params = null;
        return Database::getRows($sql, $params);
    }
}
