package com.polsl.factoringcompany.currency;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@CrossOrigin
@AllArgsConstructor
@RestController
@RequestMapping(path = "/currency")
public class CurrencyController {

    private final CurrencyService currencyService;

    @GetMapping
    public List<CurrencyEntity> getCurrencies() {
        return currencyService.getCurrencies();
    }


    @GetMapping(path = "/{id}")
    public CurrencyEntity getCurrency(@PathVariable Long id) {
        try {
            return this.currencyService.getCurrency(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }


    @PostMapping
    public CurrencyEntity addCurrency(@RequestParam() String name, @RequestParam() String code) {
        try {
            return this.currencyService.addCurrency(name, code);
//        } catch (ItemExistsInDatabaseException e) {
//            System.out.println(e.getMessage());
//            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @PutMapping("/{id}")
    public CurrencyEntity updateCurrency(@PathVariable Long id, @RequestParam String name, @RequestParam String code) {
        try {
            return this.currencyService.updateCurrency(id, name, code);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
//        } catch (ItemExistsInDatabaseException e) {
//            System.out.println(e.getMessage());
//            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @DeleteMapping("/{id}")
    public void deleteCurrency(@PathVariable Long id) {
        try {
            this.currencyService.deleteCurrency(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }
}

