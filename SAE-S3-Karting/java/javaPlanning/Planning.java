package javaPlanning;

import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javaPlanning.exceptions.CircuitExistException;
import javaPlanning.exceptions.WrongTimeException;

public class Planning {

    private ArrayList<Match> matchs;
    private String url = "jdbc:mysql://localhost:3306/bdsae";

    /**
     * Constructeur de la classe Planning
     * Initialise la liste des matchs
     * Récupère ensuite dans la base de données les matchs déjà présents
     */
    public Planning() {
        this.matchs = new ArrayList<Match>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, "root", "");
            Statement stmt = con.createStatement();

            // Récupère les circuits
            ResultSet rs = stmt.executeQuery("SELECT * FROM circuit");

            while (rs.next()) {
                // Ajoute les circuits
                ListCircuit.addCircuit(new Circuit(rs.getString("nom"), rs.getString("adresse"), rs.getInt("nbrMaxPlace")));
            }

            ResultSet rs2 = stmt.executeQuery("SELECT * FROM `match` WHERE 1");
            // Utilise un autre Statement pour avoir les circuits
            Statement stmt2 = con.createStatement();
            // Utilise un autre Statement pour avoir les adherents participant au match
            Statement stmtAd = con.createStatement();

            while (rs2.next()) {
                // On recupere le circuit correspondant au circuit du match pour avoir son nom
                ResultSet rsCircuit = stmt2.executeQuery("SELECT * FROM circuit WHERE idCircuit = " + rs2.getInt(8));
                rsCircuit.next();
                // Ajoute les matchs
                this.ajouterMatch(new Match(rs2.getString(2), rs2.getString(3), rs2.getString(4),
                        ListCircuit.getCircuit(rsCircuit.getString(4)), rs2.getInt(5)));
                // On recupere les adherents participant au match
                ResultSet rsAd = stmtAd.executeQuery("SELECT idPersonne, nom, prenom FROM personne JOIN match_has_adherent ON match_has_adherent.Adherent_Personne_idPersonne = personne.idPersonne WHERE Match_idMatch = " + rs2.getInt(1));
                while (rsAd.next()) {
                    Adherent adherent = new Adherent(rsAd.getString(2), rsAd.getString(3), rsAd.getInt(1));
                    // Ajoute les participants au match
                    this.getMatchs().get(this.getMatchs().size() - 1).addParticipant(adherent);
                    // Si c'est le gagnant du match, on l'ajoute au match
                    if (rs2.getInt(6) == rsAd.getInt(1)) {
                        this.getMatchs().get(this.getMatchs().size() - 1).setGagnant(adherent);
                    }
                }
            }
            // Ferme les Statement et les ResultSet
            stmt.close();
            stmt2.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     * Ajoute un match au planning
     * Verfie au prealable qu'on peut l'ajouter
     * 
     * @param match le match a ajouter
     */
    public void ajouterMatch(Match match) throws WrongTimeException {
        // On verifie d'abord la disponibilite de l'heure, du circuit, et de la date
        if (verifierDispo(match)) {
            matchs.add(match);
        } else {
            throw new WrongTimeException("Le match ne peut pas etre ajouté à cause de la date ou de l'heure");
        }
    }

    /**
     * Deplace un match en verifiant qu'on peut le deplacer
     * 
     * @param match      le match a deplacer
     * @param date       la nouvelle date du match
     * @param heureDebut la nouvelle heure de debut du match
     * @param heureFin   la nouvelle heure de fin du match
     */
    public void deplacerMatch(Match match, String date, String heureDebut, String heureFin) throws WrongTimeException {
        // Recopie le match dans une variable tampon, et garde l'index du match dans la
        // liste
        Match tmp = new Match(match.getDate(), match.getHeureDeb(), match.getHeureFin(), match.getCircuit(),
                match.getNbJoueursMax());
        int index = matchs.indexOf(match);
        supprimerMatch(match);
        if (verifierDispo(new Match(date, heureDebut, heureFin, match.getCircuit(), match.getNbJoueursMax()))) {
            match.setDate(date);
            match.setHeureDeb(heureDebut);
            match.setHeureFin(heureFin);
            matchs.add(index, match);
        } else {
            // Si on ne peut pas le deplacer, on remet le match dans la liste
            matchs.add(index, tmp);
            throw new WrongTimeException("Le match ne peut pas etre deplacé à cause de la date ou de l'heure");
        }
    }

