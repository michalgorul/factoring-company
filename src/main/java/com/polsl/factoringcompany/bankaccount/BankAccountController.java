package com.polsl.factoringcompany.bankaccount;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/bank-account")
public class BankAccountController {

    private final BankAccountService bankAccountService;

    @GetMapping
    public List<BankAccountEntity> getBankAccounts() {
        return this.bankAccountService.getBankAccounts();
    }


    @GetMapping(path = "/{id}")
    public BankAccountEntity getBankAccount(@PathVariable Long id) {
        return this.bankAccountService.getBankAccount(id);
    }

    @GetMapping(path = "/current")
    public BankAccountEntity getCurrentUserBankAccount() {
        return this.bankAccountService.getCurrentUserBankAccount();
    }


    @PostMapping
    public BankAccountEntity addBankAccount(@RequestBody BankAccountEntity bankAccountEntity) {
        return this.bankAccountService.addBankAccount(bankAccountEntity);
    }


    @PutMapping("/{id}")
    public BankAccountEntity updateBankAccount(@PathVariable Long id, @RequestBody BankAccountEntity bankAccountEntity) {
        return this.bankAccountService.updateBankAccount(id, bankAccountEntity);
    }


    @DeleteMapping("/{id}")
    public void deleteBankAccount(@PathVariable Long id) {
        this.bankAccountService.deleteBankAccount(id);
    }
}
