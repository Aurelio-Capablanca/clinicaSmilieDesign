<?php

class Historial extends Validator{

    public function searchRows($value)
    {
        $sql = 'SELECT ip, usuario, region, zonahoraria, distribuidor, pais, fecharegistro
                From Historialsesiones
                Where usuario ILIKE ?
                Order by usuario ASC';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT ip, usuario, region, zonahoraria, distribuidor, pais, fecharegistro
                From Historialsesiones
                Order by fecharegistro DESC'; 
        $params = null;
        return Database::getRows($sql, $params);
    }    

}