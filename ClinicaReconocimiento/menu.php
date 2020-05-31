<?php
	if (session_status() == PHP_SESSION_NONE) {
    	session_start();
	}
?>

<!DOCTYPE html>
<head>
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="css/menu.css" />
</head>
<body>
<nav>

<ul class="menu">
  <li class="dropdown">
  <?php if (isset($_SESSION['login']) || isset($_SESSION['admin'])){ ?>
    <a href="#" class="dropbtn">Mi cuenta</a>
    <div class="dropdown-content">
     <?php if (isset($_SESSION['login'])){ ?>
     	<a href="consulta_perfil.php">Perfil</a>
     <?php } ?>
      <a href="consulta_citas.php">Mis citas</a>
	  <a href="logout.php">Cerrar sesión</a>
    </div>
  </li>
   <?php }else{ ?>
   	<li><a href="login.php">Iniciar sesión</a></li>
   	<?php } ?>
  <li><a href="#home"><i id="icon" class="fa fa-phone" aria-hidden="true"></i>902 103 400</a></li>
</ul>


</nav>
</body>
</html>