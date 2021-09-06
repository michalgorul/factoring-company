package com.polsl.factoringcompany.bankaccount;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class BankAccountService {

    private final BankAccountRepository bankAccountRepository;
    private final UserService userService;

    public List<BankAccountEntity> getBankAccounts() {
        return this.bankAccountRepository.findAll();
    }

    public BankAccountEntity getBankAccount(Long id) {
        return this.bankAccountRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Bank account", id));
    }

    public BankAccountEntity addBankAccount(BankAccountEntity bankAccountEntity) {

        addValidate(bankAccountEntity);

        try {
            return this.bankAccountRepository.save(new BankAccountEntity(
                    bankAccountEntity.getBankSwift().toUpperCase(),
                    bankAccountEntity.getBankAccountNumber(),
                    StringUtils.capitalize(bankAccountEntity.getBankName()),
                    bankAccountEntity.getSellerId(),
                    bankAccountEntity.getCompanyId()));

        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public BankAccountEntity updateBankAccount(Long id, BankAccountEntity bankAccountEntity) {

        Optional<BankAccountEntity> bankAccountEntityOptional = bankAccountRepository.findById(id);

        if (bankAccountEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Bank Account", id);

        updateValidate(id, bankAccountEntity);

        try {
            bankAccountEntityOptional.get().setBankSwift(bankAccountEntity.getBankSwift().toUpperCase());
            bankAccountEntityOptional.get().setBankAccountNumber(bankAccountEntity.getBankAccountNumber());
            bankAccountEntityOptional.get().setBankName(StringUtils.capitalize(bankAccountEntity.getBankName()));
            bankAccountEntityOptional.get().setSellerId(bankAccountEntity.getSellerId());
            bankAccountEntityOptional.get().setCompanyId(bankAccountEntity.getCompanyId());

            return this.bankAccountRepository.save(bankAccountEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteBankAccount(Long id) {
        try {
            this.bankAccountRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Bank Account", id);
        }
    }

    private void updateValidate(Long id, BankAccountEntity bankAccountEntity) {

        if (ifBankAccountNumberTakenUpdating(id, bankAccountEntity.getBankAccountNumber()))
            throw new NotUniqueException("Bank Account", "number", bankAccountEntity.getBankAccountNumber());

        nameValidator(bankAccountEntity);
    }


    private void addValidate(BankAccountEntity bankAccountEntity) {
        if (ifBankAccountNumberTakenAdding(bankAccountEntity.getBankAccountNumber()))
            throw new NotUniqueException("Bank Account", "number", bankAccountEntity.getBankAccountNumber());

        nameValidator(bankAccountEntity);
    }


    private boolean ifBankAccountNumberTakenAdding(String bankAccountNumber) {
        Optional<BankAccountEntity> bankAccountEntityOptional = bankAccountRepository
                .findByBankAccountNumber(bankAccountNumber);
        return bankAccountEntityOptional.isPresent();
    }

    private boolean ifBankAccountNumberTakenUpdating(Long id, String bankAccountNumber) {
        Optional<BankAccountEntity> bankAccountEntitybyBankAccountNumber = bankAccountRepository
                .findByBankAccountNumber(bankAccountNumber);
        Optional<BankAccountEntity> bankAccountEntitybyId = bankAccountRepository.findById(id);

        if (bankAccountEntitybyId.isEmpty())
            throw new IdNotFoundInDatabaseException("Bank Account", id);
        if (bankAccountEntitybyBankAccountNumber.isEmpty())
            return false;

        return !bankAccountEntitybyBankAccountNumber.get().getId().equals(bankAccountEntitybyId.get().getId());
    }

    private void nameValidator(BankAccountEntity bankAccountEntity) {
        if (StringValidator.stringWithSpacesImproper(bankAccountEntity.getBankName(), 16)) {
            throw new ValueImproperException(bankAccountEntity.getBankName());
        }

        else if (StringValidator.stringWithDigitsImproper(bankAccountEntity.getBankSwift(), 8)) {
            throw new ValueImproperException(bankAccountEntity.getBankSwift());
        }

        else if (StringValidator.stringWithDigitsImproper(bankAccountEntity.getBankAccountNumber(), 28)) {
            throw new ValueImproperException(bankAccountEntity.getBankAccountNumber());
        }

        else if (!StringValidator.isBankAccountNumberValid(bankAccountEntity.getBankAccountNumber())){
            throw new ValueImproperException((bankAccountEntity.getBankAccountNumber()));
        }

        else if (bankAccountEntity.getCompanyId() != null && bankAccountEntity.getSellerId() != null){
            throw new ValueImproperException(bankAccountEntity.getCompanyId() + " or " +
                    bankAccountEntity.getSellerId());
        }

    }

    public BankAccountEntity getCurrentUserBankAccount() {
        UserEntity currentUser = userService.getCurrentUser();
        return this.getBankAccount((long) currentUser.getCompanyId());
    }
}
