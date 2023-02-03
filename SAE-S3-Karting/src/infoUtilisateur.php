<?php
//fonction qui recupere les informations de l'utilisateur
function infoUtilisateur()
{
    require_once("connectbd.php");

    //Afficher les infos de l'utilisateur connecté avec une requete sql et en utilisant PDO et en l'affichant en HTML

    $connexion = connect_bd();
    $sql = "SELECT * FROM `personne` JOIN adherent ON personne.idPersonne = adherent.Personne_idPersonne WHERE `mail` = :mail";
    $stmt = $connexion->prepare($sql);
    $values = [
        ":mail" => $_SESSION["username"]
    ];

    $res = $stmt->execute($values);
    if (!$res) {
        echo "Problème d'accès à la bdd";
    } else {
        if ($stmt->rowCount() == 0) {
        ?>
            <script>
                alert("Erreur de connexion");
            </script>
        <?php
        } else {
            $row = $stmt->fetch();
        ?>

            <body>
                <div id="contenu">
                    <h1>Informations personnelles</h1>
                    <div id="profile">
                        <p>Photo de profil :</p>
                        <p>
                            <?php
                            // Vérifie si un dossier au nom de l'utilisateur existe, sinon le crée
                            if (!file_exists("users/" . $_SESSION["username"])) {
                                mkdir("users/" . $_SESSION["username"]);
                            }

                            // Vérifie qu'il existe une image dans ce dossier, sinon affiche une image par défaut
                            if ($result = glob("users/" . $_SESSION["username"] . "/profil.*")) {
                                // Ajoute le paramètre t=... pour éviter que le navigateur utilise une image en cache
                                echo "<img src='" . $result[0] . "?t=" . time() . "' alt='Photo de profil' class='logo'>";
                            } else {
                                echo "<img src='logos/kart.jpg' alt='Photo de profil' width='200' height='200'>";
                            }

                            // Ajoute un formulaire permettant de choisir une image et de l'envoyer au serveur
                            ?>
                            <form action="upload.php" method="post" enctype="multipart/form-data" id="pictureForm">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <input type="file" name="file" id="file" accept="image/*">
                                    </div>
                                    <div class="form-group">
                                        <input type="reset" name="reset" class="btn btn-secondary">
                                        <input type="submit" name="submit" class="btn btn-primary">
                                    </div>
                                    <!-- Afficher les erreurs éventuelles -->
                                    <div class="form-group">
                                        <small id="upError" class="text-danger">
                                            <?php
                                            if (isset($_GET['error']) && $_GET['error'] == "fileSize") {
                                                echo "Le fichier est trop volumineux";
                                            }
                                            ?>
                                        </small>
                                    </div>
                                </div>
                            </form>
                        </p>

                        <hr>

                        <p>Nom : <?php echo $row["nom"]; ?></p>
                        <p>Prénom : <?php echo $row["prenom"]; ?></p>
                        <p>Téléphone : <?php echo $row["telephone"]; ?></p>
                        <p>Mail : <?php echo $row["mail"]; ?></p>
                        <p>Niveau de pratique : <?php
                        if ($row["niveauPratique"] == null) {
                            // Si le niveau de pratique n'est pas rensegigné, affiche "Non renseigné"
                            // Permet de le renseigner avec un formulaire
                            ?>
                            <p>Non renseigné</p>
                            <form action="updateNiveau.php" method="post" id="niveauForm" onsubmit="return confirm('Etes-vous sûr ? Cette action est irréversible');">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <select name="niveau" id="niveau">
                                            <option value="Débutant">Débutant</option>
                                            <option value="Intermédiaire">Intermédiaire</option>
                                            <option value="Confirmé">Confirmé</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <input type="reset" name="reset" class="btn btn-secondary">
                                        <input type="submit" name="submit" class="btn btn-primary">
                                    </div>
                                </div>
                            </form>
                            <?php
                        } else {
                            echo $row["niveauPratique"]; 
                        }
                        ?></p>

                        <hr>

                        <p>Document administratif : </p>
                        <p>
                            <?php 
                            // Vérifie que le fichier existe puis affiche un bouton pour le télécharger
                            if (!file_exists("users/" . $_SESSION["username"] . "/doc_administratif.pdf")) {
                                echo "Aucun document administratif";
                            } else {
                                echo "<a href='download.php?file=" . urlencode($_SESSION["username"]) . "'>Télécharger le document administratif</a>";
                            }
                            ?>

                            <form action="upload.php" method="post" enctype="multipart/form-data" id="docForm">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <input type="file" name="filePdf" id="filePdf" accept="application/pdf">
                                    </div>
                                    <div class="form-group">
                                        <input type="reset" name="reset" class="btn btn-secondary">
                                        <input type="submit" name="submitPdf" class="btn btn-primary">
                                    </div>
                                    <div class="form-group">
                                        <!-- Texte qui servira à afficher les eventuelles erreurs -->
                                        <small id="upErrorPdf" class="text-danger">

                                        </small>
                                    </div>
                                </div>
                            </form>
                        </p>
                    </div>
                </div>
            </body>
<?php
        }
    }
}
?>