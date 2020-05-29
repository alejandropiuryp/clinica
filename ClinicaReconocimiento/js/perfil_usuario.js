
function validateForm(){
	var noValidation = document.getElementById("perfilUsuario").noValidate;
	if(!noValidation){
		var error1 = checkPass();
		var error2 = checkTelefono();
		var error3 = checkDom();
		return (error1.length == 0) && (error2.length == 0) && (error3.length == 0);
	}else{
		return true;
	}
}

function checkPass(){
	const passValue = document.getElementById("contrasena").value.trim();
	var expresion_regular_pass = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
	if(passValue == ''){
		errorFor(document.getElementById("contrasena"), document.getElementById("smallContrasena"), 'La contraseña no puede estar vacía');
		var error = "La contraseña no puede estar vacía";
	}else if(expresion_regular_pass.test(passValue) == false){
		errorFor(document.getElementById("contrasena"), document.getElementById("smallContrasena"), 'Debe contener al menos 8 caracteres, una letra mayuscula, una letra minúscula y al menos un dígito');
		var error = "Introduce una contraseña válida";
	}else{
		exitoFor(document.getElementById("contrasena"),document.getElementById("smallContrasena"));
		var error = "";
	}
	return error;
}

function checkTelefono(){
	const telefonoValue = document.getElementById("telefono").value.trim();
	var expresion_regular_telefono = /^[0-9]{9}$/;
	if(telefonoValue == ''){
		errorFor(document.getElementById("telefono"), document.getElementById("smallTelefono"), 'El teléfono no puede estar vacío');
		var error = "El teléfono no puede estar vacío";
	}else if(expresion_regular_telefono.test(telefonoValue) == false){
		errorFor(document.getElementById("telefono"), document.getElementById("smallTelefono"), 'Número de teléfono incorrecto');
		var error = "Teléfono incorrecto";
	}else{
		exitoFor(document.getElementById("telefono"),document.getElementById("smallTelefono"));
		var error = "";
	}
	return error;
}

function checkDomicilio(){
	const domicilioValue = document.getElementById("domicilio").value.trim();
	var expresion_regular_domicilio= /^[a-zA-Z ']*$/;
	if(domicilioValue == ''){
		errorFor(document.getElementById("domicilio"), document.getElementById("smallDomicilio"), 'El domicilio no puede estar vacío');
		var error = "El domicilio no puede estar vacío";
	}else if(expresion_regular_domicilio.test(domicilioValue) == false){
		errorFor(document.getElementById("domicilio"), document.getElementById("smallDomicilio"), 'El domicilio no es correcto');
		var error = "El domicilio no es correcto";
	}else{
		exitoFor(document.getElementById("domicilio"),document.getElementById("smallDomicilio"));
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
