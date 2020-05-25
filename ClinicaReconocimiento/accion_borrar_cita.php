<?php	
	session_start();	
	
	if (isset($_SESSION["cita"])) {
		$cita = $_SESSION["cita"];
		unset($_SESSION["cita"]);
		
		require_once("gestionBD.php");
		require_once("gestionarCitas.php");
		
		$conexion = crearConexionBD();		
		$excepcion = eliminarCita($conexion,$cita["DNI"], $cita["FECHA"]);
		cerrarConexionBD($conexion);
			
		if ($excepcion<>"") {
			$_SESSION["excepcion"] = $excepcion;
			$_SESSION["destino"] = "consulta_citas.php";
			Header("Location: excepcion.php");
		}
		else Header("Location: consulta_citas.php");
	}
	else Header("Location: consulta_citas.php"); // Se ha tratado de acceder directamente a este PHP
?>
