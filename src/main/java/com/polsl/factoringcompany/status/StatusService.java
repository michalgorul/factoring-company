package com.polsl.factoringcompany.status;

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

    public List<StatusEntity> getStatuses(){
        return statusRepository.findAll();
    }

    public Optional<StatusEntity> getStatus(Long id) {

        Optional<StatusEntity> statusEntity = statusRepository.findById(id);

        if (statusEntity.isEmpty()) {
            throw new IllegalStateException("Status with id " + id + " does not exist");
        }
        return statusEntity;
    }


    public StatusEntity addStatus(String name) {

        ifFits(name);
        return statusRepository.save(new StatusEntity(StringUtils.capitalize(name)));
    }


    public Optional<StatusEntity> deleteStatus(Long id) {
        Optional<StatusEntity> statusEntity = statusRepository.findById(id);

        if (statusEntity.isPresent()) {
            statusRepository.deleteById(id);
            return statusEntity;
        } else {
            throw new IllegalStateException("Status with id " + id + " does not exist");
        }
    }


    @Transactional
    public Optional<StatusEntity> updateStatus(Long id, String name) {

        StatusEntity statusEntity = statusRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Status with id " + id + " does not exist"));

        ifFits(name);
        statusEntity.setName(StringUtils.capitalize(name));

        return Optional.of(statusEntity);
    }


    public void ifNameTaken(String name){
        Optional<StatusEntity> foundByName = statusRepository.findStatusEntityByName(StringUtils.capitalize(name));

        if (foundByName.isPresent()) {
            throw new IllegalStateException("Status with '" + name + "' name already exists");
        }
    }

    // TODO: 23.05.2021 SPACES SHOULD BE ACCEPTABLE
    public void checkName(String name){
        if (name == null || name.length() <= 0 || name.length() > 25 || !name.chars().allMatch(Character::isLetter)) {
            throw new IllegalStateException("The name '" + name + "' is not appropriate");
        }
    }

    public void ifFits(String name){
        checkName(name);
        ifNameTaken(name);
    }
}
