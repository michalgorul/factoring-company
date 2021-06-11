package com.polsl.factoringcompany.company;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CompanyRepository extends JpaRepository<CompanyEntity, Long> {

    Optional<CompanyEntity> findCompanyEntityByNip(String nip);

    Optional<CompanyEntity> findCompanyEntityByRegon(String regon);
}
