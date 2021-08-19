<?php
require_once('../../helpers/database.php');
require_once('../../helpers/validator.php');
require_once('../../models/pacientes.php'); 

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
	 // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
//session_start();
	 // Se instancia la clase correspondiente. 
	 $paciente = new Pacientes;
	 // Se declara e inicializa un arreglo para guardar el resultado que retorna la API. 
	 $result = array('status' => 0, 'message' => null, 'exception' => null);
	 // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
//if (isset($_SESSION['id_usuario'])) {
		  // Se compara la acción a realizar cuando un administrador ha iniciado sesión. El socialismo no funciona 
		  switch ($_GET['action']) {
				case 'readAll':
					 if ($result['dataset'] = $paciente->readAll()) {
						  $result['status'] = 1;
					 } else {
						  if (Database::getException()) {
								$result['exception'] = Database::getException();
						  } else {
								$result['exception'] = 'No hay Pacientes registrados';
						  }
					 }
					 break;
					 case 'readAllESTADO':
						if ($result['dataset'] = $paciente->readAllESTADO()) {
							 $result['status'] = 1;
						} else {
							 if (Database::getException()) {
								   $result['exception'] = Database::getException();
							 } else {
								   $result['exception'] = 'No hay Estados para pacientes registrados';
							 }
						}
						break;
						case 'readAllDOCTOR':
							if ($result['dataset'] = $paciente->readAllDOCTOR()) {
								 $result['status'] = 1;
							} else {
								 if (Database::getException()) {
									   $result['exception'] = Database::getException();
								 } else {
									   $result['exception'] = 'No hay Estados para pacientes registrados';
								 }
							}
							break;
						case 'readAllP1':
							if ($result['dataset'] = $paciente->readAllP1()) {
								 $result['status'] = 1;
							} else {
								 if (Database::getException()) {
									   $result['exception'] = Database::getException();
								 } else {
									   $result['exception'] = 'No hay Estados para pacientes registrados';
								 }
							}
							break;
							case 'readAllP2':
								if ($result['dataset'] = $paciente->readAllP2()) {
									 $result['status'] = 1;
								} else {
									 if (Database::getException()) {
										   $result['exception'] = Database::getException();
									 } else {
										   $result['exception'] = 'No hay Estados para pacientes registrados';
									 }
								}
								break;
								case 'readAllP3':
									if ($result['dataset'] = $paciente->readAllP3()) {
										 $result['status'] = 1;
									} else {
										 if (Database::getException()) {
											   $result['exception'] = Database::getException();
										 } else {
											   $result['exception'] = 'No hay Estados para pacientes registrados';
										 }
									}
								break;
								case 'readAllP4':
									if ($result['dataset'] = $paciente->readAllP4()) {
										 $result['status'] = 1;
									} else {
										 if (Database::getException()) {
											   $result['exception'] = Database::getException();
										 } else {
											   $result['exception'] = 'No hay Estados para pacientes registrados';
										 }
									}
								break;
								case 'readAllP5':
									if ($result['dataset'] = $paciente->readAllP5()) {
										 $result['status'] = 1;
									} else {
										 if (Database::getException()) {
											   $result['exception'] = Database::getException();
										 } else {
											   $result['exception'] = 'No hay Estados para pacientes registrados';
										 }
									}
									break;
									case 'readAllP6':
										if ($result['dataset'] = $paciente->readAllP6()) {
											 $result['status'] = 1;
										} else {
											 if (Database::getException()) {
												   $result['exception'] = Database::getException();
											 } else {
												   $result['exception'] = 'No hay Estados para pacientes registrados';
											 }
										}
										break;
										case 'readAllP7':
											if ($result['dataset'] = $paciente->readAllP7()) {
												 $result['status'] = 1;
											} else {
												 if (Database::getException()) {
													   $result['exception'] = Database::getException();
												 } else {
													   $result['exception'] = 'No hay Estados para pacientes registrados';
												 }
											}
										break;
										case 'readAllP8':
											if ($result['dataset'] = $paciente->readAllP8()) {
												 $result['status'] = 1;
											} else {
												 if (Database::getException()) {
													   $result['exception'] = Database::getException();
												 } else {
													   $result['exception'] = 'No hay Estados para pacientes registrados';
												 }
											}
										break;
					 case 'search':
					 $_POST = $paciente->validateForm($_POST);
					 if ($_POST['search'] != '') {
						  if ($result['dataset'] = $paciente->searchRows($_POST['search'])) {
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
					 $_POST = $paciente->validateForm($_POST);
					 if ($paciente->setNombre($_POST['nombre_paciente'])) {
						if ($paciente->setApellido($_POST['apellido_paciente'])) {
							if ($paciente->setFecha($_POST['fecha_nacimiento'])) {
							 if ($paciente->setDUI($_POST['dui_paciente'])) {
								if ($paciente->setDireccion($_POST['direccion_paciente'])) { 
								if ($paciente->setTelefono($_POST['telefono_paciente'])) {
									if ($paciente->setCorreo($_POST['correo_cliente'])) 
									{if (is_uploaded_file($_FILES['archivo_paciente']['tmp_name'])) {
										if ($paciente->setImagen($_FILES['archivo_paciente'])) {
											if (isset($_POST['estado_paciente'])) {
											if ($paciente->setEstado($_POST['estado_paciente'])) {
											if ($paciente->createRow()) {
												$result['status'] = 1;
												if ($paciente->saveFile($_FILES['archivo_paciente'], $paciente->getRuta(), $paciente->getImagen())) {
													$result['message'] = 'Paciente creado correctamente';
												} else {
													$result['message'] = 'Paciente creado pero no se guardó la imagen';
												}											
												
											} else {
												$result['exception'] = Database::getException();;
											}
										} else {
											$result['exception'] = 'Categoría incorrecta';
										}
									} else {
										$result['exception'] = 'Seleccione una categoría';
									}											
										} else {
											$result['exception'] = $paciente->getImageError();
										}
									} else {
										$result['exception'] = 'Seleccione una imagen';
									} 							
							} else {
								$result['exception'] = 'Correo incorrecto';
							}
								} else {
									$result['exception'] = 'Dirección incorrecto';
								}	
							   } else {
									$result['exception'] = 'Teléfono incorrecto';
								}
								} else {
									$result['exception'] = 'DUI incorrecto';
								}																																																																																			
								  } else {
									$result['exception'] = 'Fecha incorrecto';
								  }
								} else {
									$result['exception'] = 'Apellido incorrecto';
							   }                            
							} else {
							 $result['exception'] = 'Nombre incorrecto';
							}
					 break;
					case 'readOne':
					 if ($paciente->setId($_POST['id_paciente'])) {
						  if ($result['dataset'] = $paciente->readOne()) {
								$result['status'] = 1;
						  } else {
								if (Database::getException()) {
									 $result['exception'] = Database::getException();
								} else {
									 $result['exception'] = 'Paciente inexistente';
								}
						  }
					 } else {
						  $result['exception'] = 'Producto incorrecto';
					 }
					 break;
					 case 'readOneAnswer':
						if ($paciente->setId($_POST['id_pacientesP'])) {
							 if ($result['dataset'] = $paciente->readOne()) {
								   $result['status'] = 1;
							 } else {
								   if (Database::getException()) {
										$result['exception'] = Database::getException();
								   } else {
										$result['exception'] = 'Paciente inexistente';
								   }
							 }
						} else {
							 $result['exception'] = 'Producto incorrecto';
						}
						break;
						case 'createRowAnswers':
						$_POST = $paciente->validateForm($_POST);
						if ($paciente->setR1($_POST['respuesta1'])) {
						 if (isset($_POST['pregunta1'])) {
						  if ($paciente->setP1($_POST['pregunta1'])) {
						  if ($paciente->setR2($_POST['respuesta2'])) {
							if (isset($_POST['pregunta2'])) {
							   if ($paciente->setP2($_POST['pregunta2'])) {
							if ($paciente->setR3($_POST['respuesta3'])) {
								if (isset($_POST['pregunta3'])) {
								  if ($paciente->setP3($_POST['pregunta3'])) {
							  if ($paciente->setR4($_POST['respuesta4'])) {
								if (isset($_POST['pregunta4'])) {
									if ($paciente->setP4($_POST['pregunta4'])) {			
								if ($paciente->setR5($_POST['respuesta5'])) {
								   if (isset($_POST['pregunta5'])) {
									  if ($paciente->setP5($_POST['pregunta5'])) {
								  if ($paciente->setR6($_POST['respuesta6'])) {
									if (isset($_POST['pregunta6'])) {
										if ($paciente->setP6($_POST['pregunta6'])) {
									if ($paciente->setR7($_POST['respuesta7'])) {
										if (isset($_POST['pregunta7'])) {
											if ($paciente->setP7($_POST['pregunta7'])) {
									  if ($paciente->setR8($_POST['respuesta8'])) {
										if (isset($_POST['pregunta8'])) {
											if ($paciente->setP8($_POST['pregunta8'])) {		 
												if ($paciente->setRespuesta($_POST['notas'])) {
													if ($paciente->setId($_POST['id_pacientesP'])) {				
														if ($paciente->createRowRespuesta()) {
															$result['status'] = 1;
															$result['message'] = 'Datos Ingresados correctamente';                                                        
															} else {
															$result['exception'] = Database::getException();                                                        
															}									
													} else {
														$result['exception'] = 'Paciente incorrecto';
														}		
													} else {
													  $result['exception'] = 'Notas incorrecto';
													}
											} else {
												$result['exception'] = 'Producto incorrecto';
												}		
											} else {
											  $result['exception'] = 'Producto incorrecto';
											}
											} else {
												$result['exception'] = 'Respuesta 8 incorrecto';
												}		
											} else {
											  $result['exception'] = 'Producto incorrecto';
											}		
										} else {
											$result['exception'] = 'Producto incorrecto';
											}		
										} else {
										  $result['exception'] = 'Respuesta 7 incorrecto';
										}	
										} else {
											$result['exception'] = 'Producto incorrecto';
											}		
										} else {
										  $result['exception'] = 'Producto incorrecto';
										}
									} else {
										$result['exception'] = 'Respuesta 6 incorrecto';
										}		
									} else {
									  $result['exception'] = 'Producto incorrecto';
									}
									} else {
										$result['exception'] = 'Producto incorrecto';
										}		
									} else {
									  $result['exception'] = 'Respuesta 5 incorrecto';
									}		
								} else {
									$result['exception'] = 'Producto incorrecto';
									}		
								} else {
								  $result['exception'] = 'Producto incorrecto';
								}	
								} else {
									$result['exception'] = 'Respuesta 4 incorrecto';
									}		
								} else {
								  $result['exception'] = 'Producto incorrecto';
								}	
								} else {
									$result['exception'] = 'Producto incorrecto';
									}		
								} else {
								  $result['exception'] = 'Respuesta 3 incorrecto';
								}	
								} else {
									$result['exception'] = 'Producto incorrecto';
									}		
								} else {
								  $result['exception'] = 'Producto incorrecto';
								}
								} else {
									$result['exception'] = 'Respuesta 2 incorrecto';
									}		
								} else {
								  $result['exception'] = 'Producto incorrecto';
								}
							} else {
							$result['exception'] = 'Producto incorrecto';
							}		
					    } else {
						  $result['exception'] = 'Respuesta 1 incorrecto';
					    }						
						break;										 
						case 'update':
							$_POST = $paciente->validateForm($_POST);
							  if ($paciente->setId($_POST['id_paciente'])) {
								  if ($data = $paciente->readOne()) {
							     	if ($paciente->setNombre($_POST['nombre_paciente'])) {                            
								    	 if ($paciente->setApellido($_POST['apellido_paciente'])) {	
											if ($paciente->setFecha($_POST['fecha_nacimiento'])) {
												if ($paciente->setDUI($_POST['dui_paciente'])) {
													if ($paciente->setDireccion($_POST['direccion_paciente'])) {
													if ($paciente->setTelefono($_POST['telefono_paciente'])) {
														if ($paciente->setCorreo($_POST['correo_cliente'])) {		
															if (isset($_POST['estado_paciente'])) {
																if ($paciente->setEstado($_POST['estado_paciente'])) {
																	if ($paciente->updateRow()) {
																		$result['status'] = 1;
																		$result['message'] = 'Datos del Paciente Actualizados correctamente';                                                        
																		} else {
																		$result['exception'] = Database::getException();                                                        
																		}   
															} else {
																$result['exception'] = 'Categoría incorrecta';
															}
														} else {
															$result['exception'] = 'Seleccione una categoría';
														}
													} else {
														$result['exception'] = 'Correo incorrecto';
													}
													} else {
														$result['exception'] = 'Dirección incorrecta';
													}	
													} else {
														$result['exception'] = 'Teléfono incorrecto';
													}	
												} else {
													$result['exception'] = 'DUI incorrecto';
												}
											} else {
											  $result['exception'] = 'Fecha incorrecta';
									     	}																 
										 } else {
											$result['exception'] = 'Apellido incorrecto';
									     } 
									} else {
									  $result['exception'] = 'Nombre incorrecto';
									}
								} else {
								  $result['exception'] = 'Paciente inexistente';
								}
							  } else {
								$result['exception'] = 'Paciente incorrecto';
							   }
							  break;				 
					case 'delete':
					 if ($paciente->setId($_POST['id_paciente'])) {
						  if ($data = $paciente->readOne()) {
								if ($paciente->deleteRow()) {
									 $result['status'] = 1;									 
									$result['message'] = 'Datos del Paciente eliminados correctamente';									  
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
					 case 'searchOneDoctor':
						$_POST = $paciente->validateForm($_POST);
						if ($_POST['nombre_pacienteA'] != '') {
							if ($result['dataset'] = $paciente->searchOneDoctor($_POST['nombre_pacienteA'])) {
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
				case 'readOneDoctor':      
					if ($paciente->setId($_POST['id_pacienteA'])) {                            
						// if ($result['dataset'] = $paciente->readOneDoctor()) {
						// 	$result['status'] = 1;                                
						// } else {
						// 	if (Database::getException()) {
						// 		$result['exception'] = Database::getException();
						// 	} else {
						// 		$result['exception'] = 'Paciente no posee doctores asignados';
						// 	}
						// }  
						$result['dataset'] = $paciente->readOneDoctor();
						$result['status'] = 1;                       
					} else {
						$result['exception'] = 'Paciente sin datos';
					}                    
					break;
					case 'readOneA':
						if ($paciente->setId($_POST[''])) {
							  if ($result['dataset'] = $paciente->readOne()) {
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
						case 'readOneAsignado1':
							if ($paciente->setId($_POST['id_pacientesD'])) {
								  if ($result['dataset'] = $paciente->readOneAsignado1()) {
									   $result['status'] = 1;
								  } else {
									   if (Database::getException()) {
											$result['exception'] = Database::getException();
									   } else {
											$result['exception'] = 'Paciente inexistente';
									   }
								  }
							} else {
								  $result['exception'] = 'Paciente incorrecto';
							}							
							break;
							case 'readOneAsignado2':
								if ($paciente->setId($_POST['id_pacientesDA'])) {
									  if ($result['dataset'] = $paciente->readOne()) {
										   $result['status'] = 1;
									  } else {
										   if (Database::getException()) {
												$result['exception'] = Database::getException();
										   } else {
												$result['exception'] = 'Paciente inexistente';
										   }
									  }
								} else {
									  $result['exception'] = 'Paciente incorrecto';
								}							
								break;
							case'updateRowassignement':
								$_POST = $paciente->validateForm($_POST);
								if ($paciente->setId($_POST['id_pacientesD'])) {
									if ($data = $paciente->readOneAsignado1()) {
										if (isset($_POST['nombre_doctor'])) {
											if ($paciente->setidDoctor($_POST['nombre_doctor'])) {

												if ($paciente->updateRowassignement()) {
													$result['status'] = 1;
													$result['message'] = 'Asignación Actualizada Correctamente';                                                        
												  } else {
													  $result['exception'] = Database::getException();                                                        
												  }
	
										} else {
											$result['exception'] = 'Paciente inexistente';
										}
								} else {
								  $result['exception'] = 'Paciente inexistente';
								}	
							} else {
						      $result['exception'] = 'Paciente inexistente';
						    }
						} else {
						  $result['exception'] = 'Paciente inexistente';
					    }														
						break;
						case 'createRowassignement':
							$_POST = $paciente->validateForm($_POST);
							if ($paciente->setId($_POST['id_pacientesDA'])) {
								if (isset($_POST['nombre_doctores'])) {
									if ($paciente->setidDoctor($_POST['nombre_doctores'])) {
										if ($paciente->createRowassignement()) {
											$result['status'] = 1;
											$result['message'] = 'Asignación Creada Correctamente';                                                        
										  } else {
											  $result['exception'] = Database::getException();                                                        
										  }
								} else {
									$result['exception'] = 'Paciente inexistente';
								}	
						  }else {
						   $result['exception'] = 'Paciente inexistente';
						  }		
						} else {
					      $result['exception'] = 'Paciente inexistente';
					    }
						break;
						case 'readPacientesTipos':
							if ($paciente->setId($_POST['id_pacientetratamiento'])) {
								if ($result['dataset'] = $paciente->readPacientesTipos()) {
									$result['status'] = 1;
								} else {
									if (Database::getException()) {
										$result['exception'] = Database::getException();
									} else {
										$result['exception'] = 'Identificador inexistente';
									}
								}
							} else {
								$result['exception'] = 'Identificador incorrecto';
							}     
						break;
						case 'readOnes':
							if ($paciente->setId($_POST['id_pacientetratamiento'])) {
								if ($result['dataset'] = $paciente->readOne()) {
									  $result['status'] = 1;
								} else {
									  if (Database::getException()) {
										   $result['exception'] = Database::getException();
									  } else {
										   $result['exception'] = 'Paciente inexistente';
									  }
								}
						   } else {
								$result['exception'] = 'Producto incorrecto';
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
