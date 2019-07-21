<h1>¡Hola!</h1>
<h4>Intentando conexión MySQL desde php...</h4>
<?php
$host = 'mysql';
$user = 'root';
$pass = 'rootpassword';
$conn = new mysqli($host, $user, $pass);

if ($conn->connect_error) {
    die("conexión fallida: " . $conn->connect_error);
} 
echo "¡Conectado a MySQL!";
?>
