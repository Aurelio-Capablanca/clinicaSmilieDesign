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
    //Declaración de variables para historial de sesiones
    private $user = null;
    private $ip = null;
    private $region = null;
    private $zona = null;
    private $distribuidor = null;
    private $pais = null;
    private $codigo = null;
    private $intentos = null;
    private $intentosenvio = null;


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

    public function setCodigo($value)
    {
        if ($this->validateAlphanumeric($value, 1, 50)) {
            $this->codigo = $value;
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
        if ($this->validateAlphanumeric($value, 1, 50)) {
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

    public function setIp($value)
    {
        if ($this->validateIp($value)) {
            $this->ip = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setRegion($value)
    {
        if ($this->validateString($value, 1, 56)) {
            $this->region = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setZona($value)
    {
        if ($this->validateString($value, 1, 56)) {
            $this->zona = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setDistribuidor($value)
    {
        if ($this->validateString($value, 1, 156)) {
            $this->distribuidor = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setPais($value)
    {
        if ($this->validateString($value, 1, 56)) {
            $this->pais = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setUser($value)
    {
        if ($this->validateString($value, 1, 56)) {
            $this->user = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setIntentos($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->intentos = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setIntentosenvio($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->intentosenvio = $value;
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

    public function getIp()
    {
        return $this->ip;
    }

    public function getRegion()
    {
        return $this->region;
    }

    public function getZona()
    {
        return $this->zona;
    }

    public function getDistribuidor()
    {
        return $this->distribuidor;
    }

    public function getPais()
    {
        return $this->pais;
    }

    public function getUser()
    {
        return $this->user;
    }

    public function getCodigo()
    {
        return $this->codigo;
    }

    public function getCorreos()
    {
        return $this->correos;
    }

    public function getIntentos()
    {
        return $this->intentos;
    }

    public function getIntentosEnvios()
    {
        return $this->intentosenvio;
    }

    /*
    *   Métodos para gestionar la cuenta del usuario.
    */
    public function checkUser($usuario)
    {
        $sql = 'SELECT idusuario, correousuario, idtipousuario FROM usuarios WHERE aliasusuario = ? AND idestadousuario = 1';
        $params = array($usuario);
        if ($data = Database::getRow($sql, $params)) {
            $this->id = $data['idusuario'];
            $this->tipo = $data['idtipousuario'];
            $this->correo = $data['correousuario'];            
            $this->usuario = $usuario;
            return true;
        } else {
            return false;
        }
    }

    public function checkTipo($usuario)
    {
        $sql = 'SELECT idusuario, correousuario, idtipousuario FROM usuarios WHERE aliasusuario = ? AND idestadousuario = 1';
        $params = array($usuario);
        return Database::getRow($sql, $params);
    }

    public function createCodigo($value)
    {
        $sql = "SELECT UPPER(substring(md5(random()::text),1,6)) AS codigo
                From usuarios
                Where aliasusuario ILIKE ?";
        $params = array("%$value%");
        return Database::getRow($sql, $params);
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

    public function changePassword()
    {
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'UPDATE usuarios SET claveusuario = ? WHERE idusuario = ?';
        $params = array($hash, $_SESSION['idusuario']);
        return Database::executeRow($sql, $params);
    }


    public function restorePassword()
    {
        $fechahoy = date('Y-m-d');
        $hash = password_hash($this->clave, PASSWORD_DEFAULT);
        $sql = 'UPDATE usuarios SET claveusuario = ?, fechacambioclave = ? WHERE correousuario=( Select identificador From verificarcodigos Where idcodigos = (Select max(idcodigos) from verificarcodigos) )';
        $params = array($hash, $fechahoy);
        return Database::executeRow($sql, $params);
    }

    public function HistorialSesiones()
    {       
        $sql = 'INSERT INTO historialsesiones(ip, usuario, region, zonahoraria, distribuidor, pais, fecharegistro)
                VALUES (?, ?, ?, ?, ?, ?, current_date )';
        $params = array($this->ip, $this->user, $this->region, $this->zona, $this->distribuidor, $this->pais);
        return Database::executeRow($sql, $params);
    }

    public function createCodigoSesiones()
    {       
        $sql = 'INSERT INTO codigosesiones(codigo, idusuario) VALUES ( ?, ?)';
        $params = array($this->codigo , $this->id);
        return Database::executeRow($sql, $params);
    }

    public function searchCorreo($value)
    {
        $sql = "SELECT idusuario, nombreusuario, apellidousuario, correousuario, aliasusuario,
                    UPPER(substring(nombreusuario,1,3)||''||substring(apellidousuario,1,3)||''||substring(md5(random()::text),1,3)) AS claveusuario
                From usuarios
                Where correousuario ILIKE ?";
        $params = array("%$value%");
        return Database::getRow($sql, $params);
    }

    public function searchCodigo($value)
    {
        $sql = "SELECT codigo From verificarCodigos Where codigo ILIKE ? AND idcodigos = (Select MAX(idcodigos) From verificarcodigos)";
        $params = array("%$value%");
        return Database::getRow($sql, $params);
    }

    public function prueba90Dias($value)
    {
        $sql = "SELECT fechacambioclave, (current_date - fechacambioclave) as dias From usuarios  Where aliasusuario ILIKE ?";
        $params = array("%$value%");
        return Database::getRow($sql, $params);
    }

    public function validateCodigo($value)
    {
        $sql = "SELECT codigo from codigosesiones Where codigo ILIKE ? and idcodigosesion=(Select max(idcodigosesion) from codigosesiones)";
        $params = array("%$value%");
        //return Database::getRow($sql, $params);
        if ($data = Database::getRow($sql, $params)) {
            $this->codigo = $data['codigo'];            
            return true;
        } else {
            return false;
        }
    }

    public function InsertCodigo()
    {       
        $sql = 'INSERT INTO verificarcodigos(codigo, identificador)	VALUES (?, ?)';
        $params = array($this->codigo, $this->correos);
        return Database::executeRow($sql, $params);
    }

    public function validarIntentos()
    {       
        $sql = 'UPDATE usuarios set intentosfallidos = ? , idestadousuario = 2   Where aliasusuario= ?';
        $params = array($this->intentos, $this->user);
        return Database::executeRow($sql, $params);
    }

    public function validarIntentosEnvios()
    {       
        $sql = 'INSERT INTO conteointentosfallidos(intentosfallidos, usuario, fecharegistro) VALUES (? , ? , current_date )';
        $params = array($this->intentosenvio, $this->user);
        return Database::executeRow($sql, $params);
    }    

    public function readProfile()
    {
        $sql = 'SELECT idusuario, nombresusuario, apellidosusuario, usuario, correousuario, usuario
                FROM usuarios
                WHERE idusuario = ?';
        $params = array($_SESSION['idusuario']);
        return Database::getRow($sql, $params);
    }

    public function editProfile()
    {
        $sql = 'UPDATE usuarios
                SET nombresusuario = ?, apellidosusuario = ?, correousuario = ?, usuario = ?
                WHERE idusuario = ?';
        $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $_SESSION['idusuario']);
        return Database::executeRow($sql, $params);
    }

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, delete).
    */
    // public function searchRows($value)
    // {
    //     $sql = 'SELECT idusuario, nombresusuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario
    //             FROM usuarios
    //             WHERE apellidosusuario ILIKE ? OR nombresusuario ILIKE ?
    //             ORDER BY apellidosusuario';
    //     $params = array("%$value%", "%$value%");
    //     return Database::getRows($sql, $params);
    // }

    // public function createRow()
    // {
    //     // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
    //     $hash = password_hash($this->clave, PASSWORD_DEFAULT);
    //     $sql = 'INSERT INTO usuarios(
    //         nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario)
    //         VALUES (?, ?, ?, ?, ?, ?, ?, 1, 1)';
    //     $params = array($this->nombres, $this->apellidos, $this->direccion, $this->telefono, $this->correo, $this->usuario, $hash);
    //     return Database::executeRow($sql, $params);
    // }

    // public function addUser()
    // {
    //     // Se encripta la clave por medio del algoritmo bcrypt que genera un string de 60 caracteres.
    //     $hash = password_hash($this->clave, PASSWORD_DEFAULT);
    //     $sql = 'INSERT INTO usuarios(nombresusuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario)
    //             VALUES(?, ?, ?, ?, ?, ?, ?)';
    //     $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $hash, $this->tipo,$this->estado);
    //     return Database::executeRow($sql, $params);
    // }

    public function readAll()
    {
        $sql = 'SELECT idusuario, nombreusuario, apellidousuario, direccionusuario, telefonousuario, correousuario, aliasusuario, claveusuario, idestadousuario, idtipousuario
        FROM public.usuarios;';
        $params = null;
        return Database::getRows($sql, $params);
    }

    // public function readOne()
    // {
    //     $sql = 'SELECT idusuario, nombresusuario,usuario, apellidosusuario, correousuario, usuario, claveusuario, idtipousuario, idestadousuario
    //             FROM usuarios
    //             WHERE idusuario = ?';
    //     $params = array($this->id);
    //     return Database::getRow($sql, $params);
    // }

    // public function updateRow()
    // {
    //     $sql = 'UPDATE usuarios 
    //             SET nombresusuario = ?, apellidosusuario = ?, correousuario = ?, usuario = ?, idtipousuario = ?, idestadousuario = ?
    //             WHERE idusuario = ?';
    //     $params = array($this->nombres, $this->apellidos, $this->correo, $this->usuario, $this->tipo, $this->estado, $this->id);
    //     return Database::executeRow($sql, $params);
    // }

    // public function deleteRow()
    // {
    //     $sql = 'DELETE FROM usuarios
    //             WHERE idusuario = ?';
    //     $params = array($this->id);
    //     return Database::executeRow($sql, $params);
    // }
}
