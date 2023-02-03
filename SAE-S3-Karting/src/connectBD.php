<?php
define('USER', "root");
define('PSWD', "");
define('SERVER', "localhost");
define('BASE', "bdsae");


function connect_bd(){
    $dsn = "mysql:dbname=".BASE.";host=".SERVER.";charset=utf8";
    try {
        $connexion = new PDO($dsn, USER, PSWD);
    } catch (PDOException $e) {
        printf("Echec de la connexion : %s\n", $e->getMessage()); exit();
    }
    return $connexion;
}
?>