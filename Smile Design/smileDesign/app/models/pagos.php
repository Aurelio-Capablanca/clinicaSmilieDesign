<?php 

class Pagos extends Validator{

    private $id = null;
    private $saldo = null;
    private $tipo = null;
    private $estado = null;
    private $codigo = null;

    
    public function setId($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setSaldo($value)
    {
        if ($this->validateMoney($value)) {
            $this->saldo = $value;
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

    public function setTipo($value)
    {
        if ($this->validateNaturalNumber($value)) {
            $this->tipo = $value;
            return true;
        } else {
            return false;
        }
    }

    public function setCodigo($value)
    {
        if ($this->validateString($value, 1, 200)) {
            $this->codigo = $value;
            return true;
        } else {
            return false;
        }
    }

    // ----------------------------------------------

    public function getId()
    {
        return $this->id;
    }

    public function getSaldo()
    {
        return $this->saldo;
    }

    public function getEstado()
    {
        return $this->estado;
    }

    public function getTipo()
    {
        return $this->tipo;
    }

    public function getCodigo()
    {
        return $this->codigo;
    }
    // ------------------------------------------

    public function readAll()
    {
        $sql = 'SELECT idpago ,nombrepaciente, apellidopaciente , fechainicio, pagodebe, pagoabono, pagototal, pagosaldo, tipopago ,estadopago
                From Pagos  ps
                Inner join Tipopago tg on tg.idtipopago=ps.idtipopago
                Inner join EstadoPago eg on eg.idestadopago = ps.idestadopago
                Inner join Tratamientos tr on tr.idtratamiento = ps.idtratamiento
                Inner join Pacienteasignado pa on pa.idpacienteasignado = tr.idpacienteasignado
                Inner join pacientes tp on tp.idpaciente = pa.idpaciente
                Order By idpago ASC';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readAllTIPO()
    {
        $sql = 'SELECT idtipopago, tipopago
                FROM tipopago';
        $params = null;
        return Database::getRows($sql, $params);
    }    

    public function readAllESTADO()
    {
        $sql = 'SELECT idestadopago, estadopago
                FROM estadopago';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOnes()
    {
        $sql = 'SELECT idpago ,nombrepaciente, apellidopaciente , fechainicio, pagodebe, pagoabono, pagototal, pagosaldo, tipopago ,estadopago
                From Pagos  ps
                Inner join Tipopago tg on tg.idtipopago=ps.idtipopago
                Inner join EstadoPago eg on eg.idestadopago = ps.idestadopago
                Inner join Tratamientos tr on tr.idtratamiento = ps.idtratamiento
                Inner join Pacienteasignado pa on pa.idpacienteasignado = tr.idpacienteasignado
                Inner join pacientes tp on tp.idpaciente = pa.idpaciente
                WHERE idpago = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }


    public function readOneCuentas()
    {
        $sql = 'SELECT tr, fecha, debe, abono, saldo From Buscar_cuentas (?)';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function searchRows($value)
    {
        $sql = 'SELECT idpago ,nombrepaciente , apellidopaciente , fechainicio, pagodebe, pagoabono, pagototal, pagosaldo, tipopago ,estadopago
                From Pagos  ps
                Inner join Tipopago tg on tg.idtipopago=ps.idtipopago
                Inner join EstadoPago eg on eg.idestadopago = ps.idestadopago
                Inner join Tratamientos tr on tr.idtratamiento = ps.idtratamiento
                Inner join Pacienteasignado pa on pa.idpacienteasignado = tr.idpacienteasignado
                Inner join pacientes tp on tp.idpaciente = pa.idpaciente
                WHERE nombrepaciente ILIKE ? or apellidoPaciente ILIKE ? 
                Order By idpago ASC';
        $params = array("%$value%","%$value%");
        return Database::getRows($sql, $params);
    }

    public function createCuenta()
    {
        $sql = 'SELECT * FROM Calculo_Cuenta (?)';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function createSaldo()
    {
        $sql = 'SELECT * FROM Calculo_Saldo (?,?)';
        $params = array($this->id, $this->saldo);
        return Database::executeRow($sql, $params);
    }

    public function searchOneCount($value)
    {
        $sql = 'SELECT  nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        from historialpagos 
        Where codigotratamientoh ILIKE ?
        and pagoabonoh >0  and pagosaldoh >=0                 
        group by  nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        having count(pagodebeh)>=1 and count(pagoabonoh)>=1';
        $params = array("%$value%");
        return Database::getRows($sql, $params);
    }
    
    public function readAllCount()
    {
        $sql = 'SELECT nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        from historialpagos 
        Where pagoabonoh >0  and pagosaldoh >=0                 
        group by  nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        having count(pagoabonoh)>=1 and count(pagodebeh)>=1';
        $params = null;
        return Database::getRows($sql, $params);
    }

    public function readOneCount()
    {
        $sql = 'SELECT nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        from historialpagos 
        Where tratamiento = ?
        and pagoabonoh >0  and pagosaldoh >=0                 
        group by  nombrepaciente, pagodebeh, pagoabonoh, pagototalh, pagosaldoh, tratamiento, codigotratamientoh
        having count(pagoabonoh)>=1 and count(pagodebeh)>=1 ';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE pagos SET idtipopago=? WHERE idpago=?';
        $params = array($this->tipo, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'UPDATE pagos SET idestadopago=? WHERE idpago=?';
        $params = array($this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function UpdateCuenta()
    {
        $sql = 'SELECT * From Actualizar_Pagos(?)';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readOnePayment()
    {
        $sql = 'SELECT count(cl.idconsulta) as idconsulta, costoprocedimiento, descripcionprocedimiento, nombreprocedimiento ,nombrepaciente, pagoabono,pagoabonoh, tratamiento
        from historialpagos ph
        inner join pagos pg on pg.idpago = ph.tratamiento
        inner join tratamientos tr on tr.idtratamiento = ph.tratamiento
        inner join cantidadconsultas cc on cc.idtratamiento = tr.idtratamiento
        inner join consultas cl on cl.idconsulta = cc.idconsulta
        inner join consultaprocedimiento pc on pc.idconsulta = cl.idconsulta
        inner join procedimientos pr on pr.idprocedimiento = pc.idprocedimiento
        Where idpago = ?
        group by  costoprocedimiento,descripcionprocedimiento, nombrepaciente, pagoabonoh, pagoabono, nombreprocedimiento, tratamiento';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readOnepaciente()
    {
        $sql = 'SELECT pc.nombrepaciente as nombrepaciente, apellidopaciente, telefonopaciente, duipaciente, direccionpaciente, correopaciente, tratamiento
        from pacientes pc
        inner join pacienteasignado pp on pp.idpaciente = pc.idpaciente
        inner join tratamientos tr on tr.idpacienteasignado = pp.idpacienteasignado
        inner join historialpagos hp on hp.tratamiento = tr.idtratamiento
        Where idpago = ? limit 1';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }


    public function suspenderPago()
    {
        $sql = 'UPDATE pagos Set idestadopago=3 Where idpago = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

}