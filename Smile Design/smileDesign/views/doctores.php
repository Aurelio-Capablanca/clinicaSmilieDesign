<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Doctores');
?>
<div class="container">
    <div class="row">
        <h4 style="text-align:center;"> Gestion de Doctores </h4>
        <div class="section container">
            <div class="row card-panel" style="text-align:center;">
                <a href="#save-modal" onclick="openCreateDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Ingresar Doctor</a>
                <a class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>
                <form method="post" id="search-form">
                    <div class="input-field col s6 m4">
                        <i class="material-icons prefix">search</i>
                        <input id="search" type="text" name="search" required />
                        <label for="search">Buscador</label>
                    </div>
                    <div class="input-field col s6 m4">
                        <button type="submit" class="btn waves-effect green tooltipped" data-tooltip="Buscar"><i class="material-icons">check_circle</i></button>
                        <a href="../app/reports/doctores.php" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de doctores por estado"><i class="material-icons">assignment</i></a>
                        <a href="../app/reports/todasespecialidades.php" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de doctores por especialidad"><i class="material-icons">assignment</i></a>
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
                        <th>Foto</th>
                        <th>Nombre Doctor</th>
                        <th>Apellido Doctor</th>
                        <th>Dirección Doctor</th>
                        <th>Teléfono Doctor</th>
                        <th>Correo Doctor</th>
                        <th>Estado</th>
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
                    <input class="hide" type="number" id="id_doctor" name="id_doctor" />
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="nombre_doctor" type="text" name="nombre_doctor" class="validate" required />
                            <label for="nombre_doctor">Nombre Doctor</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_box</i>
                            <input id="apellido_doctor" type="text" name="apellido_doctor" class="validate" required />
                            <label for="apellido_doctor">Apellido Doctor</label>
                        </div>
                        <div class="input-field col s12">
                            <i class="material-icons prefix">place</i>
                            <input type="text" id="direccion_doctor" name="direccion_doctor" maxlength="200" class="validate" required />
                            <label for="direccion_doctor">Dirección</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">phone</i>
                            <input type="text" id="telefono_doctor" name="telefono_doctor" placeholder="0000-0000" pattern="[2,6,7]{1}[0-9]{3}[-][0-9]{4}" class="validate" required />
                            <label for="telefono_doctor">Teléfono</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">email</i>
                            <input type="email" id="correo_doctor" name="correo_doctor" maxlength="100" class="validate" required />
                            <label for="correo_doctor">Correo electrónico</label>
                        </div>

                        <div class="input-field col s12 left">
                            <i class="material-icons prefix">person</i>
                            <input type="text" id="alias_doctor" name="alias_doctor" maxlength="200" class="validate" required />
                            <label for="alias_doctor">Alias</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">security</i>
                            <input type="password" id="clave_doctor" name="clave_doctor" class="validate" required />
                            <label for="clave_doctor">Clave</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">security</i>
                            <input type="password" id="confirmar_doctor" name="confirmar_doctor" class="validate" required />
                            <label for="confirmar_doctor">Confirmar clave</label>
                        </div>
                        <div class="input-field col s6">
                            <select id="estado_doctor" name="estado_doctor">
                            </select>
                            <label>Estado</label>
                        </div>
                        <div class="file-field input-field col s12 m6">
                            <div class="btn waves-effect tooltipped" data-tooltip="Seleccione una imagen de al menos 500x500">
                                <span><i class="material-icons">image</i></span>
                                <input id="foto_doctor" type="file" name="foto_doctor" accept=".gif, .jpg, .png" />
                            </div>
                            <div class="file-path-wrapper">
                                <input type="text" class="file-path validate" placeholder="Formatos aceptados: gif, jpg y png" />
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

<!-- <div id="save-especialidad-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4> -->
<!-- Título para la caja de dialogo -->
<!-- <h4 id="modal-especialidad-title" class="center-align"></h4> -->
<!-- Formulario para crear o actualizar un registro -->
<!-- <form method="post" id="save-especialidad-form"> -->
<!-- Campo oculto para asignar el id del registro al momento de modificar -->
<!-- <input class="hide" type="number" id="id_doctorE" name="id_doctorE"/>
                    <input class="hide" type="number" id="id_especialidaddoctor" name="id_especialidaddoctor"/>
                    <input  class="hide" id="nombre_doctorE" type="text" name="nombre_doctorE" class="validate"/>
                    <div class="row">                                                
                        <div class="input-field col s6">
                            <select id="especialidad" name="especialidad">
                            </select>
                            <label>Especialidad</label>                            
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
</div> -->

<div id="send-modal" class="modal">
            <div class="modal-content center-align">
            <h4></h4>
                <!-- Título para la caja de dialogo -->
                <h4 id="modal-s-title" class="center-align"></h4>
                <!-- Formulario para crear o actualizar un registro -->
                <form method="post" id="send-form">
                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                    <input class="hide" type="number" id="id_doctorestr" name="id_doctorestr" />
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

<!-- Importación del archivo para generar gráficas en tiempo real. Para más información https://www.chartjs.org/ -->
    <script type="text/javascript" src="../resources/js/chart.js"></script>
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('doctores.js');
?>