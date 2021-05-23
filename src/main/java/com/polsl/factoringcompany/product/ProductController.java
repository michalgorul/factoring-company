package com.polsl.factoringcompany.product;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/product")
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public List<ProductEntity> getProducts(){
        return productService.getProducts();
    }


    @GetMapping(path = "/{id}")
    public ResponseEntity<ProductEntity> getProduct(@PathVariable Long id){
        Optional<ProductEntity> response = productService.getProduct(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @PostMapping
    public ProductEntity addProduct(@RequestParam String name, @RequestParam String pkwiu,
                                    @RequestParam String measureUnit) {
        return productService.addProduct(name, pkwiu, measureUnit);
    }


    @PutMapping("/{id}")
    public ResponseEntity<ProductEntity> updateProduct(@PathVariable Long id, @RequestParam String name,
                                                       @RequestParam String pkwiu, @RequestParam String measureUnit) {
        Optional<ProductEntity> response = productService.updateProduct(id, name, pkwiu, measureUnit);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<ProductEntity> deleteProduct(@PathVariable Long id) {
        Optional<ProductEntity> response = productService.deleteProduct(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }
}
