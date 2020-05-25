<?php
	//Si es trabajador ve todas las citas
	
	function consultarTodasCitas($conexion) {
 		$consulta = "SELECT FECHA, HORA, TIPO_CITA,TIPO_CERTIFICADO, DNI FROM CITAS";
		try {
	    	return $conexion->query($consulta);
		}catch(PDOException $e){
			
		$_SESSION['excepcion'] = $e->GetMessage();
			header("Location: excepcion.php");
		}
	}
	//Si es cliente sólo ve sus citas
   function consultarCitasCliente($conexion, $dni) {
 		$consulta = "SELECT FECHA, HORA, TIPO_CITA, TIPO_CERTIFICADO, DNI FROM CITAS WHERE DNI:=dni";
		try {
	    	return $conexion->query($consulta);
			
		}catch(PDOException $e){
			
		$_SESSION['excepcion'] = $e->GetMessage();
			header("Location: excepcion.php");
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
	
	//Igual que consultaCitasCliente?
	function citasPorDNI($conexion, $dni){
		try {
			$stmt=$conexion->prepare('CALL ConsultaCita(:dni)');
			$stmt->bindParam(':dni',$dni);
			$stmt->execute();
			return "";
	} catch(PDOException $e) {
		return $e->getMessage();
    	}
	}
	
   
?>
