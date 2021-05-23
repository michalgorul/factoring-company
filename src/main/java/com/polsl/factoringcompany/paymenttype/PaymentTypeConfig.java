package com.polsl.factoringcompany.paymenttype;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class PaymentTypeConfig {

    @Bean
    CommandLineRunner commandLineRunnerPaymentType(PaymentTypeRepository paymentTypeRepository) {
        return args -> {
            PaymentTypeEntity cash = new PaymentTypeEntity("Cash");
            PaymentTypeEntity check = new PaymentTypeEntity("Check");
            PaymentTypeEntity debit = new PaymentTypeEntity("Debit card");
            PaymentTypeEntity credit = new PaymentTypeEntity("Credit card");
            PaymentTypeEntity mobile = new PaymentTypeEntity("Mobile payment");
            PaymentTypeEntity transfer = new PaymentTypeEntity("Electronic bank transfer");

            paymentTypeRepository.saveAll(List.of(cash, check, debit, credit, mobile,transfer));
        };
    }
}
