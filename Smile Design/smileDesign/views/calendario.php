<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Agenda');
?>
<div class="container">
    <div class="row">
        <h4 style="text-align:center;"> Agenda </h4>
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
                    </div>

                </form>
            </div>
        </div>

        <div>
            <!-- Título del contenido principal -->
            <h4 class="center indigo-text" id="title"></h4>
            <!-- Fila para mostrar los productos disponibles por categoría -->
            <div class="row" id="consulta"></div>
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
                                    <th>Hora Consulta</th>
                                    <th>Nombre Procedimiento</th>
                                    <th>Descripción Procedimiento</th>
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


    <?php
    //Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
    Dashboard_Page::footerTemplate('agenda.js');
    ?>