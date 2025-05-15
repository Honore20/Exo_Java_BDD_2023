<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<html>
<head>
    <title>Tableau d'entiers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 5px;
            margin-right: 10px;
        }
        input[type="submit"] {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message {
            color: #333;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<h1>Interagir avec le tableau d'entiers</h1>

<form action="#" method="post">
    <p>Ajouter une valeur : <input type="text" name="valeur">
    <input type="submit" name="action" value="Ajouter">
</form>

<form action="#" method="post">
    <input type="submit" name="action" value="Supprimer la dernière valeur">
</form>

<form action="#" method="post">
    <input type="submit" name="action" value="Afficher le tableau">
</form>

<form action="#" method="post">
    <input type="submit" name="action" value="Vider le tableau">
</form>

<%
    // Initialisation du tableau
    List<Integer> tableau = (List<Integer>) session.getAttribute("tableau");
    if (tableau == null) {
        tableau = new ArrayList<>();
        session.setAttribute("tableau", tableau);
    }

    String action = request.getParameter("action");
    String message = "";

    if ("Ajouter".equals(action)) {
        String valeurStr = request.getParameter("valeur");
        if (valeurStr != null && !valeurStr.trim().isEmpty()) {
            try {
                int valeur = Integer.parseInt(valeurStr);
                if (tableau.size() < 10) {
                    tableau.add(valeur);
                    message = "✅ Valeur ajoutée avec succès.";
                } else {
                    message = "❌ Tableau plein. Impossible d'ajouter plus de 10 valeurs.";
                }
            } catch (NumberFormatException e) {
                message = "❌ Veuillez entrer une valeur entière valide.";
            }
        }
    } else if ("Supprimer la dernière valeur".equals(action)) {
        if (!tableau.isEmpty()) {
            tableau.remove(tableau.size() - 1);
            message = "🗑️ Dernière valeur supprimée avec succès.";
        } else {
            message = "⚠️ Le tableau est déjà vide.";
        }
    } else if ("Afficher le tableau".equals(action)) {
        if (!tableau.isEmpty()) {
            message = "📋 Contenu actuel du tableau : " + tableau.toString();
        } else {
            message = "ℹ️ Le tableau est vide.";
        }
    } else if ("Vider le tableau".equals(action)) {
        tableau.clear();
        message = "🧹 Tableau vidé avec succès.";
    }
%>

<div class="message"><%= message %></div>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
