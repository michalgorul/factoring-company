package com.polsl.factoringcompany.currency;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CurrencyRepository extends JpaRepository<CurrencyEntity, Long> {

    Optional<CurrencyEntity> findCurrencyEntityByName(String name);

    Optional<CurrencyEntity> findCurrencyEntityByCode(String code);
}
