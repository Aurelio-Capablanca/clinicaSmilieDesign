<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Expedientes');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de Expedientes </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">
        <a href="#" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Expediente</a>
        <a onclick="cargarDatos()" class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
            <form method="post" id="search-form">
                <div class="input-field col s12 m8">
                    <i class="material-icons prefix">search</i>
                    <input id="search" type="text" name="search" placeholder="Buscar por Nombre o Apellido del Paciente" required/>
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
        <th>Odontograma</th>      
        <th>Periodontograma</th>                 
        <th>Nombre Paciente</th>
        <th>Apellido Paciente</th>
        <th>Acciones</th>
        </tr>
    </thead>
    <!-- Cuerpo de la tabla para mostrar un registro por fila -->
    <tbody id="tbody-rows">
    </tbody>
</table>
</div>

<div id="show-proced-modal" class="modal">
            <div class="modal-content center-align">
            <h4> </h4>                
                <h4 id="modal-proced-title" class="center-align"></h4>                
                <form method="post" id="show-a-form">                   
                    <input class="hide" type="number" id="id_expedientes" name="id_consultaP"/> 
                    <input class="hide" type="number" id="id_pacienteAs" name="id_pacienteAs"/>  
                    <input id="odontogrma" type="text" name="odontogrma"  class="hide" />                        
                    <div class="row">
                        <table class="responsive-table highlight">                           
                            <thead>
                                <tr>
                                    <th>Numero de Archivo</th>
                                    <th class="actions-column">Acciones</th>                                  
                                </tr>
                            </thead>                            
                            <tbody id="proced-rows">
                            </tbody>
                        </table>
                    <div class="row center-align">                    
                    </div>           
                </form>
            </div>            
        </div>
    </div>

<!-- Componente Modal para mostrar una caja de dialogo -->
<div id="save-modal" class="modal">
    <div class="modal-content">
    <h4 id="modal-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="txtId" name="txtId"/>
                    <div class="row">                        
                        <!-- <div class="input-field col s12 m6">
                            <i class="material-icons prefix">how_to_reg</i>
                            <input id="notas_medicas" type="text" name="notas_medicas" class="validate"  required/>
                            <label for="notas_medicas">Notas Médicas</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="observaciones" type="text" name="observaciones" class="validate"  required/>
                            <label for="observaciones">Observaciones periodontograma</label>
                        </div>                                                 -->
                                                
                        <div class="input-field col s6">
                            <select id="ide_paciente" name="ide_paciente">
                            </select>
                            <label>Paciente</label>                            
                        </div>                         
                        <div class="file-field input-field col s12 m6">
                        <div class="btn waves-effect tooltipped" data-tooltip="Seleccione una imagen de al menos 500x500">
                            <span><i class="material-icons">image</i></span>
                            <input id="odontograma" type="file" name="odontograma" accept=".gif, .jpg, .png"/>
                        </div>
                        <div class="file-path-wrapper">
                            <input type="text" class="file-path validate" placeholder="Formatos aceptados: gif, jpg y png"/>
                        </div class="left">

                        <div class="file-field input-field col s12 ">
                        <div class="btn waves-effect tooltipped" data-tooltip="Seleccione una imagen de al menos 500x500">
                            <span><i class="material-icons">image</i></span>
                            <input id="periodontograma" type="file" name="periodontograma" accept=".gif, .jpg, .png"/>
                        </div>
                        <div class="file-path-wrapper">
                            <input type="text" class="file-path validate" placeholder="Formatos aceptados: gif, jpg y png"/>
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

<div id="save-archivo-modal" class="modal">
    <div class="modal-content">
    <h4 id="modal-a-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-archivo-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="idArchivoT" name="idArchivoT"/>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">how_to_reg</i>
                            <input id="notas_medicas" type="text" name="notas_medicas" class="validate"  required/>
                            <label for="notas_medicas">Notas Médicas</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="observaciones" type="text" name="observaciones" class="validate"  required/>
                            <label for="observaciones">Observaciones periodontograma</label>
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

<div id="up-archivo-modal" class="modal">
    <div class="modal-content">
    <h4 id="modal-at-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="up-archivo-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="idArchivoTr" name="idArchivoTr"/>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">how_to_reg</i>
                            <textarea  id="notas_medicass" cols="30" rows="10" type="text" name="notas_medicass" class="validate"  required></textarea>
                            <label for="notas_medicass">Notas Médicas</label>
                        </div>
                        <div class="col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <textarea id="observacioness" type="text" cols="30" rows="10" name="observacioness" class="validate"  required></textarea>
                            <label for="observacioness">Observaciones periodontograma</label>
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
Dashboard_Page::footerTemplate('expedientes.js');
?>  
