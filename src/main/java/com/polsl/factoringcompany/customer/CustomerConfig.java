package com.polsl.factoringcompany.customer;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class CustomerConfig {

    @Bean
    CommandLineRunner commandLineRunnerCustomer(CustomerRepository customerRepository) {
        return args -> {
            CustomerEntity elsie = new CustomerEntity(
                    "Elsie",
                    "Newcomb",
                    "Wordware",
                    "Nigeria",
                    "Sauri",
                    "8627 Brentwood Park",
                    "564561",
                    "929-885-1154",
                    false);

            CustomerEntity barry = new CustomerEntity(
                    "Barry",
                    "Comins",
                    "Leexo",
                    "Sierra Leone",
                    "Lago",
                    "98432 Southridge Alley",
                    "44665",
                    "479-764-6085",
                    false);

            CustomerEntity deirdre = new CustomerEntity(
                    "Deirdre",
                    "Grinley",
                    "Yadel",
                    "Papua New Guinea",
                    "Kavieng",
                    "17162 Valley Edge Crossing",
                    null,
                    "426-776-1338",
                    true);

            customerRepository.saveAll(List.of(elsie, barry, deirdre));
        };
    }
}
