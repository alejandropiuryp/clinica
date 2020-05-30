<?php	
	session_start();	
	
	if (isset($_SESSION["usuario"])) {
		$usuario = $_SESSION["usuario"];
		unset($_SESSION["usuario"]);
		
		require_once("gestionBD.php");
		require_once("gestionarUsuario.php");
		
		$telefono=$usuario["TELEFONO"];
		$contraseña=$usuario["PASS"];
		$domicilio=$usuario["DOMICILIO"];
		$dni=$usuario["DNI"];
		
		
		$conexion = crearConexionBD();
				
		cerrarConexionBD($conexion);
			Header("Location: consulta_perfil.php");
		
		}else {
			Header("Location: consulta_perfil.php");
		}


?>