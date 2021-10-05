<?php

class Productos extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $notas = null;
    private $odontograma = null;
    private $periodontograma = null;
    private $observaciones = null;
    private $paciente = null;
    private $rutaOdontograma = '../../resources/img/odontograma/';
    private $rutaPeriodontograma = '../../resources/img/periodontograma/';

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

    public function setNotas($value)
    {
        if ($this->validateString($value, 1, 1250)) {
            $this->notas = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setPeriodontograma($file)
    {
        if ($this->validateImageFile($file, 500, 500)) {
            $this->periodontograma = $this->getImageName();
            return true;
        } else {
            return false;
        }
    }

    public function setOdontograma($file)
    {
        if ($this->validateImageFile($file, 500, 500)) {
            $this->odontograma = $this->getImageName();
            return true;
        } else {
            return false;
        }   
    }

    public function setObservaciones($value)
    {
        if ($this->validateString($value, 1, 1250)) {
            $this->observaciones = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setPaciente($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->paciente = $value;
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

    public function getNotas()
    {
        return $this->notas;
    }

    public function getOdontograma()
    {
        return $this->odontograma;
    }

    public function getPeriodontograma()
    {
        return $this->periodontograma;
    }

    public function getObservaciones()
    {
        return $this->observaciones;
    }

    public function getPaciente()
    {
        return $this->paciente;
    }

    public function getRutaOdontograma()
    {
        return $this->rutaOdontograma;
    }

    public function getRutaPeriodontograma()
    {
        return $this->rutaPeriodontograma;
    }

    // METODOS PARA REALIZAR LAS OPERACIONES SCRUD 

    public function searchRows($value)
    {
        $sql = 'SELECT idexpediente, odontograma,periodontograma,
        nombrepaciente,apellidopaciente, idpaciente
        from expedientes 
        INNER JOIN pacientes Using(idpaciente)
        WHERE nombrepaciente ILIKE ? OR apellidopaciente ILIKE ?
        order by idexpediente';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO expedientes( odontograma, periodontograma, idpaciente)
            VALUES (?, ?, ?);';
        $params = array( $this->odontograma, $this->periodontograma, $this->paciente);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT idexpediente, odontograma,periodontograma,
        nombrepaciente,apellidopaciente, idpaciente
        from expedientes 
        INNER JOIN pacientes Using(idpaciente)
        order by idexpediente';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readRow()
    {
        $sql = 'SELECT idexpediente, odontograma,periodontograma,
        nombrepaciente,apellidopaciente,duipaciente, idpaciente
        from expedientes 
        INNER JOIN pacientes Using(idpaciente)
        WHERE idexpediente = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow($current_image,$current_image2)
    {
        ($this->periodontograma) ? $this->deleteFile($this->getRutaPeriodontograma(), $current_image) : $this->periodontograma = $current_image;
        ($this->odontograma) ? $this->deleteFile($this->getRutaOdontograma(), $current_image2) : $this->odontograma = $current_image2;

        $sql = 'UPDATE expedientes
        SET odontograma = ? , periodontograma = ? , idpaciente = ?
        WHERE idexpediente = ?;';
        $params = array($this->odontograma, $this->periodontograma, $this->paciente, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM expedientes where idexpediente = ? ';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function createRowArchivo()
    {
        $sql = 'INSERT INTO archivos(notas, observacionesperiodontograma, idexpediente)
                VALUES (?, ?, ?);';
        $params = array($this->notas,$this->observaciones,$this->id);
        return Database::executeRow($sql, $params);
    }

    public function readOneArchivo()
    {
        $sql = 'SELECT idarchivo, notas, observacionesperiodontograma, idpaciente, idexpediente, odontograma
                From archivos 
                inner join expedientes Using(idexpediente)
                Where idexpediente = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readOneArchivo1()
    {
        $sql = 'SELECT idarchivo, notas, observacionesperiodontograma, idpaciente, idexpediente, odontograma
                From archivos 
                inner join expedientes Using(idexpediente)
                Where idarchivo = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function searchOneArchivo($value)
    {
        $sql = 'SELECT idarchivo, notas, observacionesperiodontograma, idpaciente, idexpediente, odontograma
                From archivos 
                inner join expedientes Using(idexpediente)
                Where odontograma ILIKE ?';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }

    public function readAllArchivo()
    {
        $sql = 'SELECT idarchivo, notas, observacionesperiodontograma, idpaciente, idexpediente, odontograma
                From archivos 
                inner join expedientes Using(idexpediente)';
        $params = null;
        return Database::getRows($sql, $params);
    }


    public function updateRowArchivo()
    {        
        $sql = 'UPDATE archivos
                SET  notas = ?, observacionesperiodontograma = ?
                WHERE idarchivo = ?';
        $params = array( $this->notas,$this -> observaciones ,$this->id);
        return Database::executeRow($sql, $params);
    }


    public function readArchivos()
    {
        $sql = "SELECT idarchivo ,notas, observacionesperiodontograma,  nombrepaciente , apellidopaciente , idexpediente
        from archivos
        inner join expedientes USING(idexpediente)
        inner join pacientes USING(idpaciente)
        Where idarchivo = ?";
        $params =  array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readArchivosall()
    {
        $sql = "SELECT idarchivo ,nombrepaciente , apellidopaciente , idexpediente
        from archivos
        inner join expedientes USING(idexpediente)
        inner join pacientes USING(idpaciente)
        Where idarchivo = ?";
        $params =  array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readOneArchivo2()
    {
        $sql = 'SELECT idarchivo, notas, observacionesperiodontograma, idpaciente, idexpediente, odontograma
                From archivos 
                inner join expedientes Using(idexpediente)
                Where idarchivo = ?';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    
}
