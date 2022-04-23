<?php
require_once('../helpers/database.php');
require_once('../helpers/validator.php');
require_once('../models/expedientes.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    session_start();
    $producto = new Productos;
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
                if (isset($_POST['ide_paciente'])) {
                    if ($producto->setPaciente($_POST['ide_paciente'])) {
                        if (is_uploaded_file($_FILES['odontograma']['tmp_name'])) {
                            if ($producto->setOdontograma($_FILES['odontograma'])) {
                                if (is_uploaded_file($_FILES['periodontograma']['tmp_name'])) {
                                    if ($producto->setPeriodontograma($_FILES['periodontograma'])) {
                                        if ($producto->createRow()) {
                                            $result['status'] = 1;
                                            if ($producto->saveFile($_FILES['odontograma'], $producto->getRutaOdontograma(), $producto->getOdontograma())) {
                                                if ($producto->saveFile($_FILES['periodontograma'], $producto->getRutaPeriodontograma(), $producto->getPeriodontograma())) {
                                                    $result['message'] = 'Expediente ingresado correctamente';
                                                } else {
                                                    $result['message'] = 'Producto creado pero no se guardó la imagen de periodontograma';
                                                }
                                            } else {
                                                $result['message'] = 'Producto creado pero no se guardó la imagen de odontograma';
                                            }
                                        } else {
                                            $result['exception'] = Database::getException();;
                                        }
                                    } else {
                                        $result['exception'] = $producto->getImageError();
                                    }
                                } else {
                                    $result['exception'] = 'Seleccione una imagen para periodontograma';
                                }
                            } else {
                                $result['exception'] = $producto->getImageError();
                            }
                        } else {
                            $result['exception'] = 'Seleccione una imagen para odontograma';
                        }
                    } else {
                        $result['exception'] = 'Paciente incorrecto';
                    }
                } else {
                    $result['exception'] = 'Seleccione un paciente';
                }
                break;
            case 'readOne':
                if ($producto->setId($_POST['id'])) {
                    if ($result['dataset'] = $producto->readRow()) {
                        $result['status'] = 1;
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Expediente inexistente';
                        }
                    }
                } else {
                    $result['exception'] = 'Expediente incorrecto';
                }
                break;

            case 'update':
                $_POST = $producto->validateForm($_POST);
                if ($producto->setId($_POST['txtId'])) {
                    if ($data = $producto->readRow()) {
                        if (is_uploaded_file($_FILES['odontograma']['tmp_name'])) {
                            if ($producto->setOdontograma($_FILES['odontograma'])) {
                                if (is_uploaded_file($_FILES['periodontograma']['tmp_name'])) {
                                    if ($producto->setPeriodontograma($_FILES['periodontograma'])) {
                                        if ($producto->updateRow($data['periodontograma'], $data['odontograma'])) {
                                            $result['status'] = 1;
                                            if ($producto->saveFile($_FILES['odontograma'], $producto->getRutaOdontograma(), $producto->getOdontograma())) {
                                                if ($producto->saveFile($_FILES['periodontograma'], $producto->getRutaPeriodontograma(), $producto->getPeriodontograma())) {
                                                    $result['message'] = 'Expediente modificado correctamente';
                                                } else {
                                                    $result['message'] = 'Expediente modificado pero no se guardó la imagen';
                                                }
                                            } else {
                                                $result['message'] = 'Producto modificado pero no se guardó la imagen';
                                            }
                                        } else {
                                            $result['exception'] = Database::getException();
                                        }
                                    } else {
                                        $result['exception'] = $producto->getImageError();
                                    }
                                } else {
                                    if ($producto->updateRow($data['periodontograma'], $data['odontograma'])) {
                                        $result['status'] = 1;
                                        if ($producto->saveFile($_FILES['odontograma'], $producto->getRutaOdontograma(), $producto->getOdontograma())) {
                                            $result['message'] = 'Expediente modificado correctamente';
                                        } else {
                                            $result['message'] = 'Expediente modificado pero no se actualizo la imagen del odontograma';
                                        }
                                    } else {
                                        $result['exception'] = Database::getException();
                                    }
                                }
                            } else {
                                $result['exception'] = $producto->getImageError();
                            }
                        } else {
                            if ($producto->updateRow($data['periodontograma'], $data['odontograma'])) {
                                $result['status'] = 1;
                                if ($producto->saveFile($_FILES['periodontograma'], $producto->getRutaPeriodontograma(), $producto->getPeriodontograma())) {
                                    $result['message'] = 'Expediente modificado correctamente';
                                } else {
                                    $result['message'] = 'Expediente modificado pero no se actualizo la imagen del odontograma';
                                }
                            } else {
                                $result['exception'] = Database::getException();
                            }
                        }
                    } else {
                        $result['exception'] = 'Producto inexistente';
                    }
                } else {
                    $result['exception'] = 'Producto incorrecto';
                }
                break;

            case 'delete':
                if ($producto->setId($_POST['id'])) {
                    if ($data = $producto->readRow()) {
                        if ($producto->deleteRow()) {
                            $result['status'] = 1;
                            if ($producto->deleteFile($producto->getRutaOdontograma(), $data['odontograma'])) {
                                if ($producto->deleteFile($producto->getRutaPeriodontograma(), $data['periodontograma'])) {
                                    $result['message'] = 'Expediente eliminado correctamente';
                                } else {
                                    $result['message'] = 'Expediente eliminado pero no se borró la imagen del periodontograma';
                                }
                            } else {
                                $result['message'] = 'Expediente eliminado pero no se borró la imagen del odontograma';
                            }
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Producto inexistente';
                    }
                } else {
                    $result['exception'] = 'Producto incorrecto';
                }
                break;
            case 'readOneA':
                if ($producto->setId($_POST['idArchivoT'])) {
                    if ($result['dataset'] = $producto->readRow()) {
                        $result['status'] = 1;
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Expediente inexistente';
                        }
                    }
                } else {
                    $result['exception'] = 'Expediente incorrecto';
                }
                break;
            case 'createArchivo':
                if ($producto->setNotas($_POST['notas_medicas'])) {
                    if ($producto->setObservaciones($_POST['observaciones'])) {
                        if ($producto->setId($_POST['idArchivoT'])) {
                            if ($producto->createRowArchivo()) {
                                $result['status'] = 1;
                                $result['message'] = 'Archivo  Creado Correctamente';
                            } else {
                                $result['exception'] = Database::getException();
                            }
                        } else {
                            $result['exception'] = 'Observaciones invalidas';
                        }
                    } else {
                        $result['exception'] = 'Observaciones invalidas';
                    }
                } else {
                    $result['exception'] = 'Notas invalidas';
                }
                break;
            case 'searchOneArchivo':
                $_POST = $producto->validateForm($_POST);
                if ($_POST['odontogrma'] != '') {
                    if ($result['dataset'] = $producto->searchOneArchivo($_POST['odontogrma'])) {
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
            case 'readOneArchivo':
                if ($producto->setId($_POST['id_expedientes'])) {
                    // if ($result['dataset'] = $producto->readOneArchivo()) {
                    //     $result['status'] = 1;                                
                    // } else {
                    //     if (Database::getException()) {
                    //         $result['exception'] = Database::getException();
                    //     } else {
                    //         $result['exception'] = 'Cliente inexistente Orden';
                    //     }
                    // }      
                    $result['dataset'] = $producto->readOneArchivo();
                    $result['status'] = 1;
                } else {
                    $result['exception'] = 'Cliente incorrecto Orden';
                }
                break;
            case 'readOneArchivo1':
                if ($producto->setId($_POST['idArchivoTr'])) {
                    if ($result['dataset'] = $producto->readOneArchivo1()) {
                        $result['status'] = 1;
                    } else {
                        if (Database::getException()) {
                            $result['exception'] = Database::getException();
                        } else {
                            $result['exception'] = 'Cliente inexistente Orden';
                        }
                    }
                } else {
                    $result['exception'] = 'Cliente incorrecto Orden';
                }
                break;
            case 'updateRowArchivo':
                $_POST = $producto->validateForm($_POST);
                if ($producto->setId($_POST['idArchivoTr'])) {
                    if ($data = $producto->readOneArchivo1()) {
                        if ($producto->setNotas($_POST['notas_medicass'])) {
                            if ($producto->setObservaciones($_POST['observacioness'])) {

                                if ($producto->updateRowArchivo()) {
                                    $result['status'] = 1;
                                    $result['message'] = 'Archivo Actualizado Correctamente';
                                } else {
                                    $result['exception'] = Database::getException();
                                }
                            } else {
                                $result['exception'] = 'observaciones invalidas';
                            }
                        } else {
                            $result['exception'] = 'Notas invalidas';
                        }
                    } else {
                        $result['exception'] = 'Datos inexistente';
                    }
                } else {
                    $result['exception'] = 'Archivo inexistente';
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
