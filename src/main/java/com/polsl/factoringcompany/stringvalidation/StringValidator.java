package com.polsl.factoringcompany.stringvalidation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class StringValidator {

    private String string;
    private int acceptableLength;

    public static boolean onlyLettersSpaces(String s) {
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (Character.isLetter(ch) || ch == ' ') {
                continue;
            }
            return true;
        }
        return s.charAt(s.length() - 1) == ' ';
    }

    public static boolean ifNotDigitsOnly(String checkingString) {
        return !checkingString.chars().allMatch(Character::isDigit);
    }

    public static boolean stringWithSpacesImproper(String string, int length) {
        return string == null || string.length() <= 0 || string.length() > length || onlyLettersSpaces(string);
    }

    public static boolean stringWithoutSpacesImproper(String string, int length) {
        return string == null || string.length() <= 0 || string.length() > length || !string.chars().allMatch(Character::isLetter);
    }

}
