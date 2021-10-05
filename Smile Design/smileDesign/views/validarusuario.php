<?php
//Se incluye la clase con las plantillas del documento
include('../app/helpers/loginPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Verificación de codigo');
?>   
<div class="container">
        <div class="row justify-content-md-center" style="margin-top:15%">
                <h3>Verificar Cuenta</h3>
                <form id="confirmacion-form" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="c" class="form-label">Código de Verificación</label>
                    <input type="text" class="form-control " placeholder="" aria-label="codigo" aria-describedby="basic-addon1" id="codigoos" type="text" name="codigoos" class="validate" onpaste="return true" required autocomplete="off">                    
                </div>
                <button type="submit" class="btn btn-primary">Verificar</button>
            </form>
        </div>
</div>
<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('confirmarcodigo.js');
?>