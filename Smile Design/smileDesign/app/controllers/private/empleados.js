// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PRODUCTOS = '../../app/api/private/empleados.php?action=';
const ENDPOINT_CATEGORIAS = '../../app/api/private/estadousuario.php?action=readAll';
const ENDPOINT_CATEGORIAS2 = '../../app/api/private/tipousuario.php?action=readAll';


document.addEventListener('DOMContentLoaded', function () {
    readRows(API_PRODUCTOS);
});

// Función para llenar la tabla con los datos de los registros. Se manda a llamar en la función readRows().
function fillTable(dataset) {
    let content = '';
    dataset.map(function (row) {
        content += `
            <tr>
                <td>${row.nombreusuario}</td>
                <td>${row.apellidousuario}</td>
                <td>${row.direccionusuario}</td>
                <td>${row.telefonousuario}</td>
                <td>${row.correousuario}</td>
                <td>${row.estadousuario}</td>
                <td>${row.tipousuario}</td>
                <td>
                    <a href="#" onclick="openUpdateDialog(${row.idusuario})" class="btn waves-effect blue tooltipped" data-tooltip="Actualizar"><i class="material-icons">mode_edit</i></a>
                    <a href="#" onclick="openDeleteDialog(${row.idusuario})" class="btn waves-effect red tooltipped" data-tooltip="Eliminar"><i class="material-icons">delete</i></a>
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
    document.getElementById('modal-title').textContent = 'Registrar usuario'; 
    fillSelect(ENDPOINT_CATEGORIAS, 'estado_usuario', null);
    fillSelect(ENDPOINT_CATEGORIAS2, 'tipo_usuario', null);

}

// Función para preparar el formulario al momento de modificar un registro.
function openUpdateDialog(id) {
    document.getElementById('save-form').reset();
    let instance = M.Modal.getInstance(document.getElementById('save-modal'));
    instance.open();
    document.getElementById('modal-title').textContent = 'Actualizar usuario';
    document.getElementById('id_usuario').value = id;
    const data = new FormData();
    data.append('id', id);
    document.getElementById('clave_cliente').required = false;
    document.getElementById('confirmar_clave').required = false;

    fetch(API_PRODUCTOS + 'readOne', {
        method: 'post',
        body: data
    }).then(function (request) {
        if (request.ok) {
            request.json().then(function (response) {
                if (response.status) {
                    document.getElementById('nombre_usuario').value = response.dataset.nombreusuario;
                    document.getElementById('apellido_usuario').value = response.dataset.apellidousuario;
                    document.getElementById('direccion_usuario').value = response.dataset.direccionusuario;
                    document.getElementById('telefono_usuario').value = response.dataset.telefonousuario;
                    document.getElementById('correo_usuario').value = response.dataset.correousuario;
                    document.getElementById('alias_usuario').value = response.dataset.aliasusuario;
                    fillSelect(ENDPOINT_CATEGORIAS, 'estado_usuario', response.dataset.idestadousuario);
                    fillSelect(ENDPOINT_CATEGORIAS2, 'tipo_usuario', response.dataset.idtipousuario);
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

    var nombre, apellido, direccion, telefono, correo, alias, clave, conf;
    var exnombre, exapellido, exdireccion, extelefono, excorreo, exalias, exclave, exconf;

    nombre = document.getElementById('nombre_usuario').value;
    apellido = document.getElementById('apellido_usuario').value;
    telefono = document.getElementById('telefono_usuario').value;
    direccion = document.getElementById('direccion_usuario').value;
    correo = document.getElementById('correo_usuario').value;
    alias = document.getElementById('alias_usuario').value;
    clave = document.getElementById('clave_cliente').value;
    conf = document.getElementById('confirmar_clave').value;

    exnombre = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;
    exapellido = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;    
    extelefono = /^[2,6,7]{1}[0-9]{3}[-][0-9]{4}$/;
    exalias = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;

    if(nombre === " " || apellido === " " || telefono === " " || direccion === " " ||  correo === " " || alias === " " || clave === " " || conf === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
        return false;
    }
    if (nombre == " "){
        sweetAlert(2, 'no se puede dejar vacio el campo nombre', null);
    }
    else if (!exnombre.test(nombre)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el nombre', null);
        return false;
    }
    if (apellido == " "){
        sweetAlert(2, 'no se puede dejar vacio el campo apellido', null);
    }
    else if (!exapellido.test(apellido)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el apellido', null);
        return false;
    }
    if (telefono == " "){
        sweetAlert(2, 'no se puede dejar vacio el campo telefono', null);
    }
    else if (!extelefono.test(telefono)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el teléfono', null);
        return false;
    }
    if (alias == " "){
        sweetAlert(2, 'no se puede dejar vacio el campo alias', null);
    }   
    if (clave === " "){
        sweetAlert(2, 'no se puede dejar vacio el campo alias', null);
    }
    else if (nombre !== " " || apellido !== " " || telefono !== " " || direccion !== " " ||  correo !== " " || alias !== " " || clave !== " " || conf !== " " || clave === conf) {
        if (document.getElementById('id_usuario').value) {
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