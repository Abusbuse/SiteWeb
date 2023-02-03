<?php 
    require_once("header.php"); 
?>
<!--Présentation de notre site du club de karting -->

<div id="contenu">
    <h1> Bienvenue sur le site du club de karting de la ville de Saint-Gorgon </h1><br>

    <h2 class="midTitle"> Vous voulez nous rejoindre ? </h2><br>

    <p class="par"> C'est simple,vous pouvez vous inscrire dans l'onglet <em>Inscription</em>, ou vous pouvez nous rejoindre sur notre circuit situé à Saint-Gorgon. </p><br>
    <p class="par"> Ici se réunissent chaque jour plus de 20 pilotes de karting de tous niveaux. </p><br>

    <h2 class="midTitle"> Vous pouvez aussi regarder quelques vidéos de notre club </h2><br>
    
    <div id="videos" class="videos">
        <video class="vids" width = "300" height = "300" controls>
            <source src="im_vid/KartingPres.mp4" type="video/mp4">
        </video>
        
        <video class="vids" width = "300" height = "300" controls>
            <source src="im_vid/KartingPres3.mp4" type="video/mp4">
        </video>
        
        <video class="vids" width = "300" height = "300" controls>
            <source src="im_vid/KartingPres2.mp4" type="video/mp4">
        </video>
    </div>
    <br>
    
    <h2 class="midTitle">Vous pouvez aussi regarder quelques photos de notre club </h2>
    <br>
    
    <div id="images" class="images">
        <div class="IM">
            <img src="im_vid/photoKarting.jpg" alt="Photo du karting">
            <div class="im-content">
                <p class="parIM">Championnat régional en KZ2</p>
            </div>
        </div>

        <div class="IM">
            <img src="im_vid/photoKarting2.jpg" alt="Photo du karting">
            <div class="im-content">
                <p class="parIM">Circuit à la fin de la journée</p>
            </div>
        </div>

        <div class="IM">
            <img src="im_vid/photoKarting3.jpg" alt="Photo du karting">
            <div class="im-content">
                <p class="parIM">Essai du nouveau PRAGA KA100</p>
            </div>
        </div>
    </div>
    
</div>

<?php
    require_once("footer.php");
?>