
function validateForm(){
	var noValidation = document.getElementById("filtrosConsulta").noValidate;
	if(!noValidation){
		var error1 = checkDNI();
		var error2 = checkFecha();
		var error3 = checkTipo();
		var error4 = checkGeneral();
		return (error1.length == 0) && (error2.length == 0) && (error3.length == 0) && (error4.length == 0);
	}else{
		return true;
	}
}

function checkDNI(){
	const DNIvalue = document.getElementById("dni").value.trim();
	var expresion_regular_dni = /^\d{8}[a-zA-Z]$/;
	if(DNIvalue !="" && expresion_regular_dni.test(DNIvalue) == false){
		errorFor(document.getElementById("dni"), document.getElementById("smallDni"), 'Introduce un DNI correcto');
		var error = "DNI no correcto";
	}else{
		exitoFor(document.getElementById("dni"),document.getElementById("smallDni"));
		var error = "";
	}
	return error;
}

function checkFecha(){
	const fechaInicio = document.getElementById("fechaInicio").value.trim();
	const fechaFin = document.getElementById("fechaFin").value.trim();	
	var inputDateInicio= new Date(fechaInicio);
	var inputDateFin= new Date(fechaFin);
	if (inputDateInicio.getDay()==0 || inputDateInicio.getDay()==5 || inputDateInicio.getDay()==6 || inputDateFin.getDay()==0 || inputDateFin.getDay()==5 || inputDateFin.getDay()==6 ) {
		errorFor(document.getElementById("fechaFin") , document.getElementById("smallFecha"), 'Los días no puede ser viernes, sábado o domingo');
		var error = "Los días no puede ser viernes, sábado o domingo";
	} else if ((fechaInicio=="" && fechaFin!="") || (fechaFin=="" && fechaInicio!="")) {
		errorFor(document.getElementById("fechaFin") , document.getElementById("smallFecha"), 'Rellena ambas fechas');
		var error = "Los días no puede ser viernes, sábado o domingo";	
	} else {
		exitoFor(document.getElementById("fechaFin"), document.getElementById("smallFecha"));
		var error="";
	}
	return error;
}

function checkTipo(){
	const tipo= document.getElementById("certificado").value.trim();
	var expresion_regular_tipo = /^[1-7]{1}$/;
	if(tipo !="" && expresion_regular_tipo.test(tipo) == false){
		errorFor(document.getElementById("certificado"), document.getElementById("smallCertificado"), 'Introduce un valor entre 1 y 7');
		var error = "Introduce un valor entre 1 y 7";
	}else{
		exitoFor(document.getElementById("certificado"),document.getElementById("smallCertificado"));
		var error = "";
	}
	return error;
}
function checkGeneral(){
	const DNIvalue = document.getElementById("dni").value.trim();
	const fechaInicio = document.getElementById("fechaInicio").value.trim();
	const fechaFin = document.getElementById("fechaFin").value.trim();
	const tipo= document.getElementById("certificado").value.trim();
		
	if(DNIvalue=="" && fechaInicio=="" && fechaFin=="" && tipo==""){
		errorFor(document.getElementById("filtrosError"), document.getElementById("smallFiltros"), 'Debe rellenar al menos un campo de filtrado completo');
		var error = "Campos no rellenos";
	}else{
		exitoFor(document.getElementById("filtrosError"),document.getElementById("smallFiltros"));
		var error = "";
	}
	return error;
}


function errorFor(input, small, mensaje){
	input.className = "error";
	small.className = "errorSmall";
	small.innerText = mensaje;
}

function exitoFor(input, small){
	input.className = "";
	small.className = "";
}

