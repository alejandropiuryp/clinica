<?php
	session_start();
	require_once("gestionBD.php");
	if(!isset($_SESSION['login'])){
		
		header("Location: login.php");
	}
	if(!isset($_SESSION["reqCita"])){
		$reqCita['tipoCertificado'] = "";
		$reqCita['opcionesCertificado'] = "";
		$reqCita['fechaCita'] = "";
		$reqCita['horaCita'] = "";
		

		
		$_SESSION["reqCita"] = $reqCita;
	}else{
		$reqCita = $_SESSION["reqCita"];
	
	if(isset($_SESSION["errores"])){
			$errores = $_SESSION["errores"];
			unset($_SESSION["errores"]);
		}
	}
	
	
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="css/pedircitas.css"/>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
  <script src="js/opciones_datalist.js"></script>
  <script src="js/pedir_cita.js" type="text/javascript"></script>
  

  <title>Citas online</title>
</head>

<body>
<?php
	include_once('menu.php');
	include_once('cabecera.php');
?>  		
	<div class="contenedor">

		<div class="titulo">
			<h1>Pide tu cita</h1>
		</div>	
		<!--Formulario-->
			<div class="form">
				<form id="citaUsuario" method="get" action="validacion_cita.php" onsubmit="return validateForm()">	
					<div class="columnas">	
						<div class = "datos_cita">
						<label for="tipoCertificado" id="labelCertificado">Tipo de certificado:</label>
						<input id="tipoCertificado" name="tipoCertificado" type="text"  list="opcionesCertificado"  size="20" value = "<?php echo $reqCita['tipoCertificado'];?>"/>
							<datalist id="opcionesCertificado" name="opcionesCertificado" value = "<?php echo $reqCita['opcionesCertificado'];?>">
							<!-- Aquí se añadirán con AJAX los tipos de certificados -->
							
							</datalist><br>
						<div class="smallColumn1">
						<small id="smallTipo">Error message</small>
						</div>
						<label for="fechaCita" id="labelFecha">¿Para qué día quieres tu cita?</label><br/>
						<label for="fechaCita">Día:</label>
						<input id="fechaCita"  name="fechaCita" type="date" value = "<?php echo $reqCita['fechaCita'];?>" />
	
						<label for="horaCita" id="labelHora">Hora:</label>
						<input id="horaCita" name="horaCita" type="time" min="16:00" max="20:00" step="1800"  value = "<?php echo $reqCita['horaCita'];?>"/><br>
						<div class="smallColumn2">
						<small id="smallFecha">Error message</small>
						</div>
						<div class="smallColumn3">
						<small id="smallHora">Error message</small>
						
						</div>
							
					
						<?php 
						if(isset($errores) && count($errores) > 0){
							echo "<div id=\"div_errores\" class=\"errorServer\">";
							echo "<h4> Errores en la petición: </h4>";
							foreach ($errores as $error) {
								echo $error;
							}	
							echo "</div>";
						}
			
						?>
						</div>
					</div>						
				<input id="enviar" type="submit"  value="Confirmar cita">
			</form>
		</div>
	</div>
	
</body>
</html>