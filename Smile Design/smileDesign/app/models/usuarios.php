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
    private $correos = null;
    private $usuario = null;
    private $clave = null;
    private $tipo = null;
    private $estado = null;
    private $direccion = null;
    private $telefono = null;
    private $clavev = null;


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
        if ($this->validateString($value, 1, 50)) {
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

    public function setCorreos($value)
    {
        if ($this->validateEmail($value)) {
            $this->correos = $value;
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
        if ($this->validatePhone($value, 1, 50)) {
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

    public function getCorreos()
    {
        return $this->correos;
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
    *   Métodos para gestionar la cuenta del usuario.
    */
    public function checkUser($usuario)
    {
        $sql = 'SELECT idusuario, correousuario, idtipousuario FROM usuarios WHERE aliasusuario = ?';
        $params = array($usuario);
        if ($data = Database::getRow($sql, $params)) {
            $this->id = $data['idusuario'];
            $this->tipo = $data['idtipousuario'];
            $this->correos = $data['correousuario'];
            $this->usuario = $usuario;            
            return true;
        } else {
            return false;
        }
    }

    public function checkPassword($password)
    {
        $sql = 'SELECT claveusuario FROM usuarios WHERE idusuario = ?';
        $params = array($this->id);
        $data = Database::getRow($sql, $params);
        if (password_verify($password, $data['claveusuario'])) {
            return true;
        } else {
            return false;
        }
    }

    public function validatePassword($password)
    {
        $sql = 'SELECT claveusuario, correousuario, aliasusuario 
                FROM usuarios 
                WHERE idusuario = ?';
        $params = array($this->id);       
        $data = Database::getRow($sql, $params);
        if (password_verify($password, $data['claveusuario']) ) {
            return false;
        }else if ($password==$data['aliasusuario'] && $password==$data['correousuario']){
            return false;
        } 
        else {
            return true;
        }


    }
    
    public function changePassword()
    {
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'UPDATE usuarios SET claveusuario = ?, fechacambioclave = current_date WHERE idusuario = ?';
        $params = array($hash, $_SESSION['idusuario']);
        return Database::executeRow($sql, $params);
    }

    public function readProfile()
    {
        $sql = 'SELECT idusuario, nombreusuario, apellidousuario, aliasusuario, correousuario, direccionusuario
                FROM usuarios
                WHERE idusuario = ?';
        $params = array($_SESSION['idusuario']);
        return Database::getRow($sql, $params);
    }

    public function editProfile()
    {
        $sql = 'UPDATE usuarios
                SET nombreusuario = ?, apellidousuario = ?, correousuario = ?, aliasusuario = ?, direccionusuario = ?
                WHERE idusuario = ?';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $this->direccion, $_SESSION['idusuario']);
        return Database::executeRow($sql, $params);
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */
    public function searchRows($value)
    {
        $sql = 'SELECT idusuario, nombresusuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario
                FROM usuarios
                WHERE apellidosusuario ILIKE ? OR nombresusuario ILIKE ?
                ORDER BY apellidosusuario';
        $params = array("%$value%", "%$value%");
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'INSERT INTO usuarios(
            nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario)
            VALUES (?, ?, ?, ?, ?, ?, ?, 1, 1)';
        $params = array($this->nombres, $this->apellidos, $this->direccion, $this->telefono, $this->correo, $this->usuario, $hash);
        return Database::executeRow($sql, $params);
    }

    public function addUser()
    {
        // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'INSERT INTO usuarios(nombresusuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario)
                VALUES(?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $hash, $this->tipo,$this->estado);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT idusuario, nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario
        FROM usuarios
        Order by idusuario';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT idusuario, nombresusuario,usuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario
                FROM usuarios
                WHERE idusuario = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE usuarios 
                SET nombresusuario = ?, apellidosusuario = ?, correousuario = ?, usuario = ?, idtipousuario = ?, idestadousuario = ?
                WHERE idusuario = ?';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $this->tipo, $this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM usuarios
                WHERE idusuario = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readTipo()
    {
        $sql = 'SELECT idtipousuario,tipousuario 
        FROM tipousuario';
        $params = null;
        return Database::getRows($sql, $params);
    }

     // Funcion para cargar registros de un tipo de usuario en especifico
     public function readUsuariosTipo()
     {
         // Creamos la sentencia SQL que contiene la consulta que mandaremos a la base
         $sql = "SELECT idusuario, concat(nombreusuario,' ',apellidousuario) as nombres, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario
         FROM usuarios where idtipousuario=?";
         $params = array($this->tipo);
         return Database::getRows($sql, $params);
     }
}
