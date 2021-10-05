<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/loginPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Login');
?>   
<br>
<div class="container">
    <div class="row">
        <!-- Formulario para iniciar sesión -->
        <form method="post" id="session-form">
        <input id="ipdata" type="text" name="ipdata" class="hide" />        
        <input id="region" type="text" name="region" class="hide" />
        <input id="zona" type="text" name="zona" class="hide" />
        <input id="distribuidor" type="text" name="distribuidor" class="hide" />
        <input id="codigovalidar" type="text" name="codigovalidar" class="hide" />
        <input id="contador" type="text" name="contador" class="hide"/>
        <input id="pais" type="text" name="pais" class="hide" />
        <input id="dias" type="text" name="dias" class="hide" />

            <div class="input-field col s12 m6 offset-m3">
                <i class="material-icons prefix">person_pin</i>
                <input id="usuario" type="text" name="usuario" class="validate" required/>
                <label for="usuario">Alias</label>
            </div>
            <div class="input-field col s12 m6 offset-m3">
                <i class="material-icons prefix">security</i>
                <input id="clave" type="password" name="clave" class="validate" required/>
                <label for="clave">Clave</label>
            </div>
            <div class="col s12 center-align">
                <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Ingresar"><i class="material-icons">send</i></button>
                <br>
                <a href="restaurarcontraseña.php" >Restaurar Contraseña</a>
            </div>
        </form>  
    </div>
</div>

<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('index.js');
?>