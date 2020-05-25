$(document).ready(function () {
		$("#tipoCertificado").on("click", function () {
			$.get("gestionar_tipo_certificados.php", function(data){
        			// Adjunto al datalist la lista de tipos de certificados devuelta por la consulta AJAX
        			$("#opcionesCertificado").empty();
        			
					$("#opcionesCertificado").append(data);
					});
    			});
    		});