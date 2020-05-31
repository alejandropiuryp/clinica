<?php
//Función para insertar citas
	function insertarCita($conexion, $fecha, $hora, $tipoCita,$dni, $tipoCertificado){
		try {
			$stmt=$conexion->prepare('CALL InsertaCita(:fecha, :hora, :tipoCita, :dni , :tipoCertificado)');
			$stmt->bindParam(':fecha',$fecha);
			$stmt->bindParam(':hora',$hora);
			$stmt->bindParam(':tipoCita',$tipoCita);
			$stmt->bindParam(':dni',$dni);
			$stmt->bindParam(':tipoCertificado',$tipoCertificado);
			$stmt->execute();
			return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    	}
	}
		
	//Función para eliminar citas
	function eliminarCita($conexion, $dni, $fecha){
		try {
			$stmt=$conexion->prepare('CALL CancelarCita(:dni , :fecha)');
			$stmt->bindParam(':dni',$dni);
			$stmt->bindParam(':fecha',$fecha);
			$stmt->execute();
			return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    	}
	}
	
	
?>
