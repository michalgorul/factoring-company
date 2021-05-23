package com.polsl.factoringcompany.paymenttype;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/paymenttype")
public class PaymentTypeController {

    private final PaymentTypeService paymentTypeService;

    @GetMapping
    public List<PaymentTypeEntity> getPaymentTypes(){
        return paymentTypeService.getSPaymentTypes();
    }


    @GetMapping(path = "/{id}")
    public ResponseEntity<PaymentTypeEntity> getPaymentType(@PathVariable Long id){
        Optional<PaymentTypeEntity> response = paymentTypeService.getPaymentType(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @PostMapping
    public PaymentTypeEntity addPaymentType(@RequestParam() String name) {
        return paymentTypeService.addPaymentType(name);
    }


    @PutMapping("/{id}")
    public ResponseEntity<PaymentTypeEntity> updatePaymentType(@PathVariable Long id, @RequestParam String name) {
        Optional<PaymentTypeEntity> response = paymentTypeService.updatePaymentType(id, name);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<PaymentTypeEntity> deletePaymentType(@PathVariable Long id) {
        Optional<PaymentTypeEntity> response = paymentTypeService.deletePaymentType(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }
}
