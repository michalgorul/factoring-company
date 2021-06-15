package com.polsl.factoringcompany.seller;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.ValueImproperException;
import com.polsl.factoringcompany.stringvalidation.StringValidator;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class SellerService {

    private final SellerRepository sellerRepository;

    public List<SellerEntity> getSellers() {
        return this.sellerRepository.findAll();
    }


    public SellerEntity getSeller(Long id) {
        return this.sellerRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Seller", id));
    }


    public SellerEntity addSeller(SellerEntity sellerEntity) {

        nameValidator(sellerEntity);

        try {
            return this.sellerRepository.save(new SellerEntity(
                    StringUtils.capitalize(sellerEntity.getFirstName()),
                    StringUtils.capitalize(sellerEntity.getLastName()),
                    StringUtils.capitalize(sellerEntity.getCompanyName()),
                    StringUtils.capitalize(sellerEntity.getCountry()),
                    StringUtils.capitalize(sellerEntity.getCity()),
                    StringUtils.capitalize(sellerEntity.getStreet()),
                    sellerEntity.getPostalCode(),
                    sellerEntity.getNip(),
                    sellerEntity.getRegon()));
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    public SellerEntity updateSeller(Long id, SellerEntity sellerEntity) {

        Optional<SellerEntity> sellerEntityOptional = sellerRepository.findById(id);

        if (sellerEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Seller", id);

        nameValidator(sellerEntity);

        try {
            sellerEntityOptional.get().setFirstName(StringUtils.capitalize(sellerEntity.getFirstName()));
            sellerEntityOptional.get().setLastName(StringUtils.capitalize(sellerEntity.getLastName()));
            sellerEntityOptional.get().setCompanyName(StringUtils.capitalize(sellerEntity.getCompanyName()));
            sellerEntityOptional.get().setCountry(StringUtils.capitalize(sellerEntity.getCountry()));
            sellerEntityOptional.get().setCity(StringUtils.capitalize(sellerEntity.getCity()));
            sellerEntityOptional.get().setStreet(StringUtils.capitalize(sellerEntity.getStreet()));
            sellerEntityOptional.get().setPostalCode(sellerEntity.getPostalCode());
            sellerEntityOptional.get().setNip(sellerEntity.getNip());
            sellerEntityOptional.get().setRegon(sellerEntity.getRegon());

            return this.sellerRepository.save(sellerEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteSeller(Long id) {
        try {
            this.sellerRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Seller", id);
        }
    }




    private void nameValidator(SellerEntity sellerEntity) {
        if (StringValidator.stringWithSpacesImproper(sellerEntity.getFirstName(), 50)) {
            throw new ValueImproperException(sellerEntity.getFirstName());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getLastName(), 50)) {
            throw new ValueImproperException(sellerEntity.getLastName());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getCompanyName(), 50)) {
            throw new ValueImproperException(sellerEntity.getCompanyName());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getCountry(), 50)) {
            throw new ValueImproperException(sellerEntity.getCountry());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getCity(), 50)) {
            throw new ValueImproperException(sellerEntity.getCity());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getStreet(), 50)) {
            throw new ValueImproperException(sellerEntity.getStreet());
        }

        else if (StringValidator.stringWithSpacesImproper(sellerEntity.getPostalCode(), 15)) {
            throw new ValueImproperException(sellerEntity.getPostalCode());
        }

        else if (StringValidator.ifNotDigitsOnly(sellerEntity.getNip()))
            throw new ValueImproperException(sellerEntity.getNip(), "NIP");

        else if (StringValidator.ifNotDigitsOnly(sellerEntity.getRegon()))
            throw new ValueImproperException(sellerEntity.getRegon(), "REGON");
    }

}
