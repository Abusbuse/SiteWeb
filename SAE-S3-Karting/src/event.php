<?php 
    require_once("header.php"); 
    require_once("connectBD.php");

    //On récupère les événements à venir
    $con = connect_bd();
    $sql = "SELECT * FROM `match` WHERE `date` > NOW() ORDER BY `date`";
    $stmtEvComing = $con->prepare($sql);

    $res = $stmtEvComing->execute();

    if (!$res) {
        echo "Erreur lors de la récupération des événements";
    }

    // On récupère les événements passés
    $sql = "SELECT * FROM `match` WHERE `date` < NOW() ORDER BY `date`";
    $stmtEvPast = $con->prepare($sql);

    $res = $stmtEvPast->execute();

    if (!$res) {
        echo "Erreur lors de la récupération des événements";
    }

    // On récupère les circuits pour afficher ses infos
    $sql = "SELECT * FROM `circuit` WHERE `idCircuit` = :idCircuit";
    $stmt2 = $con->prepare($sql);

    // On récupère l'id du match pour avoir tous les participants de ce match
    $sql = "SELECT * FROM `match_has_adherent` JOIN `personne` ON `Adherent_Personne_idPersonne` = idPersonne WHERE `Match_idMatch` = :idMatch";
    $stmt3 = $con->prepare($sql);
?>

<div id="contenu">
    <h1> Évènements </h1>
    <h2> À venir : </h2>
    <div class="event-list">
        <ul class="events">
            <?php
                //On affiche les événements
                while ($row = $stmtEvComing->fetch()) {
                    $values = [
                        "idCircuit" => $row["Circuit_idCircuit"]
                    ];
            
                    $res = $stmt2->execute($values);
            
                    if (!$res) {
                        echo "Erreur lors de la récupération des circuits";
                    }

                    $values = [
                        "idMatch" => $row["idMatch"]
                    ];

                    $res = $stmt3->execute($values);

                    if (!$res) {
                        echo "Erreur lors de la récupération des matchs";
                    }
                    
                    $rowCirc = $stmt2->fetch();
                    $rowId = $stmt3->fetchAll();

                    // On vérifie si l'utilisateur est inscrit à l'événement
                    $isRegistered = false;
                    foreach ($rowId as $id) {
                        if (isset($_SESSION["connected"]) && $_SESSION["connected"]) {
                            if ($id["Adherent_Personne_idPersonne"] == $_SESSION["id"]) {
                                $isRegistered = true;
                            }
                        }
                    }

                    echo "<li class='event'>";
                    echo "<h2 style=\" color: var(--yellowColor);\">" . $row["date"] . "</h2>";
                    echo "<p> Circuit : " . $rowCirc["nom"] . "</p>";
                    echo "<p> Adresse : " . $rowCirc["adresse"] . "</p>";
                    echo "<p> Début : " . $row["heureDebut"] . "</p>";
                    echo "<p> Fin : " . $row["heureFin"] . "</p>";
                    echo "<p> Nombre de places disponibles : " . ($row["nbrPartNecessaire"] - count($rowId)) . "</p>";
                    if (isset($_SESSION["connected"]) && $_SESSION["connected"]) {
                        if ($row["nbrPartNecessaire"] - count($rowId) <= 0) {
                            echo "<button id='" . $row["idMatch"] . "' class='registerMatch' disabled> Complet </button>";
                        } else if ($isRegistered) {
                            echo "<button id='" . $row["idMatch"] . "' class='registerMatch unreg' onclick='registerMatch(" . $row["idMatch"] . "," . $_SESSION["id"] . ",true)'> Se désinscrire </button>";
                        } else {
                            echo "<button id='" . $row["idMatch"] . "' class='registerMatch' onclick='registerMatch(" . $row["idMatch"] . "," . $_SESSION["id"] . ",false)'> S'inscrire </button>";
                        }
                    }
                    echo "<small id='matchError" . $row["idMatch"] . "' style='color: white; '> </small>";
                    echo "</li>";
                }
            ?>
        </ul>
    </div>
    <h2> Passés : </h2>
    <div class="event-list">
        <ul class="events">
            <?php
                while ($row = $stmtEvPast->fetch()) {
                    $values = [
                        "idCircuit" => $row["Circuit_idCircuit"]
                    ];
            
                    $res = $stmt2->execute($values);
            
                    if (!$res) {
                        echo "Erreur lors de la récupération des circuits";
                    }

                    $rowCirc = $stmt2->fetch();
                    
                    
                    echo "<li class='event'>";
                    echo "<h2 style=\" color: var(--yellowColor);\">" . $row["date"] . "</h2>";
                    echo "<p> Circuit : " . $rowCirc["nom"] . "</p>";
                    echo "<p> Adresse : " . $rowCirc["adresse"] . "</p>";
                    echo "<p> Début : " . $row["heureDebut"] . "</p>";
                    echo "<p> Fin : " . $row["heureFin"] . "</p>";
                    
                    if ($row["Gagnant"] != null) {
                        $stmt4 = $con->prepare("SELECT * FROM `personne` WHERE `idPersonne` = :idPersonne");
    
                        $values = [
                            "idPersonne" => $row["Gagnant"]
                        ];

                        $res = $stmt4->execute($values);

                        if (!$res) {
                            echo "Erreur lors de la récupération des matchs";
                        }

                        $rowWin = $stmt4->fetch();

                        echo "<p> Gagnant : " . $rowWin["nom"] . " " . $rowWin["prenom"] . "</p>";
                    }
                    if (isset($_SESSION["admin"]) && $_SESSION["admin"]) {
                        $values = [
                            "idMatch" => $row["idMatch"]
                        ];
                        $res = $stmt3->execute($values);

                        if (!$res) {
                            echo "Erreur lors de la récupération des matchs";
                        }
                        
                        if ($row["Gagnant"] == null) {
                            echo "<select id=\"list" . $row["idMatch"] . "\" class=\"registerMatch\" onchange=\"setWinner(" . $row["idMatch"] . ")\"> Définir le gagnant";
                            echo "<option value=\"0\"> Définir le gagnant </option>";
                            $rowId = $stmt3->fetchAll();
                            foreach($rowId as $id) {
                                echo "<option value=\"" . $id["Adherent_Personne_idPersonne"] . "\">" . $id["nom"] . " " . $id["prenom"] . "</option>";
                            }
                            echo "</select>";
                        }
                    }
                    echo "<small id=\"winError" . $row["idMatch"] . "\"> </small>";
                    echo "</li>";
                }
            ?>
        </ul>
    </div>
</div>

<?php 
    require_once("footer.php");
?>