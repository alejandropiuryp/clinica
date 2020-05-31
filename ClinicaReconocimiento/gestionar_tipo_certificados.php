<?php
require_once("gestionBD.php");

	// Abrimos una conexión con la BD 
	$conexion = crearConexionBD();
	
	// Obtenemos la lista de municipios dada una provincia
	$listaTipos= listarTiposCertificados($conexion);
	// Si la lista no está vacía:
	if($listaTipos !=NULL){
		//Para cada tipo certificado del listado devuelto
		foreach($listaTipos as $tipo) { 
			//Creamos OPTIONS con VALUE = tipo de certificado 
			echo"<option label='".$tipo["TIPO"]."'value='".$tipo["TIPO"]."'/>".$tipo["TIPO"]."</option>";
	 	} 
	}
	
	// Cerramos la conexión
	cerrarConexionBD($conexion);

function listarTiposCertificados($conexion){
	try {
		$consulta = "SELECT TIPO FROM tipo_certificado";
		$stmt=$conexion->prepare($consulta);	

		$stmt->execute();	

		return $stmt->fetchAll();
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}

function oidCertificado($conexion, $tipo){
	try {
		$consulta = "SELECT OID_TIPO_CERTIFICADO FROM tipo_certificado WHERE TIPO=:tipo";
		$stmt=$conexion->prepare($consulta);	
		$stmt->bindParam(':tipo',$tipo);
		$stmt->execute();	

		return $stmt->fetch();
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}
	
?>