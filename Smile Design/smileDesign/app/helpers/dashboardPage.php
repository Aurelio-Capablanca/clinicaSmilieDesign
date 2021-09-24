<?php
//Clase para definir las plantillas de las páginas web del sitio privado
class Dashboard_Page
{
    //Método para imprimir el encabezado y establecer el titulo del documento
    public static function headerTemplate($title)
    {
        session_start();
        print('
        <!DOCTYPE html>
            <html lang="es">
            <head>
                <!--Se establece la codificación de caracteres para el documento-->
                <meta charset="utf-8">
                <!--Se importa la fuente de iconos de Google-->
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                <!--Se importan los archivos CSS-->
                <link type="text/css" rel="stylesheet" href="../resources/css/materialize.min.css"/>
                <link type="text/css" rel="stylesheet" href="../resources/css/style.css" />
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                <!--Se informa al navegador que el sitio web está optimizado para dispositivos móviles-->
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <!--Título del documento-->
                <title>Smile Design - ' . $title . '</title>
            </head>
            <nav class="nav-extended blue-grey">
            <div class="nav-wrapper">
            <a href="#" data-target="slide-out" class="sidenav-trigger show-on-large">
            <i class="material-icons">menu</i>
            </a>  
            <ul class="left left hide-on-med-and-down">
               <li><a href="main.php"><i class="material-icons left">home</i>Home</a></li>
            </ul>                       
                <ul class="right right hide-on-med-and-down">
                    <li><a href="calendario.php"><i class="material-icons left">schedule</i>Agenda</a></li>
                    <li><a href="consultas.php"><i class="material-icons left">check</i>Consultas</a></li>
                    <!-- <li><a href="mantenimientos.php"><i class="material-icons left">desktop_mac</i>Mantenimientos</a></li> -->
                    <li><a href="pagos.php"><i class="material-icons left">assignment</i>Pagos</a></li>
                    <li><a href="procedimientos.php"><i class="material-icons left">health_and_safety</i>Procedimientos</a></li>
                    <li><a href="#" onclick="logOut()"><i class="material-icons left">highlight_off</i>Cerrar sesión</a></li>
                                                
                </ul>
            </div> 
            <div class="nav-content">
            <ul class="tabs tabs-transparent">
                <li class="tab"><a href="usuarioss.php">Usuarios</a></li>
                <li class="tab"><a href="expedientes.php">Expedientes</a></li>
                <li class="tab"><a href="doctores.php">Doctores</a></li>
                <li class="tab"><a href="pacientes.php">Pacientes</a></li>
                <li class="tab"><a href="tratamientos.php">Tratamientos</a></li>
                <li class="tab"><a href="causaConsulta.php">Causa Consultas</a></li>
                <li class="tab"><a href="especialidad.php">Especialidades</a></li>
            </ul>
            </div>
        </nav>
        <ul id="slide-out" class="sidenav">
                    <li>  
                        <div class="user-view">
                            <div class="background">
                                <img src="../resources/img/fonfo12.jpg"> 
                            </div>
                            <a href="#user"><img class="circle" src="../resources/img/SmileDesign.jfif"></a>
                            <a href="#name"><span class="white-text name">Usuario:<b> ' . $_SESSION['aliasusuario'] . '</b></span></a>
                            <br>                            
                            <br>
                        </div>                                         
                    <li>
                        <li><a href="#" onclick="openProfileDialog()"><i class="material-icons">face</i>Editar perfil</a></li>
                        <li><a href="#" onclick="openPasswordDialog()"><i class="material-icons">lock</i>Cambiar clave</a></li>
                        <div class="divider"></div>
                    </li>              
                        <li><a href="#"  onclick="logOut()"><i class="material-icons left">highlight_off</i>Cerrar sesión</a></li>                              
                        <li class="hide-on-large-only" ><a href="consultas.php"><i class="material-icons left">check</i>Consultas</a></li>
                       <!-- <li class="hide-on-large-only" ><a href="mantenimientos.php"><i class="material-icons left">desktop_mac</i>Mantenimientos</a></li> -->
                        <li class="hide-on-large-only" ><a href="pagos.php"><i class="material-icons left">assignment</i>Pagos</a></li>
                        <li class="hide-on-large-only" ><a href="procedimientos.php"><i class="material-icons left">health_and_safety</i>Procedimientos</a>
                </ul> 

                        <div id="profile-modal" class="modal">
                            <div class="modal-content center-align">
                            <h4></h4>
                                <!-- Título para la caja de dialogo -->
                                <h4 id="modal-title" class="center-align"></h4>
                                <!-- Formulario para crear o actualizar un registro -->
                                <form method="post" id="profile-form">
                                    <!-- Campo oculto para asignar el id del registro al momento de modificar -->
                                    <input class="hide" type="number" id="id_usuario" name="id_usuario"/>
                                    <div class="row">                        
                                        <div class="input-field col s12 m6">
                                            <i class="material-icons prefix">account_box</i>
                                            <input id="nombre_usuario" type="text" name="nombre_usuario" class="validate"  required/>
                                            <label for="nombre_usuario">Nombre Usuario</label>
                                        </div>
                                        <div class="input-field col s12 m6">
                                            <i class="material-icons prefix">account_box</i>
                                            <input id="apellido_usuario" type="text" name="apellido_usuario" class="validate"  required/>
                                            <label for="apellido_usuario">Apellido Usuario</label>
                                        </div>
                                        <div class="input-field col s12">
                                            <i class="material-icons prefix">place</i>
                                            <input type="text" id="direccion_usuario" name="direccion_usuario" maxlength="200" class="validate" required/>
                                            <label for="direccion_usuario">Dirección</label>
                                        </div>                                       
                                        <div class="input-field col s12 m6">
                                            <i class="material-icons prefix">email</i>
                                            <input type="email" id="correo_usuario" name="correo_usuario" maxlength="100" class="validate" required/>
                                            <label for="correo_usuario">Correo electrónico</label>
                                        </div>
                                        <div class="input-field col s12">
                                            <i class="material-icons prefix">person</i>
                                            <input type="text" id="alias_usuario" name="alias_usuario" maxlength="200" class="validate" required/>
                                            <label for="alias_usuario">Alias</label>
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


              <main>        
        ');
    }

    //Método para imprimir el pie y establecer el controlador del documento
    public static function footerTemplate($controller)
    {
        print('
                </main>
                <!--Pie del documento-->
                <footer class="page-footer blue-grey ">
                    <div class="container">
                        <div class="row">
                            <div class="col l6 s12">
                                <h5 class="white-text">Smile Design</h5>                               
                            </div>
                            <div class="col l4 offset-l2 s12">                                
                            </div>
                        </div>
                    </div>
                    <div class="footer-copyright">
                        <div class="container">
                            © 2021 Copyright                            
                        </div>
                    </div>
                </footer>
                <!--Importación de archivos JavaScript al final del cuerpo para una carga optimizada-->
                <script type="text/javascript" src="../resources/js/sweetalert.min.js"></script> 
                <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
                <script type="text/javascript" src="../app/helpers/components.js"></script>                
                <script type="text/javascript" src="../resources/js/materialize.min.js"></script>              
                <script src="../resources/js/init.js"></script>        
                <script type="text/javascript" src="../app/controllers/account.js"></script>        
                <script type="text/javascript" src="../app/controllers/' . $controller . '"></script>
            </body>
            </html>
        ');
    }
}
