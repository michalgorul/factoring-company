package com.polsl.factoringcompany.currency;

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


    public CurrencyEntity getCurrency(Long id) throws IdNotFoundInDatabaseException {
        return this.currencyRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Currency", id));
    }


    public CurrencyEntity addCurrency(String name, String code) {
        validating(name, code);
        try {
            return currencyRepository.save(new CurrencyEntity(StringUtils.capitalize(name), code.toUpperCase()));
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    public void deleteCurrency(Long id) throws IdNotFoundInDatabaseException {
        try {
            this.currencyRepository.deleteById(id);
        } catch (RuntimeException ignored) {
            throw new IdNotFoundInDatabaseException("Currency", id);
        }
    }


    @Transactional
    public CurrencyEntity updateCurrency(Long id, String name, String code) {

        Optional<CurrencyEntity> currencyEntity = currencyRepository.findById(id);

        if (currencyEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Currency", id);

        try {
            validating(name, code);
            currencyEntity.get().setName(StringUtils.capitalize(name));
            currencyEntity.get().setCode(code.toUpperCase());
            return this.currencyRepository.save(currencyEntity.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    private void validating(String name, String code) {

        if (StringValidator.stringWithSpacesImproper(name,15))
            throw new ValueImproperException(name);

        if (StringValidator.stringWithoutSpacesImproper(code, 5))
            throw new ValueImproperException(code, "code");

        if (ifNameTaken(name))
            throw new NotUniqueException("Currency", "name", name);

        if (ifCodeTaken(code))
            throw new NotUniqueException("Currency", "code", code);
    }


    public boolean ifNameTaken(String name) {
        Optional<CurrencyEntity> foundByName = currencyRepository.findCurrencyEntityByName(
                StringUtils.capitalize(name));
        return foundByName.isPresent();
    }


    public boolean ifCodeTaken(String code) {
        Optional<CurrencyEntity> foundByName = currencyRepository.findCurrencyEntityByCode(code.toUpperCase());
        return foundByName.isPresent();
    }

}
