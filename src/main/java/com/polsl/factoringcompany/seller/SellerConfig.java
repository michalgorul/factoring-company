package com.polsl.factoringcompany.seller;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class SellerConfig {

    @Bean
    CommandLineRunner commandLineRunnerSeller(SellerRepository sellerRepository) {
        return args -> {
            SellerEntity elsie = new SellerEntity(
                    "Elsie",
                    "Newcomb",
                    "Wordware",
                    "Nigeria",
                    "Sauri",
                    "8627 Brentwood Park",
                    "564561",
                    "2462795182",
                    "12784200290184");

            SellerEntity barry = new SellerEntity(
                    "Barry",
                    "Comins",
                    "Leexo",
                    "Sierra Leone",
                    "Lago",
                    "98432 Southridge Alley",
                    "44665",
                    "3517198313",
                    "24214552118290");

            SellerEntity deirdre = new SellerEntity(
                    "Deirdre",
                    "Grinley",
                    "Yadel",
                    "Papua New Guinea",
                    "Kavieng",
                    "17162 Valley Edge Crossing",
                    null,
                    "2372800459",
                    "26765293944844");

            sellerRepository.saveAll(List.of(elsie, barry, deirdre));
        };
    }
}
