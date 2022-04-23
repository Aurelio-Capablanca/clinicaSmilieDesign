// Constante para establecer la ruta y parámetros de comunicación con la API.
const API_LOGIN = '../app/api/login.php?action=';
const API_CORREO = '../app/api/validarcorreo.php';

// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se inicializa el componente Tooltip asignado al botón del formulario para que funcione la sugerencia textual.
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));    
    HistorialSesion();
    // Petición para verificar si existen usuarios.
    fetch(API_LOGIN + 'readAll', {
        method: 'get'
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción
                if (response.status) {
                    //sweetAlert(1, response.message, null);
                } else {
                    // Se verifica si ocurrió un problema en la base de datos, de lo contrario se continua normalmente.
                    if (response.error) {
                        sweetAlert(2, response.exception, null);
                    } else {
                        sweetAlert(1, response.message, 'register.php');
                    }
                }
            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    }).catch(function (error) {
        console.log(error);
    });

});


function HistorialSesion(){
//pericion a API de ipinfo para obtener datos del cliente
    fetch('https://ipinfo.io/json?token=678b02f9a4faa4', {
        method: 'get'
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción
                if (response.status) {
                } else {
                    // Se verifica si ocurrió un problema en la API externa, de lo contrario se continua normalmente.
                    if (response.error) {
                        sweetAlert(2, response.exception, null);
                    } else {
                        let ips = response.ip;                        
                        document.getElementById('ipdata').value=ips.toString();
                        document.getElementById('region').value=response.region;
                        document.getElementById('zona').value=response.timezone;
                        document.getElementById('distribuidor').value=response.org;
                        document.getElementById('pais').value=response.country;
                    }
                }
            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    }).catch(function (error) {
        console.log(error);
    });
}

function confirmacion(codigo) {
    // Se restauran los elementos del formulario.
    document.getElementById('session-form').reset();
    const data = new FormData();    
    data.append('codigovalidar', codigo );
fetch(API_CORREO, {     
    method: 'post',
    body: data
}).then(function (request) {
    // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
    if (request.ok) {
        request.json().then(function (response) {
            // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción
            if (response.status) {
                sweetAlert(1, response.message, null);
            } else {
                // En caso contrario nos envia este mensaje
                sweetAlert(2, response.exception, null);
            }
        });
    } else {
        console.log(request.status + ' ' + request.statusText);
    }
}).catch(function (error) {
    console.log(error);
});

}


let validarintentos = 0;

function incrementClick() {
    var contador = ++validarintentos;
    document.getElementById('contador').value = contador;
}

// Método manejador de eventos que se ejecuta cuando se envía el formulario de iniciar sesión.
document.getElementById('session-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();    
    
    fetch(API_LOGIN + 'searchDays', {
        method: 'post',
        body: new FormData(document.getElementById('session-form'))
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                        var tiempo = document.getElementById('dias').value = response.dataset.dias;
                        if(tiempo>=90){
                            sweetAlert(3, 'Su contraseña excede el tiempo limite de vigencía, por favor proceda a recuperar su contraseña', 'restaurarcontraseña.php');
                        }
                        else {
                            fetch(API_LOGIN + 'logIn', {
                                method: 'post',
                                body: new FormData(document.getElementById('session-form'))
                            }).then(function (request) {
                                // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
                                if (request.ok) {
                                    request.json().then(function (response) {
                                        // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                                        if (response.status) {                    
                                            document.getElementById("codigovalidar").value = response.dataset.codigo;                    
                                            action = 'GuardarCodigoValidacion';
                                            saveRowCodigo(API_LOGIN, action, 'session-form');
                                            action = 'HistorialSesiones';
                                            saveRowhistorial(API_LOGIN, action, 'session-form');
                                            var codigo = document.getElementById("codigovalidar").value;
                                            confirmacion(codigo);
                                            sweetAlert(1, response.message, 'validarusuario.php');                                        
                                        } else {
                                            incrementClick();
                                            if (validarintentos==3){
                                             action = 'intentosFallidos';
                                             saveRowIntentosFallidos(API_LOGIN, action, 'session-form');
                                            }
                                            action = 'intentosFallidosenvio';
                                            saveRowIntentosFallidosConteo(API_LOGIN, action, 'session-form');
                                            sweetAlert(2, response.exception, null);
                                        }
                                    });
                                } else {
                                    console.log(request.status + ' ' + request.statusText);
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        }                    
                    //sweetAlert(1, response.message, 'validarusuario.php');                                        
                } else {
                    sweetAlert(2, response.exception, null);
                }
            });
        } else {
            console.log(request.status + ' ' + request.statusText);
        }
    }).catch(function (error) {
        console.log(error);
    });


    // fetch(API_LOGIN + 'logIn', {
    //     method: 'post',
    //     body: new FormData(document.getElementById('session-form'))
    // }).then(function (request) {
    //     // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
    //     if (request.ok) {
    //         request.json().then(function (response) {
    //             // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    //             if (response.status) {                    
    //                 document.getElementById("codigovalidar").value = response.dataset.codigo;                    
    //                 action = 'GuardarCodigoValidacion';
    //                 saveRowCodigo(API_LOGIN, action, 'session-form');
    //                 action = 'HistorialSesiones';
    //                 saveRowhistorial(API_LOGIN, action, 'session-form');
    //                 var codigo = document.getElementById("codigovalidar").value;
    //                 confirmacion(codigo);
    //                 sweetAlert(1, response.message, 'validarusuario.php');                                        
    //             } else {
    //                 incrementClick();
    //                 if (validarintentos==3){
    //                  action = 'intentosFallidos';
    //                  saveRowIntentosFallidos(API_LOGIN, action, 'session-form');
    //                 }                    
    //                 sweetAlert(2, response.exception, null);
    //             }
    //         });
    //     } else {
    //         console.log(request.status + ' ' + request.statusText);
    //     }
    // }).catch(function (error) {
    //     console.log(error);
    // });


});