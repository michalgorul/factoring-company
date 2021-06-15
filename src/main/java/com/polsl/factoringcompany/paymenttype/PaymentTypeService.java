package com.polsl.factoringcompany.paymenttype;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
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
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Payment type: ", id ));
    }


    public PaymentTypeEntity addPaymentType(String name) {

        nameValidation(name);

        try {
            return this.paymentTypeRepository.save(new PaymentTypeEntity(StringUtils.capitalize(name)));
        } catch (RuntimeException e) {
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

        nameValidation(name);

        try {
            paymentTypeEntity.get().setName(StringUtils.capitalize(name));
            return this.paymentTypeRepository.save(paymentTypeEntity.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }

    }


    private void nameValidation(String name) {
        if (StringValidator.stringWithSpacesImproper(name, 25))
            throw new ValueImproperException(name);

        if (ifNameTaken(name)) {
            throw new NotUniqueException("Payment type", "name", name);
        }
    }


    public boolean ifNameTaken(String name) {
        Optional<PaymentTypeEntity> paymentTypeEntity = paymentTypeRepository.findPaymentTypeEntityByName(
                StringUtils.capitalize(name));
        return paymentTypeEntity.isPresent();
    }
}
