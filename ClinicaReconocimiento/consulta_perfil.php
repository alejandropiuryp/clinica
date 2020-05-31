<?php
	session_start();

	require_once("gestionBD.php");
	require_once("gestionarPerfil.php");
	require_once("gestionarUsuarios.php");
	
	if(!isset($_SESSION['login'])){
		
		header("Location: login.php");
	} 
	if(!isset($_SESSION['perfil']))	{
		$perfil["contrasena"] = "";
		$perfil["telefono"] = "";
		$perfil["domicilio"] = "";
		$_SESSION['perfil']=$perfil;
	}else{
		$perfil=$_SESSION['perfil'];
		if(isset($_SESSION["errores"])){
            $errores = $_SESSION["errores"];
            unset($_SESSION["errores"]);
        }
	}

	
	$conexion=crearConexionBD();
    
	$login = $_SESSION['login'];
	
	$email = $login;
	$usuario=extraerDatosUsuario($conexion, $email);
	$_SESSION['usuario'] = $usuario;
	
	
	cerrarConexionBD($conexion);
	
	?>
	
<!DOCTYPE html>
<title>Perfil</title>
<head>
	
<link href="css/perfil.css" rel="stylesheet" type="text/css">
<script src="js/perfil_usuario.js"></script>
</head>
<body>
<?php
	include_once('menu.php');
	include_once('cabecera.php');
?> 
	
			<!--Formulario-->
			<div class="contenedor">
				<div class="form">
					<form id="perfilUsuario"  method="post" action="validacion_perfil.php" onsubmit="return validateForm()" >
						<div class="caja">
							<div class="encabezado">
							 <h1>Datos de perfil</h1>
							 </div>
						<div class="columnas">
							
							<div class = "datos_personales">
								
								<input type="text" id="nombre" name="nombre" class = "exito" value = "<?php echo $usuario['NOMBRE'];?>" maxlength= "20"; placeholder = "<?php echo $usuario['NOMBRE'];?>" readonly/>
								<small id="smallNombre">Error message</small>
								<input type="text" id="apellidos" name="apellidos"  value = "<?php echo $usuario['APELLIDO'];?>" placeholder= "<?php echo $usuario['APELLIDO'];?>"readonly  />
								<small id="smallApellidos">Error message</small> 
								<input type="text" id="fecha" name="fecha" value = "<?php echo $usuario['FECHA_NACIMIENTO'];?>" placeholder= "<?php echo $usuario['FECHA_NACIMIENTO'];?>" readonly />
								<small id="smallFecha">Error message</small>
								<input type="text" id="edad" name="edad" value = "<?php echo $usuario['EDAD'];?>" max="150" placeholder="<?php echo $usuario['EDAD'];?>" readonly />
								<small id="smallEdad">Error message</small>
								<input type="text" id="dni" name="dni"  value = "<?php echo $usuario['DNI'];?>" placeholder="<?php echo $usuario['DNI'];?>" readonly />
								<small id="smallDni">Error message</small>
								<input type="text" id="tarjeta_sanitaria" name="tarjeta_sanitaria" value = "<?php echo $usuario['TARJETA_SANITARIA'];?>" placeholder= "<?php echo $usuario['TARJETA_SANITARIA'];?>" readonly />
								<small id="smallTarjeta">Error message</small>
								<?php 
								if(isset($errores) && count($errores) > 0){
									echo "<div id=\"div_errores\" class=\"errorServer\">";
						 			echo "<h4> Errores en el perfil: </h4>";
								foreach ($errores as $error) {
									echo $error;
								}
								echo "</div>";
								}
			
								?>
							</div>
							<div class = "datos_contacto">
								
								<input type="text" id="email" name="email"  value = "<?php echo $usuario['EMAIL'];?>" placeholder="<?php echo $usuario['EMAIL'];?>"  readonly/>
								<small id="smallEmail">Error message</small>
								<input type="password" id="contrasena" name="contrasena"  placeholder="<?php echo $usuario['PASS'];?>" />
								<small id="smallContrasena">Error message</small>
								<input type="text" id="telefono" name="telefono"  placeholder="<?php echo $usuario['TELEFONO'];?>"  />
								<small id="smallTelefono">Error message</small>
								<input type="text" id="domicilio" name="domicilio"   placeholder="<?php echo $usuario['DOMICILIO'];?>"  />
								<small id="smallDomicilio">Error message</small>
								
							</div>
							
						</div>
						
						</div>
						<input id="modificar" type="submit"  value="Actualizar Perfil">
					</form>
					
				
				</div>
				
			</div>

	</body>
	
	
</html>

