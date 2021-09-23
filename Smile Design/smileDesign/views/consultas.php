<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Consultas');
?>
<div class="container">
    <div class="row">
        <h4 style="text-align:center;"> Gestion de Consultas </h4>
        <div class="section container">
            <div class="row card-panel" style="text-align:center;">
                <!-- <a href="#send-modal" onclick="openSendDialog()" class="waves-effect waves-light btn-small modal-trigger"><i class="material-icons left">publish</i>Generar Gráfico Consultas</a> -->
                <a class="waves-effect waves-light btn-small"><i class="material-icons left">rotate_left</i>Actualizar lista</a>

                <form method="post" id="search-form">
                    <div class="input-field col s12 m8">
                        <i class="material-icons prefix">search</i>
                        <input id="search" type="text" name="search" placeholder="Buscar por Nombre o Apellido del Paciente" required />
                        <label for="search">Buscador</label>
                    </div>
                    <div class="input-field col s6 m4">
                        <button type="submit" class="btn waves-effect green tooltipped" data-tooltip="Buscar"><i class="material-icons">check_circle</i></button>
                        <a href="../app/reports/consultaspaciente.php" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de consultas por paciente"><i class="material-icons">assignment</i></a>
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
                        <th>Fecha Consulta</th>
                        <th>Hora Consulta</th>
                        <th>Causa Consulta</th>
                        <th class="actions-column">Acciones</th>
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
                    <input class="hide" type="number" id="id_consultaP" name="id_consultaP" />
                    <input class="hide" type="number" id="id_pacienteAs" name="id_pacienteAs" />
                    <input id="notas_consultaP" type="text" name="notas_consultaP" class="hide" />
                    <div class="row">
                        <table class="responsive-table highlight">
                            <thead>
                                <tr>
                                    <th>Nombre Procedimiento</th>
                                    <th>Descripción Procedimiento</th>
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


    <div id="save-modal" class="modal">
        <div class="modal-content center-align">
            <h4></h4>
            <!-- Título para la caja de dialogo -->
            <h4 id="modal-title" class="center-align"></h4>
            <!-- Formulario para crear o actualizar un registro -->
            <form method="post" id="save-form">
                <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                <input class="hide" type="number" id="id_consulta" name="id_consulta" />
                <div class="row">
                    <div class="input-field col s12">
                        <i class="material-icons prefix">place</i>
                        <input type="text" id="notas_consulta" name="notas_consulta" maxlength="1000" class="validate" required />
                        <label for="notas_consulta">Notas Consulta</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <i class="material-icons prefix">attach_money</i>
                        <input id="precio_consulta" type="number" name="precio_consulta" class="validate" max="999.99" min="0.01" step="any" required />
                        <label for="precio_consulta">Precio</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <i class="material-icons prefix">cake</i>
                        <input id="fecha_consulta" type="date" name="fecha_consulta" class="validate" required />
                        <label for="fecha_consulta">Fecha Consulta</label>
                    </div>
                    <div class="input-field col s12 m6">
                        <i class="material-icons prefix">cake</i>
                        <input id="hora_consulta" type="time" name="hora_consulta" class="validate" required />
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

<div id="send-modal" class="modal">
    <div class="modal-content center-align">
        <h4></h4>
        <!-- Título para la caja de dialogo -->
        <h4 id="modal-s-title" class="center-align"></h4>
        <!-- Formulario para crear o actualizar un registro -->
        <form method="post" id="send-form">
            <!-- Campo oculto para asignar el id del registro al momento de modificar -->
            <!-- <input class="hide" type="number" id="id_causaconsulta" name="id_consulta"/> -->
            <div class="row">
                <div class="col s12 m6">
                    <input class="hide" type="number" id="id_causaconsulta" name="id_consulta" />
                    <canvas id="chart1"></canvas>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
</div>


<div id="save-procedimiento-modal" class="modal">
    <div class="modal-content center-align">
        <h4></h4>
        <!-- Título para la caja de dialogo -->
        <h4 id="modal-procedimiento-title" class="center-align"></h4>
        <!-- Formulario para crear o actualizar un registro -->
        <form method="post" id="save-procedimiento-form">
            <!-- Campo oculto para asignar el id del registro al momento de modificar -->
            <input class="hide" type="number" id="id_consultasP" name="id_consultasP" />
            <div class="row">
                <div class="input-field col s12 m6">
                    <i class="material-icons prefix">cake</i>
                    <input id="fecha_consultas" type="text" name="fecha_consultas" class="validate" required />
                </div>
                <div class="input-field col s6">
                    <select id="procedimiento" name="procedimiento">
                    </select>
                    <label>Procedimiento</label>
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

<div id="save-procedimientos-modal" class="modal">
    <div class="modal-content center-align">
        <h4></h4>
        <!-- Título para la caja de dialogo -->
        <h4 id="modal-procedimientos-title" class="center-align"></h4>
        <!-- Formulario para crear o actualizar un registro -->
        <form method="post" id="save-procedimientos-form">
            <!-- Campo oculto para asignar el id del registro al momento de modificar -->
            <input class="hide" type="number" id="id_consultasPr" name="id_consultasPr" />
            <div class="row">
                <div class="input-field col s12 m6">
                    <i class="material-icons prefix">cake</i>
                    <input id="fecha_consultasa" type="text" name="fecha_consultasa" class="validate" required />
                </div>
                <div class="input-field col s6">
                    <select id="procedimientos" name="procedimientos">
                    </select>
                    <label>Procedimiento</label>
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
Dashboard_Page::footerTemplate('consulta.js');
?>