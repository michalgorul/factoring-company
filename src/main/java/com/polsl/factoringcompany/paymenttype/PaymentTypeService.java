package com.polsl.factoringcompany.paymenttype;

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

    public List<PaymentTypeEntity> getSPaymentTypes() {
        return paymentTypeRepository.findAll();
    }

    public Optional<PaymentTypeEntity> getPaymentType(Long id) {

        Optional<PaymentTypeEntity> paymentTypeEntity = paymentTypeRepository.findById(id);

        if (paymentTypeEntity.isEmpty()) {
            throw new IllegalStateException("Payment type with id " + id + " does not exist");
        }
        return paymentTypeEntity;
    }

    public PaymentTypeEntity addPaymentType(String name) {

        ifFits(name);
        return paymentTypeRepository.save(new PaymentTypeEntity(StringUtils.capitalize(name)));
    }

    public Optional<PaymentTypeEntity> deletePaymentType(Long id) {
        Optional<PaymentTypeEntity> paymentTypeEntity = paymentTypeRepository.findById(id);

        if (paymentTypeEntity.isPresent()) {
            paymentTypeRepository.deleteById(id);
            return paymentTypeEntity;
        } else {
            throw new IllegalStateException("Payment type with id " + id + " does not exist");
        }
    }

    @Transactional
    public Optional<PaymentTypeEntity> updatePaymentType(Long id, String name) {

        PaymentTypeEntity paymentTypeEntity = paymentTypeRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Payment type with id " + id + " does not exist"));

        ifFits(name);
        paymentTypeEntity.setName(StringUtils.capitalize(name));

        return Optional.of(paymentTypeEntity);
    }

    public void ifNameTaken(String name) {
        Optional<PaymentTypeEntity> foundByName = paymentTypeRepository.findPaymentTypeEntityByName(
                StringUtils.capitalize(name));

        if (foundByName.isPresent()) {
            throw new IllegalStateException("Payment type with '" + name + "' name already exists");
        }
    }


    // TODO: 23.05.2021 SPACES SHOULD BE ACCEPTABLE :)
    public void checkName(String name) {
        if (name == null || name.length() <= 0 || name.length() > 25 || !name.chars().allMatch(Character::isLetter)) {
            throw new IllegalStateException("The name '" + name + "' is not appropriate");
        }
    }

    public void ifFits(String name) {
        checkName(name);
        ifNameTaken(name);
    }
}
