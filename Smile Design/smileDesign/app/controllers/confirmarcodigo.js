const API_LOGIN = '../app/api/login.php?action=';

document.getElementById('confirmacion-form').addEventListener('submit', function (event) {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se llama a la función que realiza la búsqueda. Se encuentra en el archivo components.js      
    searchRowsCodigoValidar(API_LOGIN, 'confirmacion-form');
});

