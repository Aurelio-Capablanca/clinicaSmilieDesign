<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Historial de Sesiones');
?> 
<div class="container">
<div class="row">
<div class="row">
     <h4 style="text-align:center;"> Historial de Sesiones </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">
        <!-- <a href="#" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Expediente</a> -->
        <a onclick="cargarDatos()" class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
            <form method="post" id="search-form">
                <div class="input-field col s12 m8">
                    <i class="material-icons prefix">search</i>
                    <input id="search" type="text" name="search" placeholder="Buscar por Nombre del Empleado" required/>
                    <label for="search">Buscador</label>
                </div>
                <div class="input-field col s6 m4">
                    <button type="submit" class="btn waves-effect green tooltipped" data-tooltip="Buscar por nombre o apellido del paciente"><i class="material-icons">check_circle</i></button>
                </div>
            </form>
        </div>
    </div>
<br>
<div class="col s12 m12 12">
 <table class="responsive-table highlight">
    <!-- Cabeza de la tabla para mostrar los títulos de las columnas -->
    <thead>
        <tr>
        <th>IP</th>      
        <th>Usuario</th>                 
        <th>Region</th>
        <th>Zona Horaria</th>
        <th>Distribuidor de Red</th>
        <th>Pais</th>
        </tr>
    </thead>
    <!-- Cuerpo de la tabla para mostrar un registro por fila -->
    <tbody id="tbody-rows">
    </tbody>
</table>
</div>

</div>
</div>
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('historial.js');
?>  