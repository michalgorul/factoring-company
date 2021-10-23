package com.polsl.factoringcompany.registration;

import com.polsl.factoringcompany.security.auth.ApplicationUserService;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class RegistrationService {

    private final ApplicationUserService applicationUserService;
    private final UserService userService;

    public UserEntity register(RegistrationRequest registrationRequest) {

        // TODO: 23.10.2021 make more authorities | now all users are admins

        UserEntity userEntity = userService.registerNewUser(registrationRequest);

        return userEntity;

    }
}
