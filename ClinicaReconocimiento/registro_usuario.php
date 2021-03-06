<?php
	session_start();
	
	if(!isset($_SESSION["registro"])){
		$registro['nombre'] = "";
		$registro['apellidos'] = "";
		$registro['dni'] = "";
		$registro['edad'] = "";
		$registro['tarjeta_sanitaria'] = "";
		$registro['contrasena'] = "";
		$registro['fecha'] = "";
		$registro['email'] = "";
		$registro['telefono'] = "";
		$registro['domicilio'] = "";
		
		$_SESSION["registro"] = $registro;
	}else{
		$registro = $_SESSION["registro"];
		
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
		<title>Registrarse</title>
		<link href="css/registro_usuario.css" rel="stylesheet" type="text/css" media="all">
		<script src="js/registro_usuario.js" type="text/javascript"></script>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
	</head>
	<body>
<?php
	include_once('cabecera.php');
?>
	
			<!--Formulario-->
			<div class="contenedor">
				<div class="form">
					<form id="registroUsuario"  method="post" action="validacion_registro.php" onsubmit="return validateForm()">
						<div class="columnas">
							
							<div class = "datos_personales">
								<h1>Datos personales</h1>
								<input type="text" id="nombre" name="nombre" class = "exito" value = "<?php echo $registro['nombre'];?>" maxlength= "20"; placeholder = "Nombre"/>
								<small id="smallNombre">Error message</small>
								<input type="text" id="apellidos" name="apellidos"  value = "<?php echo $registro['apellidos'];?>" placeholder= "Apellidos"  />
								<small id="smallApellidos">Error message</small> 
								<input type="date" id="fecha" name="fecha" value = "<?php echo $registro['fecha'];?>" placeholder= "Fecha de nacimiento"  />
								<small id="smallFecha">Error message</small>
								<input type="number" id="edad" name="edad" value = "<?php echo $registro['edad'];?>" min="0" max="150" step="1" placeholder="Edad"  />
								<small id="smallEdad">Error message</small>
								<input type="text" id="dni" name="dni"  value = "<?php echo $registro['dni'];?>" placeholder="DNI"  />
								<small id="smallDni">Error message</small>
								<input type="number" id="tarjeta_sanitaria" name="tarjeta_sanitaria" value = "<?php echo $registro['tarjeta_sanitaria'];?>" placeholder= "Nº de tarjeta sanitaria"  />
								<small id="smallTarjeta">Error message</small>
								<?php 
								if(isset($errores) && count($errores) > 0){
									echo "<div id=\"div_errores\" class=\"errorServer\">";
						 			echo "<h4> Errores en el registro: </h4>";
								foreach ($errores as $error) {
									echo $error;
								}
								echo "</div>";
								}
			
								?>
							</div>
							<div class = "datos_contacto">
								<h1>Datos de contacto</h1>
								<input type="text" id="email" name="email"  value = "<?php echo $registro['email'];?>" placeholder="Correo electrónico"  />
								<small id="smallEmail">Error message</small>
								<input type="password" id="contrasena" name="contrasena"  placeholder="Contraseña" />
								<small id="smallContrasena">Error message</small>
								<input type="password" id="contrasena2" name="contrasena2"  placeholder="Confirmar contraseña" />
								<small id="smallContrasena2">Error message</small>
								<input type="number" id="telefono" name="telefono"  value = "<?php echo $registro['telefono'];?>" placeholder="Teléfono de contacto"  />
								<small id="smallTelefono">Error message</small>
								<input type="text" id="domicilio" name="domicilio"  value = "<?php echo $registro['domicilio'];?>" placeholder="C/Domicilio"  />
								<small id="smallDomicilio">Error message</small>
								<a class="redireccion" href="login.php">¿Ya tienes una cuenta?</a>
								
							</div>
							
						</div>
						<input id="enviar" type="submit"  value="Finalizar registro">
					</form>
					
				</div>
			</div>

			<footer>
				<p>
					
				</p>
			</footer>	
	</body>
</html>
