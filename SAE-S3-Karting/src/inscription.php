<?php
session_start();
require_once("connectBD.php");

// Vérifie que tous les champs du formulaire ont été remplis
if (isset($_POST["name"]) && isset($_POST["forename"]) && isset($_POST["adresse"]) && isset($_POST["phone"]) && isset($_POST["mail"]) && isset($_POST["password"]) && isset($_POST["password2"])) {

    $name = $_POST["name"];
    $forename = $_POST["forename"];
    $adresse = $_POST["adresse"];
    $phone = $_POST["phone"];
    $mail = $_POST["mail"];
    $password = $_POST["password"];
    $password2 = $_POST["password2"];

    // Vérifie que les 2 mots de passe sont identiques
    if ($password != $password2) {
        exit("Les mots de passe ne sont pas identiques");
    }

    // Vérifie que l'adresse mail n'est pas déjà utilisée
    $connexion = connect_bd();
    $sql = "SELECT * FROM `personne` WHERE `mail` = :mail";
    $stmt = $connexion->prepare($sql);
    $values = [
        ":mail" => $mail
    ];
    $res = $stmt->execute($values);

    if (!$res) {
        exit("Problème d'accès à la bdd");
    } elseif ($stmt->rowCount() != 0) {
        exit("Cette adresse mail est déjà utilisée");
    }

    // Hash le mot de passe
    $hash = password_hash($password, PASSWORD_DEFAULT);

    // Insère les données dans la table personne
    $sql = htmlspecialchars("INSERT INTO `personne` (`nom`, `prenom`, `adresse`, `telephone`, `mail`, `mdp`) VALUES (:name, :forename, :adresse, :phone, :mail, :password)");

    $values = [
        ":name" => $name,
        ":forename" => $forename,
        ":adresse" => $adresse,
        ":phone" => $phone,
        ":mail" => $mail,
        ":password" => $hash,
    ];

    $stmt2 = $connexion->prepare($sql);
    $res = $stmt2->execute($values);

    if (!$res) {
        exit("Problème d'accès à la bdd");
    } else {
        $sql = htmlspecialchars("INSERT INTO `adherent` (`derniereVisite`, `niveauPratique`, `photo`, `Personne_idPersonne`) VALUES (NULL, NULL, NULL, :id)");
        
        $values = [
            ":id" => $connexion->lastInsertId()
        ];
        
        $stmt3 = $connexion->prepare($sql);
        $res2 = $stmt3->execute($values);
        
        if (!$res2) {
            exit("Problème d'accès à la bdd");
        }
        exit("Inscription réussie");
    }
}