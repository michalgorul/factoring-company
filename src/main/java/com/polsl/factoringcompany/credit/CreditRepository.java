package com.polsl.factoringcompany.credit;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CreditRepository extends JpaRepository<CreditEntity, Long> {

    List<CreditEntity> findAllByUserId(int userId);
}
