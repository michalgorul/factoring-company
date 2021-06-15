package com.polsl.factoringcompany.product;

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
import java.util.regex.Pattern;

@Service
@AllArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;


    public List<ProductEntity> getProducts() {
        return productRepository.findAll();
    }


    public ProductEntity getProduct(Long id) {
        return this.productRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Product", id));
    }


    public ProductEntity addProduct(String name, String pkwiu, String measureUnit) {

        validating(name, pkwiu, measureUnit);

        try {
            return productRepository.save(new ProductEntity(StringUtils.capitalize(name), pkwiu, measureUnit));
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    public void deleteProduct(Long id) {
        try {
            this.productRepository.deleteById(id);
        } catch (RuntimeException ignored) {
            throw new IdNotFoundInDatabaseException("Product", id);
        }
    }


    @Transactional
    public ProductEntity updateProduct(Long id, String name, String pkwiu, String measureUnit) {

        Optional<ProductEntity> productEntity = productRepository.findById(id);

        if (productEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Product", id);

        validating(name, pkwiu, measureUnit);

        try {
            productEntity.get().setName(StringUtils.capitalize(name));
            productEntity.get().setMeasureUnit(measureUnit);
            productEntity.get().setPkwiu(pkwiu);
            return this.productRepository.save(productEntity.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }


    private void validating(String name, String pkwiu, String measureUnit) {

        if (StringValidator.stringWithSpacesImproper(name, 50))
            throw new ValueImproperException(name);

        if (pkwiuImproper(pkwiu))
            throw new ValueImproperException(pkwiu, "PKWIU");

        if (StringValidator.stringWithSpacesImproper(measureUnit, 8))
            throw new ValueImproperException(measureUnit, "measure unit");

        if (ifNameTaken(name))
            throw new NotUniqueException("Product", "name", name);
    }

    // TODO: 23.05.2021 CONSIDER MEASURE UNIT - ANOTHER TABLE? CHECKING? IF YES - HOW?

    public boolean ifNameTaken(String name) {
        Optional<ProductEntity> foundByName = productRepository.findProductEntityByName(
                StringUtils.capitalize(name));
        return foundByName.isPresent();
    }


    public boolean pkwiuImproper(String pkwiu) {
        String patterns = "\\d\\d[.]\\d\\d[.]\\d\\d[.]\\d";
        Pattern pattern = Pattern.compile(patterns);
        return !pattern.matcher(pkwiu).matches();
    }
}
