package javaPlanning.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import javaPlanning.*;
import javaPlanning.exceptions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class TestPlanning {

    static Planning test;
    static Match match1;
    static Match match2;
    static Match match3;
    static Match match4;
    
    @BeforeAll
    public static void init() {

        test = new Planning();

        try {
            ListCircuit.addCircuit(new Circuit("Monza", "Viale di Vedano 5", 500));
            ListCircuit.addCircuit(new Circuit("Silverstone", "Silverstone", 1000));
            ListCircuit.addCircuit(new Circuit("Monaco", "38 Quai Jean Charles Rey", 100));
            test.ajouterMatch(new Match("2020-01-01", "10:00", "12:00", ListCircuit.getCircuit("Monza"), 10));
            match1 = new Match("2020-01-01", "12:01", "14:00", ListCircuit.getCircuit("Monza"), 20);
            match2 = new Match("2020-01-02", "12:01", "14:00", ListCircuit.getCircuit("Monza"), 25);
            match3 = new Match("2020-01-02", "16:01", "17:00", ListCircuit.getCircuit("Monza"), 20);
            match4 = new Match("2020-01-02", "19:00", "21:00", ListCircuit.getCircuit("Monza"), 24);
        } catch (CircuitExistException e1) {
            System.out.println(e1.getMessage());
        } catch (WrongTimeException e2) {
            System.out.println(e2.getMessage());
        }
    }

    @AfterAll
    public static void end() {
        test.afficherPlanning();
        System.out.println(ListCircuit.getInstance());
    }

    /**
     * Test l'ajout d'un match dans le cas ou tout est bon
     */
    @Test
    @Order(1)
    public void testAddMatch() {
        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(match1);
        });

        // Test ajout match jour different mais meme horaire
        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(match2);
        });

        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(match3);
        });

        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(match4);
        });

        test.afficherPlanning();
        System.out.println("\n\n");
    }

    /**
     * Test l'ajout d'un match dans le cas ou l'heure de debut est inferieur a l'heure de fin
     */
    @Test
    @Order(2)
    public void testAddMatchTimeIllegal() {
        Assertions.assertThrows(IllegalArgumentException.class, () -> {
            test.ajouterMatch(new Match("2020-01-07", "12:00", "10:00", ListCircuit.getCircuit("Silverstone"), 25));
        });
    }

    /**
     * Test l'ajout d'un match dans le cas ou un autre match est deja present
     */
    @Test
    @Order(3)
    public void testAddMatchWrong() {
        Assertions.assertThrows(WrongTimeException.class, () -> {
            test.ajouterMatch(new Match("2020-01-01", "11:00", "15:00", ListCircuit.getCircuit("Monza"), 25));
        });
    }

    /**
     * Test l'ajout d'un match dans le cas ou c'est le meme horaire mais sur un autre circuit
     */
    @Test
    @Order(4)
    public void testAddMatchSameTime() {
        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(new Match("2020-01-01", "10:00", "12:00", ListCircuit.getCircuit("Silverstone"), 25));
        });
    }

    /**
     * Test l'ajout d'un match dans la cas ou le circuit n'existe pas
     */
    @Test
    @Order(5)
    public void testAddMatchCircuitNotExist() {
        Assertions.assertThrows(CircuitExistException.class, () -> {
            test.ajouterMatch(new Match("2020-01-01", "10:00", "12:00", ListCircuit.getCircuit("Castelet"), 25));
        });
    }

    /**
     * Test le deplacement d'un match dans le cas ou tout est bon
     */
    @Test
    @Order(6)
    public void testMoveMatch() {
        Assertions.assertDoesNotThrow(() -> {
            test.deplacerMatch(match1, "2020-01-01", "16:00", "18:00");
        });

        // Verification que le match est bien deplace
        assertEquals("2020-01-01, début à 16:00 et fin à 18:00. Nbr nécessaires 20 à Monza, Viale di Vedano 5, 500 places", match1.toString());

        Assertions.assertDoesNotThrow(() -> {
            test.deplacerMatch(match1, "2020-01-07", "00:00", "23:00");
        });
        
        // Verification que le match est bien deplace
        assertEquals("2020-01-07, début à 00:00 et fin à 23:00. Nbr nécessaires 20 à Monza, Viale di Vedano 5, 500 places", match1.toString());
        test.afficherPlanning();
        System.out.println("prout\n\n");
    }
    
    /**
     * Test le deplacement d'un match dans le cas ou un match est deja present
     */
    @Test
    @Order(7)
    public void testMoveMatchWrong() {
        Assertions.assertThrows(WrongTimeException.class, () -> {
            test.deplacerMatch(match1, "2020-01-01", "11:00", "15:00");
        });
    }

    /**
     * Test le déplacement d'un match pour voir si ce meme match ne bloque pas le deplacement
     */
    @Test
    @Order(8)
    public void testMoveMatchSame(){
        Assertions.assertDoesNotThrow(() -> {
            test.deplacerMatch(match4, "2020-01-02", "18:00", "20:00");
        });
    }
    
    /**
     * Test l'ajout d'un match entre deux autres matchs dans le cas ou tout est bon
     */
    @Test
    @Order(9)
    public void testInsertMatchBetween(){
        Assertions.assertDoesNotThrow(() -> {
            test.ajouterMatch(new Match("2020-01-02", "14:01", "16:00", ListCircuit.getCircuit("Monza"), 30));
        });
    }

    /**
     * Test l'ajout d'un match entre deux autres matchs dans le cas un match est deja present
     */
    @Test
    @Order(10)
    public void testInsertMatchBetweenWrong(){
        Assertions.assertThrows(WrongTimeException.class ,() -> {
            test.ajouterMatch(new Match("2020-01-02", "14:01", "16:05", ListCircuit.getCircuit("Monza"), 30));
        });
    }

}
