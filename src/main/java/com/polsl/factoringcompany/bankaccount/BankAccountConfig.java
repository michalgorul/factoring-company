package com.polsl.factoringcompany.bankaccount;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class BankAccountConfig {

    @Bean
    CommandLineRunner commandLineRunnerBankAccount(BankAccountRepository bankAccountRepository) {
        return args -> {
//            BankAccountEntity youspan = new BankAccountEntity(
//                    "ALLBPLPW",
//                    "PL55106001226993953859941195",
//                    "Bank Pekao",
//                    null,
//                    1);
//
//            BankAccountEntity twiyo = new BankAccountEntity(
//                    "CITIPLPX",
//                    "PL35103000062415176170519183",
//                    "Citi Handlowy",
//                    1,
//                    null);
//
//            BankAccountEntity meejo = new BankAccountEntity(
//                    "LUBWPLPR",
//                    "PL43188010221244859866799600",
//                    "ING Bank Slaski",
//                    null,
//                    2);
//
//
//            bankAccountRepository.saveAll(List.of(youspan, twiyo, meejo));
        };
    }
}
