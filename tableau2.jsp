<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<html>
<head>
    <title>Tableau d'entiers</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
            justify-content: center;
        }

        input[type="text"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 200px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            font-size: 18px;
            color: #333;
            margin-top: 20px;
            padding: 10px;
            background-color: #f0f8ff;
            border-left: 5px solid #4CAF50;
            border-radius: 6px;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Interagir avec le tableau d'entiers</h1>

    <form action="#" method="post">
        <input type="text" name="valeur" placeholder="Entrez une valeur entière">
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

    <a href="index.html">⬅ Retour au sommaire</a>
</div>
</body>
</html>
