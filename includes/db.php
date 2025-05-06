<?php
$host = 'localhost';
$dbname = 'chiikawastore';
$username = 'root'; // hoặc tên tài khoản của bạn
$password = '';     // hoặc mật khẩu của bạn

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
