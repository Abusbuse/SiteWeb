<?php

    session_start();
    if (!isset($_POST["date"]) || !isset($_POST["heureDebut"]) || !isset($_POST["heureFin"]) || !isset($_POST["nombreParticipant"]) || !isset($_POST["idCircuit"])) {
        exit("Erreur");
    }

    require_once("connectBD.php");

    $con = connect_bd();

    $sql = htmlspecialchars("SET FOREIGN_KEY_CHECKS=0; INSERT INTO `reservation` (`date`, `heureDebut`, `heureFin`, `nombreParticipant`, `Circuit_idCircuit`, `Adherent_Personne_idPersonne`) VALUES (:date, :heureDebut, :heureFin, :nombreParticipant, :idCircuit, :idPersonne); SET FOREIGN_KEY_CHECKS=1;");
    $values = [
        "date" => $_POST["date"],
        "heureDebut" => $_POST["heureDebut"] . ":00",
        "heureFin" => $_POST["heureFin"] . ":00",
        "nombreParticipant" => $_POST["nombreParticipant"],
        "idCircuit" => $_POST["idCircuit"],
        "idPersonne" => $_SESSION["id"]
    ];

    $stmt = $con->prepare($sql);
    $res = $stmt->execute($values);

    if (!$res) {
        exit("Erreur");
    }

    exit(header('Location: reservation.php'));

?>