<?php
//Se incluye la clase con las plantillas del documento
include('../../app/helpers/private/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Tratamientos');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de Tratamientos </h4>
    <div class="section container">
        
        <div class="row card-panel" style="text-align:center;">

            <a href="#" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Tratamiento</a>
            <a onclick="cargarDatos()" class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
        
        
            <form method="post" id="search-form">
                <div class="input-field col s6 m4">
                    <i class="material-icons prefix">search</i>
                    <input id="search" type="text" name="search" required/>
                    <label for="search">Buscador</label>
                </div>
                <div class="input-field col s6 m4">
                    <button type="submit" class="btn waves-effect green tooltipped" data-tooltip="Buscar por nombre apellido o dui"><i class="material-icons">check_circle</i></button>
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
        <th>Fecha Inicio</th>      
        <th>Descripción Tratamiento</th>                   
        <th>Nombre </th>
        <th>Apellido </th>
        <th>DUI </th>
        <th>Tipo</th>
        <th>Estado</th>
        <th class="actions-column">Acciones</th>
        </tr>
    </thead>
    <!-- Cuerpo de la tabla para mostrar un registro por fila -->
    <tbody id="tbody-rows">
    </tbody>
</table>
</div>

<!-- Componente Modal para mostrar una caja de dialogo -->
<div id="save-modal" class="modal">
    <div class="modal-content">
        <h4 id="modal-title" class="center-align"></h4>
        <form method="post" id="save-form" enctype="multipart/form-data">
            <!-- Campo oculto para asignar el id del registro al momento de modificar -->
            <input class="hide" type="number" id="txtId" name="txtId"/>
                    <div class="row">                        
                    <div class="input-field col s12 m6">
                            <i class="material-icons prefix">cake</i>
                            <input id="fecha_nacimiento" type="date" name="fecha_nacimiento" class="validate"  required/>
                            <label for="fecha_nacimiento">Fecha Nacimiento</label>
                        </div>    
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="descripcion" type="text" name="descripcion" class="validate"  required/>
                            <label for="descripcion">Descripción Tratamiento</label>
                        </div>
                        <div class="input-field col s6">
                            <select id="id_asignado" name="id_asignado">
                            </select>
                            <label>Paciente Asignado</label>                            
                        </div>
                        <div class="input-field col s6">
                            <select id="id_tipo" name="id_tipo">
                            </select>
                            <label>Tipo Tratamiento</label>                            
                        </div>
                        <div class="input-field col s6">
                            <select id="id_estado" name="id_estado">
                            </select>
                            <label>Estado Tratamiento</label>                            
                        </div>
                        <div>
                         <a href="#" class="btn waves-effect grey tooltipped modal-close" data-tooltip="Cancelar"><i class="material-icons center-align">cancel</i></a>
                        <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Guardar"><i class="material-icons center-align">save</i></button>                                
                        </div>
                    </div>           
        </form>
    </div>
</div>

<?php
// Se imprime la plantilla del pie enviando el nombre del controlador para la página web.
Dashboard_Page::footerTemplate('tratamiento.js');
?>
