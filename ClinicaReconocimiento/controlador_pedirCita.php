<?php	
	session_start();
	require_once("gestionBD.php");
	require_once("gestionarUsuarios.php");
	require_once("gestionarCitas.php");
	require_once("gestionar_tipo_certificados.php");
	if (isset($_SESSION["reqCita"])){

		$reqCita=$_SESSION["reqCita"];
		if($reqCita["fechaCita"]!="" && $reqCita["horaCita"]!=""){
			$fecha =date_format(date_create($reqCita["fechaCita"]),"d-m-Y");
			$hora = $reqCita["horaCita"];
		}
		$tipoCertificado= $reqCita["tipoCertificado"];
		echo $tipoCertificado;
		$tipoCita="1";
		
		$conexion=crearConexionBD();
		$login = $_SESSION['login'];
		$email = $login;
		$usuario=extraerDatosUsuario($conexion, $email);
		$dni=$usuario["DNI"];
	
		$oid=oidCertificado($conexion, $tipoCertificado);
		insertarCita($conexion, $fecha, $hora, $tipoCita ,$dni, $oid[0]);
		cerrarConexionBD($conexion);
		Header("Location: consulta_citas.php");
		
		
	}else{
		Header("Location: pedir_cita.php");
	}
		
	

?>