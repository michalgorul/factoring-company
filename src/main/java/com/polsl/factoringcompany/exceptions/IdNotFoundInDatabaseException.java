package com.polsl.factoringcompany.exceptions;

public class IdNotFoundInDatabaseException extends RuntimeException{
    public IdNotFoundInDatabaseException(String message) {
        super(message);
    }
}
