<?php
require_once('../helpers/database.php');
require_once('../helpers/validator.php');
require_once('../models/login.php');

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
            case 'readProfile': //se usa para mostrar los datos a editar del usuario de la sesion
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
            case 'HistorialSesiones':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setIp($_POST['ipdata'])) {
                    if ($usuario->setRegion($_POST['region'])) {
                        if ($usuario->setZona($_POST['zona'])) {
                            if ($usuario->setUser($_POST['usuario'])) {
                                if ($usuario->setDistribuidor($_POST['distribuidor'])) {
                                    if ($usuario->setPais($_POST['pais'])) {
                                        if ($usuario->HistorialSesiones()) {
                                            $result['status'] = 1;
                                        } else {
                                            $result['exception'] = Database::getException();
                                        }
                                    } else {
                                        $result['exception'] = 'Pais incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Distribuidor incorrecto';
                                }
                            } else {
                                $result['exception'] = 'Usuario incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Zona incorrecto';
                        }
                    } else {
                        $result['exception'] = 'Region incorrecta';
                    }
                } else {
                    $result['exception'] = 'IP incorrecto';
                }
                break;
            case 'GuardarCodigoValidacion':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setCodigo($_POST['codigovalidar'])) {
                    if ($usuario->setId($_SESSION['idusuario'])) {
                        if ($usuario->createCodigoSesiones()) {
                            $result['status'] = 1;
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Ingrese un valor para validar identidad';
                    }
                } else {
                    $result['exception'] = 'Ingrese un valor para enviar codigo';
                }
                break;
            case 'searchCodigoValidar':
                $_POST = $usuario->validateForm($_POST);
                if ($_POST['codigoos'] != '') {
                    if ($result['dataset'] = $usuario->validateCodigo($_POST['codigoos'])) {
                        $result['status'] = 1;
                        //$rows = count($result['dataset']);
                        $_SESSION['codigo'] = $usuario->getCodigo();
                        $result['message'] = 'Codigo Correcto';
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
            case 'GuardarCodigoValidacion':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setCodigo($_POST['codigovalidar'])) {
                    if ($usuario->setId($_SESSION['idusuario'])) {
                        if ($usuario->createCodigoSesiones()) {
                            $result['status'] = 1;
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Ingrese un valor para validar identidad';
                    }
                } else {
                    $result['exception'] = 'Ingrese un valor para enviar codigo';
                }
                break;
            case 'readOneMails':
                $_POST = $usuario->validateForm($_POST);
                if ($_POST['correo_enviar'] != '') {
                    if ($result['dataset'] = $usuario->searchCorreo($_POST['correo_enviar'])) {
                        $result['status'] = 1;
                        $rows = count($result['dataset']);
                        $result['message'] = 'Correo Encontrado en el registro';
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
                                } else {
                                    $result['exception'] = 'Telefono incorrecto';
                                }
                            } else {
                                $result['exception'] = 'Correo incorrecto';
                            }
                        } else {
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
                if ($usuario->checkTipo($_POST['usuario'])) {
                    if ($usuario->checkUser($_POST['usuario'])) {
                        if ($usuario->checkPassword($_POST['clave'])) {
                            $result['status'] = 1;
                            $result['message'] = 'Autenticación correcta';
                            $_SESSION['idusuario'] = $usuario->getId();
                            $_SESSION['aliasusuario'] = $usuario->getUsuario();
                            $_SESSION['idtipousuario'] = $usuario->getTipo();
                            $_SESSION['correousuario'] = $usuario->getCorreo();
                            if ($result['dataset'] = $usuario->createCodigo($_POST['usuario'])) {
                                $result['status'] = 1;
                            } else {
                                if (Database::getException()) {
                                    $result['exception'] = Database::getException();
                                } else {
                                    $result['exception'] = 'No hay coincidencias';
                                }
                            }
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
                } else {
                    if (Database::getException()) {
                        $result['exception'] = Database::getException();
                    } else {
                        $result['exception'] = 'Usuario Bloqueado';
                    }
                }
                break;            
            case 'HistorialSesiones':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setIp($_POST['ipdata'])) {
                    if ($usuario->setRegion($_POST['region'])) {
                        if ($usuario->setZona($_POST['zona'])) {
                            if ($usuario->setUser($_POST['usuario'])) {
                                if ($usuario->setDistribuidor($_POST['distribuidor'])) {
                                    if ($usuario->setPais($_POST['pais'])) {
                                        if ($usuario->HistorialSesiones()) {
                                            $result['status'] = 1;
                                        } else {
                                            $result['exception'] = Database::getException();
                                        }
                                    } else {
                                        $result['exception'] = 'Pais incorrecto';
                                    }
                                } else {
                                    $result['exception'] = 'Distribuidor incorrecto';
                                }
                            } else {
                                $result['exception'] = 'Usuario incorrecto';
                            }
                        } else {
                            $result['exception'] = 'Zona incorrecto';
                        }
                    } else {
                        $result['exception'] = 'Region incorrecta';
                    }
                } else {
                    $result['exception'] = 'IP incorrecto';
                }
                break;
            case 'pasarcodigo':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setCodigo($_POST['codigosenviar'])) {
                    if ($usuario->setCorreos($_POST['correo'])) {
                        if ($usuario->InsertCodigo()) {
                            $result['status'] = 1;
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'Correo incorrecto';
                    }
                } else {
                    $result['exception'] = 'Codigo incorrecto';
                }
                break;
            case 'searchCodigo':
                $_POST = $usuario->validateForm($_POST);
                if ($_POST['codigos'] != '') {
                    if ($result['dataset'] = $usuario->searchCodigo($_POST['codigos'])) {
                        $result['status'] = 1;
                        $rows = count($result['dataset']);
                        $result['message'] = 'Codigo Correcto';
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
            case 'restorePassword':
                $_POST = $usuario->validateForm($_POST);
                if ($_POST['clave'] == $_POST['confirmacion']) {
                    if ($usuario->setClave($_POST['clave'])) {
                        if ($usuario->restorePassword()) {
                            $result['status'] = 1;
                            $result['message'] = 'Clare restaurada correctamente';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = $usuario->getPasswordError();
                    }
                } else {
                    $result['exception'] = 'Claves distintas';
                }
                break;
            case 'intentosFallidos':
                $_POST = $usuario->validateForm($_POST);
                if ($usuario->setIntentos($_POST['contador'])) {
                    if ($usuario->setUser($_POST['usuario'])) {
                        if ($usuario->validarIntentos()) {
                            $result['status'] = 1;
                            $result['message'] = 'Su Usuario ha sido bloqueado debido a que ha intentado demasiados intentos de inicio de sesion, Comuniquese con su supervisor para resolver el caso';
                        } else {
                            $result['exception'] = Database::getException();
                        }
                    } else {
                        $result['exception'] = 'usuario no reconocido';
                    }
                } else {
                    $result['exception'] = 'Cantidad de intentos no reconocida';
                }
                break;
                case 'intentosFallidosenvio':
                    $_POST = $usuario->validateForm($_POST);
                    if ($usuario->setIntentosenvio($_POST['contador'])) {
                        if ($usuario->setUser($_POST['usuario'])) {
                            if ($usuario->validarIntentosEnvios()) {
                                $result['status'] = 1;
                                //$result['message'] = 'Su Usuario ha sido bloqueado debido a que ha intentado demasiados intentos de inicio de sesion, Comuniquese con su supervisor para resolver el caso';
                            } else {
                                $result['exception'] = Database::getException();
                            }
                        } else {
                            $result['exception'] = 'usuario no reconocido';
                        }
                    } else {
                        $result['exception'] = 'Cantidad de intentos no reconocida';
                    }
                    break;
                case 'searchDays':
                    $_POST = $usuario->validateForm($_POST);
                    if ($_POST['usuario'] != '') {
                        if ($result['dataset'] = $usuario->prueba90Dias($_POST['usuario'])) {
                            $result['status'] = 1;
                            //$rows = count($result['dataset']);
                            //$result['message'] = 'Codigo Correcto';
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
