<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Usuarios');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de Usuarios </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">
        <a href="#save-modal" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Usuario</a>
        <a class="waves-effect waves-light btn-small" onclick="cargarDatos()"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
        <form method="post" id="search-form">
        <div class="input-field col s6 m4">
            <i class="material-icons prefix">search</i>
            <input id="search" type="text" name="search" required/>
            <label for="search">Buscador</label>
        </div>
        <div class="input-field col s6 m4">
            <button type="submit" class="btn waves-effect green tooltipped" data-tooltip="Buscar"><i class="material-icons">check_circle</i></button>
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
        <th>Nombre Usuario</th>      
        <th>Apellido Usuario</th>
        <th>Dirección Usuario</th>                   
        <th>Teléfono Usuario</th>
        <th>Correo Usuario</th>        
        <th>Estado</th>
        <th>Tipo</th> 
            <th class="actions-column">Acciones</th>
        </tr>
    </thead>
    <!-- Cuerpo de la tabla para mostrar un registro por fila -->
    <tbody id="tbody-rows">
    </tbody>
</table>
</div>

<div id="save-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_usuario" name="id_usuario"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="nombre_usuario" type="text" name="nombre_usuario" class="validate"  required/>
                            <label for="nombre_usuario">Nombre Usuario</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="apellido_usuario" type="text" name="apellido_usuario" class="validate"  required/>
                            <label for="apellido_usuario">Apellido Usuario</label>
                        </div>
                        <div class="input-field col s12">
                            <i class="material-icons prefix">place</i>
                            <input type="text" id="direccion_usuario" name="direccion_usuario" maxlength="200" class="validate" required/>
                            <label for="direccion_usuario">Dirección</label>
                        </div>                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">phone</i>
                            <input type="text" id="telefono_usuario" name="telefono_usuario" placeholder="0000-0000" pattern="[2,6,7]{1}[0-9]{3}[-][0-9]{4}" class="validate" required/>
                            <label for="telefono_usuario">Teléfono</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">email</i>
                            <input type="email" id="correo_usuario" name="correo_usuario" maxlength="100" class="validate" required/>
                            <label for="correo_usuario">Correo electrónico</label>
                        </div>
                        <div class="input-field col s12">
                            <i class="material-icons prefix">person</i>
                            <input type="text" id="alias_usuario" name="alias_usuario" maxlength="200" class="validate" required/>
                            <label for="alias_usuario">Alias</label>
                        </div> 
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">security</i>
                            <input type="password" id="clave_cliente" name="clave_cliente" class="validate" required/>
                            <label for="clave_cliente">Clave</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">security</i>
                            <input type="password" id="confirmar_clave" name="confirmar_clave" class="validate" required/>
                            <label for="confirmar_clave">Confirmar clave</label>
                        </div>                        
                        <div class="input-field col s12 m6">
                            <select id="estado_usuario" name="estado_usuario">
                            </select>
                            <label>Estado</label>                            
                        </div>
                        <div class="input-field col s12 m6">
                            <select id="tipo_usuario" name="tipo_usuario">
                            </select>
                            <label>Tipo</label>                            
                        </div>

                         <div>
                         <a href="#" class="btn waves-effect grey tooltipped modal-close" data-tooltip="Cancelar"><i class="material-icons center-align">cancel</i></a>
                        <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Guardar"><i class="material-icons center-align">save</i></button>                                
                        </div>
                    </div>           
                </form>
            </div>            
        </div>
  	</div>
</div>


</div>
</div>
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('empleados.js');
?>  
