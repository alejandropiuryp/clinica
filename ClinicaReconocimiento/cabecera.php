<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"	href="css/cabecera.css" />

<header>
<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}
</script>
</header>
<body>
	<div class="encabezado">
	<img id="logo" src="img/clinica.png" alt="Certificados Moguer">
	<div class="topnav" id="myTopnav">
 	<ul class="listaCabecera">
  		<li><a href="#">Inicio</a></li>
  		<li><a href="#">Conócenos</a></li>
  		<li><a href="#">Servicios</a></li>
  		<li><a href="#">Citas</a></li>
  		<li><a href="#" class="icon" onclick="myFunction()">
    		<i class="fa fa-bars"></i>
  		</a></li>
  		
	</ul>
	</div>
</div>	
</body>
</html>