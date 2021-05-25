package com.polsl.factoringcompany.product;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.ItemExistsInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

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
    public ProductEntity getProduct(@PathVariable Long id){
        try {
            return this.productService.getProduct(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }


    @PostMapping
    public ProductEntity addProduct(@RequestParam String name, @RequestParam String pkwiu,
                                    @RequestParam String measureUnit) {
        try {
            return this.productService.addProduct(name, pkwiu, measureUnit);
        } catch (ItemExistsInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @PutMapping("/{id}")
    public ProductEntity updateProduct(@PathVariable Long id, @RequestParam String name,
                                       @RequestParam String pkwiu, @RequestParam String measureUnit) {
        try {
            return this.productService.updateProduct(id, name, pkwiu, measureUnit);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
        } catch (ItemExistsInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @DeleteMapping("/{id}")
    public void deleteProduct(@PathVariable Long id) {
        try {
            this.productService.deleteProduct(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }
}
