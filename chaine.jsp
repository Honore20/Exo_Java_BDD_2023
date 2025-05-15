public class Chaine {
    public static void main(String[] args) {
        String bonjour = "salut la compagnie";

        // Affichage en majuscules
        System.out.println("En majuscules : " + bonjour.toUpperCase());

        // Affichage avec la première lettre en majuscule
        System.out.println("Première lettre en majuscule : " + capitalizeFirstLetter(bonjour));
    }

    // Méthode pour mettre uniquement la première lettre en majuscule
    public static String capitalizeFirstLetter(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
}
