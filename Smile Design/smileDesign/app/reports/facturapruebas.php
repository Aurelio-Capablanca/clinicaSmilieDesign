<?php
if (isset($_GET['id'])) {
    require('../helpers/report.php');
    require('../models/pagos.php');

    // Se instancia el módelo Categorias para procesar los datos.
    $pagos = new Pagos;
    session_start();
    // Se verifica si el parámetro es un valor correcto, de lo contrario se direcciona a la página web de origen.
    if ($pagos->setCodigo($_GET['id'])) {
        // Se verifica si la categoría del parametro existe, de lo contrario se direcciona a la página web de origen.
        if ($rowPago = $pagos->readOneAbonosNombres()) {
            // Se instancia la clase para crear el reporte.
            $pdf = new Report;
            // Se inicia el reporte con el encabezado del documento.
            $pdf->startReport('Factura');
            // Se verifica si existen registros (productos) para mostrar, de lo contrario se imprime un mensaje.
            if ($dataCuenta = $pagos->readOneAbonos()) {
                // Se establece un color de relleno para los encabezados.
                $pdf->SetFillColor(225);
                // Se establece la fuente para los encabezados.                
                $pdf->Cell(176, 10, utf8_decode('Nombre Paciente:  ' . $rowPago['nombrepaciente']), 0, 0, 'C', 0);
                $pdf->Ln();                
                $pdf->SetFont('Times', 'B', 11);
                // Se imprimen las celdas con los encabezados.
                $pdf->Cell(36, 10, utf8_decode('Abono (USD $)'), 1, 0, 'C', 1);
                //$pdf->Cell(58, 10, utf8_decode('Fecha de Pago'), 1, 0, 'C', 1);
                $pdf->Cell(36, 10, utf8_decode('Saldo (USD $)'), 1, 1, 'C', 1);
                // $pdf->Cell(56, 10, utf8_decode('Procedimiento'), 1, 0, 'C', 1);
                // $pdf->Cell(78, 10, utf8_decode('Descripcion'), 1, 1, 'C', 1);
                // Se establece la fuente para los datos de los productos.
                $pdf->SetFont('Times', '', 11);
                // Se recorren los registros ($dataProductos) fila por fila ($rowProducto).
                foreach ($dataCuenta as $rows) {
                    // Se imprimen las celdas con los datos de los productos.                    
                    $pdf->Cell(36, 10, utf8_decode($rows['pagoabonoh']), 1, 0);
                    //$pdf->Cell(58, 10, utf8_decode($rows['fecharegistro']), 1, 0);
                    $pdf->Cell(36, 10, utf8_decode($rows['pagosaldoh']), 1, 1);
                }
            } else {
                $pdf->Cell(0, 10, utf8_decode('No hay Datos'), 1, 1);
            }
            // Se envía el documento al navegador y se llama al método Footer()      
            $pdf->Output();
        } else {
            header('location: ../../views/private/pagos.php');
        }
    } else {
        header('location: ../../views/private/pagos.php');
    }
} else {
    header('location: ../../views/private/pagos.php');
}
?>
