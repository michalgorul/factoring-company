package com.polsl.factoringcompany.transaction;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/transaction")
public class TransactionController {

    private final TransactionService transactionService;

    @GetMapping
    public List<TransactionEntity> getTransactions() {
        return this.transactionService.getTransactions();
    }


    @GetMapping(path = "/{id}")
    public TransactionEntity getTransaction(@PathVariable Long id) {
        return this.transactionService.getTransaction(id);
    }


    @PostMapping
    public TransactionEntity addTransaction(@RequestBody TransactionEntity transactionEntity) {
        return this.transactionService.addTransaction(transactionEntity);
    }


    @PutMapping("/{id}")
    public TransactionEntity updateTransaction(@PathVariable Long id, @RequestBody TransactionEntity transactionEntity) {
        return this.transactionService.updateTransaction(id, transactionEntity);
    }


    @DeleteMapping("/{id}")
    public void deleteTransaction(@PathVariable Long id) {
        this.transactionService.deleteTransaction(id);
    }
}
