<?php
// Se verifica si existe el parámetro id en la url, de lo contrario se direcciona a la página web de origen.
if (isset($_GET['id'])) {
    require('../helpers/report.php');
    require('../models/doctores.php');
    
    // Se instancia el módelo Categorias para procesar los datos.
    $doctores = new Doctores;
    session_start();
    // Se verifica si el parámetro es un valor correcto, de lo contrario se direcciona a la página web de origen.
    if ($doctores->setId($_GET['id'])) {
        // Se verifica si la categoría del parametro existe, de lo contrario se direcciona a la página web de origen.
        if ($rowDoctor = $doctores->readOne()) {
            // Se instancia la clase para crear el reporte.
            $pdf = new Report;
            // Se inicia el reporte con el encabezado del documento.
            $pdf->startReports('Ganancías por Doctor');
            // Se verifica si existen registros (productos) para mostrar, de lo contrario se imprime un mensaje.
            if ($dataTratamiento = $doctores->readGananciasDoctor()) {
                if ($dataConsultas = $doctores->readDataDoctor()) {  
                // Se establece un color de relleno para los encabezados.
                $pdf->SetFillColor(225);
                // Se establece la fuente para los encabezados.                
                $pdf->Cell(176, 10, utf8_decode('Nombre Doctor:  '.$rowDoctor['nombredoctor'].' '.$rowDoctor['apellidodoctor']), 0, 1, 'C', 0);
                $pdf->Ln();
                $pdf->SetFont('Times', 'B', 11);
                // Se imprimen las celdas con los encabezados.                
                // Se establece la fuente para los datos de los productos.
                $pdf->SetFont('Times', '', 11);
                // Se recorren los registros ($dataProductos) fila por fila ($rowProducto).
                foreach ($dataTratamiento as $rows) {
                    // Se imprimen las celdas con los datos de los productos.                                            
                        $pdf->Cell(176, 10, utf8_decode('Total: '.$rows['costoprocedimiento']), 0, 1, 'C', 0);                        
                }

                $pdf->Cell(49, 10, utf8_decode('Fecha de inicio Tratamiento'), 1, 0, 'C', 1);
                $pdf->Cell(36, 10, utf8_decode('Fecha de la Consulta'), 1, 0, 'C', 1);
                $pdf->Cell(28, 10, utf8_decode('Hora de Consulta'), 1, 0, 'C', 1);
                $pdf->Cell(50, 10, utf8_decode('Procedimiento'), 1, 0, 'C', 1);
                $pdf->Cell(36, 10, utf8_decode('Costo de la Consulta'), 1, 0, 'C', 1);
                $pdf->Cell(56, 10, utf8_decode('Nombre del Paciente'), 1, 1, 'C', 1);
                $pdf->SetFont('Times', '', 11);

                foreach ($dataConsultas as $rows) {
                    // Se imprimen las celdas con los datos de los productos.                                        
                        $pdf->Cell(49, 10, utf8_decode($rows['fechainicio']), 1, 0); 
                        $pdf->Cell(36, 10, utf8_decode($rows['fechaconsulta']), 1, 0);
                        $pdf->Cell(28, 10, utf8_decode($rows['horaconsulta']), 1, 0);
                        $pdf->Cell(50, 10, utf8_decode($rows['nombreprocedimiento']), 1, 0);
                        $pdf->Cell(36, 10, $rows['costoprocedimiento'], 1, 0); 
                        $pdf->Cell(56, 10, utf8_decode($rows['nombrepaciente']), 1, 1);
                }

            } else {
                $pdf->Cell(0, 10, utf8_decode('No hay Datos'), 1, 1);
            }
                } else {
                    $pdf->Cell(0, 10, utf8_decode('No hay Datos'), 1, 1);
                }
            // Se envía el documento al navegador y se llama al método Footer()      
            $pdf->Output();
        } else {
            header('location: ../../../views/private/UsuarioAdminCli.php');
        }
    } else {
        header('location: ../../../views/private/UsuarioAdminCli.php');
    }
} else {
    header('location: ../../../views/private/UsuarioAdminCli.php');
}
?>