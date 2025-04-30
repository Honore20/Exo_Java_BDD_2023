package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AsciiArtServlet extends HttpServlet {

    private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ?";

    private static final int WIDTH = 4;  // Par exemple
    private static final int HEIGHT = 5;
    
    private static final String[] ASCII_FONT = {
        " A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  ? ",
        "/|  |\\ |\\ |\\ |-- |-- |-- |\\ |\\  |  |\\ |\\ |\\ |\\ |\\ |\\ |-- |-- |-- |-- |\\ |\\ |\\ |  ",
        " |--|  | | | |-- |-- |\\  | |\\ |\\ |\\ | | | |\\ | | | | |\\ | | | |\\ | | | |\\ |\\ |\\ ",
        " |  |\\ |/ |/ |__ |__ | \\ | | \\|/ | \\|/ |/ | \\|/ |/ |/ | | |/ |/ |/ |/ |/ |/ |/  ",
        "                                        (exemple fixe, à modifier si besoin)"
    };

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String text = request.getParameter("chaine");
        if (text == null || text.length() < 1) {
            request.setAttribute("asciiResult", null);
            request.getRequestDispatcher("/ascii.jsp").forward(request, response);
            return;
        }

        text = text.toUpperCase();
        StringBuilder[] resultLines = new StringBuilder[HEIGHT];
        for (int i = 0; i < HEIGHT; i++) {
            resultLines[i] = new StringBuilder();
        }

        for (char c : text.toCharArray()) {
            int index = ALPHABET.indexOf(c);
            if (index == -1) index = ALPHABET.length() - 1; // '?'

            for (int h = 0; h < HEIGHT; h++) {
                int start = index * WIDTH;
                resultLines[h].append(ASCII_FONT[h], start, start + WIDTH);
            }
        }

        request.setAttribute("asciiResult", resultLines);
        request.setAttribute("originalText", text);
        request.getRequestDispatcher("/ascii.jsp").forward(request, response);
    }
}
