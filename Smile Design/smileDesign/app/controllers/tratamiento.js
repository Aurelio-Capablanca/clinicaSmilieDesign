// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../app/api/tratamientos.php?action=';
const ENDPOINT_CATEGORIAS = '../app/api/tipotratamiento.php?action=readAll';
const ENDPOINT_CATEGORIAS2 = '../app/api/estadotratamiento.php?action=readAll';
const ENDPOINT_CATEGORIAS3 = '../app/api/pacienteasignado.php?action=readAll';
const API_CONSULTAS = '../app/api/consulta.php?action=';
const ENDPOINT_CAUSA = '../app/api/consulta.php?action=readAllCAUSA';
const ENDPOINT_PROCEDIMIENTO = '../app/api/consulta.php?action=readAllPROCEDIMIENTO';

document.addEventListener('DOMContentLoaded', function () {
    readRows(API_PRODUCTOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    dataset.map(function (row) {
        content += `
            <tr>
            <td>${row.nombrepaciente}</td>
            <td>${row.apellidopaciente}</td>
            <td>${row.duipaciente}</td>
            <td>${row.fechainicio}</td>
            <td>${row.tipotratamiento}</td>
            <td>${row.estadotratamiento}</td>
            <td>
                <a href="#" onclick="openUpdateDialog(${row.idtratamiento})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                <a href="#" onclick="openCreateDialogConsulta(${row.idtratamiento})" class="btn waves-effect green tooltipped" data-tooltip="Crear Consulta"><i class="material-icons">assignment</i></a>
                <a href="#" onclick="openDeleteDialog(${row.idtratamiento})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
                <a href="#" onclick="openDates(${row.idtratamiento})" class="btn waves-effect grey tooltipped" data-tooltip="Mostrar Consultas"><i class="material-icons">search</i></a>
                <a href="#" onclick="graficaPastelCausa(${row.idtratamiento})" class="btn waves-effect yellow tooltipped" data-tooltip="Generar Gráfica"><i class="material-icons">pie_chart</i></a>
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
                <td>${row.fechaconsulta}</td>
                <td>${row.horaconsulta}</td>                
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


function openDates(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('show-a-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('show-proced-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-proced-title').textContent = 'Consultas';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_tratamientos', id);

    fetch(API_CONSULTAS + 'readOneConsultasCantidad', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {               
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.                
                if (response.status) {                    
                    document.getElementById('id_tratamientos').value = response.dataset.idtratamiento;  
                    document.getElementById('codigos').value = response.dataset.codigotratamiento;                                                                               
                    searchRowsDates(API_CONSULTAS, 'show-a-form');                                                                      

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
    document.getElementById('modal-title').textContent = 'Registrar tratamiento';    
    fillSelect(ENDPOINT_CATEGORIAS, 'id_tipo', null);
    fillSelect(ENDPOINT_CATEGORIAS2, 'id_estado', null);
    fillSelect(ENDPOINT_CATEGORIAS3, 'id_asignado', null);
}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdateDialog(id) {
    document.getElementById('save-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    document.getElementById('modal-title').textContent = 'Actualizar tratamiento';
    const data = new FormData();
    data.append('id', id);

    fetch(API_PRODUCTOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('txtId').value = response.dataset.idtratamiento;
                    document.getElementById('fecha_nacimiento').value = response.dataset.fechainicio;
                    document.getElementById('descripcion').value = response.dataset.descripciontratamiento;
                    fillSelect(ENDPOINT_CATEGORIAS, 'id_tipo', response.dataset.idtipotratamiento);
                    fillSelect(ENDPOINT_CATEGORIAS2, 'id_estado', response.dataset.idestadotratamiento);
                    fillSelect(ENDPOINT_CATEGORIAS3, 'id_asignado', response.dataset.idpacienteasignado);
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

    var tratamiento;
    var extratamiento;

    tratamiento = document.getElementById('descripcion').value;
    extratamiento = /^[a-zA-Z0-9ñÑáÁéÉíÍóÓúÚ\s\,\;\.\ \:\#\-]{}$/;
    
    if(tratamiento === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
        return false;
    }    
    else if(tratamiento !== " "){
        if (document.getElementById('txtId').value) {
            action = 'update';
        } else {
            action = 'create';
        }
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

// function openCreateDialogConsulta() {
//     // Se restauran los elementos del formulario.
//     document.getElementById('save-form-consultas').reset();
//     // Se abre la caja de dialogo (modal) que contiene el formulario.
//     let instance = M.Modal.getInstance(document.getElementById('save-modal-consultas'));
//     instance.open();
//     // Se asigna el título para la caja de dialogo (modal).
//     document.getElementById('modal-title-consultas').textContent = 'Ingresar Consulta';
//     // Se llama a la función para llenar el select del estado cliente         
//     fillSelect(ENDPOINT_CAUSA, 'causa_consulta', null);

// } 

function openCreateDialogConsulta(id) {
    document.getElementById('save-form-consultas').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal-consultas'));
    instance.open();
    document.getElementById('modal-title-consultas').textContent = 'Ingresar Consulta';
    const data = new FormData();
    data.append('id_t', id);
    document.getElementById('nombre_paciente').disabled = true;

    fetch(API_PRODUCTOS + 'readOneC', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('id_t').value = response.dataset.idtratamiento;                    
                    document.getElementById('nombre_paciente').value = response.dataset.nombrepaciente;
                    fillSelect(ENDPOINT_CAUSA,'causa_consulta',null);
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

document.getElementById('save-form-consultas').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    let action1 = 'createConsulta';    
    // Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    
    var notas, precio;
    notas = document.getElementById('notas_consulta').value;
    precio = document.getElementById('precio_consulta').values;
        
    if(notas === " " || precio === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null); 
        return false;       
    }
    if(notas === " "){
        sweetAlert(2, 'no se puede dejar vacio el campo de las notas', null);
        return false;
    }   
    else if(precio === " "){
        sweetAlert(2, 'no se puede dejar vacio el campo del precio', null);
        return false; 
    }    
    else if (notas !== " " || precio !== " "){
        if (document.getElementById('id_consulta').value) {
            action = 'update';            
        } else {
            action = 'create';            
        }
    }
    saveRow34(API_PRODUCTOS, action1, 'save-form-consultas', 'save-modal-consultas');        
    saveRow25(API_CONSULTAS, action, 'save-form-consultas', 'save-modal-consultas');         
});


function graficaPastelCausa(id) {
    document.getElementById('send-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('send-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-s-title').textContent = 'Gráfica';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_causaconsulta', id);

    fetch(API_PRODUCTOS + 'readOnes', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_causaconsulta').value = response.dataset.idtratamiento;

                    document.getElementById('charts').innerHTML = '<canvas id="chart1"></canvas>';

                    fetch(API_PRODUCTOS + 'readTratamientoConsulta', {
                        method: 'post',
                        body: data
                    }).then(function (request) {
                        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
                        if (request.ok) {
                            request.json().then(function (response) {
                                // Se comprueba si la respuesta es satisfactoria, de lo contrario se remueve la etiqueta canvas de la gráfica.
                                if (response.status) {                    
                                    // Se declaran los arreglos para guardar los datos por gráficar.                    
                                    let causa = [];
                                    let cantidad = [];
                                    // Se recorre el conjunto de registros devuelto por la API (dataset) fila por fila a través del objeto row.
                                    response.dataset.map(function (row) {
                                        // Se asignan los datos a los arreglos.
                                        causa.push(row.causa);
                                        cantidad.push(row.cantidad);
                                    });
                                    // Se llama a la función que genera y muestra una gráfica de pastel en porcentajes. Se encuentra en el archivo components.js
                                    pieGraph('chart1', causa, cantidad, 'Porcentaje de Consultas por Tratamiento');
                                } else {
                                    document.getElementById('chart1').remove();
                                    console.log(response.exception);
                                }
                            });
                        } else {
                            console.log(request.status + ' ' + request.statusText);
                        }
                    }).catch(function (error) {
                        console.log(error);
                    });


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


