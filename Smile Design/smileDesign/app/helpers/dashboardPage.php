<?php
//Clase para definir las plantillas de las páginas web del sitio privado
class Dashboard_Page
{
    //Método para imprimir el encabezado y establecer el titulo del documento
    public static function headerTemplate($title)
    {
        // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en las páginas web.
        session_start();
        // Se imprime el código HTML de la cabecera del documento.
        print('
            <!DOCTYPE html>
            <html lang="es">
                <head>
                    <meta charset="utf-8">
                    <title>Dashboard - ' . $title . '</title>
                    <!--Se importa la fuente de iconos de Google-->
                    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                    <!--Se importan los archivos CSS-->
                    <link type="text/css" rel="stylesheet" href="../resources/css/materialize.min.css"/>
                    <link type="text/css" rel="stylesheet" href="../resources/css/style.css" />
                    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                    <!--Se informa al navegador que el sitio web está optimizado para dispositivos móviles-->
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                </head>
                <body>
        ');
        // Se obtiene el nombre del archivo de la página web actual.
        $filename = basename($_SERVER['PHP_SELF']);
        // Se comprueba si existe una sesión de administrador para mostrar el menú de opciones, de lo contrario se muestra un menú vacío.
        if (isset($_SESSION['idusuario'])) {
            if (isset($_SESSION['codigo'])) {
                if ($_SESSION['idtipousuario'] == 1) {
                    // Se verifica si la página web actual es diferente a index.php (Iniciar sesión) y a register.php (Crear primer usuario) para no iniciar sesión otra vez, de lo contrario se direcciona a main.php
                    if ($filename != 'index.php' && $filename != 'register.php') {
                        // Se llama al método que contiene el código de las cajas de dialogo (modals).
                        self::modals();
                        // Se imprime el código HTML para el encabezado del documento con el menú de opciones.
                        print('
                    <header>
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
                        <li class="tab"><a href="historialsesion.php">Historial de Sesiones</a></li>
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
                                    <a href="#name"><span class="white-text name">Correo:<b> ' . $_SESSION['correousuario'] . '</b></span></a>
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
                      <main>                    
                        <!-- <h3 class="center-align">' . $title . '</h3> -->
                '); 
                    } else {
                        header('location: main.php');
                    }
                    
                } else if ($_SESSION['idtipousuario'] == 2) {
                    self::modals();
                    print('
                    <header>
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
                                    <a href="#name"><span class="white-text name">Correo:<b> ' . $_SESSION['correousuario'] . '</b></span></a>
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
                      <main>                    
                        <!-- <h3 class="center-align">' . $title . '</h3> -->
                ');
                } 
                else if($_SESSION['idtipousuario'] == 3){
                    self::modals();
                    print('
                    <header>
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
                            <li><a href="#" onclick="logOut()"><i class="material-icons left">highlight_off</i>Cerrar sesión</a></li>
                                                        
                        </ul>
                    </div> 
                    <div class="nav-content">
                    <ul class="tabs tabs-transparent">                        
                        <li class="tab"><a href="expedientes.php">Expedientes</a></li>
                        <li class="tab"><a href="doctores.php">Doctores</a></li>
                        <li class="tab"><a href="pacientes.php">Pacientes</a></li>
                        <li class="tab"><a href="tratamientos.php">Tratamientos</a></li>                                              
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
                                    <a href="#name"><span class="white-text name">Correo:<b> ' . $_SESSION['correousuario'] . '</b></span></a>
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
                      <main>                    
                        <!-- <h3 class="center-align">' . $title . '</h3> -->
                ');
                }                   
            } else {
                // Se verifica si la página web actual es diferente a index.php (Iniciar sesión) y a register.php (Crear primer usuario) para direccionar a index.php, de lo contrario se muestra un menú vacío.
                if ($filename != 'validarusuario.php') {
                    header('location: validarusuario.php');
                }
            }
        } else {
            // Se verifica si la página web actual es diferente a index.php (Iniciar sesión) y a register.php (Crear primer usuario) para direccionar a index.php, de lo contrario se muestra un menú vacío.
            if ($filename != 'index.php' && $filename != 'register.php') {
                header('location: index.php');
            } else {
                // Se imprime el código HTML para el encabezado del documento con un menú vacío cuando sea iniciar sesión o registrar el primer usuario.
                print('
                    <header>
                        <div class="navbar-fixed">
                            <nav class="teal">
                                <div class="nav-wrapper">
                                    <a href="index.php" class="brand-logo"><i class="material-icons">dashboard</i></a>
                                </div>
                            </nav>
                        </div>
                    </header>
                    <main class="container">
                        <h3 class="center-align">' . $title . '</h3>
                ');
            }
        }
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

    private static function modals()
    {
        // Se imprime el código HTML de las cajas de dialogo (modals).
        print('
            <!-- Componente Modal para mostrar el formulario de editar perfil -->
            <div id="profile-modal" class="modal">
                            <div class="modal-content center-align">
                            <h4></h4>
                                <!-- Título para la caja de dialogo -->
                                <h4 id="modal-titles" class="center-align"></h4>
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

                <!-- Componente Modal para mostrar el formulario de cambiar contraseña -->
            <div id="password-modal" class="modal">
                <div class="modal-content">
                    <h4 class="center-align">Cambiar contraseña</h4>
                    <form method="post" id="password-form">                        
                        <div class="row center-align">                            
                        </div>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">security</i>
                                <input id="clave_nueva_1" type="password" name="clave_nueva_1" class="validate" required/>
                                <label for="clave_nueva_1">Clave</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">security</i>
                                <input id="clave_nueva_2" type="password" name="clave_nueva_2" class="validate" required/>
                                <label for="clave_nueva_2">Confirmar clave</label>
                            </div>
                        </div>
                        <div class="row center-align">
                            <a href="#" class="btn waves-effect grey tooltipped modal-close" data-tooltip="Cancelar"><i class="material-icons">cancel</i></a>
                            <button type="submit" class="btn waves-effect blue tooltipped" data-tooltip="Guardar"><i class="material-icons">save</i></button>
                        </div>
                    </form>
                </div>
            </div>
        ');
    }
}
