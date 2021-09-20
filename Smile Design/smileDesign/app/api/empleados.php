<?php
require_once('../helpers/database.php');
require_once('../helpers/validator.php');
require_once('../models/empleados.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    session_start();
    $producto = new Usuarios;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'exception' => null);
     if (isset($_SESSION['idusuario'])) {
        switch ($_GET['action']) {
            case 'readAll': 
                if ($result['dataset'] = $producto->readAll()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'No hay expedientes registrados';
                    }
                }
                break;
            case 'search': 
                $_POST = $producto->validateForm($_POST);
                if ($_POST['search'] != '') {
                    if ($result['dataset'] = $producto->searchRows($_POST['search'])) {
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
                $_POST = $producto->validateForm($_POST);
                if ($producto->setNombres($_POST['nombre_usuario'])) {
                    if ($producto->setApellidos($_POST['apellido_usuario'])) {
                        if ($producto->setDireccion($_POST['direccion_usuario'])) {
                            if ($producto->setCorreo($_POST['correo_usuario'])) {
                                if ($producto->setUsuario($_POST['alias_usuario'])) {
                                    if ($producto->setTelefono($_POST['telefono_usuario'])) {
                                        if (isset($_POST['tipo_usuario'])) {
                                            if ($producto->setTipo($_POST['tipo_usuario'])) {               
                                                if (isset($_POST['estado_usuario'])) {
                                                    if ($producto->setEstado($_POST['estado_usuario'])) {               
                                                        if ($_POST['clave_cliente'] == $_POST['confirmar_clave']) {
                                                            if ($producto->setClave($_POST['confirmar_clave'])) {
                                                                if ($producto->createRow()) {
                                                                    $result['status'] = 1;
                                                                    $result['message'] = 'Usuario creado correctamente';
                                                                } else {
                                                                    $result['exception'] = Database::getException();;
                                                                }
                                                            } else {
                                                                $result['exception'] = $producto->getPasswordError();
                                                            }
                                                        } else {
                                                            $result['exception'] = 'Claves nuevas diferentes';
                                                        }
                                                    } else {
                                                        $result['exception'] = 'Estado incorrecto';
                                                    }
                                                } else {
                                                    $result['exception'] = 'Seleccione un estado';
                                                }       
                                            } else {
                                                $result['exception'] = 'Tipo incorrecto';
                                            }
                                        } else {
                                            $result['exception'] = 'Seleccione un tipo';
                                        }
                                    } else {
                                        $result['exception'] = 'Telefono incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Usuario incorrecto';
                                }
                            } else {
                                $result['exception'] = 'Correo incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Direccion incorrecta';
                        }
                    } else {
                        $result['exception'] = 'Apellido incorrecto';
                    }
                } else {
                    $result['exception'] = 'Nombre incorrecto';
                }
                break;
            case 'readOne': 
                if ($producto->setId($_POST['id'])) {
                    if ($result['dataset'] = $producto->readOne()) {
                        $result['status'] = 1;
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Causa inexistente';
                        }
                    }
                } else {
                    $result['exception'] = 'Causa incorrecto';
                }
                break;
                case 'update': 
                    $_POST = $producto->validateForm($_POST);
                    if ($producto->setId($_POST['id_usuario'])) {
                        if ($producto->setNombres($_POST['nombre_usuario'])) {
                            if ($producto->setApellidos($_POST['apellido_usuario'])) {
                                if ($producto->setDireccion($_POST['direccion_usuario'])) {
                                    if ($producto->setCorreo($_POST['correo_usuario'])) {
                                        if ($producto->setUsuario($_POST['alias_usuario'])) {
                                            if ($producto->setTelefono($_POST['telefono_usuario'])) {
                                                if (isset($_POST['tipo_usuario'])) {
                                                    if ($producto->setTipo($_POST['tipo_usuario'])) {               
                                                        if (isset($_POST['estado_usuario'])) {
                                                            if ($producto->setEstado($_POST['estado_usuario'])) {               
                                                                if ($_POST['clave_cliente'] == $_POST['confirmar_clave']) {
                                                                    if ($producto->setClave($_POST['confirmar_clave'])) {
                                                                        if ($producto->updateRow()) {
                                                                            $result['status'] = 1;
                                                                            $result['message'] = 'Usuario actualizado correctamente';
                                                                        } else {
                                                                            $result['exception'] = Database::getException();;
                                                                        }
                                                                    } else {
                                                                        $result['exception'] = $producto->getPasswordError();
                                                                    }
                                                                } else {
                                                                    $result['exception'] = 'Claves nuevas diferentes';
                                                                }
                                                            } else {
                                                                $result['exception'] = 'Estado incorrecto';
                                                            }
                                                        } else {
                                                            $result['exception'] = 'Seleccione un estado';
                                                        }       
                                                    } else {
                                                        $result['exception'] = 'Tipo incorrecto';
                                                    }
                                                } else {
                                                    $result['exception'] = 'Seleccione un tipo';
                                                }
                                            } else {
                                                $result['exception'] = 'Telefono incorrecto';
                                            }
                                        } else {
                                            $result['exception'] = 'Usuario incorrecto';
                                        }
                                    } else {
                                        $result['exception'] = 'Correo incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Direccion incorrecta';
                                }
                            } else {
                                $result['exception'] = 'Apellido incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Nombre incorrecto';
                        } 
                    } else {
                        $result['exception'] = 'ID incorrecto';
                    }
                           
                break;

            case 'delete': 
                if ($producto->setId($_POST['id'])) {
                    if ($data = $producto->readOne()) {
                        if ($producto->deleteRow()) {
                            $result['status'] = 1;
                            $result['message'] = 'Usuario eliminado correctamente';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Usuario inexistente';
                    }
                } else {
                    $result['exception'] = 'Usuario  incorrecto';
                }
                break;
            default: 
                $result['exception'] = 'Acción no disponible dentro de la sesión';
        }
        header('content-type: application/json; charset=utf-8');
        print(json_encode($result));
   } else {
        print(json_encode('Acceso denegado'));
    }
} else {
    print(json_encode('Recurso no disponible'));
}
