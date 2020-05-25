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
			//Creamos OPTIONS con VALUE = nombre del tipo de certificado 
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

		return $stmt;
	} catch(PDOException $e) {
		return $e->getMessage();
    }
}
?>