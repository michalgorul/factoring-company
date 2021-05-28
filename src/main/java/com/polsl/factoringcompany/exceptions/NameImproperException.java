package com.polsl.factoringcompany.exceptions;

public class NameImproperException extends IllegalArgumentException{
    public NameImproperException(String name) {
        super("The name " + name + " is not appropriate");
    }
}
