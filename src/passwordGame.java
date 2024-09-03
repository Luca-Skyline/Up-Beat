// Password Game | RIBIT | 8/29/24 | Advanced Computer Science 4B

import java.util.Scanner;

public class PasswordGame {
    
    static int level = 1;
    static String[] my_rules_text = {"Password must be at least five characters.",
        "Password must include a number.",
        "Password must contain a special character.",
        "Must contain the Roman numeral for the number 500.",
        "Must contain the only word with all 26 letters.",
        "What is light during the day and heavy at night?",
        "What starts and ends with 'E' but only has one letter in it?",
        "What do you do? r1bqkb1r/ppp2ppp/2n2n2/3pp1N1/2B1P3/8/PPPP1PPP/RNBQK2R w KQkq - 0 1",
        "Now for atomic chess too.",
        "Must contain the name of Max Design Pro's little brother."
    };
    
    public static void main(String[] args) {
        
        Scanner scanner = new Scanner(System.in);
        
        while(true){
            
            System.out.println("Please Choose Your Password:");
            String password = scanner.nextLine();
            clearScreen();
            System.out.println("Old Password: " + password);
            level = test(password);
            if (level == 0) {
                System.out.println("You completed the Password Game :)");
                break;
            }
            for(int i = 0; i < level - 1; i++) {
                System.out.println("✔️  " + my_rules_text[i]);
            }
            System.out.println("❎  " + my_rules_text[level-1] + "\n");
            
        }
        // scanner.close();
    }
    
    static int test(String password){
        //Rule 1: Password must be at least 5 characters
        if (password.length() < 5) {
            return 1;
        } 
        
        //Rule 2: Password must contain a number
        boolean hasNumber = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) {
                hasNumber = true;
                break;
            }
        }
        if (!hasNumber) {
            return 2;
        }
        
        //Rule 3: Must contain a special character
        boolean hasSpecialCharacter = false;
        for (char c : password.toCharArray()) {
            if (!(Character.isDigit(c) || Character.isLetter(c) || c==' ')) {
                hasSpecialCharacter = true;
                break;
            }
        }
        if (!hasSpecialCharacter) {
            return 3;
        }
          //Rule 4: Must contain the roman numeral for 500: 
        if (!password.contains("D")) {
            return 4;
        }
        //Rule 5: Password must contain "alphabet" (funny)
        if (!password.contains("alphabet") && !password.contains("Alphabet")) {
            return 5;
        }
        
        //Rule 6: What is light during the day but heavy at night (eyelids)
        if (!password.contains("eyelids") && !password.contains("Eyelids")) {
            return 6;
        }
        
        //Rule 7: What starts and ends with "E" but only has one letter in it? (envelope or eye)
        if (!password.contains("envelope") && !password.contains("Envelope")) {
            return 7;
        }
        
        //Rule 8: Must include the best chess move in the position r1bqkb1r/ppp2ppp/2n2n2/3pp1N1/2B1P3/8/PPPP1PPP/RNBQK2R w KQkq - 0 1 (exd5)
        if (!password.contains("exd5")) {
            return 8;
        }
            
        //Rule 9: Must include the best atomic chess move in the same position (nxf7)
        if (!password.contains("nxf7")) {
            return 9;
        }
        
        //Rule 10: Must contain the name of Max Design Pro's little brother?
        if (!password.contains("jimmy") && !password.contains("Jimmy")) {
            return 10;
        }
        
        
        System.out.println("Congratulations! Your identity won't get stolen!");
        return 0;
    }
    //cheat password ;) :: alphabeteyelidsenvelopeexd5nxf7@Djimmy
    public static void clearScreen() {  
        System.out.print("\033[H\033[2J");  
        System.out.flush(); 
    }
}  
