<?php

if (!isset($_POST["idMatch"]) || !isset($_POST["idWinner"])) {
    exit("Erreur1");
}

require("connectBD.php");

$con = connect_bd();

$sql = "SET FOREIGN_KEY_CHECKS=0; UPDATE `match` SET `Gagnant` = :idWinner WHERE `idMatch` = :idMatch; SET FOREIGN_KEY_CHECKS=1;";
$values = [
    "idMatch" => $_POST["idMatch"],
    "idWinner" => $_POST["idWinner"]
];

$stmt = $con->prepare($sql);
$res = $stmt->execute($values);

if (!$res) {
    exit("Erreur");
}

exit("Réussie");
?>