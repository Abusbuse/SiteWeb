package javaPlanning;

import java.util.ArrayList;

import javaPlanning.exceptions.CircuitExistException;

/**
 * Classe ListCircuit
 * Permet de gérer une liste de circuits et de ne pas avoir de doublons
 */
public class ListCircuit {
    
    private static volatile ArrayList<Circuit> instance;

    public static ArrayList<Circuit> getInstance() {
        if (instance == null) {
            synchronized (Circuit.class) {
                if (instance == null) {
                    instance = new ArrayList<Circuit>();
                }
            }
        }
        return instance;
    }
    
    public static void addCircuit(Circuit circuit) throws CircuitExistException {
        if (getInstance().contains(circuit)) {
            throw new CircuitExistException("Circuit deja existant");
        } else {
            getInstance().add(circuit);
        }
    }

    public static Circuit getCircuit(String nom) throws CircuitExistException {
        for (Circuit circuit : getInstance()) {
            if (circuit.getName().equals(nom)) {
                return circuit;
            }
        }
        throw new CircuitExistException("Circuit inexistant");
    }
}
