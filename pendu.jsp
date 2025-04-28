<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
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
            // Utiliser des balises JSP pour l'affichage
            out.println("Mot à deviner : " + new String(motAffiche) + "<br>");
            out.println("Lettres proposées : " + lettresProposees + "<br>");
            out.println("Essais restants : " + essaisRestants + "<br>");
        }

        public String getMotADeviner() {
            return motADeviner;
        }
    }
%>

<%
    List<String> listeMots = Arrays.asList("PROGRAMME", "JAVA", "ORDINATEUR", "INTERNET", "CLAVIER", "SOURIS", "ECRAN", "LOGICIEL", "COMPILATEUR", "ALGORITHME");
    JeuPendu jeu = new JeuPendu(listeMots, 6);

    String lettreProposee = request.getParameter("lettre");
    if (lettreProposee != null && !lettreProposee.isEmpty()) {
        jeu.proposerLettre(lettreProposee.toUpperCase().charAt(0));
    }

    jeu.afficherEtat();
%>

<form action="pendu.jsp" method="post">
    <label for="lettre">Proposez une lettre :</label>
    <input type="text" id="lettre" name="lettre" maxlength="1" required>
    <input type="submit" value="Envoyer">
</form>

<%
    if (jeu.estGagne()) {
        out.println("Félicitations, vous avez gagné !<br>");
    } else if (jeu.estPerdu()) {
        out.println("Dommage, vous avez perdu. Le mot était : " + jeu.getMotADeviner() + "<br>");
    }
%>

</body>
</html>
