<?php
//Se incluye la clase con las plantillas del documento
include('../../app/helpers/private/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Pacientes');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de pacientes </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">
        <a href="#save-modal" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Paciente</a>
        <a class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
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
        <th>Nombre Paciente</th>      
        <th>Apellido Paciente</th>
        <th>Fecha Nacimiento</th>            
        <th>DUI</th>
        <th>Teléfono Paciente</th>
        <th>Correo Paciente</th>
        <th>Estado</th>
            <th class="actions-column">Acciones</th>
        </tr>
    </thead>
    <!-- Cuerpo de la tabla para mostrar un registro por fila -->
    <tbody id="tbody-rows">
    </tbody>
</table>
</div>

<div id="show-pregunta-modal" class="modal">
            <div class="modal-content center-align">
            <h4> </h4>                
                <h4 id="modal-pregunta-title" class="center-align"></h4>                
                <form method="post" id="show-form">                   
                    <input class="hide" type="number" id="id_pacienteS" name="id_pacienteS"/> 
                    <input class="hide" type="number" id="id_pacienteC" name="id_pacienteC"/>  
                    <input id="nombre_pacienteS" type="text" name="nombre_pacienteS"  class="hide" />                        
                    <div class="row">
                        <table class="responsive-table highlight">                           
                            <thead>
                                <tr>
                                    <th>Pregunta</th>                                          
                                    <th class="actions-column">Acciones</th>                                  
                                </tr>
                            </thead>                            
                            <tbody id="Shipper-rows">
                            </tbody>
                        </table>
                    <div class="row center-align">                    
                    </div>           
                </form>
            </div>            
        </div>
        </div>

<div id="save-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_paciente" name="id_paciente"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="nombre_paciente" type="text" name="nombre_paciente" class="validate"  required/>
                            <label for="nombre_paciente">Nombre Paciente</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="apellido_paciente" type="text" name="apellido_paciente" class="validate"  required/>
                            <label for="apellido_paciente">Apellido Paciente</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">cake</i>
                            <input id="fecha_nacimiento" type="date" name="fecha_nacimiento" class="validate"  required/>
                            <label for="fecha_nacimiento">Fecha Nacimiento</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">how_to_reg</i>
                            <input type="text" id="dui_paciente" name="dui_paciente" placeholder="00000000-0" pattern="[0-9]{8}[-][0-9]{1}" class="validate" required/>
                            <label for="dui_paciente">DUI</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">phone</i>
                            <input type="text" id="telefono_paciente" name="telefono_paciente" placeholder="0000-0000" pattern="[2,6,7]{1}[0-9]{3}[-][0-9]{4}" class="validate" required/>
                            <label for="telefono_paciente">Teléfono</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">email</i>
                            <input type="email" id="correo_cliente" name="correo_cliente" maxlength="100" class="validate" required/>
                            <label for="correo_cliente">Correo electrónico</label>
                        </div>
                        <div class="input-field col s6">
                            <select id="estado_paciente" name="estado_paciente">
                            </select>
                            <label>Estado</label>                            
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

