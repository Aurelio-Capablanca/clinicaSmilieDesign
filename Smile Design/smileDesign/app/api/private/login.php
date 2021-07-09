<?php
require_once('../../helpers/database.php');
require_once('../../helpers/validator.php');
require_once('../../models/login.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    // Se instancia la clase correspondiente.
    $usuario = new Usuarios;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'error' => 0, 'message' => null, 'exception' => null);
    // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
    if (isset($_SESSION['idusuario'])) {
        // Se compara la acción a realizar cuando un administrador ha iniciado sesión.
        switch ($_GET['action']) {
            case 'logOut':
                if (session_destroy()) {
                    $result['status'] = 1;
                    $result['message'] = 'Sesión eliminada correctamente';
                } else {
                    $result['exception'] = 'Ocurrió un problema al cerrar la sesión';
                }
                break;
            case 'readProfile'://se usa para mostrar los datos a editar del usuario de la sesion
                if ($result['dataset'] = $usuario->readProfile()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'Usuario inexistente';
                    }
                }
                break;
            case 'editProfile':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setNombres($_POST['nombres_perfil'])) {
                    if ($usuario->setApellidos($_POST['apellidos_perfil'])) {
                        if ($usuario->setCorreo($_POST['correo_perfil'])) {
                            if ($usuario->setUsuario($_POST['alias_perfil'])) {
                                if ($usuario->editProfile()) {
                                    $result['status'] = 1;
                                    $_SESSION['usuario'] = $usuario->getUsuario();
                                    $result['message'] = 'Perfil modificado correctamente';
                                } else {
                                    $result['exception'] = Database::getException();
                                }
                            } else {
                                $result['exception'] = 'Alias incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Correo incorrecto';
                        }
                    } else {
                        $result['exception'] = 'Apellidos incorrectos';
                    }
                } else {
                    $result['exception'] = 'Nombres incorrectos';
                }
                break;
            case 'changePassword':
                if ($usuario->setId($_SESSION['idusuario'])) {
                    $_POST = $usuario->validateForm($_POST);
                    if ($usuario->checkPassword($_POST['clave_actual'])) {
                        if ($_POST['clave_nueva_1'] == $_POST['clave_nueva_2']) {
                            if ($usuario->setClave($_POST['clave_nueva_1'])) {
                                if ($usuario->changePassword()) {
                                    $result['status'] = 1;
                                    $result['message'] = 'Contraseña cambiada correctamente';
                                } else {
                                    $result['exception'] = Database::getException();
                                }
                            } else {
                                $result['exception'] = $usuario->getPasswordError();
                            }
                        } else {
                            $result['exception'] = 'Claves nuevas diferentes';
                        }
                    } else {
                        $result['exception'] = 'Clave actual incorrecta';
                    }
                } else {
                    $result['exception'] = 'Usuario incorrecto';
                }
                break;
            case 'readAll':
                if ($result['dataset'] = $usuario->readAll()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'No hay usuarios registrados';
                    }
                }
                break;
            case 'search':
                $_POST = $usuario->validateForm($_POST);
                if ($_POST['search'] != '') {
                    if ($result['dataset'] = $usuario->searchRows($_POST['search'])) {
                        $result['status'] = 1;
                        $rows = count($result['dataset']);
                        if ($rows > 1) {
                            $result['message'] = 'Se encontraron ' . $rows . ' coincidencias';
                        } else {
                            $result['message'] = 'Solo existe una coincidencia';
                        }
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'No hay coincidencias';
                        }
                    }
                } else {
                    $result['exception'] = 'Ingrese un valor para buscar';
                }
                break;
            case 'create':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setNombres($_POST['nombres_usuario'])) {
                    if ($usuario->setApellidos($_POST['apellidos_usuario'])) {
                        if ($usuario->setCorreo($_POST['correo_usuario'])) {
                            if ($usuario->setUsuario($_POST['alias_usuario'])) {
                                if ($_POST['clave_usuario'] == $_POST['confirmar_clave']) {
                                    if ($usuario->setClave($_POST['clave_usuario'])) {
                                        if (isset($_POST['cmbTipo'])) {
                                            if ($usuario->setTipo($_POST['cmbTipo'])) {
                                                if (isset($_POST['cmbEstado'])) {
                                                    if ($usuario->setEstado($_POST['cmbEstado'])) {
                                                        if ($usuario->addUser()) {
                                                            $result['status'] = 1;
                                                            $result['message'] = 'Usuario creado correctamente';
                                                        } else {
                                                            $result['exception'] = Database::getException();
                                                        }
                                                    } else {
                                                        $result['exception'] = 'Categoria incorrecta';
                                                    }
                                                } else {
                                                    $result['exception'] = 'Seleccione una categoria';
                                                }
                                            } else {
                                                $result['exception'] = 'Categoria incorrecta';
                                            }
                                        } else {
                                            $result['exception'] = 'Seleccione una categoria';
                                        }
                                    } else {
                                        $result['exception'] = $usuario->getPasswordError();
                                    }
                                } else {
                                    $result['exception'] = 'Claves diferentes';
                                }
                            } else {
                                $result['exception'] = 'Alias incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Correo incorrecto';
                        }
                    } else {
                        $result['exception'] = 'Apellidos incorrectos';
                    }
                } else {
                    $result['exception'] = 'Nombres incorrectos';
                }
                break;
            case 'readOne':
                if ($usuario->setId($_POST['idusuario'])) {
                    if ($result['dataset'] = $usuario->readOne()) {
                        $result['status'] = 1;
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Usuario inexistente';
                        }
                    }
                } else {
                    $result['exception'] = 'Usuario incorrecto';
                }
                break;
            case 'update':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setId($_POST['idusuario'])) {
                    if ($usuario->readOne()) {
                        if ($usuario->setNombres($_POST['nombres_usuario'])) {
                            if ($usuario->setApellidos($_POST['apellidos_usuario'])) {
                                if ($usuario->setCorreo($_POST['correo_usuario'])) {
                                    if ($usuario->setUsuario($_POST['alias_usuario'])) {
                                        if ($usuario->setTipo($_POST['cmbTipo'])) {
                                            if ($usuario->setEstado($_POST['cmbEstado'])) {
                                                if ($usuario->updateRow()) {
                                                    $result['status'] = 1;
                                                    $result['message'] = 'Usuario modificado correctamente';
                                                } else {
                                                    $result['exception'] = Database::getException();
                                                }
                                            } else {
                                                $result['exception'] = 'Categoria incorrecta';
                                            }
                                        } else {
                                            $result['exception'] = 'Categoria incorrecta';
                                        }
                                    } else {
                                        $result['exception'] = 'Alias incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Correo incorrecto';
                                }
                            } else {
                                $result['exception'] = 'Apellidos incorrectos';
                            }
                        } else {
                            $result['exception'] = 'Nombres incorrectos';
                        }
                    } else {
                        $result['exception'] = 'Usuario inexistente';
                    }
                } else {
                    $result['exception'] = 'Usuario incorrecto';
                }
                break;
            case 'delete':
                if ($_POST['idusuario'] != $_SESSION['idusuario']) {
                    if ($usuario->setId($_POST['idusuario'])) {
                        if ($usuario->readOne()) {
                            if ($usuario->deleteRow()) {
                                $result['status'] = 1;
                                $result['message'] = 'Usuario eliminado correctamente';
                            } else {
                                $result['exception'] = Database::getException();
                            }
                        } else {
                            $result['exception'] = 'Usuario inexistente';
                        }
                    } else {
                        $result['exception'] = 'Usuario incorrecto';
                    }
                } else {
                    $result['exception'] = 'No se puede eliminar a sí mismo';
                }
                break;
            default:
                $result['exception'] = 'Acción no disponible dentro de la sesión';
        }
    } else {
        // Se compara la acción a realizar cuando el administrador no ha iniciado sesión.
        switch ($_GET['action']) {
            case 'readAll':
                if ($usuario->readAll()) {
                    $result['status'] = 1;
                    $result['message'] = 'Existe al menos un usuario registrado';
                } else {
                    if (Database::getException()) {
                        $result['error'] = 1;
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'No existen usuarios registrados';
                    }
                }
                break;
            case 'register':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setNombres($_POST['nombres'])) {
                    if ($usuario->setApellidos($_POST['apellidos'])) {
                        if ($usuario->setDireccion($_POST['txtDireccion'])) {
                            if ($usuario->setTelefono($_POST['txtTel'])) {
                        if ($usuario->setCorreo($_POST['correo'])) {
                            if ($usuario->setUsuario($_POST['alias'])) {
                                if ($_POST['clave1'] == $_POST['clave2']) {
                                    if ($usuario->setClave($_POST['clave1'])) {
                                        if ($usuario->createRow()) {
                                            $result['status'] = 1;
                                            $result['message'] = 'Usuario registrado correctamente';
                                        } else {
                                            $result['exception'] = Database::getException();
                                        }
                                    } else {
                                        $result['exception'] = $usuario->getPasswordError();
                                    }
                                } else {
                                    $result['exception'] = 'Claves diferentes';
                                }
                            } else {
                                $result['exception'] = 'Usuario incorrecto';
                            }
                        }else{
                            $result['exception'] = 'Telefono incorrecto';

                        }
                        } else {
                            $result['exception'] = 'Correo incorrecto';
                        }
                        }else{
                            $result['exception'] = 'Direccion incorrecta';

                        }
                    } else {
                        $result['exception'] = 'Apellidos incorrectos';
                    }
                } else {
                    $result['exception'] = 'Nombres incorrectos';
                }
                break;
            case 'logIn':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->checkUser($_POST['usuario'])) {
                    if ($usuario->checkPassword($_POST['clave'])) {
                        $result['status'] = 1;
                        $result['message'] = 'Autenticación correcta';
                        $_SESSION['idusuario'] = $usuario->getId();
                        $_SESSION['aliasusuario'] = $usuario->getUsuario();

                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Clave incorrecta';
                        }
                    }
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'Usuario incorrecto';
                    }
                }
                break;
            default:
                $result['exception'] = 'Acción no disponible fuera de la sesión';
        }
    }
    // Se indica el tipo de contenido a mostrar y su respectivo conjunto de caracteres.
    header('content-type: application/json; charset=utf-8');
    // Se imprime el resultado en formato JSON y se retorna al controlador.
    print(json_encode($result));
} else {
    print(json_encode('Recurso no disponible'));
}
