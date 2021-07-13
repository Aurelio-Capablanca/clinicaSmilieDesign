// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../../app/api/private/tratamientos.php?action=';
const ENDPOINT_CATEGORIAS = '../../app/api/private/tipotratamiento.php?action=readAll';
const ENDPOINT_CATEGORIAS2 = '../../app/api/private/estadotratamiento.php?action=readAll';
const ENDPOINT_CATEGORIAS3 = '../../app/api/private/pacienteasignado.php?action=readAll';

document.addEventListener('DOMContentLoaded', function () {
    readRows(API_PRODUCTOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    dataset.map(function (row) {
        content += `
            <tr>
            <td>${row.fechainicio}</td>
            <td>${row.descripciontratamiento}</td>
            <td>${row.nombrepaciente}</td>
            <td>${row.apellidopaciente}</td>
            <td>${row.duipaciente}</td>
            <td>${row.tipotratamiento}</td>
            <td>${row.estadotratamiento}</td>
            <td>
                <a href="#" onclick="openUpdateDialog(${row.idtratamiento})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                <a href="#" onclick="openDeleteDialog(${row.idtratamiento})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
            </td>
            </tr>
        `;          
    });
    document.getElementById('tbody-rows').innerHTML = content;
    M.Materialbox.init(document.querySelectorAll('.materialboxed'));
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
                    fillSelect(ENDPOINT_CATEGORIAS, 'id_tipo', response.dataset.tipotratamiento);
                    fillSelect(ENDPOINT_CATEGORIAS2, 'id_estado', response.dataset.estadotratamiento);
                    fillSelect(ENDPOINT_CATEGORIAS3, 'id_asignado', response.dataset.duipaciente);
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
    }
    // else if(!extratamiento.test(tratamiento)){
    //     sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados', null); 
    //}
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