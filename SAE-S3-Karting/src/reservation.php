<?php 
    require_once("header.php"); 
?>

<?php
    //Si l'utilisateur n'est pas connecté, on affiche un message
    if (!isset($_SESSION["connected"]) || !$_SESSION["connected"]) {
        echo "<div id='contenu'>
            <h1>Réservation</h1>

            <p id='blink'>VOUS DEVEZ VOUS CONNECTER POUR VOIR LES RESERVATIONS</p>
        </div>";
    }

    require_once("connectBD.php");
    $con = connect_bd();    

    //Si l'utilisateur est connecté 
    if (isset($_SESSION["connected"]) && $_SESSION["connected"]) {
        //On récupère les réservations de l'utilisateur
        $sql = "SELECT * FROM Reservation WHERE Adherent_Personne_idPersonne = :idPersonne";
        $stmt = $con->prepare($sql);
        $values = [
            "idPersonne" => $_SESSION["id"]
        ];
        $res = $stmt->execute($values);
        if (!$res) {
            echo "Erreur lors de la récupération des réservations";
        }
        $row = $stmt->fetchAll();
        $nbrRes = count($row);
        if ($nbrRes == 0) {
            echo "<div id='contenu'>
            <h1>Réservation</h1>
    
            <p id='blink'>VOUS N'AVEZ AUCUNE RESERVATION</p>";
        } 
        else {
            echo "
            <div id='contenu'>
                <div>
                    <h1>Vos réservations</h1>
                    <div class='event-list'>
                        <ul class='events'>";
                        foreach ($row as $res) {
                            //On récupère les circuits de la réservation
                            $sql = "SELECT * FROM `circuit` WHERE `idCircuit` = :idCircuit";
                            $stmtCirc = $con->prepare($sql);

                            $values = [
                                "idCircuit" => $res["Circuit_idCircuit"]
                            ];

                            $res3 = $stmtCirc->execute($values);

                            if (!$res3) {
                                echo "Erreur lors de la récupération des circuits";
                            }

                            $rowCirc = $stmtCirc->fetch();
                            echo "<li class='event'>";
                            echo "<h2 style=\" color: var(--yellowColor);\">" . $res["date"] . "</h2>";
                            echo "<p> Nombre de places réservées : " . $res["nombreParticipant"] . "</p>";
                            echo "<p> Circuit : " . $rowCirc["nom"] . "</p>";
                            switch($res['autorisation']) {
                                case 0:
                                    echo "<p>Pas encore vérifiée</p>";
                                    break;
                                case 1:
                                    echo "<p>Autorisée</p>";
                                    if ($res["date"] > date("Y-m-d")) {
                                        // Ajoute un bouton pour se désinscrire
                                        echo "<button class='registerMatch unreg' onclick='cancelRes(" . $res["idReservation"] . ")'> Annuler </button>" ;
                                        echo "<small id='resError" . $res["idReservation"] . "'></small>";
                                    }
                                    break;
                                default:
                                    echo "<p>Refusée</p>";
                                    break;
                            }
                            echo "</li>";
                        }
                        echo "</ul>
                        </div>
                </div>";
        }
    ?>
        <div class="addReserv">
            <h1>Ajouter une réservation</h1>
            <form action='addReservation.php' method='post'>

                <label for='date'>Date</label>
                <input type='date' name='date' id='date' required><br>

                <label for='heureDebut'>Heure de début</label>
                <input type='time' name='heureDebut' id='heureDebut' required><br>

                <label for='heureFin'>Heure de fin</label>
                <input type='time' name='heureFin' id='heureFin' required><br>

                <label for='nbrPlace'>Nombre de places</label>
                <input type='text' name='nombreParticipant' id='nombreParticipant' required><br>

                <label for='idCircuit'>Circuit</label>
                <select name='idCircuit' id='idCircuit' required>
                    <?php
                        $sql = "SELECT * FROM Circuit";
                        $stmt = $con->prepare($sql);
                        $res = $stmt->execute();
                        if (!$res) {
                            echo "Erreur lors de la récupération des circuits";
                        }
                        $row = $stmt->fetchAll();
                        foreach ($row as $circ) {
                            echo "<option value='" . $circ["idCircuit"] . "'>" . $circ["nom"] . "</option>";
                        }
                    ?>
                </select><br>
                
                <input type='submit' value='Ajouter'>
            </form>
        </div>
    </div>
<?php
    }
    require_once("footer.php");
?>