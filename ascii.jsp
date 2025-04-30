<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Générateur ASCII Art</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
            line-height: 1.6;
            background-color: #f8f9fa;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 2rem;
        }
        form {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        input {
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            width: 100%;
        }
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #2980b9;
        }
        .ascii-art {
            font-family: 'Courier New', monospace;
            white-space: pre;
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            line-height: 1.2;
            letter-spacing: 1px;
            color: #e74c3c; /* Couleur du texte ASCII */
        }
    </style>
</head>
<body>
    <h1>Générateur ASCII Art</h1>
    
    <form method="post">
        <input type="text" name="text" 
               placeholder="Entrez votre texte ici..." 
               value="<%= request.getMethod().equalsIgnoreCase("POST") 
                          ? request.getParameter("text") 
                          : "" %>"
               required>
        <button type="submit">Générer</button>
    </form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String input = request.getParameter("text");
        if (input != null && !input.trim().isEmpty()) {
            final int L = 4;  // Largeur d'un caractère
            final int H = 5;  // Hauteur d'un caractère
            
            // Définition des caractères ASCII Art pour A-Z, 0-9
            String[] rows = {
                " #   ##   ## ##  ###  ##   ##  ###   ## ##  ###  #   ##    ##  ##   ##   ###  ",
                "# #  # #  #    #   #  #  # #  #  #   #    #  #  #  # #    # # # #  #   #  #  ",
                "###  # #  ##   ##   ##  ### ##  #  #   ##   ##   ###   #  #  ## # #  ##   ##  ",
                "# #  # #  #    #   #   # #  #   #  #    #   #   # #  #  #  ## #   ##   #    #  ",
                "# #  ##   ## ##  ###  ##   ##  ###   ## ##   ###   #   ##  #  #   #  #   #   #  ",
                
                // Chiffres (0-9)
                "###  #  #  #  #  ###  ###  ###   #  #  ###  ###  ##   ##  ###  ##  ##   ##   ###   ###",
                "#  # #  #  #  #  #   #   #    #   #  #  #   #  #   #    # #    #  # # #  #  #    #   #  #",
                "###  ###  ##   #   ##  ##   ##   ##  #   ##  ##   ##   ##  #   #   ##  ##  # ##   ##   ## ",
                "#  # #  #   #   #  #   #    # #  #  ##   ##  #   #  ##   #   ##   # #   ##    ##   #   ##",
                "###  ##   ###   ##   ##  ##    ##  ###  ###  ###   #  ## ##    ##    ##    ###   ##    ##"
            };

            StringBuilder[] asciiLines = new StringBuilder[H];
            for (int i = 0; i < H; i++) {
                asciiLines[i] = new StringBuilder();
            }

            input = input.toUpperCase();
            for (int j = 0; j < input.length(); j++) {
                char c = input.charAt(j);
                int index;
                if (c >= 'A' && c <= 'Z') {
                    index = c - 'A';  // Index pour les lettres A-Z
                } else if (c >= '0' && c <= '9') {
                    index = c - '0' + 26; // Index pour les chiffres 0-9 (après les lettres)
                } else {
                    index = 36; // Pour les caractères non pris en charge (les espaces, ponctuation, etc.)
                }

                for (int i = 0; i < H; i++) {
                    int start = index * L;
                    int end = start + L;
                    if (end <= rows[i].length()) {
                        // Ajoute le caractère ASCII + un espace (sauf après le dernier caractère)
                        asciiLines[i].append(rows[i].substring(start, end));
                        if (j < input.length() - 1) {
                            asciiLines[i].append(" "); // Ajoute un espace entre les caractères
                        }
                    }
                }
            }

            out.println("<div class=\"ascii-art\">");
            for (int i = 0; i < H; i++) {
                out.println(asciiLines[i].toString());
            }
            out.println("</div>");
        }
    }
%>
</body>
</html>
