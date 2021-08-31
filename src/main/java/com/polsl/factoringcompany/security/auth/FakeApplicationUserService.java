package com.polsl.factoringcompany.security.auth;

import com.google.common.collect.Lists;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import static com.polsl.factoringcompany.security.ApplicationUserRole.ADMIN;

@RequiredArgsConstructor
@Repository("fake")
public class FakeApplicationUserService implements ApplicationUserDao{

    private final PasswordEncoder passwordEncoder;

    @Override
    public Optional<ApplicationUser> selectApplicationUserByUsername(String username) {
        return getApplicationUsers()
                .stream()
                .filter(applicationUser -> username.equals(applicationUser.getUsername()))
                .findFirst();
    }

    private List<ApplicationUser> getApplicationUsers() {
        String password = passwordEncoder.encode("password");
        List<ApplicationUser> applicationUsers = Lists.newArrayList(
                new ApplicationUser(
                        ADMIN.getGrantedAuthorities(),
                        "admin",
                        password,
                        true,
                        true,
                        true,
                        true
                )
        );

        return applicationUsers;
    }
}
