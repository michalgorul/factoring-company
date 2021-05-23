package com.polsl.factoringcompany.currency;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class CurrencyConfig {

    @Bean
    CommandLineRunner commandLineRunner(CurrencyRepository currencyRepository){
        return args -> {
            CurrencyEntity ruble = new CurrencyEntity("Ruble", "RUB");
            CurrencyEntity euro = new CurrencyEntity("Euro", "EUR");
            CurrencyEntity zloty = new CurrencyEntity("Zloty", "PLN");
            CurrencyEntity lev = new CurrencyEntity("Lev", "BGN");
            CurrencyEntity dollar = new CurrencyEntity("Dollar", "USD");

            currencyRepository.saveAll(List.of(ruble, euro, zloty, lev, dollar));
        };
    }
}
