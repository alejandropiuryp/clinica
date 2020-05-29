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
    <a href="#" class="dropbtn">Mi cuenta</a>
    <div class="dropdown-content">
      <a href="#">Perfil</a>
      <a href="#">Mis citas</a>
	  <?php if (isset($_SESSION['login'])) {?>
	  		<a href="logout.php">Cerrar sesión</a>
	  <?php } ?>
    </div>
  </li>
  <li><a href="#home"><i class="fa fa-phone" aria-hidden="true"></i> 902 103 400</a></li>
</ul>
</nav>
</body>
</html>