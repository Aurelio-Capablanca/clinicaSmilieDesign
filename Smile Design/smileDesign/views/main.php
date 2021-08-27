<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Home');
?>                   

<!-- Se muestra un saludo de acuerdo con la hora del cliente -->
<div class="row">
    <h4 class="center-align blue-text" id="greeting"></h4>
</div>

<!-- Se agrega un elemento de reloj analógico como un decorativo -->
<!-- <table>
     <tr><td style="text-align: center;"><canvas id="canvas_tt6121668f69210" width="175" height="175"></canvas></td></tr>
     <tr><td style="text-align: center; font-weight: bold"><a href="//24timezones.com/San-Salvador/hora" style="text-decoration: none" class="clock24" 
            id="tz24-1629578895-c1228-eyJzaXplIjoiMTc1IiwiYmdjb2xvciI6IjAwOTlGRiIsImxhbmciOiJlcyIsInR5cGUiOiJhIiwiY2FudmFzX2lkIjoiY2FudmFzX3R0NjEyMTY2OGY2OTIxMCJ9" title="hora San Salvador" target="_blank">Hora actual en San Salvador</a></td></tr>
</table> -->

<!--Contenedor para mostrar una tabla con datos-->
<div class="container center-align">
<p style="color: red; font-size:40px">¡Bienvenid@!</p>
<img  width="250" src="../resources/img/SmileDesign.jfif">
</div>
<br>
<!-- Se muestran las gráficas de acuerdo con algunos datos disponibles en la base de datos -->
<div class="row">

    <div class="col s12 m6">
        <!-- Se muestra una gráfica de barra con la cantidad de productos por categoría -->
        <canvas id="chart1"></canvas>
    </div>

    <div class="col s12 m6">
        <!-- Se muestra una gráfica de pastel con el porcentaje de productos por categoría -->
        <canvas id="chart2"></canvas>
    </div>
</div>    


<div class="row">    

    <div class="col s12 m6">
        <!-- Se muestra una gráfica de barra con la cantidad de productos por categoría -->
        <canvas id="chart3"></canvas>
    </div>

    <div class="col s12 m6">
        <!-- Se muestra una gráfica de pastel con el porcentaje de productos por categoría -->
        <canvas id="chart4"></canvas>
    </div>


</div>

<script type="text/javascript" src="../resources/js/chart.js"></script>
<!-- <script type="text/javascript" src="//w.24timezones.com/l.js" async></script> -->
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('principal.js');
?>