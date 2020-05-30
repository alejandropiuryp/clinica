<?php
   function alta_usuario($conexion,$usuario){
   		$fechaNacimiento = date('d/m/Y', strtotime($usuario["fecha"]));
		
		try{
			$consulta = "CALL INSERTACLIENTE(:dni, :nombre, :apellido, :edad, :domicilio, :telefono,
			:tarjeta, :pass, :fecha, :email)";
			$stmt=$conexion->prepare($consulta);
			$stmt->bindParam(':dni', $usuario["dni"]);
			$stmt->bindParam(':nombre', $usuario["nombre"]);
			$stmt->bindParam(':apellido', $usuario["apellidos"]);
			$stmt->bindParam(':edad', $usuario["edad"]);
			$stmt->bindParam(':domicilio', $usuario["domicilio"]);
			$stmt->bindParam(':telefono', $usuario["telefono"]);
			$stmt->bindParam(':tarjeta', $usuario["tarjeta_sanitaria"]);
			$stmt->bindParam(':pass', $usuario["contrasena"]);
			$stmt->bindParam(':fecha', $fechaNacimiento);
			$stmt->bindParam(':email', $usuario["email"]);
			
			$stmt->execute();
			
			return true;
		}catch(PDOException $e){
			return false;
		}
   }
   
   function consultarUsuario($conexion,$email,$pass) {
 		$consulta = "SELECT COUNT(*) AS TOTAL FROM CLIENTES WHERE EMAIL=:email AND PASS=:pass";
		$stmt = $conexion->prepare($consulta);
		$stmt->bindParam(':email',$email);
		$stmt->bindParam(':pass',$pass);
		$stmt->execute();
		return $stmt->fetchColumn();
	}
   	
   	 function consultarTrabajador($conexion,$email,$pass) {
 		$consulta = "SELECT COUNT(*) AS TOTAL FROM TRABAJADORES WHERE EMAIL=:email AND PASS=:pass";
		$stmt = $conexion->prepare($consulta);
		$stmt->bindParam(':email',$email);
		$stmt->bindParam(':pass',$pass);
		$stmt->execute();
		return $stmt->fetchColumn();
	}
	 
	function extraerDatosUsuario($conexion, $email){
        $consulta = "SELECT * FROM CLIENTES WHERE EMAIL=:email";
        $stmt = $conexion->prepare($consulta);
        $stmt->bindParam(':email',$email);
        $stmt->execute();
        return $stmt->fetch();
     }
	
?>