<?php

session_start();

$target_dir = "users/" . $_SESSION["username"] . "/";
$uploadOk = 1;

// Si le formulaire pour la photo de profil a été envoyé et que le fichier est bien présent
if (isset($_FILES['file']) && $_FILES['file']['error'] == 0) {
    $target_file = $target_dir . "profil." . pathinfo($_FILES["file"]["name"], PATHINFO_EXTENSION);
    // Vérifie que l'image est bien une image
    if (isset($_POST['submit'])) {
        $check = getimagesize($_FILES['file']['tmp_name']);
        if ($check !== false) {
            echo "Le fichier est une image - " . $check["mime"] . ".";
            $uploadOk = 1;
        } else {
            echo "Le fichier n'est pas une image.";
            $uploadOk = 0;
        }
    }
    
    // Vérifie la taille du fichier
    if ($_FILES["file"]["size"] > 1000000) {
        die(header("Location: profil.php?error=fileSize"));
    }

    // Si une image "profil.*" existe déjà, on la supprime
    if ($res = glob($target_dir . "profil.*")) {
        unlink($res[0]);
    }

    // Vérifie l'état de $uploadOk
    // S'il est égal à 0, une erreur s'est produite
    if ($uploadOk == 0) {
        echo "Désolé, le fichier n'a pas été enregistré.";
    } else {
        // Si tout est bon, on tente d'uploader le fichier dans le dossier spécifié
        if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
            echo "Le fichier " . htmlspecialchars(basename($_FILES["file"]["name"])) . " a été upload.";
        } else {
            echo "Erreur lors de l'upload du fichier.";
        }
    }
} elseif (isset($_FILES['filePdf']) && $_FILES['filePdf']['error'] == 0) {
    $target_file = $target_dir . "doc_administratif.pdf";
    // Vérifie la taille du fichier
    if ($_FILES["filePdf"]["size"] > 1000000) {
        die(header("Location: profil.php?error=fileSize"));
    }

    // Vérifie l'état de $uploadOk
    // S'il est égal à 0, une erreur s'est produite
    if ($uploadOk == 0) {
        echo "Désolé, le fichier n'a pas été enregistré.";
    } else {
        // Si tout est bon, on tente d'uploader le fichier dans le dossier spécifié
        if (move_uploaded_file($_FILES["filePdf"]["tmp_name"], $target_file)) {
            echo "Le fichier " . htmlspecialchars(basename($_FILES["filePdf"]["name"])) . " a été upload.";
        } else {
            echo "Erreur lors de l'upload du fichier.";
        }
    }
}

header("Location: profil.php");
exit();

?>