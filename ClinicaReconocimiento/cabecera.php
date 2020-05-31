<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"	href="css/cabecera.css" />

<header>
</header>
<body>
	<div class="contenedorCabecera">
		<img id="logo" src="img/clinica.png" alt="Certificados Moguer">
		<div class="encabezadoCabecera">
			<div class="topnav" id="myTopnav">
 			<ul class="listaCabecera">
  				<li><a href="paginaInicio.php">Inicio</a></li>
  				<li><a href="Conocenos.php">Conócenos</a></li>
  				<li><a href="Servicios.php">Servicios</a></li>
  				<?php if(!isset($_SESSION['admin'])) {?>
  				<li><a href="pedir_cita.php">Citas</a></li>
  				<?php } ?>
  		
			</ul>
			</div>
		</div>
	</div>
</body>
</html>