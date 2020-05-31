<?php
	session_start();

	require_once("gestionBD.php");
	require_once("paginacion_citas.php");
	require_once("gestionarCitas.php");
	require_once("gestionarUsuarios.php");
	
	//Si la sesión de usuario no está abierta lo redirigimos al login
	if(isset($_SESSION['admin'])){
		$admin=$_SESSION['admin'];
	}else{
		$admin="";
		if(!isset($_SESSION['login'])){
		
			header("Location: login.php");
		} else{
			$login=$_SESSION['login'];
		}		
	}
	
	
	$conexion=crearConexionBD();
	if (isset($_SESSION["cita"])){

		$cita = $_SESSION["cita"];

		unset($_SESSION["cita"]);

	}
	
	if(!isset($_SESSION["filtro"])){
		$filtro['dni'] = "";
		$filtro['fechaInicio'] = "";
		$filtro['fechaFin'] = "";		
		$filtro['certificado'] = "";

		
		$_SESSION["filtro"] = $filtro;
	}else{
		$filtro = $_SESSION["filtro"];
		
		if(isset($_SESSION["errores"])){
			$errores = $_SESSION["errores"];
			unset($_SESSION["errores"]);
		}
	}	
	
	if (isset($_SESSION["paginacion"])) $paginacion = $_SESSION["paginacion"];

	$pagina_seleccionada = isset($_GET["PAG_NUM"])? (int)$_GET["PAG_NUM"]:

												(isset($paginacion)? (int)$paginacion["PAG_NUM"]: 1);

	$pag_tam = isset($_GET["PAG_TAM"])? (int)$_GET["PAG_TAM"]:

										(isset($paginacion)? (int)$paginacion["PAG_TAM"]: 5);

	if ($pagina_seleccionada < 1) $pagina_seleccionada = 1;

	if ($pag_tam < 1) $pag_tam = 5;



	// Antes de seguir, borramos las variables de sección para no confundirnos más adelante

	unset($_SESSION["paginacion"]);
		
	if(isset($_SESSION["query"])){
		$query=$_SESSION["query"];
		unset($_SESSION["query"]);
	} else {
			//Comprobamos si es un administrador del sistema o un cliente para lo que vamos a devolver por defecto
		if($admin!="") {
			$query="SELECT FECHA, HORA, TIPO_CITA,TIPO_CERTIFICADO, DNI FROM CITAS";
		}else {
			$email=$login;
			$usuario=extraerDatosUsuario($conexion, $email);
			$_SESSION["usuario"]=$usuario;
			$DNI=$usuario["DNI"];
			$query="SELECT * FROM CITAS WHERE DNI='$DNI'";			
		}
	}
	
	// Se comprueba que el tamaño de página, página seleccionada y total de registros son conformes.
	// En caso de que no, se asume el tamaño de página propuesto, pero desde la página 1
	$total_registros = total_consulta($conexion,$query);

	$total_paginas = (int) ($total_registros / $pag_tam);

	if ($total_registros % $pag_tam > 0) $total_paginas++;

	if ($pagina_seleccionada > $total_paginas) $pagina_seleccionada = $total_paginas;


	// Generamos los valores de sesión para página e intervalo para volver a ella después de una operación

	$paginacion["PAG_NUM"] = $pagina_seleccionada;

	$paginacion["PAG_TAM"] = $pag_tam;

	$_SESSION["paginacion"] = $paginacion;

	$filas = consulta_paginada($conexion,$query,$pagina_seleccionada,$pag_tam);
	
	cerrarConexionBD($conexion);
?>


<!DOCTYPE html>
<html lang="es">
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link rel="stylesheet" type="text/css" href="css/consulta_citas.css"/>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
  <script src="js/filtrar_citas.js"></script>
  <script src="js/sideBarNav.js"></script>  
  <title>Mis Citas</title>
</head>
<body>
  		<?php
		include_once('menu.php');
		include_once('cabecera.php');
	?>  	
