<?php
require_once("header.php");

if (isset($_POST['title']) && isset($_POST['content'])) {
    $bdd = connect_bd();
    $req = $bdd->prepare('INSERT INTO article (titre, contenu, dateCreation, dateMAJ, Admin_Personne_idPersonne) VALUES (?, ?, NOW(), NULL, ?)');
    $req->execute(array(
        $_POST['title'],
        $_POST['content'],
        $_SESSION['id']
    ));
    ?>
    <script>
        window.location.replace("actu.php");
    </script>
    <?php
}

if (isset($_POST["idArticle"])) {
    $bdd = connect_bd();
    $req = $bdd->prepare('DELETE FROM article WHERE idArticle = ?');
    $req->execute(array($_POST["idArticle"]));
}

?>

<div id="contenu">

    <form action="addArticle.php" method="post" class="addArticleForm">
        <label for ="title"> Titre de l'article : </label><br>
        <input type="text" name="title" id="title" required><br>
        <label for ="content"> Contenu de l'article : </label><br>
        <textarea name="content" id="content" cols="30" rows="10" required></textarea><br>
        <input type="submit" value="Ajouter l'article">
    </form>

</div>

<?php
require_once("footer.php");
?>