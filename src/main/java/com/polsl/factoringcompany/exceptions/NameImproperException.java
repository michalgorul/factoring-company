package com.polsl.factoringcompany.exceptions;

public class NameImproperException extends IllegalArgumentException{
    public NameImproperException(String name) {
        super("The name '" + name + "' is not appropriate");
    }

    public NameImproperException(String name, String object) {
        super("The " + object + " '" + name + "' is not appropriate");
    }
}
