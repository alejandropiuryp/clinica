<!DOCTYPE html>
<html>
<title>PruebasMedicas</title>
<head>
<link rel="stylesheet" type="text/css"	href="css/pruebasmedicas.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">




</head>


<body>
	<div class="contenedor">
	<div class="Titulo"><h2>Nuestras Pruebas</h2></div>
	<div class="div1">
		
		<img class ="slideFoto"src="img/tensiometro.jpg">
		<img class ="slideFoto"src="img/panelmiopia.jpg">
		<img class ="slideFoto"src="img/testpsicotecnico.jpg">
		
		<div class="mySlides">
			
			<div class="encabezado"><h2>Tension Arterial</h2></div>
			<h4>
				Una prueba de la presión arterial mide la presión en las arterias cuando el corazón late. Puedes tener 
				una prueba de presión arterial como parte de una cita médica de rutina o como un examen para detección 
				de presión arterial alta (hipertensión). Para esta prueba solo necesitaremos un tensiómetro de nuestro 
				material. Puedes conocer el valor de tu presión arterial apenas termina la prueba. La lectura de la 
				presión arterial, que se mide en milímetros de mercurio (mm Hg), tiene dos números. El primer número, 
				o superior, mide la presión en las arterias cuando el corazón late (presión sistólica). 
				El segundo número, o inferior, mide la presión en las arterias entre los latidos (presión diastólica).
				
			</h4>
			
		</div>
		<div class="mySlides">
			<div class="encabezado"><h2>Test de visión</h2></div>
			<h4>
				La prueba de agudeza visual se realiza a distancias cortas, medias y largas, ya que, de  esta forma es 
				posible conocer el nivel de visión de un individuo. Ahora bien, en el caso de que la agudeza visual no 
				sea la óptima, durante el examen el médico oftalmólogo, a través de optotipos 
				(láminas con letras, números, figuras o símbolos de distintos tamaños) determinará y corregirá el problema 
				refractivo del paciente, como   miopía, hipermetropía, astigmatismo o presbicia. Para algo mas de información
				el test que mas realiza es el test de Snellen que consiste en observar filas de letras que van reduciendo su 
				tamaño conforme bajamos la mirada. Cuanto mayor es el número de filas que es capaz de ver el paciente, 
				mejor es su agudeza visual, aunque se realizaran mas tipos de pruebas visuales.
			</h4>
			
		</div>
		<div class="mySlides">
			<div class="encabezado"><h2>Test Psicotécnicos</h2></div>
			<h4>
				Se entienden por tests psicotécnicos a un tipo de tests objetivo diseñados para evaluar de forma objetiva 
				(sin que medie en la obtención de resultados la subjetividad de un evaluador) las capacidades intelectuales 
				de una o varias personas. Se trata de tests altamente estructurados, de respuesta voluntaria controlada por 
				el sujeto y en el que no se enmascara el objetivo de la prueba (siendo relativamente fácil imaginar qué se 
				está midiendo). Las respuestas emitidas por el sujeto analizado van a ser tratadas como sinceras y verdaderas, 
				si bien se trata de tests de ejecución que no se verían beneficiados por intentos de variar las respuestas.
			</h4>
			
		</div>
		
	</div>
	</div>
<script>
var myIndex = 0;
var slideIndex = 0;

carousel();
carousel2();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 10000); 
}




function carousel2() {
  var i;
  var x = document.getElementsByClassName("slideFoto");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none"; 
  }
  slideIndex++;
  if (slideIndex > x.length) {slideIndex = 1} 
  x[slideIndex-1].style.display = "block"; 
  setTimeout(carousel2, 10000); 
 }

</script>

	
	
</body>
</html>