function login() {
    $("#loginModal").modal('show');
}

function register() {
    $("#regModal").modal('show');
}

$(document).ready(function() {
    $("#regForm").submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: "inscription.php",
            dataType: "html",
            type: "POST",
            data: $(this).serialize(),
            success: function(data) {
                // Si les mots de passe ne sont pas identiques
                if (data == "Les mots de passe ne sont pas identiques") {
                    $("#regError").html(data);
                }
                // Si l'adresse mail est déjà utilisée
                else if (data == "Cette adresse mail est déjà utilisée") {
                    $("#regError").html(data);
                } else if (data == "Inscription réussie") {
                    $("#regError").html("");
                    $("#regModal").modal('hide');
                    $("#loginModal").modal('show');
                }
            },
            error: function(data) {
                alert("Erreur lors de l'inscription");
            }
        });
    });
});

// Fonction pour enregistrer un adhérent à un match, ou le désinscrire
// Envoie les données à registerMatch.php
// Si l'inscription/désinscription est réussie, on affiche un message de succès
// registerMatch.php ajoute l'id du match et de l'adhérent dans la table match_has_adherent
function registerMatch(idMatch, idPersonne, unreg) {
    if (unreg == true) {
        var msg = "Voulez-vous vraiment vous désinscrire de ce match ?";
    } else {
        var msg = "Voulez-vous vraiment vous inscrire à ce match ?";
    }
    if (confirm(msg)) {
        $.ajax({
            url: "registerMatch.php",
            dataType: "html",
            type: "POST",
            data: {
                unRegister: unreg,
                idMatch: idMatch,
                idPersonne: idPersonne
            },
            success: function(data) {
                if (data == "Réussie inscr")
                    $("#matchError" + idMatch).html("Inscription réussie");
                else if (data == "Réussie unreg")
                    $("#matchError" + idMatch).html("Désinscription réussie");
                else if (data == "Erreur")
                    $("#matchError" + idMatch).html("Erreur lors de l'inscription au match");
                // Reload the page
                setTimeout(function() {
                    location.reload();
                }, 1000);
            },
            error: function(data) {
                alert("Erreur lors de l'inscription au match");
            }
        });
    }
}

function setWinner(idMatch) {
    var list = document.getElementById("list" + idMatch);
    var idWinner = list.options[list.selectedIndex].value;

    if (confirm("Voulez-vous vraiment déclarer ce pilote comme gagnant ?")) {
        $.ajax({
            url: "setWinner.php",
            dataType: "html",
            type: "POST",
            data: {
                idMatch: idMatch,
                idWinner: idWinner
            },
            success: function(data) {
                if (data == "Réussie")
                    $("#winError" + idMatch).html("Déclaration réussie");
                else if (data == "Erreur")
                    $("#winError" + idMatch).html("Erreur");
                // Reload the page
                setTimeout(function() {
                    location.reload();
                }, 1000);
            },
            error: function(data) {
                alert("Dommage");
            }
        });
    }
}

function cancelRes(idRes) {
    if (confirm("Voulez-vous vraiment annuler cette réservation ?")) {
        $.ajax({
            url: "cancelRes.php",
            dataType: "html",
            type: "POST",
            data: {
                idRes: idRes
            },
            success: function(data) {
                if (data == "Réussie")
                    $("#resError" + idRes).html("Annulation réussie");
                else if (data == "Erreur")
                    $("#resError" + idRes).html("Erreur");
                // Reload the page
                setTimeout(function() {
                    location.reload();
                }, 1000);
            },
            error: function(data) {
                alert("Dommage");
            }
        });
    }
}

function deleteArticle(id) {
    if (confirm("Voulez-vous vraiment supprimer cet article ?")) {
        $.ajax({
            url: "addArticle.php",
            dataType: "html",
            type: "POST",
            data: {
                idArticle: id
            },
            success: function(data) {
                if (data == "Réussie")
                    $("#deleteErr" + id).html("Suppression réussie");
                else if (data == "Erreur")
                    $("#deleteErr" + id).html("Erreur");
                // Reload the page
                setTimeout(function() {
                    window.location.replace("actu.php");
                }, 1000);
            },
            error: function(data) {
                alert("Dommage");
            }
        });
    }
}