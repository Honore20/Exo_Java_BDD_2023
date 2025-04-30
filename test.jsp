<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Générateur ASCII Art</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            line-height: 1.6;
            background-color: #f1f1f1;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            letter-spacing: 1px;
        }

        form {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        input {
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            width: 100%;
            margin-bottom: 1rem;
            outline: none;
        }

        input:focus {
            border-color: #3498db;
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
            display: block;
            margin: 0 auto;
        }

        button:hover {
            background-color: #2980b9;
        }

        .ascii-art {
            font-family: 'Courier New', monospace;
            white-space: pre;
            background: #282c34;
            color: #e74c3c; /* Couleur du texte ASCII */
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            line-height: 1.2;
            letter-spacing: 1px;
            overflow-x: auto;
        }

        .ascii-art span {
            color: #f39c12; /* Couleur dorée pour accentuer certains caractères */
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
            
            // Définition des caractères ASCII Art pour A-Z et 0-9
            String[] rows = {
                " #  ##   ## ##  ###  ###  ##   ##  ###  ##   ## ##   ###   ## ## ##  ## ## ## ## ### ## ",
                "# # # #  #    #   # #  # #   #    #  #   #    #  # # #  #    #   #  ##    #  #   #  # #   ",
                "###  ##   ##  ##   ##  ##   ##  ##   ###  ##   #  ##    ##    #   #   ## ##  ##   ## ## # ",
                "# #  #  #    #   # #  #  # #   #   # #   #   #  ##   ### ##  ##   #    ###    ##   ## ## ##",
                "# # ##   ## ##  ###  ###  ##   ##  ### ##  ##   ##    ##   ##   ## ## ## ## ##    ### ###  ",
                
                // Représentation ASCII Art pour les chiffres 0–9
                " ###   ##   ##   ##  ###  ###  ###   ###   ###  ###  ###  ### ",
                " # #  #  #  #  #  # #  # #  # #    #  #  #  #   #  #  # #  # ",
                " # #  ##   ##   ##  ##  ##  ##  ##   ##   ##    ##   ##    ## ",
                " # #  # #   #   # #  #   #   ##  ##   ##   ##   ## ## ##  ### ",
                " # #   ##  ###   ##   ##  ##   ##   ###    ##    ##  ##  ## ## "
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
                    index = c - '0' + 26; // Index pour les chiffres 0-9
                } else {
                    index = 36; // Pour les caractères non pris en charge
                }

                for (int i = 0; i < H; i++) {
                    int start = index * L;
                    int end = start + L;
                    if (end <= rows[i].length()) {
                        // Ajoute le caractère ASCII + un espace (sauf après le dernier caractère)
                        String asciiChar = rows[i].substring(start, end);
                        if (index >= 26) {
                            asciiChar = "<span>" + asciiChar + "</span>";  // Accentuer les chiffres
                        }
                        asciiLines[i].append(asciiChar);
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
