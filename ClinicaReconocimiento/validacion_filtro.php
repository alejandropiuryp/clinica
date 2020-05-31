<?php
    session_start();
	
	if(isset($_SESSION["filtro"])){
		$filtro["dni"] = $_REQUEST["dni"];
		$filtro["fechaInicio"] = $_REQUEST["fechaInicio"];
		$filtro["fechaFin"] = $_REQUEST["fechaFin"];
		$filtro["certificado"] = $_REQUEST["certificado"];
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
 	if(isset($filtro["dni"])){
		if($filtro["dni"]!="" && !preg_match("/^\d{8}[a-zA-Z]$/", $filtro["dni"])){
			$errores[] = "<p>El DNI introducido no es correcto.</p>";
		}
	}
	//Validación de las fechas
	$fechaInicio=strtotime($filtro["fechaInicio"]);
	$fechaFin=strtotime($filtro["fechaFin"]);
	if(($filtro["fechaInicio"]=="" && $filtro["fechaFin"]!="") || ($filtro["fechaFin"]=="" && $filtro["fechaInicio"]!="")){
		$errores[] = "<p>Rellena ambas fechas.</p>";
	}
	//Validación del tipo
	if($filtro["certificado"]!="" && !preg_match("/^[1-7]{1}$/", $filtro["certificado"])){
		$errores[] = "<p>Introduce un valor entre 1 y 7.</p>";
	}
	
	//Validación general
	if(isset($filtro["dni"])){
		if($filtro["dni"]=="" && $filtro["fechaInicio"]=="" && $filtro["fechaFin"]=="" && $filtro["certificado"]==""){
			$errores[] = "<p>Debe rellenar al menos un campo para realizar el filtrado.</p>";
		}
	}else {
		if($filtro["fechaInicio"]=="" && $filtro["fechaFin"]=="" && $filtro["certificado"]==""){
			$errores[] = "<p>Debe rellenar al menos un campo para realizar el filtrado.</p>";		
		}
	}
	return $errores;
}	
?>