    /**
     * Verfie la disponibilite d'ajouter un match a la liste des matchs
     * 
     * @param match match a verifier
     * @return true si le match peut etre ajoute, false sinon
     */
    public boolean verifierDispo(Match match) {
        // Comme l'heure est au format hh:mm, on peut la split en 2
        // chechHourDeb[0] representera l'heure et checkHourDeb[1] les minutes
        String[] checkHourDeb = match.getHeureDeb().split(":");
        String[] checkHourFin = match.getHeureFin().split(":");

        for (Match m : matchs) {
            String[] checkHourDeb2 = m.getHeureDeb().split(":");
            String[] checkHourFin2 = m.getHeureFin().split(":");

            // Si ce n'est pas la meme date, on passe au match suivant
            if (!m.getDate().equals(match.getDate())) {
                continue;
            }

            // Si ce n'est pas sur le meme circuit, on passe au match suivant
            if (!m.getCircuit().equals(match.getCircuit())) {
                continue;
            }

            LocalTime timeDeb = LocalTime.of(Integer.parseInt(checkHourDeb[0]), Integer.parseInt(checkHourDeb[1]));
            LocalTime timeFin = LocalTime.of(Integer.parseInt(checkHourFin[0]), Integer.parseInt(checkHourFin[1]));

            LocalTime timeDeb2 = LocalTime.of(Integer.parseInt(checkHourDeb2[0]), Integer.parseInt(checkHourDeb2[1]));
            LocalTime timeFin2 = LocalTime.of(Integer.parseInt(checkHourFin2[0]), Integer.parseInt(checkHourFin2[1]));

            // Verifie si l'heure de debut du match est comprise entre l'heure de debut et
            // de fin d'un autre match
            // Verifie aussi que l'heure de fin du match est comprise entre l'heure de debut
            // et de fin d'un autre match
            // Verifie aussi les minutes, renvoie false si c'est le cas
            if ((timeDeb.isAfter(timeDeb2) && timeDeb.isBefore(timeFin2))
                    || (timeFin.isAfter(timeDeb2) && timeFin.isBefore(timeFin2))
                    || (timeDeb.equals(timeDeb2) && timeFin.equals(timeFin2))
                    || (timeDeb.equals(timeDeb2) && timeFin.isBefore(timeFin2))
                    || (timeDeb.isAfter(timeDeb2) && timeFin.equals(timeFin2))
                    || (timeDeb.isBefore(timeDeb2) && timeFin.isAfter(timeFin2))
                    || (timeDeb.equals(timeDeb2) && timeFin.isAfter(timeFin2))
                    || timeDeb.equals(timeDeb2) || timeFin.equals(timeFin2)) {
                return false;
            }
        }
        // Si on arrive ici, c'est que le match peut etre ajoute
        return true;
    }

    /**
     * Supprime un match du planning
     * 
     * @param match le match a supprimer
     */
    public void supprimerMatch(Match match) {
        matchs.remove(match);
    }

    /**
     * Affiche le planning, avec chaque match sur une ligne
     * Un match est affiche selon le format :
     * date/heureDebut-heureFin/nombreNecessaire/Circuit
     */
    public void afficherPlanning() {
        // sortPlanning();
        for (Match m : matchs) {
            System.out.println(m);
        }
    }

    /**
     * Trie le planning selon la date et l'heure de debut, ainsi que les minutes
     */
    public void sortPlanning() {
        Collections.sort(matchs, new Comparator<Match>() {
            @Override
            public int compare(Match m1, Match m2) {
                if (m1.getDate().equals(m2.getDate())) {
                    String[] checkHourDeb1 = m1.getHeureDeb().split(":");
                    String[] checkHourDeb2 = m2.getHeureDeb().split(":");
                    if (Integer.parseInt(checkHourDeb1[0]) == Integer.parseInt(checkHourDeb2[0])) {
                        return Integer.compare(Integer.parseInt(checkHourDeb1[1]), Integer.parseInt(checkHourDeb2[1]));
                    } else {
                        return Integer.compare(Integer.parseInt(checkHourDeb1[0]), Integer.parseInt(checkHourDeb2[0]));
                    }
                } else {
                    return m1.getDate().compareTo(m2.getDate());
                }
            }
        });
    }

    /**
     * Renvoie la liste entière des matchs présent dans le planning
     * @return ArrayList des matchs
     */
    public ArrayList<Match> getMatchs() {
        return matchs;
    }

    /**
     * Pour chaque reservation, on verifie qu'aucune ne chevauche pas le match
     * @param m
     * @return
     */
    public boolean checkReserv(Match m) {
        try {
            Connection con = DriverManager.getConnection(url, "root", "");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM reservation");

            // Ajoute le match temporairement au planning
            this.ajouterMatch(m);

            while (rs.next()) {
                // On ne garde que les reservations dont autorisation est différent de 2
                if (rs.getInt("autorisation") == 2) {
                    continue;
                }

                String date = rs.getString("date");
                String debut = rs.getString("heureDebut");
                String fin = rs.getString("heureFin");
                String circuit = rs.getString("Circuit_idCircuit");

                // Recupere le nom du circuit
                Statement stmt2 = con.createStatement();
                ResultSet rs2 = stmt2.executeQuery("SELECT * FROM circuit WHERE idCircuit = " + circuit);
                rs2.next();
                String circuitName = rs2.getString("nom");

                // On verifie que la reservation ne chevauche pas le match
                // Si oui, on supprime le match du planning et on renvoi false
                if (!this.verifierDispo(new Match(date, debut, fin, ListCircuit.getCircuit(circuitName), 0))) {
                    this.supprimerMatch(m);
                    return false;
                }
            }
        } catch (SQLException ex) {
            // Gestion des erreurs
            System.out.println("SQLException: " + ex.getMessage());
        } catch (WrongTimeException e) {
            System.out.println("Erreur : " + e.getMessage());
        } catch (CircuitExistException e2) {
            System.out.println("Erreur : " + e2.getMessage());
        }
        // Si aucun chevauchement n'a été trouvé, on supprime le match du planning et on renvoi true
        this.supprimerMatch(m);
        return true;
    }
}