<?php	
	session_start();
	
	if (isset($_SESSION["filtro"])){
		
		$filtro=$_SESSION["filtro"];
		$dni=$filtro["dni"];
		if($filtro["fechaInicio"]!="" && $filtro["fechaFin"]!=""){
			$fechaInicio=date_format(date_create($filtro["fechaInicio"]),"d-m-Y");
			$fechaFin=date_format(date_create($filtro["fechaFin"]),"d-m-Y");
		}
		$certificado=$filtro["certificado"];
	}
	//Si es admin puede filtrar todo
	if(isset($_SESSION["admin"])){
		

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
		
	}else if(isset($_SESSION["login"])){
		$usuario=$_SESSION["usuario"];
		$DNI=$usuario["DNI"];
		
		
		if(($fechaInicio!="") && ($certificado!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$DNI' AND TIPO_CERTIFICADO='$certificado' AND FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";			
		}else if(($fechaInicio!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$DNI' AND FECHA BETWEEN '$fechaInicio' AND '$fechaFin'";			
		}else if(($certificado!="")){
			$query="SELECT * FROM CITAS WHERE DNI='$DNI' AND TIPO_CERTIFICADO='$certificado'";	
		}
		$_SESSION["query"]=$query;
		Header("Location: consulta_citas.php");	
		
	} else { 
		Header("Location: consulta_citas.php");
	}
?>