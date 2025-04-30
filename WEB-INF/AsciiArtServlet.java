package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ascii-art")
public class AsciiArtServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String text = request.getParameter("chaine").toUpperCase();
        int width = 4;  // Largeur d'un caractère
        int height = 5; // Hauteur d'un caractère

        String[] asciiArt = {
            " #  ##   ## ##  ### ###  ## # # ###  ## # # #   # # ###  #  ##   #  ##   ## ### # # # # # # # # # # ### ### ",
            "# # # # #   # # #   #   #   # #  #    # # # #   ### # # # # # # # # # # #    #  # # # # # # # # # #   #   # ",
            "### ##  #   # # ##  ##  # # ###  #    # ##  #   ### # # # # ##  # # ##   #   #  # # # # ###  #   #   #   ## ",
            "# # # # #   # # #   #   # # # #  #  # # # # #   # # # # # # #    ## # #   #  #  # # # # ### # #  #  #       ",
            "# # ##   ## ##  ### #    ## # # ###  #  # # ### # # # #  #  #     # # # ##   #  ###  #  # # # #  #  ###  #  "
        };

        out.println("<html><head><title>ASCII Art</title></head><body>");
        out.println("<h1>Résultat de l'ASCII Art</h1><pre>");

        for (int h = 0; h < height; h++) {
            StringBuilder outputLine = new StringBuilder();
            for (char c : text.toCharArray()) {
                int charIndex = (c >= 'A' && c <= 'Z') ? c - 'A' : 26;
                int startPos = charIndex * width;
                outputLine.append(asciiArt[h].substring(startPos, startPos + width));
            }
            out.println(outputLine.toString());
        }

        out.println("</pre></body></html>");
    }
}
