<!DOCTYPE html>
<html>
<title>Servicios</title>

<head>
<link rel="stylesheet" type="text/css"	href="css/servicios.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/botonesservicio.js"></script>
	


<body>
<?php
	include_once('menu.php');
	include_once('cabecera.php');
?>
		<div class="Bajas" id="div1">
			<div class="T1" ><h2>Bajas Laborales</h2></div>
			
			<h4>Como en cualquier clínica medica se le realizaran chequeos para poder detectar si su salud
				esta bien tanto físicamente como psiquicamente, es decir con este servicio podremos darle un
				certificado que acredite que no esta al 100% de sus capacidades y que puede darse de baja laboral.</h4>
		</div>
		<button class="BotonIzq" id="Boton1" onclick="myButton1()">
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Bajas">
		
		</button>
		<div class="Deportistas" id="div2">
			
			<div class="T2"><h2>Deportistas</h2></div>
			<h4>Tal y como ocurre con trabajadores normales los deportistas también sufren lesiones por tanto
				aqui realizamos el reconocimiento médico necesario para acreditar que un deportista profesional 
				esta al 100% de sus capacidades y que podrá rendir al máximo.</h4>
		</div>
		<button class="BotonDrch" id="Boton2" onclick="myButton2()">
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Deportistas">
		</button>
		<div class="Gruistas" id="div3">
			<div class="T3"><h2>Gruistas</h2></div>
			<h4>Este servicio es para los trabajadores que manipulan grúas ya sea manipuladas por ellos o
				por autopropulsión. En cualquier caso la persona necesita un carné que lo 
				acreditaremos una vez que complete el reconocimiento médico, para que no ponga en riesgo su vida
				ni la de sus compañeros</h4>
		</div>
		<button class="BotonIzq" id="Boton3" onclick="myButton3()">
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Gruistas">
		</button>
		<div class="Armas" id="div4">
			<div class="T4"><h2>Armas</h2></div>
			<h4>Para utilizar armas de fuego para dedicarse a la caza hay que tener una licencia que acredite 
				que usted está en completo control de sus capacidades físicas y psíquicas para eso se le hará un 
				reconocimiento médico.</h4>
		</div>
		<button class="BotonDrch" id="Boton4" onclick="myButton4()">			
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Armas">
		</button>
		<div class="Navegacion" id="div5">
			<div class="T5"><h2>Barcos y Navegación</h2></div>
			<h4>La expedición, renovación o convalidación de las licencias otorgadas para el manejo de embarcaciones de 
				recreo se necesita igualmente un certificado médico que avale las aptitudes físicas y psíquicas 
				del aspirante.</h4>
		</div>
		<button class="BotonIzq" id="Boton5" onclick="myButton5()">			
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Navegacion">
		</button>
		<div class="Conducir" id="div6">
			<div class="T6"><h2>Carné de Conducir</h2></div>
			<h4>Es el más común de todos nuestros servicios, ya que es sabido por todo el mundo que para sacarse el
				carné de conducir debe pasar antes por un reconocimiento médico y eso es justo lo que hacemos con este 
				servicio.</h4>
		</div>
		<button class="BotonDrch" id="Boton6" onclick="myButton6()">			
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Conducir">
		</button>
		<div class="Animales" id="div7">
			<div class="T7"><h2>Animales Peligrosos</h2></div>
			<h4>El Régimen Jurídico de la Tenencia de Animales Potencialmente Peligrosos establece que la tenencia de 
				cualquier animal clasificado como potencialmente peligroso requerirá la previa obtención de una 
				licencia administrativa. Requiere un certificado médico de aptitud física y psicológica.</h4>
		</div>
		<button class="BotonIzq" id="Boton7" onclick="myButton7()">			
			<img src="./img/eyeHide.png" class="hide-icon" alt="Esconder Animales">
		</button>
	<div class="Imagenes">
	<a href="Conocenos.php">
    <img id="Imagen1" src="img/conocenos.jpg" alt="Conocenos">
    
    </a>
    <a href="pruebasMedicas.php">
    <img id="Imagen2" src="img/ref_pruebasmedicas.jpg" alt="PruebasMedicas">
    </a>
	</div>
</body>





</html>