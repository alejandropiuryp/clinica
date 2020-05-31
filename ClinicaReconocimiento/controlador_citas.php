<?php	
	session_start();
	if (isset($_REQUEST["DNI"], $_REQUEST["FECHA"])){

		$cita["FECHA"] = $_REQUEST["FECHA"];
		$cita["HORA"] = $_REQUEST["HORA"];
		$cita["TIPO_CITA"] = $_REQUEST["TIPO_CITA"];
		$cita["DNI"] = $_REQUEST["DNI"];
		$cita["TIPO_CERTIFICADO"] = $_REQUEST["TIPO_CERTIFICADO"];
		$_SESSION["cita"] = $cita;
		
		
		if (isset($_REQUEST["eliminar"])) {Header("Location: accion_borrar_cita.php"); }
		
	}else 
		Header("Location: consulta_citas.php");
	
	

?>