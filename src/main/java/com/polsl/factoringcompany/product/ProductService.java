package com.polsl.factoringcompany.product;

import com.google.common.base.Throwables;
import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.exceptions.ItemExistsInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.sql.SQLException;
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
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Product " + id + " not found"));
    }


    public ProductEntity addProduct(String name, String pkwiu, String measureUnit) {

        validating(name, pkwiu, measureUnit);

        try {
            return productRepository.save(new ProductEntity(StringUtils.capitalize(name), pkwiu, measureUnit));
        } catch (RuntimeException e) {
            Throwable rootCause = Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new ItemExistsInDatabaseException("Product ( " + name + ") exists in DB");
                }
            }
            throw new RuntimeException(e);
        }
    }

    public void deleteProduct(Long id) {
        try {
            this.productRepository.deleteById(id);
        } catch (RuntimeException ignored) {
            throw new IdNotFoundInDatabaseException("Product " + id + " not found");
        }
    }

    @Transactional
    public ProductEntity updateProduct(Long id, String name, String pkwiu, String measureUnit) {

        Optional<ProductEntity> productEntity = productRepository.findById(id);

        if (productEntity.isEmpty())
            throw new IdNotFoundInDatabaseException("Product " + id + " not found");

        validating(name, pkwiu, measureUnit);

        try {
            productEntity.get().setName(StringUtils.capitalize(name));
            productEntity.get().setMeasureUnit(measureUnit);
            productEntity.get().setPkwiu(pkwiu);
            return this.productRepository.save(productEntity.get());
        } catch (RuntimeException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new ItemExistsInDatabaseException("Currency ( " + StringUtils.capitalize(name) + ") exists in DB");
                }
            }
            throw new RuntimeException(e);
        }
    }

    private void validating(String name, String pkwiu, String measureUnit) {
        if (!validateName(name))
            throw new IllegalArgumentException("The name '" + name + "' is not appropriate");

        if (!validatePkwiu(pkwiu))
            throw new IllegalArgumentException("The PKWIU '" + pkwiu + "' is not appropriate");

        if (!validateMeasureUnit(measureUnit))
            throw new IllegalArgumentException("The measure unit '" + measureUnit + "' is not appropriate");

        if (ifNameTaken(StringUtils.capitalize(name)))
            throw new IllegalArgumentException("Product with '" + StringUtils.capitalize(name) +
                    "' name already exists");
    }

    // TODO: 23.05.2021 CONSIDER MEASURE UNIT - ANOTHER TABLE? CHECKING? IF YES - HOW?

    public boolean ifNameTaken(String name) {
        Optional<ProductEntity> foundByName = productRepository.findPProductEntityByName(
                StringUtils.capitalize(name));
        return foundByName.isPresent();
    }

    // TODO: 25.05.2021 I CAN ADD A NAME VALIDATOR CLASS OR STH

    public boolean validateName(String name) {
        return name != null && name.length() > 0 && name.length() <= 50 && onlyLettersSpaces(name);
    }

    private boolean validatePkwiu(String pkwiu) {
        String patterns = "\\d\\d[.]\\d\\d[.]\\d\\d[.]\\d";

        Pattern pattern = Pattern.compile(patterns);
        return pattern.matcher(pkwiu).matches();
    }

    private boolean validateMeasureUnit(String measureUnit) {
        return measureUnit != null && measureUnit.length() > 0 && measureUnit.length() <= 9 &&
                onlyLettersSpaces(measureUnit);

    }

    public static boolean onlyLettersSpaces(String s) {
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (Character.isLetter(ch) || ch == ' ' || ch == '-') {
                continue;
            }
            return false;
        }
        return s.charAt(s.length() - 1) != ' ';
    }
}
