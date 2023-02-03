<?php

session_start();

require_once("connectbd.php");

//Si le formulaire a été envoyé
if (isset($_POST["niveau"])) {
    $connexion = connect_bd();

    //Récupère toutes les lignes correspondantes à l'utilisateur
    $sql = "UPDATE `adherent` SET `niveauPratique` = :niveau WHERE `Personne_idPersonne` = :id";

    $stmt = $connexion->prepare($sql);

    $values = [
        ":niveau" => $_POST["niveau"],
        ":id" => $_SESSION["id"]
    ];

    $res = $stmt->execute($values);

    if (!$res) {
        echo "Problème d'accès à la bdd";
    } else {
        //Si la personne n'exsite pas
        if ($stmt->rowCount() == 0) {
            echo "Erreur de connexion";
        } else {
            header("Location: profil.php");
        }
    }
}

?>