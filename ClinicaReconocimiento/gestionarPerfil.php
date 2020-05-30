<?php
function modificarDomicilio($conexion, $dni, $domicilio) {
 		try {
         $consulta = "UPDATE CLIENTES SET DOMICILIO=:domicilio WHERE DNI=:dni";
        $stmt = $conexion->prepare($consulta);
        $stmt->bindParam(':dni',$dni);
		$stmt->bindParam(':domicilio',$domicilio);
        $stmt->execute();
        return "";
    } catch(PDOException $e) {
        return $e->getMessage();
        }
	}

function modificarTelefono($conexion, $dni, $telefono) {
 		
   try {
        $consulta = "UPDATE CLIENTES SET TELEFONO=:telefono WHERE DNI=:dni";
        $stmt = $conexion->prepare($consulta);
        $stmt->bindParam(':dni',$dni);
		$stmt->bindParam(':telefono',$telefono);
        $stmt->execute();
        return "";
    } catch(PDOException $e) {
        return $e->getMessage();
        }
        
}
function modificarContraseña($conexion, $dni, $contraseña) {
 		try {
         $consulta = "UPDATE CLIENTES SET PASS=:contraseña WHERE DNI=:dni";
        $stmt = $conexion->prepare($consulta);
        $stmt->bindParam(':dni',$dni);
		$stmt->bindParam(':contraseña',$contraseña);
        $stmt->execute();
        return "";
    } catch(PDOException $e) {
        return $e->getMessage();
        }
	}


?>