<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="#">Filtros:</a>
  
  <form id="filtrosConsulta" method="post" action="validacion_filtro.php" onsubmit="return validateForm();">
  
  <div class="filtros">
  
   <div class="filtroDNI">

  	<label for="dni" id="labeldni" 
  	style="<?php if(isset($_SESSION['login'])){
  		echo "visibility: hidden;";
			}?>">DNI</label>
  	<input id="dni" name="dni" type="text" placeholder="DNI" 
  	style="<?php if(isset($_SESSION['login'])){
  			echo "visibility: hidden;";
			}?>" />
  	<small id="smallDni">Error message</small>
  </div>
  
  <div class="filtroFecha">
  	<label for="filtrosFecha">Fechas</label>
  	<input id="fechaInicio" name="fechaInicio" type="date"/><br>
  	<input id="fechaFin" name="fechaFin" type="date"/>
  	<small id="smallFecha">Error message</small>
  </div>
  
   <div class="filtroCertificado">
    <label for="certificado">Certificado</label>
  	<input id="certificado" name="certificado" type="number" placeholder="Tipo de certificado" min="0" step="1"/>
  	<small id="smallCertificado">Error message</small>
  </div>
  
	<div id="filtrosError">
  		<small id="smallFiltros">Error message</small>
  	</div>
  
  <button id="filtrar" name="filtrar" type="submit">Filtrar</button>
     <?php 
		if(isset($errores) && count($errores) > 0){
			echo "<div id=\"div_errores\" class=\"errorServer\">";
			echo "<h4> Errores en el filtrado: </h4>";
		foreach ($errores as $error) {
			echo $error;
		}
		echo "</div>";
		}
			
	?> 
  </form>
  </div>

</div>

<span class="punteroNav" onclick="openNav()">&nbsp;&#10094;</span>

<main>
	<div class="contenedor">
		<nav>
		<div class="paginacion">
		<form method="get" action="consulta_citas.php">

			<input id="PAG_NUM" name="PAG_NUM" type="hidden" value="<?php echo $pagina_seleccionada?>"/>

			Mostrando

			<input id="PAG_TAM" name="PAG_TAM" type="number"

				min="1" max="5" step="1" value="<?php echo $pag_tam?>" autofocus="autofocus" />

			entradas de <?php echo $total_registros?>

			<input type="submit" value="Cambiar" id="cambiar">

		</form>
	</div>
	</nav>
	
	<div class="grid-title" >	
		<div class="Categoria1">DNI</div>
		<div class="Categoria2">Fecha-Hora</div>
		<div class="Categoria3">Tipo Cita</div>
		<div class="Categoria4">Tipo Certificado</div>					
				
	</div>			

	<?php
		foreach($filas as $fila) {
			
			
	?>
	<article class="citas">
		<form method="post" action="controlador_citas.php">
			<div class="fila_cita">
				<div class="datos_citas">
					<input id="DNI" name="DNI" type="hidden" value="<?php echo $fila["DNI"];?>"/>
					<input id="FECHA" name="FECHA" type="hidden" value="<?php echo $fila["FECHA"];?>"/>
					<input id="HORA" name="HORA" type="hidden" value="<?php echo $fila["HORA"];?>"/>
					<input id="TIPO_CITA" name="TIPO_CITA" type="hidden" value="<?php echo $fila["TIPO_CITA"];?>"/>
					<input id="TIPO_CERTIFICADO" name="TIPO_CERTIFICADO" type="hidden" value="<?php echo $fila["TIPO_CERTIFICADO"];?>"/>
					
				<?php


				 ?>
						<!-- mostrando citas -->
			
				<div class="grid-container" >

  						<div class="DNI"><?php echo $fila["DNI"]; ?></div>
 						<div class="Fecha-Hora"><?php echo $fila["FECHA"]; ?><br><?php echo $fila["HORA"]; ?></div>
 						<div class="Tipo-Cita"><?php echo $fila["TIPO_CITA"];?></div>
  						<div class="Tipo-Certificado"><?php echo $fila["TIPO_CERTIFICADO"]; ?></div>  

						<button id="eliminar" name="eliminar" type="submit" class="Botones">

							<img src="./img/delete.png" id="delete-icon" class="Botones" alt="Eliminar cita">

						</button>
				</div>
					
				</div>
				

		</div>
		</form>
	</article>
	
	<?php } ?>
	
	
		<div class="enlaces">
	
			<?php

				for( $pagina = 1; $pagina <= $total_paginas; $pagina++ )

					if ( $pagina == $pagina_seleccionada) { 	?>

						<span class="current"><?php echo $pagina; ?></span>

			<?php }	else { ?>

						<a href="consulta_citas.php?PAG_NUM=<?php echo $pagina; ?>&PAG_TAM=<?php echo $pag_tam; ?>"><?php echo $pagina; ?></a>

			<?php } ?>
		</div>
	</div>

</main>
</body>
</html>