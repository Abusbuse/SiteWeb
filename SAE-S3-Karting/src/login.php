<?php

session_set_cookie_params(0);
session_start();

require_once("connectbd.php");

//Si le formulaire a été envoyé
if (isset($_POST["username"]) && isset($_POST["password"])) {
    $username = $_POST["username"];
    $password = $_POST["password"];

    $connexion = connect_bd();

    //Récupère toutes les lignes correspondantes à l'utilisateur
    $sql = "SELECT * FROM `personne` WHERE `mail` = :mail";

    $stmt = $connexion->prepare($sql);

    $values = [
        ":mail" => $username
    ];

    $res = $stmt->execute($values);

    if (!$res) {
        echo "Problème d'accès à la bdd";
    } else {
        //Si la personne n'exsite pas
        if ($stmt->rowCount() == 0) {
?>

            <script>
                alert("Mauvais mot de passe ou nom d'utilisateur");
                window.location.replace("accueil.php");
            </script>

        <?php
        } else {
            $row = $stmt->fetch();
            //Si le mot de passe correspond à celui de la bdd
            if (password_verify($password, $row["mdp"])) {
                $_SESSION["connected"] = true;
                $_SESSION["username"] = $username;
                $_SESSION["id"] = $row["idPersonne"];

                // Définit le temps de la session
                $_SESSION["start"] = time();
                $_SESSION["expire"] = $_SESSION["start"] + (5 * 60 * 60);

                //Recupere l'id de l'admin dans la table admin
                $sql = "SELECT `Personne_idPersonne` FROM `admin` WHERE `Personne_idPersonne` = :id";
                $stmt2 = $connexion->prepare($sql);

                $values2 = [
                    ":id" => $row["idPersonne"]
                ];

                $res = $stmt2->execute($values2);
                //Declare une variable de session admin qui est true si l'utilisateur est admin
                $_SESSION["admin"] = $stmt2->rowCount() == 0 ? false : true;

                // Update la date de derniere visite
                $sql = "UPDATE `adherent` SET `derniereVisite` = :date WHERE `Personne_idPersonne` = :id";

                $stmt = $connexion->prepare($sql);

                $values2 = [
                    ":date" => date("Y-m-d"),
                    ":id" => $row["idPersonne"]
                ];

                $res = $stmt->execute($values2);

                $_POST = array();
            }
        ?>

            <script>
                window.location.replace("accueil.php");
            </script>

<?php
        }
    }
}
?>