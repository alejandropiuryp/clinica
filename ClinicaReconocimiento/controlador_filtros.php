<?php	
	session_start();
	if (isset($_SESSION["filtro"])){
		
		$filtro=$_SESSION["filtro"];
		$dni=$filtro["dni"];
		$fechaInicio=$filtro["fechaInicio"];
		$fechaFin=$filtro["fechaFin"];
		$certificado=$filtro["certificado"];
		
	/*No uso la fecha de fin puesto que por la validación ya estamos obligando a rellenar las 2 si se inserta 1, 
	 así que si una tiene contenido la otra obligatoriamente también, simplificando la comparación*/
	 
		if(($dni!="") && ($fechaInicio!="") && ($certificado!="")){ 
			$query="SELECT * FROM CITAS WHERE DNI='$dni' AND TIPO_CERTIFICADO='$certificado' AND FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";
		}else if(($dni!="") && ($fechaInicio!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$dni' AND FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";
		}else if(($dni!="") && ($certificado!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$dni' AND TIPO_CERTIFICADO='$certificado'";
		}else if(($fechaInicio!="") && ($certificado!="")){
			$query="SELECT * FROM CITAS WHERE TIPO_CERTIFICADO='$certificado' AND FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";
		}else if(($dni!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$dni'";
		}else if(($fechaInicio!="")){
			$query="SELECT * FROM CITAS WHERE FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";			
		}else if(($certificado!="")){
			$query="SELECT * FROM CITAS WHERE TIPO_CERTIFICADO='$certificado'";				
		}		
		$_SESSION["query"]=$query;
		Header("Location: consulta_citas.php");	
		
	} else { 
		Header("Location: consulta_citas.php");
	}
?>