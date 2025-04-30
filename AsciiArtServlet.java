package com.example;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AsciiArtServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lettre = request.getParameter("lettre");
        String resultat = "";

        if (lettre != null && lettre.length() == 1) {
            char ch = lettre.charAt(0);
            resultat = "Lettre reçue : " + ch + "<br/>";

            // Exemple simple ASCII art
            if (ch == 'A' || ch == 'a') {
                resultat += "&nbsp;&nbsp;A<br/> A&nbsp;&nbsp;A<br/>AAAAA<br/>A&nbsp;&nbsp;A<br/>";
            } else {
                resultat += "Pas d'ASCII art disponible pour cette lettre.";
            }
        } else {
            resultat = "Veuillez entrer une seule lettre.";
        }

        request.setAttribute("ascii", resultat);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ascii.jsp");
        dispatcher.forward(request, response);
    }
}
