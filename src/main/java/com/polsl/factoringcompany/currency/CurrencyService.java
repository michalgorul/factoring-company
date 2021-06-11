package com.polsl.factoringcompany.currency;

import com.google.common.base.Throwables;
import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.sql.SQLException;
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
            Throwable rootCause = Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Currency", "code", code.toUpperCase());
                }
            }
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
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Currency", "code", code);
                }
            }
            throw new RuntimeException(e);
        }
    }

    private void validating(String name, String code) {
        if (nameImproper(name))
            throw new ValueImproperException(name);

        if (codeImproper(code))
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

    // TODO: 25.05.2021 I CAN ADD A NAME VALIDATOR CLASS OR STH
    private boolean codeImproper(String code) {
        return code == null || code.length() <= 0 || code.length() > 5 || !code.chars().allMatch(Character::isLetter);
    }

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
