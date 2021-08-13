<?php
/*
*	Clase para manejar la tabla clientes de la base de datos. Es clase hija de Validator.
*/
class Doctores extends Validator {

    // Variables y atributos
    private $id = null;
    private $nombres = null;
    private $apellidos = null;
    private $direccion = null;
    private $telefono = null;
    private $correo = null;
    private $foto = null;    
    private $alias = null;
    private $clave = null;
    private $estado = null;
    private $ruta = '../../../resources/img/fotodoctor/';

    /*
    *   Métodos para asignar valores a los atributos.
    */

    public function setId($value) {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setNombres($value) {

        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->nombres = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setApellidos($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->apellidos = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDireccion($value)
    {
        if ($this->validateString($value, 1, 200)) {
            $this->direccion = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setTelefono($value)
    {
        if ($this->validatePhone($value)) {
            $this->telefono = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setCorreo($value)
    {
        if ($this->validateEmail($value)) {
            $this->correo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setFoto($file)
    {
        if ($this->validateImageFile($file, 500, 500)) {
            $this->foto = $this->getImageName();
            return true;
        } else {
            return false;
        }
    }

    public function setAlias($value)
    {
        if ($this->validateAlphanumeric($value, 1, 50)) {
            $this->alias = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setClave($value)
    {
        if ($this->validatePassword($value)) {
            $this->clave = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setEstado($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->estado = $value;
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

    public function getNombres()
    {
        return $this->nombres;
    }

    public function getApellidos()
    {
        return $this->apellidos;
    }

    public function getDireccion()
    {
        return $this->direccion;
    }

    public function getTelefono()
    {
        return $this->telefono;
    }

    public function getCorreo()
    {
        return $this->correo;
    }

    public function getFoto()
    {
        return $this->foto;
    }

    public function getAlias()
    {
        return $this->alias;
    }

    public function getClave()
    {
        return $this->clave;
    }

    public function getEstado()
    {
        return $this->estado;
    }

    public function getRuta() {
        return $this->ruta;
    }

    
    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */

    public function searchRows($value)
    {
        $sql = 'SELECT iddoctor, nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor, correodoctor, fotodoctor, aliasdoctor, clavedoctor, estadodoctor, idestadodoctor
                FROM doctores inner join estadodoctor Using(idestadodoctor)
                WHERE  nombredoctor ILIKE ?
                OR  apellidodoctor ILIKE ?
                order by apellidodoctor';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'INSERT INTO doctores(nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor, correodoctor, fotodoctor, aliasdoctor, clavedoctor, idestadodoctor)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombres, $this->apellidos, $this->direccion, $this->telefono, $this->correo, $this->foto, $this->alias, $hash, $this->estado );
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT iddoctor, nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor, correodoctor, fotodoctor, aliasdoctor, clavedoctor, estadodoctor
                FROM doctores inner join estadodoctor ON doctores.idestadodoctor = estadodoctor.idestadodoctor
                ORDER BY apellidodoctor';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT iddoctor, nombredoctor, apellidodoctor, direcciondoctor, telefonodoctor, correodoctor, fotodoctor, aliasdoctor, clavedoctor, idestadodoctor
                FROM doctores
                WHERE iddoctor = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow($current_image) {

        // Se verifica si existe una nueva imagen para borrar la actual, de lo contrario se mantiene la actual.
        ($this->foto) ? $this->deleteFile($this->getRuta(), $current_image) : $this->foto = $current_image;

        $sql = 'UPDATE doctores
                SET nombredoctor = ?, apellidodoctor = ?, direcciondoctor = ?, telefonodoctor = ?, correodoctor = ?, fotodoctor = ?, idestadodoctor = ?
                WHERE iddoctor = ?';
        $params = array($this->nombres, $this->apellidos, $this->direccion, $this->telefono, $this->correo, $this->foto, $this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow() {

        $sql = 'DELETE FROM doctores
                WHERE iddoctor = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readAll2()
    {
        $sql = 'SELECT idestadodoctor, estadodoctor
                FROM estadodoctor ORDER BY estadodoctor';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readDoctoresEstado()
    {
        $sql = 'SELECT d.iddoctor, e.idestadodoctor, d.nombredoctor, d.apellidodoctor, d.direcciondoctor
                FROM doctores d, estadodoctor e WHERE d.idestadodoctor = e.idestadodoctor
                AND d.idestadodoctor = ?';
        $params = array($this->estado);
        return Database::getRows($sql, $params);
    }


}