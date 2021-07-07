// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_CONSULTAS = '../../app/api/private/consulta.php?action=';
const ENDPOINT_CAUSA = '../../app/api/private/consulta.php?action=readAllCAUSA';
const ENDPOINT_PROCEDIMIENTO = '../../app/api/private/consulta.php?action=readAllPROCEDIMIENTO';


// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js 
    readRows(API_CONSULTAS);
});


// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
    dataset.map(function (row) {                
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `
            <tr>
                <td>${row.notasconsulta}</td>                
                <td>${row.costoconsulta}</td> 
                <td>${row.fechaconsulta}</td> 
                <td>${row.causa}</td>                 
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idconsulta})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>                    
                    <a href="#" onclick="openDeleteDialog(${row.idconsulta})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
                    <a href="#" onclick="openInsertProcedures(${row.idconsulta})" class="btn waves-effect green tooltipped" data-tooltip="Asignar Procedimientos"><i class="material-icons">assignment</i></a>
                    <a href="#" onclick="openProcedures(${row.idconsulta})" class="btn waves-effect grey tooltipped" data-tooltip="Buscar Procedimientos"><i class="material-icons">search</i></a>                    
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
                <td>${row.horaconsulta}</td>                                    
                <td>${row.nombreprocedimiento}</td> 
                <td>${row.descripcionprocedimiento}</td>                                                
                <td>
                <a href="#" onclick="openUpdateprocedures(${row.idconsultaprocedimiento})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                </td>

            </tr>
        `;
      });
    // Se agregan las filas al cuerpo de la tabla mediante su id para mostrar los registros.
    document.getElementById('proced-rows').innerHTML = content;
    // Se inicializa el componente Material Box asignado a las imagenes para que funcione el efecto Lightbox.
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
    // Se inicializa el componente Tooltip asignado a los enlaces para que funcionen las sugerencias textuales.
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));
}


document.getElementById('search-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js
    searchRows(API_CONSULTAS, 'search-form');
});

function openCreateDialog() {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Ingresar Consulta';
    // Se llama a la función para llenar el select del estado cliente         
    fillSelect(ENDPOINT_CAUSA, 'causa_consulta', null);
} 

// Función para preparar el formulario al momento de modificar un registro.

function openUpdateDialog(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Actualizar Información del Paciente';        
    // Se define un objeto con los datos del registro seleccionado.   
    document.getElementById('fecha_consulta').required = false;

    const data = new FormData();
    data.append('id_consulta', id);

    fetch(API_CONSULTAS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_consulta').value = response.dataset.idconsulta;
                    document.getElementById('notas_consulta').value = response.dataset.notasconsulta;
                    document.getElementById('precio_consulta').value = response.dataset.costoconsulta;
                    document.getElementById('fecha_consulta').value = response.dataset.fechaconsulta;
                    document.getElementById('hora_consulta').value = response.dataset.horaconsulta;
                    fillSelect(ENDPOINT_CAUSA, 'causa_consulta', response.dataset.idcausaconsulta);                    
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


document.getElementById('save-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    // Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    if (document.getElementById('id_consulta').value) {
        action = 'update';
    } else {
        action = 'create';
    } 
   
    saveRow(API_CONSULTAS, action, 'save-form', 'save-modal');
});


document.getElementById('save-procedimiento-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'updateRowprocedure';
    //--- Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    // if (document.getElementById('id_consultasP').value) {
    //     action = 'updateRowprocedure';
    // }   

    saveRow(API_CONSULTAS, action, 'save-procedimiento-form', 'save-procedimiento-modal');
});


document.getElementById('save-procedimientos-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'createRowprocedure';
    //--- Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.       

    saveRow(API_CONSULTAS, action, 'save-procedimientos-form', 'save-procedimientos-modal');
});
//--------------




// Función para establecer el registro a eliminar y abrir una caja de dialogo de confirmación.
function openDeleteDialog(id) {
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_consulta', id);
    // Se llama a la función que elimina un registro. Se encuentra en el archivo components.js
    confirmDelete(API_CONSULTAS, data);
}


// Función para preparar el formulario al momento de modificar un registro.
function openInsertProcedures(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-procedimientos-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-procedimientos-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-procedimientos-title').textContent = 'Asignar Procedimientos';        
    // Se define un objeto con los datos del registro seleccionado.
    document.getElementById('fecha_consultasa').disabled = true;  

    const data = new FormData();
    data.append('id_consultasPr', id);

    fetch(API_CONSULTAS + 'readOneAsignado2', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_consultasPr').value = response.dataset.idconsulta;
                    document.getElementById('fecha_consultasa').value = response.dataset.fechaconsulta;
                    fillSelect(ENDPOINT_PROCEDIMIENTO, 'procedimientos', null);                   
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

function openProcedures(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('show-a-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('show-proced-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-proced-title').textContent = 'Procedimientos';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_consultaP', id);

    fetch(API_CONSULTAS + 'readOneProcedure', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {               
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {                    
                    document.getElementById('id_consultaP').value = response.dataset.idconsulta;  
                    document.getElementById('notas_consultaP').value = response.dataset.notasconsulta;                                                                               
                    searchRows1(API_CONSULTAS, 'show-a-form');                                                                      

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


function openUpdateprocedures(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-procedimiento-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario. 
    let instance = M.Modal.getInstance(document.getElementById('save-procedimiento-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-procedimiento-title').textContent = 'Actualizar Datos';        
    // Se define un objeto con los datos del registro seleccionado.    
    document.getElementById('fecha_consultas').disabled = true;
    const data = new FormData();
    data.append('id_consultasP', id);

    fetch(API_CONSULTAS + 'readOneProcedure1', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_consultasP').value = response.dataset.idconsultaprocedimiento;
                    document.getElementById('fecha_consultas').value = response.dataset.horaconsulta;
                    fillSelect(ENDPOINT_PROCEDIMIENTO, 'procedimiento', response.dataset.idprocedimiento);
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
