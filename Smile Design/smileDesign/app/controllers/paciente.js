// Constantes para establecer las rutas y parámetros de comunicación con la API.
const API_PACIENTES = '../app/api/paciente.php?action=';
const ENDPOINT_ESTADO = '../app/api/paciente.php?action=readAllESTADO';
const ENDPOINT_DOCTOR = '../app/api/paciente.php?action=readAllDOCTOR';
const ENDPOINT_P1 = '../app/api/paciente.php?action=readAllP1';
const ENDPOINT_P2 = '../app/api/paciente.php?action=readAllP2';
const ENDPOINT_P3 = '../app/api/paciente.php?action=readAllP3';
const ENDPOINT_P4 = '../app/api/paciente.php?action=readAllP4';
const ENDPOINT_P5 = '../app/api/paciente.php?action=readAllP5';
const ENDPOINT_P6 = '../app/api/paciente.php?action=readAllP6';
const ENDPOINT_P7 = '../app/api/paciente.php?action=readAllP7';
const ENDPOINT_P8 = '../app/api/paciente.php?action=readAllP8';


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
                    <a href="#" onclick="graficaPastelTipo(${row.idpaciente})" class="btn waves-effect yellow tooltipped" data-tooltip="Generar Gráfica"><i class="material-icons">pie_chart</i></a>
                    <a href="../app/reports/expedientes.php?id=${row.idpaciente}" target="_blank" class="btn waves-effect amber tooltipped" data-tooltip="Reporte de Expedientes"><i class="material-icons">assignment</i></a>
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
    // Variables y procesos para evaluar las respuestas.

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

