<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
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
                <div class="input-field col s12 m8">
                    <i class="material-icons prefix">search</i>
                    <input id="search" type="text" name="search" placeholder="Buscar por Nombre, Apellido o DUI del Paciente" required/>
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
        <th>Nombre </th>
        <th>Apellido </th>
        <th>DUI </th>
        <th>Fecha Inicio</th>        
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

<div id="send-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-s-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="send-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_causaconsulta" name="id_causaconsulta" />
                    <div class="row">
                            <div class="col s12" id="charts">                                    
                                    <!-- <canvas id="chart1"></canvas> -->
                            </div>                        
                    </div>           
                </form>
            </div>            
        </div>
  	</div>
</div>


<div id="show-proced-modal" class="modal">
            <div class="modal-content center-align">
            <h4> </h4>                
                <h4 id="modal-proced-title" class="center-align"></h4>                
                <form method="post" id="show-a-form">                   
                    <input class="hide" type="number" id="id_tratamientos" name="id_tratamientos"/> 
                    <input class="hide" type="number" id="id_pacienteAs" name="id_pacienteAs"/>  
                    <input id="codigos" type="text" name="codigos"  class="hide" />                        
                    <div class="row">
                        <table class="responsive-table highlight">                           
                            <thead>
                                <tr>
                                    <th>Fecha Consulta</th>
                                    <th>Hora Consulta</th>                                    
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



<div id="save-modal-consultas" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-consultas" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-form-consultas">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_t" name="id_t"/>
                    <input class="hide" type="number" id="id_consulta" name="id_consulta"/>
                    <div class="row">                        
                    <div class="input-field col s12">
                            <i class="material-icons prefix">place</i>
                            <input type="text" id="notas_consulta" name="notas_consulta" maxlength="1000" class="validate" required/>
                            <label for="notas_consulta">Notas Consulta</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="nombre_paciente" type="text" name="nombre_paciente" class="validate"  required/>
                            <label for="nombre_paciente">Nombre Paciente</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">attach_money</i>
                            <input id="precio_consulta" type="number" name="precio_consulta" class="validate" max="999.99" min="0.01" step="any" required/>
                            <label for="precio_consulta">Precio</label>
                        </div>                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">cake</i>
                            <input id="fecha_consulta" type="date" name="fecha_consulta" class="validate"  required/>
                            <label for="fecha_consulta">Fecha Consulta</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">cake</i>
                            <input id="hora_consulta" type="time" name="hora_consulta" class="validate"  required/>
                            <label for="hora_consulta">Hora Consulta</label>
                        </div>
                        <div class="input-field col s6">
                            <select id="causa_consulta" name="causa_consulta">
                            </select>
                            <label>Causa Consulta</label>                            
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
<!-- Importación del archivo para generar gráficas en tiempo real. Para más información https://www.chartjs.org/ -->
    <script type="text/javascript" src="../resources/js/chart.js"></script>
<?php
// Se imprime la plantilla del pie enviando el nombre del controlador para la página web.
Dashboard_Page::footerTemplate('tratamiento.js');
?>
