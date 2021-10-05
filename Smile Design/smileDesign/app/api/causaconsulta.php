<?php
require_once('../helpers/database.php');
require_once('../helpers/validator.php');
require_once('../models/causaconsulta.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    session_start();
    $producto = new Causa;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'exception' => null);
    if (isset($_SESSION['idusuario']) && $_SESSION['idtipousuario'] == 2  && isset($_SESSION['codigo'])) {
        switch ($_GET['action']) {
            case 'readAll': 
                if ($result['dataset'] = $producto->readAll()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'No hay Causas registradas';
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
                if ($producto->setCausa($_POST['causa'])) {
                    if ($producto->createRow()) {
                        $result['status'] = 1;
                        $result['message'] = 'Causa consulta creada correctamente';
                    } else {
                        $result['exception'] = Database::getException();;
                    }
                } else {
                    $result['exception'] = 'Causa incorrecta';
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
                    if ($producto->setId($_POST['id_causa'])) {
                        if ($producto->setCausa($_POST['causa'])) {
                            if ($producto->updateRow()) {
                                $result['status'] = 1;
                                $result['message'] = 'Causa actualizada correctamente';
                            } else {
                                $result['exception'] = Database::getException();;
                            }
                        } else {
                            $result['exception'] = 'Causa incorrecta';
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
                            $result['message'] = 'Causa eliminada correctamente';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Causa inexistente';
                    }
                } else {
                    $result['exception'] = 'Causa  incorrecto';
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
