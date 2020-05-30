function validateForm(){
	var noValidation = document.getElementById("perfilUsuario").noValidate;
	if(!noValidation){
		var error1 = checkPass();
		var error2 = checkTelefono();
		var error3 = checkDomicilio();
		return (error1.length == 0) && (error2.length == 0) && (error3.length == 0);
	}else{
		return true;
	}
}

function checkPass(){
	const passValue = document.getElementById("contrasena").value.trim();
	var expresion_regular_pass = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/;
	if(passValue!=""){
		if(expresion_regular_pass.test(passValue) == false){
			errorFor(document.getElementById("contrasena"), document.getElementById("smallContrasena"), 'Debe contener al menos 8 caracteres, una letra mayuscula, una letra minúscula y al menos un dígito');
			var error = "Introduce una contraseña válida";
		}else{
			exitoFor(document.getElementById("contrasena"),document.getElementById("smallContrasena"));
			var error = "";
		}
	}else{
		exitoFor(document.getElementById("contrasena"),document.getElementById("smallContrasena"));
		var error = "";
	}
	
	return error;
}

function checkTelefono(){
	const telefonoValue = document.getElementById("telefono").value.trim();
	var expresion_regular_telefono = /^[0-9]{9}$/;
	if(telefonoValue!=""){
		if(expresion_regular_telefono.test(telefonoValue) == false){
			errorFor(document.getElementById("telefono"), document.getElementById("smallTelefono"), 'Número de teléfono incorrecto');
			var error = "Teléfono incorrecto";
		}else{
			exitoFor(document.getElementById("telefono"),document.getElementById("smallTelefono"));
			var error = "";
		}
	}else{
		exitoFor(document.getElementById("telefono"),document.getElementById("smallTelefono"));
		var error = "";
	}
	
	return error;
}

function checkDomicilio(){
	const domicilioValue = document.getElementById("domicilio").value.trim();
	var expresion_regular_domicilio= /^[A,B,C]{1}/[a-zA-Z ']*$/;
	if(domicilioValue!=""){
		if(expresion_regular_domicilio.test(domicilioValue) == false){
			errorFor(document.getElementById("domicilio"), document.getElementById("smallDomicilio"), 'El domicilio no es correcto');
			var error = "El domicilio no es correcto";
		}else{
			exitoFor(document.getElementById("domicilio"),document.getElementById("smallDomicilio"));
			var error = "";
		}
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