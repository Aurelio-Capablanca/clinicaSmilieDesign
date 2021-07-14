// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../../app/api/private/expedientes.php?action=';
const ENDPOINT_CATEGORIAS = '../../app/api/private/pacienteasignado.php?action=readAll';

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
                <td>${row.observacionesperiodontograma}</td>
                <td>${row.nombrepaciente}</td>
                <td>${row.apellidopaciente}</td>
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idexpediente})" class="waves-effect waves-yellow btn updateButton"><i class="material-icons left">update</i></a>
                </td>
                <td>
                    <a href="#" onclick="openDeleteDialog(${row.idexpediente})" class="waves-effect waves btn deleteButton"><i class="material-icons left">delete</i></a>
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
                    fillSelect(ENDPOINT_CATEGORIAS, 'ide_paciente', response.dataset.duipaciente);
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

    var obser, notasm;
    obser = document.getElementById('notas_medicas').value;
    notasm = document.getElementById('observaciones').value;


    if(obser === " " || notasm === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
    }
    else if(obser !== " " || notasm !== " "){
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