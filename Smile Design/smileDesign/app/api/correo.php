<?php
require_once('../helpers/correorecuperacion.php');
     //$recuperacionmail = new recuperacionmail;
        if (isset($_POST['correo_enviar']) && isset($_POST['codigosenviar'])  ) {                                
           $result['message'] = 'Correo enviado correctamente'; 
        }
?>        
