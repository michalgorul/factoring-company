package com.polsl.factoringcompany.company;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class CompanyConfig {

    @Bean
    CommandLineRunner commandLineRunnerCompany(CompanyRepository companyRepository) {
        return args -> {
            CompanyEntity youspan = new CompanyEntity(
                    "Youspan",
                    "Japan",
                    "Numazu",
                    "56242 Buena Vista Hill",
                    "419-0125",
                    "6525599666",
                    "06860486056493");

            CompanyEntity twiyo = new CompanyEntity(
                    "Twiyo",
                    "Indonesia",
                    "Cisaat",
                    "8439 North Pass",
                    null,
                    "1389431167",
                    "16804632212896");

            CompanyEntity meejo = new CompanyEntity(
                    "Meejo",
                    "United States",
                    "Des Moines",
                    "87 Goodland Junction",
                    "50981",
                    "6090238606",
                    "20435640895460");


            companyRepository.saveAll(List.of(youspan, twiyo, meejo));
        };
    }
}
