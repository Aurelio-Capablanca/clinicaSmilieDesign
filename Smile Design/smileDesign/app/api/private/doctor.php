<?php
require_once('../../helpers/database.php');
require_once('../../helpers/validator.php');
require_once('../../models/doctores.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    //Se instancia la clase correspondiente
    $doctores = new Doctores;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'exception' => null);
    // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
    // if (isset($_SESSION['idusuario'])) {
    // Se compara la acción a realizar cuando un administrador ha iniciado sesión.
    switch ($_GET['action']) {
        case 'readAll':
            if ($result['dataset'] = $doctores->readAll()) {
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
            $_POST = $doctores->validateForm($_POST);
            if ($_POST['search'] != '') {
                if ($result['dataset'] = $doctores->searchRows($_POST['search'])) {
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
            $_POST = $doctores->validateForm($_POST);
            if ($doctores->setNombres($_POST['nombre_doctor'])) {
                if ($doctores->setApellidos($_POST['apellido_doctor'])) {
                    if ($doctores->setDireccion($_POST['direccion_doctor'])) {
                        if ($doctores->setTelefono($_POST['telefono_doctor'])) {
                            if ($doctores->setCorreo($_POST['correo_doctor'])) {
                                if (is_uploaded_file($_FILES['foto_doctor']['tmp_name'])) {
                                    if ($doctores->setFoto($_FILES['foto_doctor'])) {
                                        if ($doctores->setAlias($_POST['alias_doctor'])) {
                                            if ($_POST['clave_doctor'] == $_POST['confirmar_doctor']) {
                                                if ($doctores->setClave($_POST['clave_doctor'])) {
                                                    if (isset($_POST['estado_doctor'])) {
                                                        if ($doctores->setEstado($_POST['estado_doctor'])) {
                                                            if ($doctores->createRow()) {
                                                                $result['status'] = 1;
                                                                if ($doctores->saveFile($_FILES['foto_doctor'], $doctores->getRuta(), $doctores->getFoto())) {
                                                                    $result['message'] = 'El producto fue creado exitosamente';
                                                                } else {
                                                                    $result['message'] = 'El producto fue creado, pero la imagen no fue guardada';
                                                                }
                                                            } else {
                                                                $result['exception'] = Database::getException();
                                                            }
                                                        } else {
                                                            $result['exception'] = 'Talla incorrecta 3 ';
                                                        }
                                                    } else {
                                                        $result['exception'] = 'Seleccione una imagen';
                                                    }
                                                } else {
                                                    $result['exception'] = 'Seleccione una imagen';
                                                }
                                            } else {
                                                $result['exception'] = 'Talla incorrecta 2 ';
                                            }
                                        } else {
                                            $result['exception'] = 'Talla incorrecta 1';
                                        }
                                    } else {
                                        $result['exception'] = 'Seleccione una talla';
                                    }
                                } else {
                                    $result['exception'] = $doctores->getImageError();
                                }
                            } else {
                                $result['exception'] = 'Categoria incorrecta';
                            }
                        } else {
                            $result['exception'] = 'Seleccione una categoria';
                        }
                    } else {
                        $result['exception'] = 'Precio incorrecto';
                    }
                } else {
                    $result['exception'] = 'Apellido incorrecto';
                }
            } else {
                $result['exception'] = 'Nombre incorrecto';
            }
            break;
        case 'readOne':
            if ($doctores->setId($_POST['id_doctor'])) {
                if ($result['dataset'] = $doctores->readOne()) {
                    $result['status'] = 1;
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'Producto inexistente';
                    }
                }
            } else {
                $result['exception'] = 'Producto incorrecto';
            }
            break;
        case 'update':
            $_POST = $doctores->validateForm($_POST);  
            //print_r($_POST);
            if ($doctores->setId($_POST['id_doctor']))  {
                if ($data = $doctores->readOne()) {
                    if ($doctores->setNombres($_POST['nombre_doctor'])) {
                        if ($doctores->setApellidos($_POST['apellido_doctor'])) {
                            if ($doctores->setDireccion($_POST['direccion_doctor'])) {
                                if ($doctores->setTelefono($_POST['telefono_doctor'])) {
                                    if ($doctores->setCorreo($_POST['correo_doctor'])) {
                                        if (is_uploaded_file($_FILES['foto_doctor']['tmp_name'])) {
                                            if ($doctores->updateRow($data['fotodoctor'])) {
                                                $result['status'] = 1;
                                                if ($doctores->saveFile($_FILES['foto_doctor'], $doctores->getRuta(), $doctores->getFoto())) {
                                                    $result['message'] = 'El producto fue modificado exitosamente';
                                                } else {
                                                    $result['message'] = 'El producto fue modificado, pero la imagen no fue guardada';
                                                }
                                            } else {
                                                echo Database::getException();
                                                //$result['exception'] = Database::getException();
                                            }
                                        } else {
                                            if ($doctores->updateRow($data['fotodoctor'])) {
                                                $result['status'] = 1;
                                                $result['message'] = 'Imagen modificada correctamente';
                                            } else {
                                                $result['exception'] = Database::getException();
                                            }
                                        }
                                    } else {
                                        $result['exception'] = 'Estado incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Seleccione una categoria';
                                }
                            } else {
                                $result['exception'] = 'Precio incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Descripcion incorrecta';
                        }
                    } else {
                        $result['exception'] = 'Nombre incorrecto';
                    }
                } else {
                    $result['exception'] = 'Producto inexistente';
                }
            } else {
                $result['exception'] = 'Producto incorrecto';
            }
            break;
        case 'delete':
            if ($doctores->setId($_POST['id_doctor'])) {
                if ($data = $doctores->readOne()) {
                    if ($doctores->deleteRow()) {
                        $result['status'] = 1;
                        if ($doctores->deleteFile($doctores->getRuta(), $data['fotodoctor'])) {
                            $result['message'] = 'El Doctor fue eliminado exitosamente';
                        } else {
                            $result['message'] = 'El Doctor fue eliminado, pero no se borro la imagen';
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
            case 'readTratamientoTipo':
                if ($doctores->setId($_POST['id_doctorestr'])) {
                    if ($result['dataset'] = $doctores->readTratamientoTipo()) {
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
            case 'readOnes':
                if ($doctores->setId($_POST['id_doctorestr'])) {
                    if ($result['dataset'] = $doctores->readOne()) {
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
