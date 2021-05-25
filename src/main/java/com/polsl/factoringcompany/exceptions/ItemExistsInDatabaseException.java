package com.polsl.factoringcompany.exceptions;

public class ItemExistsInDatabaseException extends RuntimeException{

    public ItemExistsInDatabaseException(String message) {
        super(message);
    }
}
