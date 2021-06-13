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
        return this.companyRepository.findAll();
    }

    public CompanyEntity getCompany(Long id) {
        return this.companyRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Company", id));
    }

    public CompanyEntity addCompany(CompanyEntity companyEntity) {

        addValidate(companyEntity);

        try {
            return this.companyRepository.save(new CompanyEntity(
                    StringUtils.capitalize(companyEntity.getCompanyName()),
                    StringUtils.capitalize(companyEntity.getCountry()),
                    StringUtils.capitalize(companyEntity.getCity()),
                    StringUtils.capitalize(companyEntity.getStreet()),
                    companyEntity.getPostalCode(),
                    companyEntity.getNip(),
                    companyEntity.getRegon()));
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Company", "companyName", companyEntity.getCompanyName());
                }
            }
            throw new RuntimeException(e);
        }
    }


    public CompanyEntity updateCompany(Long id, CompanyEntity companyEntity) {

        Optional<CompanyEntity> companyEntityOptional = companyRepository.findById(id);

        if (companyEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);

        updateValidate(id, companyEntity);

        try {
            companyEntityOptional.get().setCompanyName(StringUtils.capitalize(companyEntity.getCompanyName()));
            companyEntityOptional.get().setCountry(StringUtils.capitalize(companyEntity.getCountry()));
            companyEntityOptional.get().setCity(StringUtils.capitalize(companyEntity.getCity()));
            companyEntityOptional.get().setStreet(StringUtils.capitalize(companyEntity.getStreet()));
            companyEntityOptional.get().setPostalCode(companyEntity.getPostalCode());
            companyEntityOptional.get().setNip(companyEntity.getNip());
            companyEntityOptional.get().setRegon(companyEntity.getRegon());
            return this.companyRepository.save(companyEntityOptional.get());
        } catch (DataIntegrityViolationException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Company", "companyName", companyEntity.getCompanyName());
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

    private void updateValidate(Long id, CompanyEntity companyEntity){
        if(ifNipTakenUpdating(id, companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if(ifRegonTakenUpdating(id, companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        if (ifNotDigitsOnly(companyEntity.getNip()))
            throw new ValueImproperException(companyEntity.getNip(), "NIP");

        else if (ifNotDigitsOnly(companyEntity.getRegon()))
            throw new ValueImproperException(companyEntity.getRegon(), "REGON");
    }

    private void addValidate(CompanyEntity companyEntity) {
        if (ifNipTakenAdding(companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if (ifRegonTakenAdding(companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        if (ifNotDigitsOnly(companyEntity.getNip()))
            throw new ValueImproperException(companyEntity.getNip(), "NIP");

        else if (ifNotDigitsOnly(companyEntity.getRegon()))
            throw new ValueImproperException(companyEntity.getRegon(), "REGON");
    }
}
