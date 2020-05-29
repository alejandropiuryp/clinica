<?php
	//Si es trabajador ve todas las citas
	require_once("gestionBD.php");
	$conexion=crearConexionBD();
	function consultarTodasCitas($conexion) {
	try {
		$consulta = "SELECT * FROM CITAS";
		$stmt = $conexion->query($consulta);

		return $stmt;
	} catch(PDOException $e) {
		return $e->getMessage();
      }
	}
	
	//Si es cliente sólo ve sus citas
   function consultarCitasCliente($conexion, $dni) {
 		$consulta = "SELECT FECHA, HORA, TIPO_CITA, TIPO_CERTIFICADO, DNI FROM CITAS WHERE DNI=:dni";
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
	
	//$res2=citasPorDNI($conexion, 28123237D);
		//Cliente requiere dni para uqe no vea todas las citas
	function citasPorFechaCliente($conexion, $dni, $fechaInicio, $fechaFin){
 		$consulta = "SELECT FECHA, HORA, TIPO_CITA, TIPO_CERTIFICADO, DNI FROM CITAS WHERE DNI=:dni";
		$stmt = $conexion->prepare($consulta);
		$stmt->bindParam(':dni',$dni);
		$stmt->bindParam(':fechaInicio',$fechaInicio);
		$stmt->bindParam(':fechaFin',$fechaFin);
		$stmt->execute();
		return $stmt->fetchColumn();
	}	
	
	//Admin
	/*function citasPorFecha($conexion, $fechaInicio, $fechaFin){
	//try {
			//$fecha1=date('d/m/Y', strtotime($fechaInicio));
			//$fecha2=date('d/m/Y', strtotime($fechaFin));
			$stmt=$conexion->prepare("SELECT * FROM CITAS WHERE FECHA BETWEEN fecha_inicio=:TO_DATE('20-06-2020', 'DD-MM-YYYY') AND fecha_fin=:('27-06-2020', 'DD-MM-YYYY')");
			$stmt->bindParam(':fechaInicio',$fechaInicio);
			$stmt->bindParam(':fechaFin',$fechaFin);
			$stmt->execute();
			return $stmt -> fetch();
	/*} catch(PDOException $e) {
		echo $e -> getMessage();
		return false;
		}
	//}
	/*echo "hola";	
	$hola=citasPorFecha($conexion, '20-06-20' , '27-06-2020');
	echo $hola;*/
	function citasPorTipo($conexion, $tipo){
	
	try {
 		$consulta = "SELECT FECHA, HORA, TIPO_CITA, TIPO_CERTIFICADO, DNI FROM CITAS WHERE TIPO_CERTIFICADO=:tipo";
		$stmt = $conexion->prepare($consulta);
		$stmt->bindParam(':tipo',$tipo);
		$stmt->execute();
	    return $stmt;		
	} catch(PDOException $e) {
		return $e->getMessage();
    	}
	}
	/*$res=citasPorTipo($conexion, 1);
	foreach($res as $r){
		echo "Tipo C:" . $r["TIPO_CERTIFICADO"] . " DNI:" .$r["DNI"];
	}*/
		
   cerrarConexionBD($conexion);
?>
