<?php
//Se incluye la clase con las plantillas del documento
include('../../app/helpers/private/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Pagos');
?> 
<div class="container">
  <div class="row">
     <h4 style="text-align:center;"> Gestion de Pagos </h4>
    <div class="section container">
        <div class="row card-panel" style="text-align:center;">        
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
        <th>Fecha Inicio</th>        
        <th>Pago Debe</th>
        <th>Pago Abono</th>
        <th>Pago Total</th>            
        <th>Pago Saldo</th>
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


<div id="show-cuenta-modal" class="modal">
            <div class="modal-content center-align">
            <h4> </h4>                
                <h4 id="modal-cuenta-title" class="center-align"></h4>                
                <form method="post" id="show-a-form">                   
                    <input class="" type="number" id="id_pagoSD" name="id_pagoSD"/>                     
                    <div class="row">
                        <table class="responsive-table highlight">                           
                            <thead>
                                <tr>
                                    <th>Hora Consulta</th>
                                    <th>Nombre Procedimiento</th>                                    
                                    <th>Descripción Procedimiento</th>                                    
                                    <th class="actions-column">Acciones</th>                                  
                                </tr>
                            </thead>                            
                            <tbody id="count-rows">
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
                    <input class="" type="number" id="id_pagoT" name="id_pagoT"/>
                    <div class="row">
                        <div class="input-field col s6">
                            <select id="tipo" name="tipo">
                            </select>
                            <label>Tipo Pago</label>                            
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

<div id="save-modalE" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-titleE" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-formE">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="" type="number" id="id_pagoE" name="id_pagoE"/>
                    <div class="row">
                        <div class="input-field col s6">
                            <select id="estado" name="estado">
                            </select>
                            <label>Estado Pago</label>                            
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

<div id="save-Cuenta-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-c" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-Cuenta-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="" type="number" id="id_pagos" name="id_pagos"/>
                    <input class="" id="nombres" type="text" name="nombres" />
                    <div>
                    <a href="#" class="btn waves-effect grey tooltipped modal-close" data-tooltip="Cancelar"><i class="material-icons center-align">cancel</i></a>
                    <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Guardar"><i class="material-icons center-align">save</i></button>
                        </div>
                    </div>
                </form>
            </div>    
        </div>

<div id="save-Saldo-modal" class="modal">
     <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-S" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-Saldo-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_pago" name="id_pago"/>
                    <input class="" id="nombress" type="text" name="nombress" />
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">attach_money</i>
                            <input id="pago_abono" type="number" name="pago_abono" class="validate" max="9999.99" min="0.01" step="any" required/>
                            <label for="pago_abono">Cantidad</label>
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
Dashboard_Page::footerTemplate('pagos.js');
?>  