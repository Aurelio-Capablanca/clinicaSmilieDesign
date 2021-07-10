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
    private $rutaOdontograma = '../../../resources/img/odontograma/';
    private $rutaPeriodontograma = '../../../resources/img/periodontograma/';

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
        if ($this->validateString($value, 1, 250)) {
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
        if ($this->validateString($value, 1, 250)) {
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
        observacionesperiodontograma,p.nombrepaciente,p.apellidopaciente
        from expedientes e
        INNER JOIN pacientes p ON p.idpaciente = e.idpaciente
        WHERE p.nombrepaciente ILIKE ? OR p.apellidopaciente ILIKE ?
        order by idexpediente';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO expedientes(notasmedicas, odontograma, periodontograma, observacionesperiodontograma, idpaciente)
            VALUES (?, ?, ?, ?, ?);';
        $params = array($this->notas, $this->odontograma, $this->periodontograma, $this->observaciones,$this->paciente);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT idexpediente, odontograma,periodontograma,
        observacionesperiodontograma,p.nombrepaciente,p.apellidopaciente
        from expedientes e
        INNER JOIN pacientes p ON p.idpaciente = e.idpaciente
        order by idexpediente';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readRow()
    {
        $sql = 'SELECT idexpediente, odontograma,periodontograma,
        notasmedicas,observacionesperiodontograma,p.nombrepaciente,p.apellidopaciente,p.duipaciente
        from expedientes e
        INNER JOIN pacientes p ON p.idpaciente = e.idpaciente
        WHERE idexpediente = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow($current_image,$current_image2)
    {
        ($this->periodontograma) ? $this->deleteFile($this->getRutaPeriodontograma(), $current_image) : $this->periodontograma = $current_image;
        ($this->odontograma) ? $this->deleteFile($this->getRutaOdontograma(), $current_image2) : $this->odontograma = $current_image2;

        $sql = 'UPDATE expedientes
        SET notasmedicas = ? , odontograma = ? , periodontograma = ? , observacionesperiodontograma = ? , idpaciente = ?
        WHERE idexpediente = ?;';
        $params = array($this->notas, $this->odontograma, $this->periodontograma, $this->observaciones, $this->paciente, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM expedientes where idexpediente = ? ';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
