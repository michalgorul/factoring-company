package com.polsl.factoringcompany.status;

import com.google.common.base.Throwables;
import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NameImproperException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
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
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Status", id));
    }


    public StatusEntity addStatus(String name) {

        if (nameImproper(name))
            throw new NameImproperException(name);

        try {
            return statusRepository.save(new StatusEntity(StringUtils.capitalize(name)));
        } catch (RuntimeException e) {
            Throwable rootCause = Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Status", "name", name);
                }
            }
            throw new RuntimeException(e);
        }
    }


    public void deleteStatus(Long id) {
        try {
            this.statusRepository.deleteById(id);
        } catch (RuntimeException ignored) {
            throw new IdNotFoundInDatabaseException("Status", id);
        }
    }


    @Transactional
    public StatusEntity updateStatus(Long id, String name) {

        Optional<StatusEntity> statusEntity = statusRepository.findById(id);

        if (statusEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Status", id);

        if (nameImproper(name))
            throw new NameImproperException(name);

        if(ifNameTaken(name)){
            throw new NotUniqueException("Status", "name", name);
        }

        try {
            statusEntity.get().setName(StringUtils.capitalize(name));
            return this.statusRepository.save(statusEntity.get());
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Status", "name", name);
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
    public boolean nameImproper(String name) {
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