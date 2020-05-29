<?php
    session_start();
	
	if(isset($_SESSION["filtro"])){
		$filtro["dni"] = $_REQUEST["dni"];
		$filtro["fechaInicio"] = $_REQUEST["fechaInicio"];
		$filtro["fechaFin"] = $_REQUEST["fechaFin"];
		$filtro["certificado"] = $_REQUEST["certificado"];
		$filtro["filtrar"] =$_REQUEST["filtrar"];
		$_SESSION["filtro"] = $filtro;
		
	}else{
		Header("Location: consulta_citas.php");
	}
	
	$errores = validarFiltrosCita($filtro);
	
	if(count($errores) > 0){
		$_SESSION["errores"] = $errores;
		Header("Location: consulta_citas.php");
	} else{
		Header("Location: controlador_filtros.php");
	}

///////////////////////////////////////////////////////////
// Validación en servidor del filtro de citas
///////////////////////////////////////////////////////////

function validarFiltrosCita($filtro){
	$errores = array();
	//Validación del dni de cita 
	if($filtro["dni"]!="" && !preg_match("/^\d{8}[a-zA-Z]$/", $filtro["dni"])){
		$errores[] = "<p>El DNI introducido no es correcto.</p>";
	}
	//Validación de las fechas
	$fechaInicio=strtotime($filtro["fechaInicio"]);
	$fechaFin=strtotime($filtro["fechaFin"]);
	$diaInicio = date('w', $fechaInicio);
	$diaFin = date('w', $fechaFin);
	if($diaInicio=='0' || $diaInicio=='5' || $diaInicio=='6' || $diaFin=='0' || $diaFin=='5' || $diaFin=='6' ){
		$errores[] = "<p>La fecha no puede ser un viernes, sábado o domingo.</p>";
	} else if(($filtro["fechaInicio"]=="" && $filtro["fechaFin"]!="") || ($filtro["fechaFin"]=="" && $filtro["fechaInicio"]!="")){
		$errores[] = "<p>Rellena ambas fechas.</p>";
	}
	//Validación del tipo
	if($filtro["certificado"]!="" && !preg_match("/^[1-7]{1}$/", $filtro["certificado"])){
		$errores[] = "<p>Introduce un valor entre 1 y 7.</p>";
	}
	
	//Validación general
	if($filtro["dni"]=="" && $filtro["fechaInicio"]=="" && $filtro["fechaFin"]=="" && $filtro["certificado"]==""){
		$errores[] = "<p>Debe rellenar al menos un campo para realizar el filtrado.</p>";
	}
	return $errores;
}	
?>