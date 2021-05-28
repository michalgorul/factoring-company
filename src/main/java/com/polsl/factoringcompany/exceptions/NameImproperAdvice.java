package com.polsl.factoringcompany.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class NameImproperAdvice {

    @ResponseBody
    @ExceptionHandler(NameImproperException.class)
    @ResponseStatus(HttpStatus.NOT_ACCEPTABLE)
    public String idNotFoundHandler(NameImproperException ex){
        return ex.getMessage();
    }
}
