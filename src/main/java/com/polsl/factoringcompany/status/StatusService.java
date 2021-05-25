package com.polsl.factoringcompany.status;

import com.google.common.base.Throwables;
import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.ItemExistsInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class StatusService {

    private final StatusRepository statusRepository;

    public List<StatusEntity> getStatuses() {
        return statusRepository.findAll();
    }

    public StatusEntity getStatus(Long id) {

        return this.statusRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Status " + id + " not found"));
    }


    public StatusEntity addStatus(String name) {

        if (validateName(name))
            throw new IllegalArgumentException("The name '" + name + "' is not appropriate");

        if (ifNameTaken(StringUtils.capitalize(name)))
            throw new IllegalArgumentException("Status with '" + name + "' name already exists");
        try {
            return statusRepository.save(new StatusEntity(StringUtils.capitalize(name)));
        } catch (RuntimeException e) {
            Throwable rootCause = Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new ItemExistsInDatabaseException("Subcontractor ( " + name + ") exists in DB");
                }
            }
            throw new RuntimeException(e);
        }
    }


    public void deleteStatus(Long id) {
        try {
            this.statusRepository.deleteById(id);
        } catch (RuntimeException ignored) {
            throw new IdNotFoundInDatabaseException("Status " + id + " not found");
        }
    }


    @Transactional
    public StatusEntity updateStatus(Long id, String name) {

        Optional<StatusEntity> statusEntity = statusRepository.findById(id);

        if (statusEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Status " + id + " not found");

        if (validateName(name))
            throw new IllegalArgumentException("The name '" + name + "' is not appropriate");

        if (ifNameTaken(name))
            throw new IllegalArgumentException("Status with '" + name + "' name already exists");


        try {
            statusEntity.get().setName(StringUtils.capitalize(name));
            return this.statusRepository.save(statusEntity.get());
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new ItemExistsInDatabaseException("Status ( " + StringUtils.capitalize(name) + ") exists in DB");
                }
            }
            throw new RuntimeException(e);
        }
    }


    public boolean ifNameTaken(String name) {
        Optional<StatusEntity> foundByName = statusRepository.findStatusEntityByName(StringUtils.capitalize(name));
        return foundByName.isPresent();
    }

    // TODO: 25.05.2021 I CAN ADD A NAME VALIDATOR CLASS OR STH
    public boolean validateName(String name) {
        return name == null || name.length() <= 0 || name.length() > 25 || !onlyLettersSpaces(name);
    }

    public static boolean onlyLettersSpaces(String s) {
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (Character.isLetter(ch) || ch == ' ') {
                continue;
            }
            return false;
        }
        return s.charAt(s.length() - 1) != ' ';
    }
}