package com.polsl.factoringcompany.currency;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/currency")
public class CurrencyController {

    private final CurrencyService currencyService;

    @GetMapping
    public List<CurrencyEntity> getCurrencies(){
        return currencyService.getCurrencies();
    }


    @GetMapping(path = "/{id}")
    public ResponseEntity<CurrencyEntity> getCurrency(@PathVariable Long id){
        Optional<CurrencyEntity> response = currencyService.getCurrency(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @PostMapping
    public CurrencyEntity addCurrency(@RequestParam() String name, @RequestParam() String code) {
        return currencyService.addCurrency(name, code);
    }


    @PutMapping("/{id}")
    public ResponseEntity<CurrencyEntity> updateCurrency(@PathVariable Long id,
                                                         @RequestParam(required = false) String name,
                                                         @RequestParam(required = false) String code) {
        Optional<CurrencyEntity> response = currencyService.updateCurrency(id, name, code);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<CurrencyEntity> deleteCurrency(@PathVariable Long id) {
        Optional<CurrencyEntity> response = currencyService.deleteCurrency(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }
}

