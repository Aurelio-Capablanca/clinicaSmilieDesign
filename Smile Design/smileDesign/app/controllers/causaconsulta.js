// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../app/api/causaconsulta.php?action=';
const ENDPOINT_CATEGORIAS = '../app/api/pacienteasignado.php?action=readAll';

document.addEventListener('DOMContentLoaded', function () {
    readRows(API_PRODUCTOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    dataset.map(function (row) {
        content += `
            <tr>
                <td>${row.idcausaconsulta}</td>
                <td>${row.causa}</td>
                <td>
                <a href="#" onclick="openUpdateDialog(${row.idcausaconsulta})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                <a href="#" onclick="openDeleteDialog(${row.idcausaconsulta})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
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
    document.getElementById('modal-title').textContent = 'Registrar causa consulta';    
}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdateDialog(id) {
    document.getElementById('save-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    document.getElementById('modal-title').textContent = 'Actualizar causa consulta';
    document.getElementById('id_causa').value = id;
    const data = new FormData();
    data.append('id', id);

    fetch(API_PRODUCTOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('causa').value = response.dataset.causa;
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

    var causa, excausa;
    causa = document.getElementById('causa').value;
    excausa = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;

    if(causa === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
        return false;  
    }
    if (!excausa.test(causa)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con la causa', null);
        return false;
    }
    else if(causa !== " "){        
        if (document.getElementById('id_causa').value) {
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