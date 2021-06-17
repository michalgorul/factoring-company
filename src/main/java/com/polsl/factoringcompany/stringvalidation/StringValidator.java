package com.polsl.factoringcompany.stringvalidation;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import nl.garvelink.iban.IBAN;
import nl.garvelink.iban.IBANFields;
import nl.garvelink.iban.Modulo97;

import java.util.Optional;

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

    public static boolean onlyLettersDigits(String s) {
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (Character.isLetter(ch) || Character.isDigit(ch)) {
                continue;
            }
            return true;
        }
        return false;
    }

    public static boolean ifNotDigitsOnly(String checkingString) {
        return !checkingString.chars().allMatch(Character::isDigit);
    }

    public static boolean stringWithSpacesImproper(String string, int length) {
        return string == null || string.length() <= 0 || string.length() > length || onlyLettersSpaces(string);
    }

    public static boolean stringWithDigitsImproper(String string, int length) {
        return string == null || string.length() <= 0 || string.length() > length || onlyLettersDigits(string);
    }

    public static boolean stringWithoutSpacesImproper(String string, int length) {
        return string == null || string.length() <= 0 || string.length() > length || !string.chars().allMatch(Character::isLetter);
    }

    public static boolean ifBankAccountNumberValid(String candidate){
        boolean valid = Modulo97.verifyCheckDigits( candidate );

        IBAN iban = IBAN.valueOf(candidate);

        Optional<String> bankId = IBANFields.getBankIdentifier( iban );
        Optional<String> branchId = IBANFields.getBranchIdentifier( iban );

        boolean isRegistered = IBAN.parse(candidate).isInSwiftRegistry(); // true

        return valid;
    }

}
