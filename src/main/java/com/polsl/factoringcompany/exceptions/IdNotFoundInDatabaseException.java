package com.polsl.factoringcompany.exceptions;

public class IdNotFoundInDatabaseException extends RuntimeException{
    public IdNotFoundInDatabaseException(String message) {
        super(message);
    }

    public IdNotFoundInDatabaseException(String object, Long id) {
        super(object + " "  + id + " not found in database");
    }
}
