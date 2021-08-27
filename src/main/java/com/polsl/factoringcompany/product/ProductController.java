package com.polsl.factoringcompany.product;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/product")
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public List<ProductEntity> getProducts() {
        return productService.getProducts();
    }


    @GetMapping(path = "/{id}")
    public ProductEntity getProduct(@PathVariable Long id) {
        return this.productService.getProduct(id);
    }


    @PostMapping
    public ProductEntity addProduct(@RequestParam String name, @RequestParam String pkwiu,
                                    @RequestParam String measureUnit) {
        return this.productService.addProduct(name, pkwiu, measureUnit);
    }

    @PutMapping("/{id}")
    public ProductEntity updateProduct(@PathVariable Long id, @RequestParam String name,
                                       @RequestParam String pkwiu, @RequestParam String measureUnit) {
        return this.productService.updateProduct(id, name, pkwiu, measureUnit);
    }


    @DeleteMapping("/{id}")
    public void deleteProduct(@PathVariable Long id) {
        this.productService.deleteProduct(id);
    }
}
