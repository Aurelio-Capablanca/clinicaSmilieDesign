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
        <div class="input-field col s12 m8">
            <i class="material-icons prefix">search</i>
            <input id="search" type="text" name="search" placeholder="Buscar por Nombre, Apellido o DUI del Paciente" required/>
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
                            <tbody id="pregunta-rows">
                            </tbody>
                        </table>
                    <div class="row center-align">                    
                    </div>           
                </form>
            </div>            
        </div>
    </div>


<div id="show-asignado-modal" class="modal">
            <div class="modal-content center-align">
            <h4> </h4>                
                <h4 id="modal-asignado-title" class="center-align"></h4>                
                <form method="post" id="show-a-form">                   
                    <input class="hide" type="number" id="id_pacienteA" name="id_pacienteA"/> 
                    <input class="hide" type="number" id="id_pacienteAs" name="id_pacienteAs"/>  
                    <input id="nombre_pacienteA" type="text" name="nombre_pacienteA"  class="hide" />                        
                    <div class="row">
                        <table class="responsive-table highlight">                           
                            <thead>
                                <tr>
                                    <th>Nombre Doctor</th>
                                    <th>Apellido Doctor</th>
                                    <th class="actions-column">Acciones</th>                                  
                                </tr>
                            </thead>                            
                            <tbody id="asignado-rows">
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
                        <div class="input-field col s12">
                            <i class="material-icons prefix">place</i>
                            <input type="text" id="direccion_paciente" name="direccion_paciente" maxlength="200" class="validate" required/>
                            <label for="direccion_paciente">Dirección</label>
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
                        <div class="file-field input-field col s12 m6">
                        <div class="btn waves-effect tooltipped" data-tooltip="Seleccione una imagen de al menos 500x500">
                            <span><i class="material-icons">image</i></span>
                            <input id="archivo_paciente" type="file" name="archivo_paciente" accept=".gif, .jpg, .png"/>
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


<div id="save-asignado-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-a" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-asignado-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_pacientesD" name="id_pacientesD"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="nombre_pacientesA" type="text" name="nombre_pacientesA" class="validate"  required/>
                            <label for="nombre_pacientesA">Nombre Paciente</label>
                        </div>                        
                        <div class="input-field col s6">
                            <select id="nombre_doctor" name="nombre_doctor">
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
<div id="save-asignados-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-as" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-asignados-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_pacientesDA" name="id_pacientesDA"/>
                    <div class="row">                        
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">person</i>
                            <input id="nombre_pacientesAg" type="text" name="nombre_pacientesAg" class="validate"  required/>
                            <label for="nombre_pacientesAg">Nombre Paciente</label>
                        </div>                        
                        <div class="input-field col s6">
                            <select id="nombre_doctores" name="nombre_doctores">
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

<div id="save-preguntas-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-title-pr" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="save-preguntas-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_pacientesP" name="id_pacientesP"/>
                    <div class="row">
                    <div class="input-field col s6 left">
                            <select id="pregunta1" name="pregunta1">
                            </select>
                            <label>Pregunta #1</label>
                         </div>
                        <div class="input-field col s6"> 
                        <label>                      
                            <input type="checkbox" id="s1"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n1"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta1" name="respuesta1"/>

                        <div class="input-field col s6">
                            <select id="pregunta2" name="pregunta2">
                            </select>
                            <label>Pregunta #2</label>
                        </div>
                        <div class="input-field col s6">                                             
                        <label>                      
                            <input type="checkbox" id="s2"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n2" />
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta2" name="respuesta2"/>

                        <div class="input-field col s6 ">
                            <select id="pregunta3" name="pregunta3">
                            </select>
                            <label>Pregunta #3</label>
                        </div> 
                        <div class="input-field col s6">                          
                        <label>                      
                            <input type="checkbox" id="s3"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n3" />
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta3" name="respuesta3"/>
                                                                
                        <div class="input-field col s6">
                            <select id="pregunta4" name="pregunta4">
                            </select>
                            <label>Pregunta #4</label>
                         </div>
                         <div class="input-field col s6">   
                         <label>                                                 
                            <input type="checkbox" id="s4"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n4"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta4" name="respuesta4"/>

                         <div class="input-field col s6">
                            <select id="pregunta5" name="pregunta5">
                            </select>
                            <label>Pregunta #5</label>
                         </div>  
                         <div class="input-field col s6">                          
                         <label>                      
                            <input type="checkbox" id="s5"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n5"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta5" name="respuesta5"/>
                        
                        <div class="input-field col s6">
                            <select id="pregunta6" name="pregunta6">
                            </select>
                            <label>Pregunta #6</label>
                        </div>
                        <div class="input-field col s6">                           
                        <label>                      
                            <input type="checkbox" id="s6"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n6"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta6" name="respuesta6"/>

                        <div class="input-field col s6">
                            <select id="pregunta7" name="pregunta7">
                            </select>
                            <label>Pregunta #7</label>
                        </div>
                        <div class="input-field col s6">                           
                        <label>                      
                            <input type="checkbox" id="s7"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n7"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta7" name="respuesta7"/>
                       
                        <div class="input-field col s6 ">
                            <select id="pregunta8" name="pregunta8">
                            </select>
                            <label>Pregunta #8</label>                                           
                        </div>
                        <div class="input-field col s6">                          
                        <label>                      
                            <input type="checkbox" id="s8"/>
                            <span>Si</span>   
                        </label>                         
                       </div>
                       <div class="input-field col s6">                       
                       <label>
                            <input type="checkbox" id="n8"/>
                            <span>No</span>
                        </label>                            
                       </div>
                       <input class="" type="text" id="respuesta8" name="respuesta8"/>
                       
                       <div class="input-field col s12">
                            <i class="material-icons prefix">sticky_note_2</i>
                            <input type="text" id="notas" name="notas" maxlength="2100" class="validate" required/>
                            <label for="notas">Notas</label>
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

<div id="send-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-s-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="send-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_pacientetratamiento" name="id_pacientetratamiento" />
                    <div class="row">
                            <div class="col s12 m6">                                    
                                    <canvas id="chart1"></canvas>
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
<script type="text/javascript" src="../../resources/js/chart.js"></script>
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('paciente.js');
?>  
