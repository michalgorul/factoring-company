package com.polsl.factoringcompany.status;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StatusRepository extends JpaRepository<StatusEntity, Long> {

    Optional<StatusEntity> findStatusEntityByName(String name);
}
