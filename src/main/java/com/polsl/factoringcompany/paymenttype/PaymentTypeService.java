package com.polsl.factoringcompany.paymenttype;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NameImproperException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class PaymentTypeService {

    private final PaymentTypeRepository paymentTypeRepository;

    public List<PaymentTypeEntity> getPaymentTypes() {
        return paymentTypeRepository.findAll();
    }

    public PaymentTypeEntity getPaymentType(Long id) throws IdNotFoundInDatabaseException {
        return this.paymentTypeRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Payment type:", id ));
    }

    public PaymentTypeEntity addPaymentType(String name) {

        if (nameImproper(name))
            throw new NameImproperException(name);
        try {
            return this.paymentTypeRepository.save(new PaymentTypeEntity(StringUtils.capitalize(name)));
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Payment type", "name", name);
                }
            }
            throw new RuntimeException(e);
        }
    }

    public void deletePaymentType(Long id) throws IdNotFoundInDatabaseException {
        try {
            this.paymentTypeRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Payment type", id);
        }
    }

    @Transactional
    public PaymentTypeEntity updatePaymentType(Long id, String name) {

        Optional<PaymentTypeEntity> paymentTypeEntity = paymentTypeRepository.findById(id);

        if (paymentTypeEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Payment type", id);

        if (nameImproper(name))
            throw new NameImproperException(name);

        if(ifNameTaken(name)){
            throw new NotUniqueException("Payment type", "name", name);
        }

        try {
            paymentTypeEntity.get().setName(StringUtils.capitalize(name));
            return this.paymentTypeRepository.save(paymentTypeEntity.get());
        } catch (DataIntegrityViolationException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Payment type", "name", name);
                }
            }
            throw new RuntimeException(e);
        }

    }

    public boolean ifNameTaken(String name) {
        Optional<PaymentTypeEntity> paymentTypeEntity = paymentTypeRepository.findPaymentTypeEntityByName(
                StringUtils.capitalize(name));
        return paymentTypeEntity.isPresent();
    }

    // TODO: 25.05.2021 I CAN ADD A NAME VALIDATOR CLASS OR STH
    public boolean nameImproper(String name) {
        return name == null || name.length() <= 0 || name.length() > 25 || !onlyLettersSpaces(name);
    }


    public static boolean onlyLettersSpaces(String s) {
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (Character.isLetter(ch) || ch == ' ') {
                continue;
            }
            return false;
        }
        return s.charAt(s.length() - 1) != ' ';
    }
}
