// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PAGOS = '../../app/api/private/pago.php?action=';
const ENDPOINT_TIPO = '../../app/api/private/pago.php?action=readAllTIPO';
const ENDPOINT_ESTADO= '../../app/api/private/pago.php?action=readAllESTADO';


// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js 
    readRows(API_PAGOS);
});


// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
    dataset.map(function (row) {                
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `
            <tr>
                <td>${row.nombrepaciente}</td>
                <td>${row.apellidopaciente}</td> 
                <td>${row.fechainicio}</td>
                <td>${row.pagodebe}</td>
                <td>${row.pagoabono}</td>
                <td>${row.pagototal}</td>
                <td>${row.pagosaldo}</td>
                <td>${row.tipopago}</td>
                <td>${row.estadopago}</td>
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idpago})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                    <a href="#" onclick="openInsertSaldo(${row.idpago})" class="btn waves-effect purple tooltipped" data-tooltip="Ingresar Pago"><i class="material-icons">payments</i></a>
                    <a href="#" onclick="openDeleteDialog(${row.idpago})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
                    <a href="#" onclick="openInsertCalculo(${row.idpago})" class="btn waves-effect green tooltipped" data-tooltip="Realizar Calculo"><i class="material-icons">credit_score</i></a>
                    <a href="#" onclick="openCount(${row.idpago})" class="btn waves-effect grey tooltipped" data-tooltip="Buscar Pagos"><i class="material-icons">search</i></a>
                    <a href="#" onclick="openActualizarCuenta(${row.idpago})" class="btn waves-effect orange tooltipped" data-tooltip="Actualizar Cuenta"><i class="material-icons">paid</i></a>
                </td>
            </tr>
        `;
    });
    // Se agregan las filas al cuerpo de la tabla mediante su id para mostrar los registros.
    document.getElementById('tbody-rows').innerHTML = content;
    // Se inicializa el componente Material Box asignado a las imagenes para que funcione el efecto Lightbox.
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
    // Se inicializa el componente Tooltip asignado a los enlaces para que funcionen las sugerencias textuales.
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));
}

function fillTables(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
   dataset.map(function (row) {   
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `                           
            <tr>
                <td>${row.debe}</td>
            </tr>
        `;
      });
    // Se agregan las filas al cuerpo de la tabla mediante su id para mostrar los registros.
    document.getElementById('count-rows').innerHTML = content;
    // Se inicializa el componente Material Box asignado a las imagenes para que funcione el efecto Lightbox.
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
    // Se inicializa el componente Tooltip asignado a los enlaces para que funcionen las sugerencias textuales.
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));
}



document.getElementById('search-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js
    searchRows(API_PAGOS, 'search-form');
});


document.getElementById('save-Cuenta-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'createCuenta';   
   
    saveRow(API_PAGOS, action, 'save-Cuenta-form', 'save-Cuenta-modal');
});

function openInsertCalculo(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-Cuenta-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-Cuenta-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title-c').textContent = 'Calcular Total';        
    // Se define un objeto con los datos del registro seleccionado.     

    const data = new FormData();
    data.append('id_pagos', id);

    fetch(API_PAGOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pagos').value = response.dataset.idpago;
                    document.getElementById('nombres').value = response.dataset.nombrepaciente;
                    // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.                    
                    M.updateTextFields();                    
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
}

document.getElementById('save-Saldo-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'createSaldo';   
   
    saveRow(API_PAGOS, action, 'save-Saldo-form', 'save-Saldo-modal');
});

function openInsertSaldo(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-Saldo-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-Saldo-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title-S').textContent = 'Ingresar Abono o Pago';        
    // Se define un objeto con los datos del registro seleccionado.     

    const data = new FormData();
    data.append('id_pago', id);

    fetch(API_PAGOS + 'readOneSaldo', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pago').value = response.dataset.idpago;
                    document.getElementById('nombress').value = response.dataset.nombrepaciente;
                    // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.                    
                    M.updateTextFields();                    
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
}

function openCount(id) {
    // Se restauran los elementos del formulario.
    //document.getElementById('show-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('show-cuenta-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-cuenta-title').textContent = 'Cuenta';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_pagoSD', id);

    fetch(API_PAGOS + 'readOneCuentas', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {               
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {                    
                    document.getElementById('id_pagoSD').value = response.dataset.tr;
                    readRowsCuenta(API_PAGOS);
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
} 

document.getElementById('save-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'update';   
   
    saveRow(API_PAGOS, action, 'save-form', 'save-modal');
});

function openUpdateDialog(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Actualizar Tipo de Pago';        
    // Se define un objeto con los datos del registro seleccionado.    

    const data = new FormData();
    data.append('id_pagoT', id);

    fetch(API_PAGOS + 'readOneT', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.                    
                    document.getElementById('id_pagoT').value = response.dataset.idpago;
                    fillSelect(ENDPOINT_TIPO, 'tipo', response.dataset.idtipopago);                    
                    // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.
                    M.updateTextFields();                    
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
}

document.getElementById('save-formE').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'deleteLogic';   
   
    saveRow(API_PAGOS, action, 'save-formE', 'save-modalE');
});


function openDeleteDialog(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-formE').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modalE'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-titleE').textContent = 'Actualizar Estado del Pago';        
    // Se define un objeto con los datos del registro seleccionado.    

    const data = new FormData();
    data.append('id_pagoE', id);

    fetch(API_PAGOS + 'readOneE', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.                    
                    document.getElementById('id_pagoE').value = response.dataset.idpago;
                    fillSelect(ENDPOINT_ESTADO, 'estado', response.dataset.idestadopago);                    
                    // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.
                    M.updateTextFields();                    
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
}

// document.getElementById('save-Actualizar-form').addEventListener('submit', function (event) {
//     // Se evita recargar la página web después de enviar el formulario.
//     event.preventDefault();
//     // Se define una variable para establecer la acción a realizar en la API.
//     let action = 'UpdateCuenta';   
   
//     saveRow(API_PAGOS, action, 'save-Actualizar-form', 'save-Actualizar-modal');
// });


// function openActualizarCuenta(id) {
//     // Se restauran los elementos del formulario.
//     document.getElementById('save-Actualizar-form').reset();
//     // Se abre la caja de dialogo (modal) que contiene el formulario.
//     let instance = M.Modal.getInstance(document.getElementById('save-Actualizar-modal'));
//     instance.open();
//     // Se asigna el título para la caja de dialogo (modal).
//     document.getElementById('modal-title-A').textContent = 'Actualizar Cuenta';        
//     // Se define un objeto con los datos del registro seleccionado.    

//     const data = new FormData();
//     data.append('id_pagoA', id);

//     fetch(API_PAGOS + 'readOneE', {
//         method: 'post',
//         body: data
//     }).then(function (request) {
//         // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
//         if (request.ok) {
//             request.json().then(function (response) {
//                 // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
//                 if (response.status) {
//                     // Se inicializan los campos del formulario con los datos del registro seleccionado.                    
//                     document.getElementById('id_pagoA').value = response.dataset.idpago;
//                     document.getElementById('nombressA').value = response.dataset. nombrepaciente;                    
//                     // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.
//                     M.updateTextFields();                    
//                 } else {
//                     sweetAlert(2, response.exception, null);
//                 }
//             });
//         } else {
//             console.log(request.status + ' ' + request.statusText);
//         }
//     }).catch(function (error) {
//         console.log(error);
//     });
// }
