package javaPlanning;

import java.util.ArrayList;

import javaPlanning.exceptions.TooManyParticipant;

public class Adherent {

    private ArrayList<Match> matchs;
    private String nom, prenom;
    private int id;

    public Adherent(String nom, String prenom, int id) {
        this.nom = nom;
        this.prenom = prenom;
        this.id = id;
        this.matchs = new ArrayList<Match>();
    }

    /**
     * Reserve un match pour l'adherent
     * Ajoute aussi cet adherent a la liste des participants du match
     * @param match match pour lequel il demande une reservation
     */
    public void reservationMatch(Match match) {
        try {
            match.addParticipant(this);
        } catch (TooManyParticipant e) {
            System.out.println(e.getMessage());
        }
        matchs.add(match);
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return (nom + " " + prenom + " " + id);
    }

}