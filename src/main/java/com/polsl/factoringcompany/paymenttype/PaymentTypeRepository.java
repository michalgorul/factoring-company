package com.polsl.factoringcompany.paymenttype;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PaymentTypeRepository extends JpaRepository<PaymentTypeEntity, Long> {

    Optional<PaymentTypeEntity> findPaymentTypeEntityByName(String name);

}
