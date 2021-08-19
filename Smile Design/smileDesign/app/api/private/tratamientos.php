<?php
require_once('../../helpers/database.php');
require_once('../../helpers/validator.php');
require_once('../../models/tratamientos.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    //session_start();
    $producto = new Productos;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'exception' => null);
    //if (isset($_SESSION['id_usuario'])) {
        switch ($_GET['action']) {
            case 'readAll': // METODO READ CARGAR TODOS LOS DATOS 
                if ($result['dataset'] = $producto->readRows()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'No hay productos registrados';
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
                if ($producto->setInicio($_POST['fecha_nacimiento'])) {
                    if ($producto->setDescripcion($_POST['descripcion'])) {
                        if (isset($_POST['id_estado'])) {
                            if ($producto->setEstado($_POST['id_estado'])) {               
                                if (isset($_POST['id_tipo'])) {
                                    if ($producto->setTipo($_POST['id_tipo'])) {               
                                        if (isset($_POST['id_asignado'])) {
                                            if ($producto->setAsignado($_POST['id_asignado'])) {               
                                                if ($producto->createRow()) {
                                                    $result['status'] = 1;
                                                    $result['message'] = 'Tratamiento registrado correctamente';
                                                } else {
                                                    $result['exception'] = Database::getException();;
                                                }
                                            } else {
                                                $result['exception'] = 'Asignado incorrecto';
                                            }
                                        } else {
                                            $result['exception'] = 'Seleccione un asignado';
                                        }       
                                    } else {
                                        $result['exception'] = 'Tipo incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Seleccione un tipo';
                                }       
                            } else {
                                $result['exception'] = 'Estado incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Seleccione un estado';
                        }                                                                                     
                    } else {
                        $result['exception'] = 'Descripcion incorrecta';
                    }
                } else {
                    $result['exception'] = 'Fecha incorrecta';
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
                            $result['exception'] = 'Tratamiento inexistente';
                        }
                    }
                } else {
                    $result['exception'] = 'Tratamiento incorrecto';
                }
                break;
                case 'readOneC': 
                    if ($producto->setId($_POST['id_t'])) {
                        if ($result['dataset'] = $producto->readRow()) {
                            $result['status'] = 1;
                        } else {
                            if (Database::getException()) {
                                $result['exception'] = Database::getException();
                            } else {
                                $result['exception'] = 'Tratamiento inexistente';
                            }
                        }
                    } else {
                        $result['exception'] = 'Tratamiento incorrecto';
                    }
                    break;
                    case 'createConsulta':
                        if ($producto->setId($_POST['id_t'])) {  
                            if ($producto->createRowsCantidad()) {
                                $result['status'] = 1;
                                $result['message'] = 'Consulta Agregada correctamente';
                            } else {
                                $result['exception'] = Database::getException();
                            }
                        } else {
                            $result['exception'] = 'id incorrecto';
                        }      
                    break;    
            case 'update':
                $_POST = $producto->validateForm($_POST);   
                if ($producto->setId($_POST['txtId'])) {
                    if ($data = $producto->readRow()) {
                        if ($producto->setInicio($_POST['fecha_nacimiento'])) {
                            if ($producto->setDescripcion($_POST['descripcion'])) {
                                if (isset($_POST['id_estado'])) {
                                    if ($producto->setEstado($_POST['id_estado'])) {               
                                        if (isset($_POST['id_tipo'])) {
                                            if ($producto->setTipo($_POST['id_tipo'])) {               
                                                if (isset($_POST['id_asignado'])) {
                                                    if ($producto->setAsignado($_POST['id_asignado'])) {               
                                                        if ($producto->updateRow()) {
                                                            $result['status'] = 1;
                                                            $result['message'] = 'Tratamiento modificado correctamente';
                                                        } else {
                                                            $result['exception'] = Database::getException();
                                                        }
                                                    } else {
                                                        $result['exception'] = 'Asignado incorrecto';
                                                    }
                                                } else {
                                                    $result['exception'] = 'Seleccione un asignado';
                                                }       
                                            } else {
                                                $result['exception'] = 'Tipo incorrecto';
                                            }
                                        } else {
                                            $result['exception'] = 'Seleccione un tipo';
                                        }       
                                    } else {
                                        $result['exception'] = 'Estado incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Seleccione un estado';
                                }                                                                                     
                            } else {
                                $result['exception'] = 'Descripcion incorrecta';
                            }
                        } else {
                            $result['exception'] = 'Fecha incorrecta';
                        }                     
                    } else {
                        $result['exception'] = 'Tratamiento inexistente';
                    }
                } else {
                    $result['exception'] = 'ID incorrecto';
                }
                break;   
            case 'delete': 
                if ($producto->setId($_POST['id'])) {
                    if ($data = $producto->readRow()) {
                        if ($producto->deleteRow()) {
                            $result['status'] = 1;
                            $result['message'] = 'Tratamiento eliminado correctamente';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'El registro esta en uso no se puede eliminar';
                    }
                } else {
                    $result['exception'] = 'Producto incorrecto';
                }
                break;
                case 'readTratamientoConsulta':
                    if ($producto->setId($_POST['id_causaconsulta'])) {
                        if ($result['dataset'] = $producto->readTratamientoConsulta()) {
                            $result['status'] = 1;
                        } else {
                            if (Database::getException()) {
                                $result['exception'] = Database::getException();
                            } else {
                                $result['exception'] = 'Tratamiento inexistente';
                            }
                        }
                    } else {
                        $result['exception'] = 'Tratamiento incorrecto';
                    }     
                break;
                case 'readOnes':
                    if ($producto->setId($_POST['id_causaconsulta'])) {
                        if ($result['dataset'] = $producto->readRow()) {
                            $result['status'] = 1;
                        } else {
                            if (Database::getException()) {
                                $result['exception'] = Database::getException();
                            } else {
                                $result['exception'] = 'Tratamiento inexistente';
                            }
                        }
                    } else {
                        $result['exception'] = 'Tratamiento incorrecto';
                    }
                    break;
            default: 
                $result['exception'] = 'Acción no disponible dentro de la sesión';
        }
        header('content-type: application/json; charset=utf-8');
        print(json_encode($result));
    /*} else {
        print(json_encode('Acceso denegado'));
    }*/
} else {
    print(json_encode('Recurso no disponible'));
}
