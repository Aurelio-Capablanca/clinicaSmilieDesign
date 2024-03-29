// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_DOCTORES = '../app/api/doctor.php?action=';
const ENDPOINT_ESTADO = '../app/api/estado_doctor.php?action=readAll';

// Método manejador de eventos que se ejecuta cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', function () {
    // Se llama a la función que obtiene los registros para llenar la tabla. Se encuentra en el archivo components.js
    readRows(API_DOCTORES);
});

function cargarDatos() {
    readRows(API_DOCTORES);
}

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    // Se recorre el conjunto de registros (dataset) fila por fila a través del objeto row.
    dataset.map(function (row) {
        // Se crean y concatenan las filas de la tabla con los datos de cada registro.
        content += `
            <tr>
                <td><img src="../resources/img/fotodoctores/${row.fotodoctor}" class="materialboxed" height="100"></td>
                <td>${row.nombredoctor}</td>
                <td>${row.apellidodoctor}</td>
                <td>${row.direcciondoctor}</td>
                <td>${row.telefonodoctor}</td>
                <td>${row.correodoctor}</td>
                <td>${row.estadodoctor}</td>
                <td>
                <ul>                    
                    <li><a href="#" onclick="openUpdateDialog(${row.iddoctor})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                    <a href="#" onclick="openDeleteDialog(${row.iddoctor})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
                    <a href="#" onclick="graficaPastelCausa(${row.iddoctor})" class="btn waves-effect yellow tooltipped" data-tooltip="Generar Gráfica"><i class="material-icons">pie_chart</i></a></li>
                    <br>
                    <li><a href="../app/reports/doctorescantidad.php?id=${row.iddoctor}" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de Ganancias"><i class="material-icons">assignment</i></a>                    
                    <a href="../app/reports/pacienteasignado.php?id=${row.iddoctor}" target="_blank" class="btn waves-effect grey tooltipped" data-tooltip="Reporte de Asignaciones"><i class="material-icons">assignment</i></a>
                    <a href="../app/reports/especialidad.php?id=${row.iddoctor}" target="_blank" class="btn waves-effect purple tooltipped" data-tooltip="Reporte de Especialidades"><i class="material-icons">assignment</i></a></li>
                    <br>
                </ul>
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

function graficaPastelCausa(id) {
    document.getElementById('send-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('send-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-s-title').textContent = 'Gráfica Según Consultas por Causa';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_doctorestr', id);

    fetch(API_DOCTORES + 'readOnes', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_doctorestr').value = response.dataset.iddoctor;

                    document.getElementById('charts').innerHTML = '<canvas id="chart1"></canvas>';

                    fetch(API_DOCTORES + 'readTratamientoTipo', {
                        method: 'post',
                        body: data
                    }).then(function (request) {
                        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
                        if (request.ok) {
                            request.json().then(function (response) {
                                // Se comprueba si la respuesta es satisfactoria, de lo contrario se remueve la etiqueta canvas de la gráfica.
                                if (response.status) {                    
                                    // Se declaran los arreglos para guardar los datos por gráficar.                    
                                    let tipotratamiento = [];
                                    let cantidad = [];
                                    // Se recorre el conjunto de registros devuelto por la API (dataset) fila por fila a través del objeto row.
                                    response.dataset.map(function (row) {
                                        // Se asignan los datos a los arreglos.
                                        tipotratamiento.push(row.tipotratamiento);
                                        cantidad.push(row.cantidad);
                                    });
                                    // Se llama a la función que genera y muestra una gráfica de pastel en porcentajes. Se encuentra en el archivo components.js
                                    pieGraph('chart1', tipotratamiento, cantidad, 'Porcentaje de Consultas por Causa');
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


// Método manejador de eventos que se ejecuta cuando se envía el formulario de buscar.
document.getElementById('search-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js
    searchRows(API_DOCTORES, 'search-form');
});

// Función para preparar el formulario al momento de insertar un registro.
function openCreateDialog() {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Crear Doctor';
    // Se establece el campo de archivo como obligatorio.
    document.getElementById('foto_doctor').required = true;
    // Se llama a la función que llena el select del formulario. Se encuentra en el archivo components.js
    fillSelect(ENDPOINT_ESTADO, 'estado_doctor', null);
    document.getElementById('alias_doctor').disabled = false;
    document.getElementById('clave_doctor').disabled = false;
    document.getElementById('confirmar_doctor').disabled = false;
}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdateDialog(id) {
    // Se restauran los elementos del formulario.
    document.getElementById('save-form').reset();
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-title').textContent = 'Actualizar doctor';
    // Se establece el campo de archivo como opcional.
    document.getElementById('foto_doctor').required = false;
    document.getElementById('alias_doctor').disabled = true;
    document.getElementById('clave_doctor').disabled = true;
    document.getElementById('confirmar_doctor').disabled = true;

    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_doctor', id);

    fetch(API_DOCTORES + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {                    
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_doctor').value = response.dataset.iddoctor;
                    document.getElementById('nombre_doctor').value = response.dataset.nombredoctor;
                    document.getElementById('apellido_doctor').value = response.dataset.apellidodoctor;
                    document.getElementById('direccion_doctor').value = response.dataset.direcciondoctor;
                    document.getElementById('telefono_doctor').value = response.dataset.telefonodoctor;
                    document.getElementById('alias_doctor').value = response.dataset.aliasdoctor;
                    document.getElementById('correo_doctor').value = response.dataset.correodoctor;                    
                    fillSelect(ENDPOINT_ESTADO, 'estado_doctor', response.dataset.idestadodoctor);
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

// Método manejador de eventos que se ejecuta cuando se envía el formulario de guardar.
document.getElementById('save-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = '';
    // Se comprueba si el campo oculto del formulario esta seteado para actualizar, de lo contrario será para crear.
    
    if (document.getElementById('id_doctor').value) {
        action = 'update';
    } else {
        action = 'create';
    }
    saveRow(API_DOCTORES, action, 'save-form', 'save-modal');
});

// Función para establecer el registro a eliminar y abrir una caja de dialogo de confirmación.
function openDeleteDialog(id) {
    // Se define un objeto con los datos del registro seleccionado.
    const data = new FormData();
    data.append('id_doctor', id);
    // Se llama a la función que elimina un registro. Se encuentra en el archivo components.js
    confirmDelete(API_DOCTORES, data);
}