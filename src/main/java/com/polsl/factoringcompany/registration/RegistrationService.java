package com.polsl.factoringcompany.registration;

import com.polsl.factoringcompany.registration.token.ConfirmationTokenEntity;
import com.polsl.factoringcompany.registration.token.ConfirmationTokenService;
import com.polsl.factoringcompany.security.auth.ApplicationUserService;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Transactional
    public String confirmToken(String token) {
        ConfirmationTokenEntity confirmationTokenEntity = confirmationTokenService.getToken(token);


        if (confirmationTokenEntity.getConfirmedAt() != null) {
            throw new IllegalStateException("email already confirmed");
        }

        LocalDateTime expiredAt = confirmationTokenEntity.getExpiresAt().toLocalDateTime();

        if (expiredAt.isBefore(LocalDateTime.now())) {
            throw new IllegalStateException("token expired");
        }

        confirmationTokenService.setConfirmedAt(token);
        userService.enableAppUser(Long.valueOf(confirmationTokenEntity.getUserId()));
        return "confirmed";
    }
}
