package com.polsl.factoringcompany.status;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
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

        nameValidator(name);

        try {
            return statusRepository.save(new StatusEntity(StringUtils.capitalize(name)));
        } catch (RuntimeException e) {
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

        nameValidator(name);

        try {
            statusEntity.get().setName(StringUtils.capitalize(name));
            return this.statusRepository.save(statusEntity.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    private void nameValidator(String name) {
        if (StringValidator.stringWithSpacesImproper(name, 25))
            throw new ValueImproperException(name);

        if(ifNameTaken(name))
            throw new NotUniqueException("Status", "name", name);
    }


    public boolean ifNameTaken(String name) {
        Optional<StatusEntity> foundByName = statusRepository.findStatusEntityByName(StringUtils.capitalize(name));
        return foundByName.isPresent();
    }


}