<div id="save-proveedor-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-P" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-proveedor-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_productoP" name="id_productoP"/>
                    <div class="row"> 
                    <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_bag</i>
                            <input id="nombre_productoa" type="text" name="nombre_productoa" class="Disabled"/>
                            <label for="nombre_productoa">Nombre Producto</label>
                        </div>                                               
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_basket</i>
                            <input id="cantidad_productos" type="number" name="cantidad_productos" class="validate" max="999" min="1" step="any" required/>
                            <label for="cantidad_productos">Cantidad</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">attach_money</i>
                            <input id="precio_productos" type="number" name="precio_productos" class="validate" max="999.99" min="0.01" step="any" required/>
                            <label for="precio_productos">Precio</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_basket</i>
                            <input id="existencia_productos" type="number" name="existencia_productos" class="validate" max="999" min="1" step="any"  required/>
                            <label for="existencia_productos">Existencias</label>
                        </div>                                                                   
                         <div class="input-field col s6 right">
                            <select id="proveedor_productos" name="proveedor_productos">
                            </select>
                            <label>Proveedor</label>
                         </div>
                         <div class="input-field col s6 right">
                            <select id="pais_productos" name="pais_productos">
                            </select>
                            <label>País</label>                           
                         </div> 
                         <div class="input-field col s6">
                            <select id="estado_prodcuto" name="estado_prodcuto">
                            </select>
                            <label>Estado</label>                            
                         </div>
                         <div class="input-field col s6 right">
                            <select id="tipo_producto" name="tipo_producto">
                            </select>
                            <label>Tipo</label>
                         </div>                
                         <div class="file-field input-field col s12 m6">
                        <div class="btn waves-effect tooltipped" data-tooltip="Seleccione una imagen de al menos 500x500">
                            <span><i class="material-icons">image</i></span>
                            <input id="archivo_producto" type="file" name="archivo_producto" accept=".gif, .jpg, .png"/>
                        </div>
                        <div class="file-path-wrapper">
                            <input type="text" class="file-path validate" placeholder="Formatos aceptados: gif, jpg y png"/>
                        </div class="left">
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

<div id="update-proveedor-modal" class="col s12 m6 modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-P" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro --> 
                <form method="post" id="update-proveedor-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar --> 
                    <input class="hide" type="number" id="id_productosP" name="id_productosP"/>
                    <div class="row"> 
                    <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_bag</i>
                            <input id="nombre_productosa" type="text" name="nombre_productosa" class="Disabled"/>
                            <label for="nombre_productosa">Nombre Producto</label>
                        </div>                                               
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_basket</i>
                            <input id="cantidad_productosa" type="number" name="cantidad_productosa" class="validate" max="999" min="1" step="any" required/>
                            <label for="cantidad_productosa">Cantidad</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">attach_money</i>
                            <input id="precio_productosa" type="number" name="precio_productosa" class="validate" max="999.99" min="0.01" step="any" required/>
                            <label for="precio_productosa">Precio</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">shopping_basket</i>
                            <input id="existencia_productosa" type="number" name="existencia_productosa" class="validate" max="999" min="1" step="any"  required/>
                            <label for="existencia_productosa">Existencias</label>
                        </div>                                                                   
                         <div class="input-field col s6 right">
                            <select id="proveedor_productosa" name="proveedor_productosa">
                            </select>
                            <label>Proveedor</label>
                         </div>
                         <div class="input-field col s6 right">
                            <select id="pais_productosa" name="pais_productosa">
                            </select>
                            <label>País</label>                           
                         </div> 
                         <div class="input-field col s6">
                            <select id="estado_prodcutoa" name="estado_prodcutoa">
                            </select>
                            <label>Estado</label>                            
                         </div>
                         <div class="input-field col s6 right">
                            <select id="tipo_productosa" name="tipo_productosa">
                            </select>
                            <label>Tipo</label>
                         </div>                       
                         <a href="#" class="btn waves-effect grey tooltipped modal-close" data-tooltip="Cancelar"><i class="material-icons center-align">cancel</i></a>
                        <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Guardar"><i class="material-icons center-align">save</i></button>                                
                        </div>
                    </div>           
                </form>
            </div>            
        </div>
  	</div>
</div>

<div id="save-asignado-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-asignado-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_producto" name="id_producto"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="nombre_pacienteA" type="text" name="nombre_pacienteA" class="validate"  required/>
                            <label for="nombre_pacienteA">Nombre Paciente</label>
                        </div>                        
                        <div class="input-field col s6">
                            <select id="doctor" name="doctor">
                            </select>
                            <label>Doctor</label>                            
                         </div>
                      
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
Dashboard_Page::footerTemplate('paciente.js');
?>  