package com.polsl.factoringcompany.user;


import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.security.auth.ApplicationUser;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import lombok.AllArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public List<UserEntity> getUsers() {
        return this.userRepository.findAll();
    }

    public UserEntity getUser(Long id) {
        return this.userRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("User", id));
    }

    public UserEntity getCurrentUser(){
        Long id = 0L;
        String currentUserName = SecurityContextHolder.getContext().getAuthentication().getName();
        if(userRepository.findByUsername(currentUserName).isPresent()){
            id = userRepository.findByUsername(currentUserName).get().getId();
        }
        return getUser(id);
    }

    public UserEntity addUser(UserEntity userEntity) {

        addValidate(userEntity);

        try {
            return this.userRepository.save(new UserEntity(
                    userEntity.getUsername(),
                    userEntity.getPassword(),
                    userEntity.getEmail(),
                    StringUtils.capitalize(userEntity.getFirstName()),
                    StringUtils.capitalize(userEntity.getLastName()),
                    StringUtils.capitalize(userEntity.getCountry()),
                    StringUtils.capitalize(userEntity.getCity()),
                    StringUtils.capitalize(userEntity.getStreet()),
                    userEntity.getPostalCode(),
                    userEntity.getPhone(),
                    userEntity.getCompanyId()));

        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public UserEntity updateUser(Long id, UserEntity userEntity) {

        Optional<UserEntity> userEntityOptional = userRepository.findById(id);

        if (userEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("User", id);

        updateValidate(id, userEntity);

        try {
            userEntityOptional.get().setUsername(userEntity.getUsername());
            userEntityOptional.get().setPassword(userEntity.getPassword());
            userEntityOptional.get().setEmail(userEntity.getEmail());
            userEntityOptional.get().setFirstName(StringUtils.capitalize(userEntity.getFirstName()));
            userEntityOptional.get().setLastName(StringUtils.capitalize(userEntity.getLastName()));
            userEntityOptional.get().setCountry(StringUtils.capitalize(userEntity.getCountry()));
            userEntityOptional.get().setCity(StringUtils.capitalize(userEntity.getCity()));
            userEntityOptional.get().setStreet(StringUtils.capitalize(userEntity.getStreet()));
            userEntityOptional.get().setPostalCode(userEntity.getPostalCode());
            userEntityOptional.get().setPhone(userEntity.getPhone());
            userEntityOptional.get().setCompanyId(userEntity.getCompanyId());


            return this.userRepository.save(userEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteUser(Long id) {
        try {
            this.userRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("User", id);
        }
    }

    private void updateValidate(Long id, UserEntity userEntity) {

        if (ifEmailTakenUpdating(id, userEntity.getEmail()))
            throw new NotUniqueException("User", "email", userEntity.getEmail());

        if (ifUsernameTakenUpdating(id, userEntity.getUsername()))
            throw new NotUniqueException("User", "username", userEntity.getUsername());

        nameValidator(userEntity);
    }

    private void addValidate(UserEntity userEntity) {

        if (ifEmailTakenAdding(userEntity.getEmail()))
            throw new NotUniqueException("User", "email", userEntity.getEmail());

        if (ifUsernameTakenAdding(userEntity.getUsername()))
            throw new NotUniqueException("User", "username", userEntity.getUsername());

        nameValidator(userEntity);
    }

    private boolean ifEmailTakenAdding(String email) {
        Optional<UserEntity> userEntityOptional = userRepository.findByEmail(email);
        return userEntityOptional.isPresent();
    }

    private boolean ifEmailTakenUpdating(Long id, String email) {
        Optional<UserEntity> userEntityByEmail = userRepository.findByEmail(email);
        Optional<UserEntity> userEntityById = userRepository.findById(id);

        if (userEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("User", id);
        if (userEntityByEmail.isEmpty())
            return false;

        return !userEntityByEmail.get().getId().equals(userEntityById.get().getId());
    }

    private boolean ifUsernameTakenAdding(String username) {
        Optional<UserEntity> userEntityOptional = userRepository.findByUsername(username);
        return userEntityOptional.isPresent();
    }

    private boolean ifUsernameTakenUpdating(Long id, String username) {
        Optional<UserEntity> userEntityByUsername = userRepository.findByUsername(username);
        Optional<UserEntity> userEntityById = userRepository.findById(id);

        if (userEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("User", id);
        if (userEntityByUsername.isEmpty())
            return false;

        return !userEntityByUsername.get().getId().equals(userEntityById.get().getId());
    }

    private void nameValidator(UserEntity userEntity) {
        if (StringValidator.stringWithDigitsImproper(userEntity.getUsername(), 50)) {
            throw new ValueImproperException(userEntity.getUsername());
        }

        // TODO: 17.06.2021 PASSWORD VALIDATOR

        else if(!StringValidator.isEmailValid(userEntity.getEmail())){
            throw new ValueImproperException(userEntity.getEmail());
        }

        else if (StringValidator.stringWithSpacesImproper(userEntity.getCountry(), 50)) {
            throw new ValueImproperException(userEntity.getCountry());
        }

        else if (StringValidator.stringWithSpacesImproper(userEntity.getCity(), 50)) {
            throw new ValueImproperException(userEntity.getCity());
        }

        else if (StringValidator.stringWithSpacesImproper(userEntity.getStreet(), 50)) {
            throw new ValueImproperException(userEntity.getStreet());
        }

        else if (StringValidator.stringWithSpacesImproper(userEntity.getPostalCode(), 15)) {
            throw new ValueImproperException(userEntity.getPostalCode());
        }

        else if (!StringValidator.isPhoneNumberValid(userEntity.getPhone())) {
            throw new ValueImproperException(userEntity.getPhone());

        }

    }
}
