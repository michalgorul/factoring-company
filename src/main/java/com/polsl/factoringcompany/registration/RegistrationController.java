package com.polsl.factoringcompany.registration;

import com.polsl.factoringcompany.user.UserEntity;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/registration")
@AllArgsConstructor
public class RegistrationController {

    private RegistrationService registrationService;

    @PostMapping
    public UserEntity register(@RequestBody RegistrationRequest registrationRequest){
        return this.registrationService.register(registrationRequest);
    }
}
