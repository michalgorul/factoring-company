package com.polsl.factoringcompany.transaction;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class TransactionService {

    private final TransactionRepository transactionRepository;

    public List<TransactionEntity> getTransactions() {
        return this.transactionRepository.findAll();
    }

    public TransactionEntity getTransaction(Long id) {
        return this.transactionRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Transaction", id));
    }


    public void deleteTransaction(Long id) {
        try {
            this.transactionRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Transaction", id);
        }
    }


    public TransactionEntity addTransaction(TransactionEntity transactionEntity) {
        try {
            return this.transactionRepository.save(new TransactionEntity(transactionEntity));

        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public TransactionEntity updateTransaction(Long id, TransactionEntity transactionEntity) {
        Optional<TransactionEntity> transactionEntityOptional = transactionRepository.findById(id);

        if (transactionEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Transaction", id);

        try {
            transactionEntityOptional.get().setTransactionDate(transactionEntityOptional.get().getTransactionDate());
            transactionEntityOptional.get().setValue(transactionEntityOptional.get().getValue());
            transactionEntityOptional.get().setStatusId(transactionEntityOptional.get().getStatusId());
            transactionEntityOptional.get().setCustomerId(transactionEntityOptional.get().getCustomerId());
            transactionEntityOptional.get().setInvoiceId(transactionEntityOptional.get().getInvoiceId());
            transactionEntityOptional.get().setCurrencyId(transactionEntityOptional.get().getCurrencyId());

            return this.transactionRepository.save(transactionEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }
}