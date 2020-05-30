<?php
    session_start();
	require_once("gestionBD.php");
	require_once("gestionarPerfil.php");
	require_once ("gestionarUsuarios.php");
	$conexion=crearConexionBD();
	
	
	if(isset($_SESSION['perfil'],$_SESSION['usuario'])){
		$perfil = $_SESSION['perfil'];
		$usuario = $_SESSION['usuario'];
		$_SESSION['perfil']=null;
		$_SESSION['errores']=null;
		$_SESSION['usuario']=null;
		$telefono = $perfil['telefono'];
		$domicilio = $perfil['domicilio'];
		$contrasena = $perfil['contrasena'];
		$dni = $usuario['DNI'];
	
	}else{
		Header("Location: consulta_perfil.php");
	}
	
	
	if (isset($telefono)){
	    modificarTelefono($conexion, $dni, $telefono);
		
        
	}
	if($domicilio!=""){
		modificarDomicilio($conexion, $dni, $domicilio);
		
	}
	if(isset($contrasena)){
		modificarContraseña($conexion, $dni, $contrasena);
		
	}
	

	cerrarConexionBD($conexion);
	Header("Location: consulta_perfil.php");
	
?>