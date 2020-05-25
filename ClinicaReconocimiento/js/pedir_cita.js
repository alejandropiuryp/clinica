
function validateForm(){
	var noValidation = document.getElementById("citaUsuario").noValidate;
	if(!noValidation){
		var error1 = checkTipoCita();
		var error2 = checkFecha();
		var error3 = checkHora();
	
		return (error1.length == 0) && (error2.length == 0) && (error3.length == 0);
	}else{
		return true;
	}
}


function checkTipoCita(){
	const tipoCita = document.getElementById("tipoCertificado").value.trim();
	if (tipoCita==""){
		errorFor(document.getElementById("tipoCertificado"), document.getElementById("smallTipo"), 'El tipo no puede estar vacío');
		var error = "El tipo de cita no puede estar vacío";
	}else{
		exitoFor(document.getElementById("tipoCertificado"),document.getElementById("smallTipo"));
		var error = "";
	}
	return error;
}
	
function checkFecha(){
	const fecha = document.getElementById("fechaCita").value.trim();
	var inputDate= new Date(fecha);
	var todayDate = new Date();
	if (fecha==""){
		errorFor(document.getElementById("fechaCita") , document.getElementById("smallFecha"), 'La fecha no puede estar vacía');
		var error = "La fecha no puede estar vacía";
		
	} else if (inputDate.getDay()==0 || inputDate.getDay()==5 || inputDate.getDay()==6) {
		errorFor(document.getElementById("fechaCita") , document.getElementById("smallFecha"), 'El día de la cita no puede ser viernes, sábado o domingo');
		var error = "El día de la cita no puede ser viernes, sábado o domingo";
	
	} else if (inputDate < todayDate) {
		errorFor(document.getElementById("fechaCita") , document.getElementById("smallFecha"), 'La fecha no puede ser anterior a la de hoy');
		var error = "La fecha no puede ser anterior a la de hoy";
	} else {
		exitoFor(document.getElementById("fechaCita"), document.getElementById("smallFecha"));
		var error="";
	}
	return error;
}
	
function checkHora(){
	const hora = document.getElementById("horaCita").value.trim();
	const fecha = document.getElementById("fechaCita").value.trim();
	var inputDate= new Date(fecha);
	var expresion_regular_hora = /^([1][6-9]):[0,3][0]$/;
	var todayDate = new Date();
	var currentHourMin= todayDate.getHours() + ":" + todayDate.getMinutes();
	
	if (hora==""){
		errorFor(document.getElementById("horaCita") , document.getElementById("smallHora"), 'La hora no puede estar vacía');
		var error = "Debe especificar una hora";
	} else if (hora < currentHourMin && inputDate <= todayDate){
		errorFor(document.getElementById("horaCita") , document.getElementById("smallHora"), 'La hora no puede ser anterior a la actual');
		var error = "La hora no puede ser anterior a la actual";
	} else if (expresion_regular_hora.test(hora)==false){
		errorFor(document.getElementById("horaCita") , document.getElementById("smallHora"), 'La hora debe estar entre las 16:00 y las 19:30');
		var error = "La hora debe estar entre las 16:00 y las 19:30";
	} else {
		exitoFor(document.getElementById("horaCita"), document.getElementById("smallHora"));
		var error="";
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

function errorServer(){
	alert("hola");
}	
		
		
	
