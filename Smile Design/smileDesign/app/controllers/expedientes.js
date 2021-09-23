// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../app/api/expedientes.php?action=';
const ENDPOINT_CATEGORIAS = '../app/api/pacienteasignado.php?action=readAllPaciente';

document.addEventListener('DOMContentLoaded', function () {
    readRows(API_PRODUCTOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    dataset.map(function (row) {
        content += `
            <tr>
                <td><img src="../../resources/img/odontograma/${row.odontograma}" class="materialboxed" height="100"></td>
                <td><img src="../../resources/img/periodontograma/${row.periodontograma}" class="materialboxed" height="100"></td>                
                <td>${row.nombrepaciente}</td>
                <td>${row.apellidopaciente}</td>
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idexpediente})" class="waves-effect waves-yellow btn updateButton"><i class="material-icons left">update</i></a>
                </td>
                <td>
                    <a href="#" onclick="openDeleteDialog(${row.idexpediente})" class="waves-effect waves btn deleteButton"><i class="material-icons left">delete</i></a>
                    <a href="#" onclick="openCreateArchivo(${row.idexpediente})" class="btn waves-effect green tooltipped" data-tooltip="Insertar Archivos"><i class="material-icons">assignment</i></a>
                    <a href="#" onclick="openArchives(${row.idexpediente})" class="btn waves-effect grey tooltipped" data-tooltip="Mostrar Documentos"><i class="material-icons">search</i></a>
                </td>
            </tr>
        `;          
    });
    document.getElementById('tbody-rows').innerHTML = content;
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
    M.Tooltip.init(document.querySelectorAll('.tooltipped'));
}

function fillTables(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
   dataset.map(function (row) {   
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `                           
            <tr>
                <td>${row.idarchivo}</td>                                                              
                <td>
                    <a href="#" onclick="openUpdateArchivos(${row.idarchivo})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                    <a href="../app/reports/archivo.php?id=${row.idarchivo}" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de Expedientes"><i class="material-icons">assignment</i></a>
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

// Método manejador de eventos que se ejecuta cuando se envía el formulario de buscar.
document.getElementById('search-form').addEventListener('submit', function (event) {
    event.preventDefault();
    searchRows(API_PRODUCTOS, 'search-form');
});

// Función para preparar el formulario al momento de insertar un registro.
function openCreateDialog() {
    document.getElementById('save-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    document.getElementById('modal-title').textContent = 'Registrar cliente';    
    fillSelect(ENDPOINT_CATEGORIAS, 'ide_paciente', null);
}


// Función para preparar el formulario al momento de modificar un registro.
function openUpdateDialog(id) {
    document.getElementById('save-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    document.getElementById('modal-title').textContent = 'Actualizar cliente';
    const data = new FormData();
    data.append('id', id);

    fetch(API_PRODUCTOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('txtId').value = response.dataset.idexpediente;
                    document.getElementById('notas_medicas').value = response.dataset.notasmedicas;
                    document.getElementById('observaciones').value = response.dataset.observacionesperiodontograma;
                    fillSelect(ENDPOINT_CATEGORIAS, 'ide_paciente', response.dataset.idpaciente);
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

// Método manejador de eventos que se ejecuta cuando se envía el formulario de guardar.
document.getElementById('save-form').addEventListener('submit', function (event) {
    event.preventDefault();
    let action = '';

        if (document.getElementById('txtId').value) {
            action = 'update';
        } else {
            action = 'create';
        }
        
    saveRow(API_PRODUCTOS, action, 'save-form', 'save-modal');
});

// Función para establecer el registro a eliminar y abrir una caja de dialogo de confirmación.
function openDeleteDialog(id) {
    const data = new FormData();
    data.append('id', id);
    confirmDelete(API_PRODUCTOS, data);
}

function cargarDatos() {
    readRows(API_PRODUCTOS);
}


function openCreateArchivo(id) {
    document.getElementById('save-archivo-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-archivo-modal'));
    instance.open();
    document.getElementById('modal-a-title').textContent = 'Insertar Archivos';
    const data = new FormData();
    data.append('idArchivoT', id);

    fetch(API_PRODUCTOS + 'readOneA', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('idArchivoT').value = response.dataset.idexpediente;
                    
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

document.getElementById('save-archivo-form').addEventListener('submit', function (event) {
    event.preventDefault();
    let action = 'createArchivo';         
    saveRow(API_PRODUCTOS, action, 'save-archivo-form', 'save-archivo-modal');
});


function openArchives(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('show-a-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('show-proced-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-proced-title').textContent = 'Documentos';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_expedientes', id);

    fetch(API_PRODUCTOS + 'readOneArchivo', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {               
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {                    
                    document.getElementById('id_expedientes').value = response.dataset.idexpediente;  
                    document.getElementById('odontogrma').value = response.dataset.odontograma;                                                                               
                    searchOneArchivo(API_PRODUCTOS, 'show-a-form');

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

function openUpdateArchivos(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('up-archivo-form').reset();    
    // Se abre la caja de dialogo (modal) que contiene el formulario. 
    let instance = M.Modal.getInstance(document.getElementById('up-archivo-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-at-title').textContent = 'Actualizar Datos';        
    // Se define un objeto con los datos del registro seleccionado.    
    const data = new FormData();
    data.append('idArchivoTr', id);

    fetch(API_PRODUCTOS + 'readOneArchivo1', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('idArchivoTr').value = response.dataset.idarchivo;
                    document.getElementById('notas_medicass').value = response.dataset.notas;
                    document.getElementById('observacioness').value = response.dataset.observacionesperiodontograma;                    
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


document.getElementById('up-archivo-form').addEventListener('submit', function (event) {
    event.preventDefault();
    let action = 'updateRowArchivo';
    saveRow(API_PRODUCTOS, action, 'up-archivo-form', 'up-archivo-modal');
});