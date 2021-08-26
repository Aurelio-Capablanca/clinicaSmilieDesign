<?php
//Se incluye la clase con las plantillas del documento
include('../../app/helpers/private/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Home');
?>                                 

<!--Contenedor para mostrar una tabla con datos-->
<div class="container center-align">
<p style="color: red; font-size:40px">¡Bienvenid@!</p>
<img  width="250" src="../../resources/img/SmileDesign.jfif">
</div>

<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('init.js');
?>