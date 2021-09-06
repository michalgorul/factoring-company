package com.polsl.factoringcompany.company;


import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.NotUniqueException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserRepository;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CompanyService {

    private final CompanyRepository companyRepository;
    private UserRepository userRepository;
    private UserService userService;

    public List<CompanyEntity> getCompanies() {
        return this.companyRepository.findAll();
    }

    public CompanyEntity getCompany(Long id) {
        return this.companyRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Company", id));
    }

//    public CompanyEntity addCompany(CompanyEntity companyEntity) {
//
//        addValidate(companyEntity);
//
//        try {
//            return this.companyRepository.save(new CompanyEntity(
//                    StringUtils.capitalize(companyEntity.getCompanyName()),
//                    StringUtils.capitalize(companyEntity.getCountry()),
//                    StringUtils.capitalize(companyEntity.getCity()),
//                    StringUtils.capitalize(companyEntity.getStreet()),
//                    companyEntity.getPostalCode(),
//                    companyEntity.getNip(),
//                    companyEntity.getRegon()));
//        } catch (RuntimeException e) {
//            throw new RuntimeException(e);
//        }
//    }

//    public CompanyEntity updateCompany(Long id, CompanyEntity companyEntity) {
//
//        Optional<CompanyEntity> companyEntityOptional = companyRepository.findById(id);
//
//        if (companyEntityOptional.isEmpty())
//            throw new IdNotFoundInDatabaseException("Company", id);
//
//        updateValidate(id, companyEntity);
//
//        try {
//            companyEntityOptional.get().setCompanyName(StringUtils.capitalize(companyEntity.getCompanyName()));
//            companyEntityOptional.get().setCountry(StringUtils.capitalize(companyEntity.getCountry()));
//            companyEntityOptional.get().setCity(StringUtils.capitalize(companyEntity.getCity()));
//            companyEntityOptional.get().setStreet(StringUtils.capitalize(companyEntity.getStreet()));
//            companyEntityOptional.get().setPostalCode(companyEntity.getPostalCode());
//            companyEntityOptional.get().setNip(companyEntity.getNip());
//            companyEntityOptional.get().setRegon(companyEntity.getRegon());
//            return this.companyRepository.save(companyEntityOptional.get());
//        } catch (RuntimeException e) {
//            throw new RuntimeException(e);
//        }
//    }

    public void deleteCompany(Long id) {
        try {
            this.companyRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Company", id);
        }
    }

    private boolean ifNipTakenAdding(String nip) {
        Optional<CompanyEntity> companyEntity = companyRepository.findCompanyEntityByNip(nip);
        return companyEntity.isPresent();
    }

    private boolean ifRegonTakenAdding(String regon) {
        Optional<CompanyEntity> companyEntity = companyRepository.findCompanyEntityByRegon(regon);
        return companyEntity.isPresent();
    }

    private boolean ifNipTakenUpdating(Long id, String nip) {
        Optional<CompanyEntity> companyEntityByNip = companyRepository.findCompanyEntityByNip(nip);
        Optional<CompanyEntity> companyEntityById = companyRepository.findById(id);

        if (companyEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);
        if (companyEntityByNip.isEmpty())
            return false;

        return !companyEntityByNip.get().getId().equals(companyEntityById.get().getId());
    }

    private boolean ifRegonTakenUpdating(Long id, String regon) {
        Optional<CompanyEntity> companyEntityByRegon = companyRepository.findCompanyEntityByRegon(regon);
        Optional<CompanyEntity> companyEntityById = companyRepository.findById(id);

        if (companyEntityById.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", id);
        if (companyEntityByRegon.isEmpty())
            return false;

        return !companyEntityByRegon.get().getId().equals(companyEntityById.get().getId());
    }

    private void updateValidate(Long id, CompanyRequestDto companyEntity) {
        if (ifNipTakenUpdating(id, companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if (ifRegonTakenUpdating(id, companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        nameValidator(companyEntity);
    }

    private void addValidate(CompanyRequestDto companyEntity) {
        if (ifNipTakenAdding(companyEntity.getNip()))
            throw new NotUniqueException("Company", "NIP", companyEntity.getNip());

        else if (ifRegonTakenAdding(companyEntity.getRegon()))
            throw new NotUniqueException("Company", "REGON", companyEntity.getRegon());

        nameValidator(companyEntity);
    }

    private void nameValidator(CompanyRequestDto companyEntity) {
        if (StringValidator.stringWithSpacesImproper(companyEntity.getCompanyName(), 50)) {
            throw new ValueImproperException(companyEntity.getCompanyName());
        }

        else if (StringValidator.stringWithSpacesImproper(companyEntity.getCountry(), 50)) {
            throw new ValueImproperException(companyEntity.getCountry());
        }

        else if (StringValidator.stringWithSpacesImproper(companyEntity.getCity(), 50)) {
            throw new ValueImproperException(companyEntity.getCity());
        }

        else if (StringValidator.stringWithSpacesImproper(companyEntity.getStreet(), 50)) {
            throw new ValueImproperException(companyEntity.getStreet());
        }

        else if (StringValidator.stringWithDigitsImproper(companyEntity.getPostalCode(), 15)) {
            throw new ValueImproperException(companyEntity.getPostalCode());
        }

        else if (StringValidator.ifNotDigitsOnly(companyEntity.getNip()))
            throw new ValueImproperException(companyEntity.getNip(), "NIP");

        else if (StringValidator.ifNotDigitsOnly(companyEntity.getRegon()))
            throw new ValueImproperException(companyEntity.getRegon(), "REGON");
    }

    public CompanyEntity getCurrentUserCompany() {

        Long id = 0L;
        String currentUserName = SecurityContextHolder.getContext().getAuthentication().getName();
        if(userRepository.findByUsername(currentUserName).isPresent()){
            id = userRepository.findByUsername(currentUserName).get().getId();
        }

        Optional<UserEntity> userEntityOptional = userRepository.findById(id);

        if (userEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("User", id);

        return getCompany((long) userEntityOptional.get().getCompanyId());

    }

    public CompanyEntity updateCurrentUserCompany(CompanyRequestDto companyRequestDto){
        UserEntity currentUser = userService.getCurrentUser();
        Optional<CompanyEntity> companyEntityOptional = companyRepository.findById((long) currentUser.getCompanyId());

        if (companyEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Company", 0L);

        updateValidate(companyEntityOptional.get().getId(), companyRequestDto);

        try {
            companyEntityOptional.get().setCompanyName(StringUtils.capitalize(companyRequestDto.getCompanyName()));
            companyEntityOptional.get().setCountry(StringUtils.capitalize(companyRequestDto.getCountry()));
            companyEntityOptional.get().setCity(StringUtils.capitalize(companyRequestDto.getCity()));
            companyEntityOptional.get().setStreet(StringUtils.capitalize(companyRequestDto.getStreet()));
            companyEntityOptional.get().setPostalCode(companyRequestDto.getPostalCode());
            companyEntityOptional.get().setNip(companyRequestDto.getNip());
            companyEntityOptional.get().setRegon(companyRequestDto.getRegon());
            return this.companyRepository.save(companyEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }
}
