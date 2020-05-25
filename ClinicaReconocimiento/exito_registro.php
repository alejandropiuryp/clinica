<?php
    session_start();
	
	require_once("gestionBD.php");
	require_once("gestionarUsuarios.php");
	
	if(isset($_SESSION["registro"])){
		$nuevoUsuario = $_SESSION["registro"];
		$_SESSION["registro"] = null;
		$_SESSION["errores"] = null;
	}else{
		Header("Location: registro_usuario.php");
	}
	
	$conexion = crearConexionBD();
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <link href="css/exito_usuario.css" rel="stylesheet" type="text/css" media="all">
  <title>Registro realizado con éxito </title>
</head>

<body>
	<?php if (alta_usuario($conexion, $nuevoUsuario)) { 
				$_SESSION['login'] = $nuevoUsuario['email'];
	?>
		<div class = "centrado">
			<h1>Bienvenido <?php echo $nuevoUsuario["nombre"]; ?></h1>
			<div >	
				<a class="boton" href="">Aceptar</a>
			</div>
		</div>
	<?php } else{ ?>
		<div class = "centrado">
			<h1>Ya tienes una cuenta</h1>
			<div >	
			 	<a class="boton" href="login.php">Iniciar Sesión</a> 
			</div>
		</div>
	<?php } ?>
</body>
</html>
<?php
	cerrarConexionBD($conexion);
?>