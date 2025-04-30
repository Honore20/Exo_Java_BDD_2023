import java.util.Scanner;

class Solution {  // Codingame nécessite le nom 'Solution'
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Lecture des paramètres
        int width = scanner.nextInt();    // L (largeur)
        int height = scanner.nextInt();   // H (hauteur)
        scanner.nextLine();               // Consomme le reste de la ligne
        
        // Lecture du texte à convertir
        String text = scanner.nextLine().toUpperCase();
        
        // Lecture des lignes ASCII
        String[] asciiArt = new String[height];
        for (int i = 0; i < height; i++) {
            asciiArt[i] = scanner.nextLine();
        }

        // Génération de l'art ASCII
        for (int h = 0; h < height; h++) {
            StringBuilder outputLine = new StringBuilder();
            
            for (char c : text.toCharArray()) {
                int charIndex = (c >= 'A' && c <= 'Z') ? c - 'A' : 26;
                int startPos = charIndex * width;
                outputLine.append(asciiArt[h].substring(startPos, startPos + width));
            }
            
            System.out.println(outputLine);
        }
    }
}
