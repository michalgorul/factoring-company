package com.polsl.factoringcompany.currency;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

/**
 * @author Michal Goral
 */
@Service
@AllArgsConstructor
public class CurrencyService {

    private final CurrencyRepository currencyRepository;

    public List<CurrencyEntity> getCurrencies() {
        return currencyRepository.findAll();
    }

    public Optional<CurrencyEntity> getCurrency(Long id) {

        Optional<CurrencyEntity> currencyEntity = currencyRepository.findById(id);

        if (currencyEntity.isEmpty()) {
            throw new IllegalStateException("Currency with id " + id + " does not exist");
        }
        return currencyEntity;
    }

    public CurrencyEntity addCurrency(String name, String code) {

        ifFits(name, code);
        return currencyRepository.save(new CurrencyEntity(name, code.toUpperCase()));
    }

    public Optional<CurrencyEntity> deleteCurrency(Long id) {
        Optional<CurrencyEntity> currencyEntity = currencyRepository.findById(id);

        if (currencyEntity.isPresent()) {
            currencyRepository.deleteById(id);
            return currencyEntity;
        } else {
            throw new IllegalStateException("Currency with id " + id + " does not exist");
        }
    }

    @Transactional
    public Optional<CurrencyEntity> updateCurrency(Long id, String name, String code) {

        CurrencyEntity currencyEntity = currencyRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Currency with id " + id + " does not exist"));

        ifFits(name, code);
        currencyEntity.setName(name);
        currencyEntity.setCode(code.toUpperCase());

        return Optional.of(currencyEntity);
    }

    public void ifCodeOrNameTaken(String name, String code){
        Optional<CurrencyEntity> foundByName = currencyRepository.findCurrencyEntityByName(name);
        Optional<CurrencyEntity> foundByCode = currencyRepository.findCurrencyEntityByCode(code);
        if (foundByName.isPresent()) {
            throw new IllegalStateException("Currency with '" + name + "' name already exists");
        } else if (foundByCode.isPresent()) {
            throw new IllegalStateException("Currency with '" + code + "' code already exists");
        }
    }

    public void checkName(String name){
        if (name == null || name.length() <= 0 || name.length() > 15 || !name.chars().allMatch(Character::isLetter)) {
            throw new IllegalStateException("The name '" + name + "' is not appropriate");
        }
    }

    public void checkCode(String code){
        if (code == null || code.length() <= 0 || code.length() > 5 || !code.chars().allMatch(Character::isLetter)) {
            throw new IllegalStateException("The code '" + code + "' is not appropriate");
        }
    }

    public void ifFits(String name, String code){
        checkName(name);
        checkCode(code);
        ifCodeOrNameTaken(name, code);
    }
}
