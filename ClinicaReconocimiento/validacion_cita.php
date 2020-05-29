<?php
    session_start();
	
	if(isset($_SESSION["reqCita"])){
		$reqCita["tipoCertificado"] = $_REQUEST["tipoCertificado"];
		$reqCita["fechaCita"] = $_REQUEST["fechaCita"];
		$reqCita["horaCita"] = $_REQUEST["horaCita"];
		$_SESSION["reqCita"] = $reqCita;
	}else{
		Header("Location: pedir_cita.php");
	}
	
	$errores = validarDatosCita($reqCita);
	
	if(count($errores) > 0){
		$_SESSION["errores"] = $errores;
		Header("Location: pedir_cita.php");
	}else{
		Header("Location: exito_cita.php");    //MANDAR AL INICIO
	}
	
///////////////////////////////////////////////////////////
// Validación en servidor de la petición de cita
///////////////////////////////////////////////////////////

function validarDatosCita($reqCita){
	$errores = array();
	//Validación del tipo de cita
	if($reqCita["tipoCertificado"] == ""){
		$errores[] = "<p>El tipo de certificado no puede estar vacío.</p>";
	}
	//Validación de la fecha
	$fecha=strtotime($reqCita["fechaCita"]);
	$dia = date('w', $fecha);
	$currentDate = date("Y-m-d");
	$todayDate=strtotime($currentDate);		
	
	if($reqCita["fechaCita"] == ""){
		$errores[] = "<p>La fecha no puede estar vacía.</p>";
	}else if($dia=='0' || $dia=='5' || $dia=='6'){
		$errores[] = "<p>La fecha no puede ser un viernes, sábado o domingo.</p>";
	}else if($fecha < $todayDate){
		$errores[] = "<p>La fecha no puede ser anterior a la de hoy.</p>";
	}
	//Validación de la hora
	$currentHour= date('H:i');
	if($reqCita["horaCita"] == ""){
		$errores[] = "<p>La hora no puede estar vacía.</p>";
	}else if(!preg_match("/^([1][6-9]):[0,3][0]$/", $reqCita["horaCita"])){
		$errores[] = "<p>La hora es incorrecta: " . $reqCita["horaCita"]. ".</p>";
	} else if($reqCita["horaCita"] < $currentHour && $fecha <= $todayDate) {
		$errores[] = "<p>La hora no puede ser anterior a la actual: " . $reqCita["horaCita"]. ".</p>";	
	}
	return $errores;
}	
?>