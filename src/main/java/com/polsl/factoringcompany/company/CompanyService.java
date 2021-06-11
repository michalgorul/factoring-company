package com.polsl.factoringcompany.company;


import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CompanyService {

    private final CompanyRepository companyRepository;

    public List<CompanyEntity> getCompanies() {
        return companyRepository.findAll();
    }

    public CompanyEntity getCompany(Long id) {
        return this.companyRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Company", id));
    }

    public CompanyEntity addCompany(String companyName, String country, String city, String street,
                                    String postalCode, String nip, String regon) {

        if(ifNipTakenAdding(nip)){
            throw new NotUniqueException("Company", "NIP", nip);
        }

        if(ifRegonTakenAdding(regon)){
            throw new NotUniqueException("Company", "REGON", regon);
        }

        if (ifNotDigitsOnly(nip))
            throw new ValueImproperException(nip, "NIP");

        if (ifNotDigitsOnly(regon))
            throw new ValueImproperException(regon, "REGON");

        try {
            return this.companyRepository.save(new CompanyEntity(
                    StringUtils.capitalize(companyName),
                    StringUtils.capitalize(country),
                    StringUtils.capitalize(city),
                    StringUtils.capitalize(street),
                    postalCode, nip, regon));
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Company", "companyName", companyName);
                }
            }
            throw new RuntimeException(e);
        }
    }


    public CompanyEntity updateCompany(Long id, String companyName, String country, String city, String street,
                                       String postalCode, String nip, String regon) {

        Optional<CompanyEntity> companyEntity = companyRepository.findById(id);

        if (companyEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);

        if(ifNipTakenUpdating(id, nip)){
            throw new NotUniqueException("Company", "NIP", nip);
        }

        if(ifRegonTakenUpdating(id, regon)){
            throw new NotUniqueException("Company", "REGON", regon);
        }

        if (ifNotDigitsOnly(nip))
            throw new ValueImproperException(nip, "NIP");

        if (ifNotDigitsOnly(regon))
            throw new ValueImproperException(regon, "REGON");

        try {
            companyEntity.get().setCompanyName(StringUtils.capitalize(companyName));
            companyEntity.get().setCountry(StringUtils.capitalize(country));
            companyEntity.get().setCity(StringUtils.capitalize(city));
            companyEntity.get().setStreet(StringUtils.capitalize(street));
            companyEntity.get().setPostalCode(postalCode);
            companyEntity.get().setNip(nip);
            companyEntity.get().setRegon(regon);
            return this.companyRepository.save(companyEntity.get());
        } catch (DataIntegrityViolationException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Company", "companyName", companyName);
                }
            }
            throw new RuntimeException(e);
        }
    }

    public void deleteCompany(Long id) {
        try {
            this.companyRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Company", id);
        }
    }

    public boolean ifNipTakenAdding(String nip) {
        Optional<CompanyEntity> companyEntity = companyRepository.findCompanyEntityByNip(nip);
        return companyEntity.isPresent();
    }

    public boolean ifRegonTakenAdding(String regon) {
        Optional<CompanyEntity> companyEntity = companyRepository.findCompanyEntityByRegon(regon);
        return companyEntity.isPresent();
    }

    public boolean ifNipTakenUpdating(Long id, String nip) {
        Optional<CompanyEntity> companyEntityByNip = companyRepository.findCompanyEntityByNip(nip);
        Optional<CompanyEntity> companyEntityById = companyRepository.findById(id);

        if (companyEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);
        if(companyEntityByNip.isEmpty())
            return false;

        return !companyEntityByNip.get().getId().equals(companyEntityById.get().getId());
    }

    public boolean ifRegonTakenUpdating(Long id, String regon) {
        Optional<CompanyEntity> companyEntityByRegon = companyRepository.findCompanyEntityByRegon(regon);
        Optional<CompanyEntity> companyEntityById = companyRepository.findById(id);

        if (companyEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);
        if(companyEntityByRegon.isEmpty())
            return false;

        return !companyEntityByRegon.get().getId().equals(companyEntityById.get().getId());
    }

    public boolean ifNotDigitsOnly(String checkingString){
        return !checkingString.chars().allMatch(Character::isDigit);
    }
}
