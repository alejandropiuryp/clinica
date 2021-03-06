<?php
	session_start();
  	
  	include_once("gestionBD.php");
 	include_once("gestionarUsuarios.php");
	
	if(isset($_SESSION['login']) || isset($_SESSION['admin'])){
		Header("Location: paginaInicio.php");
	}else{
	
		if (isset($_POST['submit'])){
			$email= $_POST['email'];
			$pass = $_POST['contrasena'];

			$conexion = crearConexionBD();
			$num_usuarios = consultarUsuario($conexion,$email,$pass);
			$num_trabajadores = consultarTrabajador($conexion, $email, $pass);
			cerrarConexionBD($conexion);	
	
			if($num_trabajadores == 0){
				if($num_usuarios == 0){
					$login = "error";
				}else{
					$_SESSION['login'] = $email;
					Header("Location: paginaInicio.php");
				}
			}else{
				$_SESSION['admin'] = $email;
				Header("Location: paginaInicio.php");
			}
		}
	}

?>

<!DOCTYPE html>
<html lang="es">
	<head>
		<meta charset="utf-8">
		<title>Login</title>
		<link href="css/registro_usuario.css" rel="stylesheet" type="text/css" media="all">
		<link href="css/login.css" rel="stylesheet" type="text/css" media="all">
		<script src="js/registro_usuario.js" type="text/javascript"></script>
	</head>
<?php
	include_once('cabecera.php');
?>
	<body>
		<div class="contenedor">
			<form action="login.php" method="post" onsubmit="return validateLog()">
				<div class = "columnas2">
					<div class = "datos_contacto">
						<h1>Iniciar Sesión</h1>
						<input type="text" name="email" id="email" placeholder="Correo electrónico" />
						<small id="smallEmail">Error message</small>
						<input type="password" name="contrasena" id="contrasena" placeholder="Contraseña"/>
						<small id="smallContrasena">Error message</small>
						<?php if (isset($login)) {
							echo "<small class = \"errorSmall\">Error en la contraseña o no existe el usuario </small>";
						}	
						?>
						<input class="enviar" type="submit" name="submit" value="Iniciar Sesión" />
						 <a class="redireccion"  href="registro_usuario.php">¿No estás registrado?</a>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>
