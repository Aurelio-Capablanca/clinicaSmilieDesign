<?php

class Sesiones extends Validator{

    public function searchRows($value)
    {
        $sql = 'SELECT count(intentosfallidos) as intentos, usuario, fecharegistro
        From conteointentosfallidos
        group by usuario, fecharegistro
        Having count(usuario)>=1';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT count(intentosfallidos) as intentos, usuario, fecharegistro
                From conteointentosfallidos
                group by usuario, fecharegistro
                Having count(usuario)>=1'; 
        $params = null;
        return Database::getRows($sql, $params);
    }    

}