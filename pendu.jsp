<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.Arrays"%>

<html>
<head>
<title>Jeu du Pendu</title>
</head>
<body bgcolor="white">
<h1>Jeu du Pendu</h1>

<%! 
    public class JeuPendu {
        private String motADeviner;
        private char[] motAffiche;
        private List<Character> lettresProposees;
        private int essaisRestants;

        public JeuPendu(List<String> listeMots, int essais) {
            Random rand = new Random();
            motADeviner = listeMots.get(rand.nextInt(listeMots.size()));
            motAffiche = new char[motADeviner.length()];
            for (int i = 0; i < motAffiche.length; i++) {
                motAffiche[i] = '_';
            }
            lettresProposees = new ArrayList<>();
            essaisRestants = essais;
        }

        public boolean proposerLettre(char lettre) {
            if (lettresProposees.contains(lettre)) {
                System.out.println("Lettre déjà proposée !");
                return false;
            }
            lettresProposees.add(lettre);
            boolean lettreTrouvee = false;
            for (int i = 0; i < motADeviner.length(); i++) {
                if (motADeviner.charAt(i) == lettre) {
                    motAffiche[i] = lettre;
                    lettreTrouvee = true;
                }
            }
            if (!lettreTrouvee) {
                essaisRestants--;
            }
            return lettreTrouvee;
        }

        public boolean estGagne() {
            for (char c : motAffiche) {
                if (c == '_') {
                    return false;
                }
            }
            return true;
        }

        public boolean estPerdu() {
            return essaisRestants <= 0;
        }

        public void afficherEtat() {
            System.out.println("Mot à deviner : " + new String(motAffiche));
            System.out.println("Lettres proposées : " + lettresProposees);
            System.out.println("Essais restants : " + essaisRestants);
        }

        public String getMotADeviner() {
            return motADeviner;
        }
    }
%>

<%
    List<String> listeMots = Arrays.asList("PROGRAMME", "JAVA", "ORDINATEUR", "INTERNET", "CLAVIER", "SOURIS", "ECRAN", "LOGICIEL", "COMPILATEUR", "ALGORITHME");
    Scanner scanner = new Scanner(System.in);
    JeuPendu jeu = new JeuPendu(listeMots, 6);

    while (!jeu.estGagne() && !jeu.estPerdu()) {
        jeu.afficherEtat();
        System.out.print("Proposez une lettre : ");
        if (scanner.hasNextLine()) {
            char lettre = scanner.nextLine().toUpperCase().charAt(0);
            jeu.proposerLettre(lettre);
        } else {
            System.out.println("Aucune ligne trouvée !");
            break;
        }
    }

    if (jeu.estGagne()) {
        System.out.println("Félicitations, vous avez gagné !");
    } else {
        System.out.println("Dommage, vous avez perdu. Le mot était : " + jeu.getMotADeviner());
    }
%>

</body>
</html>
