<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Procedimientos');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de Procedimientos </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">
        <a href="#save-modal" onclick="openCreateDialog()"  class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Procedimiento</a>
        <a class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>        
        <form method="post" id="search-form">
        <div class="input-field col s12 m8">
            <i class="material-icons prefix">search</i>
            <input id="search" type="text" name="search" placeholder="Buscar por Nombre de Procedimiento" required/>
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
        <th>Nombre Procedimiento</th>      
        <th>Descripción Procedimiento</th>
        <th>Costo procedimiento</th>        
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
                            <div class="col s12 m6" id="charts">                                    
                                    <!-- <canvas id="chart1"></canvas> -->
                            </div>                        
                    </div>           
                </form>
            </div>            
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
                    <input class="hide" type="number" id="id_procedimiento" name="id_procedimiento"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">how_to_reg</i>
                            <input id="nombre_procedimiento" type="text" name="nombre_procedimiento" class="validate"  required/>
                            <label for="nombre_procedimiento">Nombre Procedimiento</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="descripcion" type="text" name="descripcion" class="validate"  required/>
                            <label for="descripcion">Descripción Procedimiento</label>
                        </div>                                                
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">attach_money</i>
                            <input id="precio_procedimiento" type="number" name="precio_procedimiento" class="validate" max="999.99" min="0.01" step="any" required/>
                            <label for="precio_procedimiento">Precio</label>
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

<!-- Importación del archivo para generar gráficas en tiempo real. Para más información https://www.chartjs.org/ -->
    <script type="text/javascript" src="../resources/js/chart.js"></script>

<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('procedimientos.js');
?>  
