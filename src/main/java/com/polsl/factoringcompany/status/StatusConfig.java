package com.polsl.factoringcompany.status;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class StatusConfig {

    @Bean
    CommandLineRunner commandLineRunnerStatus(StatusRepository statusRepository) {
        return args -> {
            StatusEntity invalid = new StatusEntity("Invalid or incomplete");
            StatusEntity cancelled = new StatusEntity("Cancelled");
            StatusEntity declined = new StatusEntity("Authorisation declined");
            StatusEntity authorized = new StatusEntity("Authorised");
            StatusEntity authorizedAndCancelled = new StatusEntity("Authorised and cancelled");
            StatusEntity deleted = new StatusEntity("Payment deleted");
            StatusEntity refund = new StatusEntity("Refund");
            StatusEntity requested = new StatusEntity("Payment requested");

            statusRepository.saveAll(List.of(invalid, cancelled, declined, authorized,
                    authorizedAndCancelled, deleted, refund, requested));
        };
    }
}