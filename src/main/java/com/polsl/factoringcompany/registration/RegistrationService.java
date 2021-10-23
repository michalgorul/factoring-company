package com.polsl.factoringcompany.registration;

import com.polsl.factoringcompany.registration.token.ConfirmationTokenEntity;
import com.polsl.factoringcompany.registration.token.ConfirmationTokenService;
import com.polsl.factoringcompany.security.auth.ApplicationUserService;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@AllArgsConstructor
public class RegistrationService {

    private final ApplicationUserService applicationUserService;
    private final UserService userService;
    private final ConfirmationTokenService confirmationTokenService;

    public String register(RegistrationRequest registrationRequest) {

        // TODO: 23.10.2021 make more authorities | now all users are admins

        UserEntity userEntity = userService.registerNewUser(registrationRequest);

        String token = UUID.randomUUID().toString();
        ConfirmationTokenEntity confirmationTokenEntity = new ConfirmationTokenEntity(
                token,
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(15),
                userEntity);

        confirmationTokenService.saveConfirmationToken(confirmationTokenEntity);

        // TODO: 23.10.2021 SEND EMAIL

        return token;

    }
}
