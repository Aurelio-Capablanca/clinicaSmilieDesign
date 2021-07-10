<?php
/*
*	Clase para manejar la tabla usuarios de la base de datos. Es clase hija de Validator.
*/
class Usuarios extends Validator
{
    // Declaración de atributos (propiedades).
    private $id = null;
    private $nombres = null;
    private $apellidos = null;
    private $correo = null;
    private $usuario = null;
    private $clave = null;
    private $tipo = null;
    private $estado = null;
    private $direccion = null;
    private $telefono = null;


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

    public function setNombres($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->nombres = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDireccion($value)
    {
        if ($this->validateAlphabetic($value, 1, 50)) {
            $this->direccion = $value;
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

    public function setCorreo($value)
    {
        if ($this->validateEmail($value)) {
            $this->correo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setUsuario($value)
    {
        if ($this->validateAlphanumeric($value, 1, 50)) {
            $this->usuario = $value;
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

    public function setClave($value)
    {
        if ($this->validatePassword($value)) {
            $this->clave = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setTipo($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->tipo = $value;
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

    
    public function getTelefono()
    {
        return $this->telefono;
    }

    public function getDireccion()
    {
        return $this->direccion;
    }

    public function getApellidos()
    {
        return $this->apellidos;
    }

    public function getCorreo()
    {
        return $this->correo;
    }

    public function getUsuario()
    {
        return $this->usuario;
    }

    public function getClave()
    {
        return $this->clave;
    }

    public function getTipo()
    {
        return $this->tipo;
    }

    public function getEstado()
    {
        return $this->estado;
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */
    public function searchRows($value)
    {
        $sql = 'SELECT idusuario,nombreusuario,apellidousuario,direccionusuario,telefonousuario,correousuario,
                aliasusuario,e.estadousuario,t.tipousuario
                from usuarios u
                INNER JOIN estadousuario e ON e.idestadousuario = u.idestadousuario
                INNER JOIN tipousuario t ON u.idtipousuario = t.idtipousuario
                WHERE apellidousuario ILIKE ? OR nombreusuario ILIKE ?
                order by estadousuario desc';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'INSERT INTO usuarios(idusuario, nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, 
        aliasusuario, claveusuario, idestadousuario, idtipousuario)
            VALUES (default, ?, ?, ?, ?, ?, ?, ?, ?, ?);';
        $params = array($this->nombres, $this->apellidos,$this->direccion,$this->telefono, $this->correo, $this->usuario, $hash, $this->estado,$this->tipo);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT idusuario,nombreusuario,apellidousuario,direccionusuario,telefonousuario,correousuario,
        aliasusuario,e.estadousuario,t.tipousuario
        from usuarios u
        INNER JOIN estadousuario e ON e.idestadousuario = u.idestadousuario
        INNER JOIN tipousuario t ON u.idtipousuario = t.idtipousuario
        order by estadousuario desc';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idusuario,nombreusuario,apellidousuario,direccionusuario,telefonousuario,correousuario,
                aliasusuario,e.estadousuario,t.tipousuario
                from usuarios u
                INNER JOIN estadousuario e ON e.idestadousuario = u.idestadousuario
                INNER JOIN tipousuario t ON u.idtipousuario = t.idtipousuario
                WHERE idusuario = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'UPDATE usuarios
        SET nombreusuario=?, apellidousuario=?, direccionusuario=?, telefonousuario=?, correousuario=?, aliasusuario=?, claveusuario=?, idestadousuario=?, idtipousuario=?
        WHERE idusuario=?;';
        $params = array($this->nombres, $this->apellidos,$this->direccion,$this->telefono, $this->correo, $this->usuario, $hash, $this->estado,$this->tipo, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM usuarios
                WHERE idusuario = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
