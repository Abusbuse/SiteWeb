<?php 
    require_once("header.php");

    if (isset($_POST['title']) && isset($_POST['content'])) {
        $title = $_POST['title'];
        $content = $_POST['content'];
        $date = date("Y-m-d H:i:s");
        // TODO : Send email
    }
?>

<div id="contenu">

    <form action="contacts.php" method="post" class="addArticleForm">
        <label for="title"> Objet </label><br>
        <input type="text" name="title" id="title" required><br>
        <label for="content"> Message </label><br>
        <textarea name="content" id="content" cols="30" rows="10" required></textarea><br>
        <input type="submit" value="Envoyer">
    </form>

</div>

<?php 
    require_once("footer.php");
?>