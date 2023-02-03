<?php

session_start();

if (!isset($_POST["idRes"])) {
    exit("Erreur");
}

require_once("connectBD.php");

$con = connect_bd();

$sql = htmlspecialchars("DELETE FROM `reservation` WHERE `idReservation` = :idRes");

$values = [
    "idRes" => $_POST["idRes"]
];

$stmt = $con->prepare($sql);
$res = $stmt->execute($values);

if (!$res) {
    exit("Erreur");
}

exit('Réussie');
?>