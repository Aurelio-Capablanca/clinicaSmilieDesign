<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web 
Dashboard_Page::headerTemplate('Agenda');
?> 

<div class="container">
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
                    <input class="hide" type="number" id="id_consultaP" name="id_consultaP"/> 
                    <input class="hide" type="number" id="id_pacienteAs" name="id_pacienteAs"/>  
                    <input id="notas_consultaP" type="text" name="notas_consultaP"  class="hide" />                        
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