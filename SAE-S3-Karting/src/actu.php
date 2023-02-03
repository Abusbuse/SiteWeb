<?php 
    require_once("header.php");
    require_once("connectBD.php");
?>

<!-- Permet d'afficher les articles en récupérant leur id avec $_GET -->
<div id="contenu">
    <?php
    $bdd = connect_bd();
    if (isset($_GET['id']) && $_GET['id'] > 0) {
        $id = $_GET['id'];
        $req = $bdd->prepare('SELECT * FROM article WHERE idArticle = ?');
        $req->execute(array($id));
        $donnees = $req->fetch();

        if (!$donnees) {
            echo "<h1>Erreur : Cet article n'existe pas</h1>";
            exit();
        }

        ?>

        <div class="article">
            <div class="articleHead">
                <h1><?php echo $donnees['titre']; ?></h1>
                <h7>Date de rédaction : <?php echo $donnees['dateCreation']; ?></h7>
                <?php if ($donnees['dateMAJ'] != null) {
                    echo "<h7>Dernière mise à jour : " . $donnees['dateMAJ'] . "</h7>";
                }
                ?>
            </div>

            <div class="bodyArticle">
                <p><?php echo $donnees['contenu']; ?></p>
            </div>
            <?php if (isset($_SESSION['admin']) && $_SESSION['admin']) {
                echo "<button onclick='deleteArticle(" . $donnees['idArticle'] . ")' class='registerMatch unreg'>Supprimer l'article</button>";
                echo "<small id='deleteErr'></small>";
            }
            ?>
        </div>


        <?php
    }
    // Si $_GET[id] n'existe pas, on affiche tout les articles dans une table
    // Si l'utilisateur est un admin, on ajoute un bouton pour ajouter un article 
    else {
        $req = $bdd->prepare('SELECT * FROM article');
        $req->execute();

        ?>

        <div class="container">
            <table class="articlesList">
                <tr>
                    <th>Titre</th>
                    <th>Date de création</th>
                    <th>Aperçu</th>
                </tr>

            <?php
            while($donnees = $req->fetch()) {
                ?>

                <tr onclick="document.location = ('actu.php?id=<?php echo $donnees['idArticle'] ?>')">
                    <?php
                    echo "<td>" . $donnees['titre'] . "</td>";
                    echo "<td>" . $donnees['dateCreation'] . "</td>";
                    echo "<td>" . substr($donnees['contenu'], 0, 50) . "...</td>";
                    ?>
                </tr>

                <?php
            }

            echo "</table>";

            if (isset($_SESSION['admin']) && $_SESSION['admin']) {
                echo "<a href='addArticle.php' class='addArticle'>Ajouter un article</a>";
            }
        echo "</div>";
    }
    ?>
</div>


<?php 
    require_once("footer.php");
?>