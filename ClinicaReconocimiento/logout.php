<?php
	session_start();
    
    if (isset($_SESSION['login']))
        unset($_SESSION['login']);
	
	if (isset($_SESSION['admin']))
		unset($_SESSION['admin']);
    
    header("Location: paginaInicio.php");
?>