document.getElementById('save-preguntas-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se define una variable para establecer la acción a realizar en la API.
    let action = 'createRowAnswers';
   
    if(s1.checked==true && n1.checked==false){        
        document.getElementById('respuesta1').value="Si";                   
    }
    if(s1.checked==false && n1.checked==true){
        document.getElementById('respuesta1').value="No";        
    }
     if(s2.checked==true && n2.checked==false){
        document.getElementById('respuesta2').value="Si";
    }
    if(s2.checked==false && n2.checked==true){
        document.getElementById('respuesta2').value="No";
    }
    if(s3.checked==true && n3.checked==false){
        document.getElementById('respuesta3').value="Si";
    }
    if(s3.checked==false && n3.checked==true){
        document.getElementById('respuesta3').value="No";
    }
    if(s4.checked==true && n4.checked==false){
        document.getElementById('respuesta4').value="Si";
    }
    if(s4.checked==false && n4.checked==true){
        document.getElementById('respuesta4').value="No";
    }    
    if(s5.checked==true && n5.checked==false){
        document.getElementById('respuesta5').value="Si";
    }
    if(s5.checked==false && n5.checked==true){
        document.getElementById('respuesta5').value="No";
    }
    if(s6.checked==true && n6.checked==false){
        document.getElementById('respuesta6').value="Si";
    }
    if(s6.checked==false && n6.checked==true){
        document.getElementById('respuesta6').value="No";
    }
    if(s7.checked==true && n7.checked==false){
        document.getElementById('respuesta7').value="Si";
    }
    if(s7.checked==false && n7.checked==true){
        document.getElementById('respuesta7').value="No";
    }
    if(s8.checked==true && n8.checked==false){
        document.getElementById('respuesta8').value="Si";
    }
    if(s8.checked==false && n8.checked==true){
        document.getElementById('respuesta8').value="No";
    }
    // if(document.getElementById('notas').value=""){
    //     document.getElementById('notas').value="-"
    // }
    
    saveRow(API_PACIENTES, action, 'save-preguntas-form', 'save-preguntas-modal');
});


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
    
    var nombre, apellido, dui, direccion, telefono, email;
    var exnombre, exapellido, exdui, exdireccion, extelefono, exemail;
    nombre = document.getElementById('nombre_paciente').value;
    apellido = document.getElementById('apellido_paciente').value;
    dui= document.getElementById('dui_paciente').value;
    direccion= document.getElementById('direccion_paciente').value;
    telefono= document.getElementById('telefono_paciente').value;
    email= document.getElementById('correo_cliente').value;

    exnombre = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;
    exapellido = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;
	exemail = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	extelefono = /^[2,6,7]{1}[0-9]{3}[-][0-9]{4}$/;
    exdireccion = /^[0-9-a-zA-ZÀ-ÿ\s]{1,440}$/;;
    exdui = /^[0-9]{8}[-][0-9]{1}$/;

    if(nombre === " " || apellido === " " || dui === " " || direccion === " " || telefono === " " || email === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
        return false;
    }
     if(nombre === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo nombre', null);
        return false;
    }
    else if (!exnombre.test(nombre)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el nombre', null);
        return false;
    }
    if(apellido === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo apellido', null);
        return false;
    }
    else if (!exapellido.test(apellido)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el apellido', null);
        return false;
    }
    if(dui === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo dui', null);
        return false;
    }
    else if (!exdui.test(dui)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el DUI', null);
        return false;
    }
    if(direccion === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo direccion', null);
        return false;
    }    
    if(telefono === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo telefono', null);
        return false;
    }
    else if (!extelefono.test(telefono)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados en Telefono', null);
        return false;
    }
    if(email === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo correo', null);
        return false;
    }
    else if (!exemail.test(email)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados con el Correo', null);
        return false;
    }
    if(nombre !== " " || apellido !== " " || dui !== " " || direccion !== " " || telefono !== " " || email !== " "){
        if (document.getElementById('id_paciente').value) {
            action = 'update';
        } else {
            action = 'create';
        } 
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
    document.getElementById('show-a-form').reset();
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

// --------------------------- validaciones ---------------------------------------------


const expresiones = {	
	nombre: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.
    apellido: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.	
	correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
	telefono: /^[2,6,7]{1}[0-9]{3}[-][0-9]{4}$/, // 7 a 14 numeros.
    direcion: /^[a-zA-Z0-9ñÑáÁéÉíÍóÓúÚ\s\,\;\.\ \:\#\-]{}$/,
    dui: /^[0-9]{8}[-][0-9]{1}$/,
}



function validar(){
    var nombre, apellido, dui, direccion, telefono, email;
    var exnombre, exapellido, exdui, exdireccion, extelefono, exemail;
    nombre = document.getElementById('nombre_paciente').value;
    apellido = document.getElementById('apellido_paciente').value;
    dui= document.getElementById('dui_paciente').value;
    direccion= document.getElementById('direccion_paciente').value;
    telefono= document.getElementById('telefono_paciente').value;
    email= document.getElementById('correo_cliente').value;

    exnombre = /^[a-zA-ZÀ-ÿ\s]{1,40}$/;

    if(nombre === " " || apellido === " " || dui === " " || direccion === " " || telefono === " " || email === " "){
        sweetAlert(2, 'Todos los campos son obligatorios', null);
        return false;

    }
    else if(nombre === " " ){
        sweetAlert(2, 'no se puede dejar vacio el campo nombre', null);
        return false;

    }
    else if (!exnombre.test(nombre)){
        sweetAlert(2, 'no coinciden los caracteres ingresados con los solicitados', null);
        return true;
    }


}

function graficaPastelTipo(id) {

    document.getElementById('send-form').reset()
    // Se abre la caja de dialogo (modal) que contiene el formulario.
    let instance = M.Modal.getInstance(document.getElementById('send-modal'));
    instance.open();
    // Se asigna el título para la caja de dialogo (modal).
    document.getElementById('modal-s-title').textContent = 'Gráfica';
    // Se deshabilitan los campos de alias y contraseña.    
    // Se define un objeto con los datos del registro seleccionado.    
    const data = new FormData();
    data.append('id_pacientetratamiento', id);    

    fetch(API_PACIENTES + 'readOnes', {
        method: 'post',
        body: data
    }).then(function (request) {
        // Se verifica si la petición es correcta, de lo contrario se muestra un mensaje indicando el problema.
        if (request.ok) {
            request.json().then(function (response) {
                // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
                if (response.status) {
                    // Se inicializan los campos del formulario con los datos del registro seleccionado.
                    document.getElementById('id_pacientetratamiento').value = response.dataset.idpaciente;

                    document.getElementById('charts').innerHTML = '<canvas id="chart1"></canvas>';


                    fetch(API_PACIENTES + 'readPacientesTipos', {
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
                                    pieGraph('chart1', tipotratamiento, cantidad, 'Porcentaje de Tratamientos por Tipo');
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
                    //document.getElementById('chart1').reset();

                    // Se actualizan los campos para que las etiquetas (labels) no queden sobre los datos.
                    //document.getElementById('chart1').reset();
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
