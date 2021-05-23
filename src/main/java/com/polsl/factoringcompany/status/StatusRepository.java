package com.polsl.factoringcompany.status;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatusRepository extends JpaRepository<StatusEntity, Long> {

    Optional<StatusEntity> findStatusEntityByName(String name);
}
