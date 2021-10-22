package com.polsl.factoringcompany.registration;

import lombok.*;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@AllArgsConstructor
public class RegistrationRequest {

    private final String email;
    private final String username;
    private final String password;

}
