package com.polsl.factoringcompany.company;


import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
        } catch (RuntimeException e) {
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
        if (companyEntityByNip.isEmpty())
            return false;

        return !companyEntityByNip.get().getId().equals(companyEntityById.get().getId());
    }

    public boolean ifRegonTakenUpdating(Long id, String regon) {
        Optional<CompanyEntity> companyEntityByRegon = companyRepository.findCompanyEntityByRegon(regon);
        Optional<CompanyEntity> companyEntityById = companyRepository.findById(id);

        if (companyEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);
        if (companyEntityByRegon.isEmpty())
            return false;

        return !companyEntityByRegon.get().getId().equals(companyEntityById.get().getId());
    }

    private void updateValidate(Long id, CompanyEntity companyEntity) {
        if (ifNipTakenUpdating(id, companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if (ifRegonTakenUpdating(id, companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        if (StringValidator.ifNotDigitsOnly(companyEntity.getNip()))
            throw new ValueImproperException(companyEntity.getNip(), "NIP");

        else if (StringValidator.ifNotDigitsOnly(companyEntity.getRegon()))
            throw new ValueImproperException(companyEntity.getRegon(), "REGON");

        nameValidator(companyEntity);
    }

    private void addValidate(CompanyEntity companyEntity) {
        if (ifNipTakenAdding(companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if (ifRegonTakenAdding(companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        if (StringValidator.ifNotDigitsOnly(companyEntity.getNip()))
            throw new ValueImproperException(companyEntity.getNip(), "NIP");

        else if (StringValidator.ifNotDigitsOnly(companyEntity.getRegon()))
            throw new ValueImproperException(companyEntity.getRegon(), "REGON");

        nameValidator(companyEntity);
    }

    private void nameValidator(CompanyEntity companyEntity) {
        if (StringValidator.stringWithSpacesImproper(companyEntity.getCompanyName(), 50)) {
            throw new ValueImproperException(companyEntity.getCompanyName());
        }

        if (StringValidator.stringWithSpacesImproper(companyEntity.getCountry(), 50)) {
            throw new ValueImproperException(companyEntity.getCountry());
        }

        if (StringValidator.stringWithSpacesImproper(companyEntity.getCity(), 50)) {
            throw new ValueImproperException(companyEntity.getCity());
        }

        if (StringValidator.stringWithSpacesImproper(companyEntity.getStreet(), 50)) {
            throw new ValueImproperException(companyEntity.getStreet());
        }

        if (StringValidator.stringWithSpacesImproper(companyEntity.getPostalCode(), 15)) {
            throw new ValueImproperException(companyEntity.getPostalCode());
        }
    }
}
