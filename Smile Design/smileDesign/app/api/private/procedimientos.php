<?php
require_once('../../helpers/database.php');
require_once('../../helpers/validator.php');
require_once('../../models/procedimientos.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    //Se instancia la clase correspondiente
    $procedimiento = new Procedimientos;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'exception' => null);
    // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
    // if (isset($_SESSION['idusuario'])) {
    // Se compara la acción a realizar cuando un administrador ha iniciado sesión.
    switch ($_GET['action']) {
        case 'readAll':
            if ($result['dataset'] = $procedimiento->readAll()) {
                $result['status'] = 1;
            } else {
                if (Database::getException()) {
                    $result['exception'] = Database::getException();
                } else {
                    $result['exception'] = 'No hay procedimientos registrados';
                }
            }
            break;
        case 'search':
            $_POST = $procedimiento->validateForm($_POST);
            if ($_POST['search'] != '') {
                if ($result['dataset'] = $procedimiento->searchRows($_POST['search'])) {
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
            $_POST = $procedimiento->validateForm($_POST);
            if ($procedimiento->setNombre($_POST['nombre_procedimiento'])) {
                if ($procedimiento->setDescripcion($_POST['descripcion'])) {
                    if ($procedimiento->setCosto($_POST['precio_procedimiento'])) {
                        if ($procedimiento->createRow()) {
                            $result['status'] = 1;
                            $result['message'] = 'Procedimiento Creado correctamente';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['message'] = 'El procedimiento no fue creado';
                    }
                } else {
                    $result['message'] = 'La descripción es incorrecta';
                }
            } else {
                $result['message'] = 'El costo del procedimiento es incorrecto';
            }
            break;

        case 'readOne':
            if ($procedimiento->setId($_POST['id_procedimiento'])) {
                if ($result['dataset'] = $procedimiento->readOne()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'Procedimiento inexistente';
                    }
                }
            } else {
                $result['exception'] = 'Procedimiento incorrecto';
            }
            break;

        case 'update':
            $_POST = $procedimiento->validateForm($_POST);
            if ($procedimiento->setId($_POST['id_procedimiento'])) {
                if ($data = $procedimiento->readOne()) {
                    if ($procedimiento->setNombre($_POST['nombre_procedimiento'])) {
                        if ($procedimiento->setDescripcion($_POST['descripcion'])) {
                            if ($procedimiento->setCosto($_POST['precio_procedimiento'])) {
                                if ($procedimiento->updateRow()) {
                                    $result['status'] = 1;
                                    $result['message'] = 'Procedimiento modificado correctamente';
                                } else {
                                    $result['exception'] = Database::getException();
                                }
                            } else {
                                $result['message'] = 'El procedimiento no fue creado';
                            }
                        } else {
                            $result['message'] = 'La descripción es incorrecta';
                        }
                    } else {
                        $result['message'] = 'El costo del procedimiento es incorrecto';
                    }
                } else {
                    $result['message'] = 'El costo del procedimiento es incorrecto';
                }
            } else {
                $result['message'] = 'El costo del procedimiento es incorrecto';
            }
            break;
        case 'delete':
            if ($procedimiento->setId($_POST['id_procedimiento'])) {
                if ($data = $procedimiento->readOne()) {
                    if ($procedimiento->deleteRow()) {
                        $result['status'] = 1;
                    } else {
                        $result['exception'] = Database::getException();
                    }
                } else {
                    $result['exception'] = 'Procedimiento inexistente';
                }
            } else {
                $result['exception'] = 'Procedimiento incorrecto';
            }
            break;
        default:
            $result['exception'] = 'Acción no disponible dentro de la sesión';
    }

    // Se indica el tipo de contenido a mostrar y su respectivo conjunto de caracteres.
    header('content-type: application/json; charset=utf-8');
    // Se imprime el resultado en formato JSON y se retorna al controlador.
    print(json_encode($result));
    // } else {
    //     print(json_encode('Acceso denegado'));
    // }
} else {
    print(json_encode('Recurso no disponible'));
}
