<?php
    session_start();
		if(isset($_SESSION['perfil'])){
			$perfil["contrasena"] = $_REQUEST["contrasena"];
			$perfil["telefono"] = $_REQUEST["telefono"];
			$perfil["domicilio"] = $_REQUEST["domicilio"];
			$_SESSION["perfil"] = $perfil;
		}else{
			Header("Location: consulta_perfil.php");
		}

	$errores = validarDatosPerfil($perfil);
	
	if(count($errores) > 0){
		$_SESSION["errores"] = $errores;
		Header("Location: consulta_perfil.php");
	}else{
		Header("Location: controlador_perfil.php"); 
	}
	
///////////////////////////////////////////////////////////
// Validación en servidor del perfil de usuario
///////////////////////////////////////////////////////////

function validarDatosPerfil($perfil){
	$errores = array();
	//Validación de la contraseña
	if($perfil['contrasena']!=""){
		if(!isset($perfil["contrasena"]) || strlen($perfil["contrasena"]) < 8){
			$errores [] = "<p>Contraseña no válida: debe tener al menos 8 caracteres.</p>";
		}else if(!preg_match("/[a-z]+/", $perfil["contrasena"]) || 
			!preg_match("/[A-Z]+/", $perfil["contrasena"]) || !preg_match("/[0-9]+/", $perfil["contrasena"])){
			$errores[] = "<p>Contraseña no válida: debe contener al menos 8 caracteres, una letra mayuscula, una letra minúscula y al menos un dígito.</p>";
		}
	}
	
	// Validación del teléfono
	if($perfil['telefono']!=""){
		if(!preg_match("/^[0-9]{9}$/", $perfil["telefono"])){
			$errores[] = "<p>El teléfono no es correcto.</p>";
		}
	}
	
	// Validación del domicilio
	if($perfil['domicilio']!=""){
		if(!preg_match("/^[A,B,C]{1}\/[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]*$/", $perfil["domicilio"])){
			$errores[] = "<p>El domicilio no es correcto.</p>";
		}
	
	}
	return $errores;
}

	
?>