package com.polsl.factoringcompany.product;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class ProductConfig {

    @Bean
    CommandLineRunner commandLineRunnerProduct(ProductRepository productRepository) {
        return args -> {
            ProductEntity plate = new ProductEntity("Plate Foam Laminated 9in Blk","26.30.40.0","kilowatt");
            ProductEntity whmis = new ProductEntity("Whmis - Spray Bottle Trigger","10.11.99.0","galons");
            ProductEntity fib = new ProductEntity("Fib N9 - Prague Powder","13.95.10.0","number");
            ProductEntity pepper = new ProductEntity("Pepper - Sorrano","26.30.40.0","meters");
            ProductEntity chicken = new ProductEntity("Chicken - Breast","01.16.19.0","litres");
            ProductEntity beer = new ProductEntity("Beer - Rickards Red","19.20.23.0","grams");


            productRepository.saveAll(List.of(plate, whmis, fib, pepper, chicken, beer));
        };
    }
}
