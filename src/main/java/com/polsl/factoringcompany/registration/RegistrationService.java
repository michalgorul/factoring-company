package com.polsl.factoringcompany.registration;

import com.polsl.factoringcompany.stringvalidation.StringValidator;
import org.springframework.stereotype.Service;

@Service
public class RegistrationService {
    public String register(RegistrationRequest registrationRequest) {
        boolean emailValid = StringValidator.isEmailValid(registrationRequest.getEmail());

        if(!emailValid){
            throw new IllegalArgumentException("email not valid");
        }
        return "null";
    }
}
