<?php
    session_start();
	
	if(isset($_SESSION["perfil"])){

		$perfil["contrasena"] = $_REQUEST["contrasena"];
		$perfil["telefono"] = $_REQUEST["telefono"];
		$perfil["domicilio"] = $_REQUEST["domicilio"];
		
		$_SESSION["perfil"] = $perfil;
	}else{
		Header("Location: login.php"); //REVISAR
	}
	
	$errores = validarDatosPerfil($perfil);
	
	if(count($errores) > 0){
		$_SESSION["errores"] = $errores;
		Header("Location: registro_usuario.php");
	}else{
		Header("Location: controlador_perfil.php");  //DONDE SE MANDA
	}
	
///////////////////////////////////////////////////////////
// Validación en servidor del perfil de usuario
///////////////////////////////////////////////////////////

function validarDatosPerfil($perfil){
	$errores = array();
	//Validación de la contraseña
	if(!isset($perfil["contrasena"]) || strlen($perfil["contrasena"]) < 8){
		$errores [] = "<p>Contraseña no válida: debe tener al menos 8 caracteres.</p>";
	}else if(!preg_match("/[a-z]+/", $perfil["contrasena"]) || 
		!preg_match("/[A-Z]+/", $perfil["contrasena"]) || !preg_match("/[0-9]+/", $perfil["contrasena"])){
		$errores[] = "<p>Contraseña no válida: debe contener al menos 8 caracteres, una letra mayuscula, una letra minúscula y al menos un dígito.</p>";
	// Validación del teléfono
	if($perfil["telefono"]==""){
		$errores[] = "<p>El teléfono no puede estar vacío.</p>";
	}else if(!preg_match("/^[0-9]{9}$/", $perfil["telefono"])){
		$errores[] = "<p>El teléfono no es correcto.</p>";
	}
	// Validación del domicilio
	if($perfil["domicilio"] == ""){
		$errores[] = "<p>El domicilio no puede estar vacío.</p>";
	}else if(!preg_match("/^[a-zA-Z ']*$/", $perfil["domicilio"])){
		$errores[] = "<p>El domicilio no es correcto.</p>";
	}
	return $errores;
}	
?>