<?php
//Se incluye la clase con las plantillas del documento
include('../../app/helpers/private/dashboardPage.php');
//Se imprime la plantilla del encabezado y se envía el titulo para la página web
Dashboard_Page::headerTemplate('Mantenimientos');
?>  
<div class='main-container'>
     <div class='row'>           
     <div class="col s12 m12 l12 right" >
            <div class="card horizontal" >      
                <div class="card-stacked">
                    <span class="card-title center-align">Mantenimientos</span>
                    <div class="card-content">
                    <div class="row">
                    
                <div class="col s12 m2">
                    <div class="card center-align" >
                         <i class="large material-icons">person</i>
                        <div class="card-block">
                            <br></br>
                            <a href="usuarioss.php" class="card-title center-align">Empleado</a>                                                        
                            <br>
                        </div>
                    </div>
                </div>                
                <div class="col s12 m2">
                  <div class="card center-align" >
                         <i class="large material-icons">description</i>
                        <div class="card-block">
                            <br></br>
                            <a href="expedientes.php" class="card-title text-center">Expedientes</a>                                                        
                            <br>
                        </div>
                    </div>
                </div>                

                <div class="col s12 m2">
                    <div class="card center-align" >
                            <i class="large material-icons">medication</i>
                        <div class="card-block">
                            <br></br>
                            <a href="doctores.php" class="card-title text-center">Doctores</a>                                                        
                            <br>                                     
                        </div>    
                    </div>
                </div>                
                <div class="col s12 m2">
                   <div class="card center-align" >
                         <i class="large material-icons">face</i>
                        <div class="card-block">
                            <br></br>
                            <a  href="pacientes.php" class="card-title text-center">Pacientes</a>                                                    
                            <br>
                    </div>
                </div>
            </div>
            <div class="col s12 m2">
                   <div class="card center-align" >
                         <i class="large material-icons">file_present</i>
                        <div class="card-block">
                            <br></br>
                            <a  href="tratamientos.php" class="card-title text-center">Tratamientos</a>                                                    
                            <br>
                    </div>
                </div>
            </div>
            <div class="col s12 m2">
                   <div class="card center-align" >
                         <i class="large material-icons">scatter_plot</i>
                        <div class="card-block">
                            <br></br>
                            <a  href="causaConsulta.php" class="card-title text-center">Causa Consulta</a>                                                    
                            <br>
                    </div>
                </div>               
            </div>
            <div class="col s12 m2">
                   <div class="card center-align" >
                         <i class="large material-icons">margin</i>
                        <div class="card-block">
                            <br></br>
                            <a  href="especialidad.php" class="card-title text-center">Especialidad</a>                                                    
                            <br>
                    </div>
                </div>               
            </div>                              
            </div>                      
     </div>
</div>

<?php
//Se imprime la plantilla del pie y se envía el nombre del controlador para la página web
Dashboard_Page::footerTemplate('init.js');
?>