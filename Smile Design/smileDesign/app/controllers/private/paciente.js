// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PACIENTES = '../../app/api/private/paciente.php?action=';
const ENDPOINT_ESTADO = '../../app/api/private/paciente.php?action=readAllESTADO';
const ENDPOINT_DOCTOR = '../../app/api/private/paciente.php?action=readAllDOCTOR';
const ENDPOINT_P1 = '../../app/api/private/paciente.php?action=readAllP1';
const ENDPOINT_P2 = '../../app/api/private/paciente.php?action=readAllP2';
const ENDPOINT_P3 = '../../app/api/private/paciente.php?action=readAllP3';
const ENDPOINT_P4 = '../../app/api/private/paciente.php?action=readAllP4';
const ENDPOINT_P5 = '../../app/api/private/paciente.php?action=readAllP5';
const ENDPOINT_P6 = '../../app/api/private/paciente.php?action=readAllP6';
const ENDPOINT_P7 = '../../app/api/private/paciente.php?action=readAllP7';
const ENDPOINT_P8 = '../../app/api/private/paciente.php?action=readAllP8';

// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js 
    readRows(API_PACIENTES);
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
                <td>${row.fechanacimiento}</td> 
                <td>${row.duipaciente}</td> 
                <td>${row.telefonopaciente}</td> 
                <td>${row.correopaciente}</td> 
                <td>${row.estadopaciente}</td>                
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idpaciente})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                    <a href="#" onclick="openAnswerDialog(${row.idpaciente})" class="btn waves-effect purple tooltipped" data-tooltip="Ingresar Preguntas"><i class="material-icons">quiz</i></a>
                    <a href="#" onclick="openDeleteDialog(${row.idpaciente})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
                    <a href="#" onclick="openInsertDoctor(${row.idpaciente})" class="btn waves-effect green tooltipped" data-tooltip="Asignar Doctor"><i class="material-icons">assignment</i></a>
                    <a href="#" onclick="openAssignements(${row.idpaciente})" class="btn waves-effect grey tooltipped" data-tooltip="Buscar Doctores"><i class="material-icons">search</i></a>                    
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
                <td>${row.nombredoctor}</td> 
                <td>${row.apellidodoctor}</td>                                                
                <td>
                <a href="#" onclick="openUpdateasignements(${row.idpacienteasignado})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                </td>

            </tr>
        `;
      });
    // Se agregan las filas al cuerpo de la tabla mediante su id para mostrar los registros.
    document.getElementById('asignado-rows').innerHTML = content;
    // Se inicializa el componente Material Box asignado a las imagenes para que funcione el efecto Lightbox.
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
    // Se inicializa el componente Tooltip asignado a los enlaces para que funcionen las sugerencias textuales.
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));
}


document.getElementById('search-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js
    searchRows(API_PACIENTES, 'search-form');
});

function openCreateDialog() {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Ingresar Paciente';
    // Se llama a la función para llenar el select del estado cliente         
    fillSelect(ENDPOINT_ESTADO, 'estado_paciente', null);
} 

function openAnswerDialog(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-preguntas-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-preguntas-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title-pr').textContent = 'Guardar Preguntas';
    // Se llama a la función para llenar el select del estado cliente         
    fillSelect2(ENDPOINT_P1, 'pregunta1', null);
    fillSelect2(ENDPOINT_P2, 'pregunta2', null);
    fillSelect2(ENDPOINT_P3, 'pregunta3', null);
    fillSelect2(ENDPOINT_P4, 'pregunta4', null);
    fillSelect2(ENDPOINT_P5, 'pregunta5', null);
    fillSelect2(ENDPOINT_P6, 'pregunta6', null);
    fillSelect2(ENDPOINT_P7, 'pregunta7', null);
    fillSelect2(ENDPOINT_P8, 'pregunta8', null);

    const data = new FormData();
    data.append('id_pacientesP', id);

    fetch(API_PACIENTES + 'readOneAnswer', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pacientesP').value = response.dataset.idpaciente;                                       
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
    document.getElementById('archivo_paciente').required = false;

    const data = new FormData();
    data.append('id_paciente', id);

    fetch(API_PACIENTES + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_paciente').value = response.dataset.idpaciente;
                    document.getElementById('nombre_paciente').value = response.dataset.nombrepaciente;
                    document.getElementById('apellido_paciente').value = response.dataset.apellidopaciente;
                    document.getElementById('fecha_nacimiento').value = response.dataset.fechanacimiento;
                    document.getElementById('dui_paciente').value = response.dataset.duipaciente;
                    document.getElementById('direccion_paciente').value = response.dataset.direccionpaciente;
                    document.getElementById('telefono_paciente').value = response.dataset.telefonopaciente;
                    document.getElementById('correo_cliente').value = response.dataset.correopaciente;
                    fillSelect(ENDPOINT_ESTADO, 'estado_paciente', response.dataset.idestadopaciente);                    
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
    if (document.getElementById('id_paciente').value) {
        action = 'update';
    } else {
        action = 'create';
    } 
   
    saveRow(API_PACIENTES, action, 'save-form', 'save-modal');
});


document.getElementById('save-asignado-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    //--- Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    if (document.getElementById('id_pacientesD').value) {
        action = 'updateRowassignement';
    }   

    saveRow(API_PACIENTES, action, 'save-asignado-form', 'save-asignado-modal');
});


document.getElementById('save-asignados-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'createRowassignement';
    //--- Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.       

    saveRow(API_PACIENTES, action, 'save-asignados-form', 'save-asignados-modal');
});

// Función para establecer el registro a eliminar y abrir una caja de dialogo de confirmación.
function openDeleteDialog(id) {
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_paciente', id);
    // Se llama a la función que elimina un registro. Se encuentra en el archivo components.js
    confirmDelete(API_PACIENTES, data);
}


// Función para preparar el formulario al momento de modificar un registro.
function openInsertDoctor(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-asignados-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-asignados-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title-as').textContent = 'Asignar Doctores';        
    // Se define un objeto con los datos del registro seleccionado.
    document.getElementById('nombre_pacientesA').disabled = true;  

    const data = new FormData();
    data.append('id_pacientesDA', id);

    fetch(API_PACIENTES + 'readOneAsignado2', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pacientesDA').value = response.dataset.idpaciente;
                    document.getElementById('nombre_pacientesAg').value = response.dataset.nombrepaciente;
                    fillSelect(ENDPOINT_DOCTOR, 'nombre_doctores', null);                   
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


function openAssignements(id) {
    // Se restauran los elementos del formulario.
    //document.getElementById('show-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('show-asignado-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-asignado-title').textContent = 'Doctores';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_pacienteA', id);

    fetch(API_PACIENTES + 'readOneDoctor', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {               
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {                    
                    document.getElementById('id_pacienteA').value = response.dataset.idpaciente;  
                    document.getElementById('nombre_pacienteA').value = response.dataset.nombrepaciente;                                                                               
                    searchRows2(API_PACIENTES, 'show-a-form');                                                                      

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


function openUpdateasignements(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-asignado-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario. 
    let instance = M.Modal.getInstance(document.getElementById('save-asignado-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title-a').textContent = 'Actualizar Datos';        
    // Se define un objeto con los datos del registro seleccionado.    
    document.getElementById('nombre_pacientesA').disabled = true;
    const data = new FormData();
    data.append('id_pacientesD', id);

    fetch(API_PACIENTES + 'readOneAsignado1', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pacientesD').value = response.dataset.idpacienteasignado;
                    document.getElementById('nombre_pacientesA').value = response.dataset.nombrepaciente;
                    fillSelect(ENDPOINT_DOCTOR, 'nombre_doctor', response.dataset.iddoctor);
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
