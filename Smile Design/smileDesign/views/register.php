<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/loginPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Primer uso');
?>

<!-- Formulario para registrar al primer usuario del dashboard -->
<br>
<div class="container">
<form method="post" id="register-form">
    <div class="row">
        <div class="input-field col s12 m6">
          	<i class="material-icons prefix">person</i>
          	<input id="nombres" type="text" name="nombres" class="validate" required/>
          	<label for="nombres">Nombres</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">person</i>
            <input id="apellidos" type="text" name="apellidos" class="validate" required/>
            <label for="apellidos">Apellidos</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">email</i>
            <input id="correo" type="email" name="correo" class="validate" required/>
            <label for="correo">Correo</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">person_pin</i>
            <input id="alias" type="text" name="alias" class="validate" required/>
            <label for="alias">Alias</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">security</i>
            <input id="clave1" type="password" name="clave1" class="validate" required/>
            <label for="clave1">Clave</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">security</i>
            <input id="clave2" type="password" name="clave2" class="validate" required/>
            <label for="clave2">Confirmar clave</label>
        </div>
        <div class="input-field col s12 m6">
           <i class="material-icons prefix">location_on</i>
           <input id="txtDireccion" type="text" name="txtDireccion" class="validate" required/>
            <label for="txtDireccion">Direccion</label>
        </div>
        <div class="input-field col s12 m6">
            <i class="material-icons prefix">phone</i>
            <input id="txtTel" type="text" name="txtTel" class="validate" required/>
            <label for="txtTel">Telefono</label>
        </div>
    </div>
    <div class="row center-align">
 	    <button type="submit" class="loginbutton">Agregar Usuario</button>
    </div>
</form>
</div>

<?php
Dashboard_Page::footerTemplate('register.js');
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
?>