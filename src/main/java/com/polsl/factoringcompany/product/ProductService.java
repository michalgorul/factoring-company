package com.polsl.factoringcompany.product;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public List<ProductEntity> getProducts() {
        return productRepository.findAll();
    }

    public Optional<ProductEntity> getProduct(Long id) {

        Optional<ProductEntity> productEntity = productRepository.findById(id);

        if (productEntity.isEmpty()) {
            throw new IllegalStateException("Product with id " + id + " does not exist");
        }
        return productEntity;
    }

    public void ifNameTaken(String name) {
        Optional<ProductEntity> foundByName = productRepository.findPProductEntityByName(StringUtils.capitalize(name));

        if (foundByName.isPresent()) {
            throw new IllegalStateException("Product with '" + name + "' name already exists");
        }
    }


    public ProductEntity addProduct(String name, String pkwiu, String measureUnit) {

        ifFits(name, pkwiu);
        return productRepository.save(new ProductEntity(StringUtils.capitalize(name), pkwiu, measureUnit));
    }

    public Optional<ProductEntity> deleteProduct(Long id) {
        Optional<ProductEntity> productEntity = productRepository.findById(id);

        if (productEntity.isPresent()) {
            productRepository.deleteById(id);
            return productEntity;
        } else {
            throw new IllegalStateException("Product with id " + id + " does not exist");
        }
    }

    @Transactional
    public Optional<ProductEntity> updateProduct(Long id, String name, String pkwiu, String measureUnit) {

        ProductEntity productEntity = productRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Product with id " + id + " does not exist"));

        ifFits(name, pkwiu);
        productEntity.setName(StringUtils.capitalize(name));
        productEntity.setPkwiu(pkwiu);
        productEntity.setMeasureUnit(measureUnit);

        return Optional.of(productEntity);
    }

    // TODO: 23.05.2021 SPACES SHOULD BE ACCEPTABLE :)
    public void checkName(String name) {
        if (name == null || name.length() <= 0 || name.length() > 50 || !name.chars().allMatch(Character::isLetter)) {
            throw new IllegalStateException("The name '" + name + "' is not appropriate");
        }
    }

    // TODO: 23.05.2021 NEED TO APPLY REGEX CHECKING :)
    public void checkPkwiu(String pkwiu) {
        if (pkwiu == null || pkwiu.length() <= 0 || pkwiu.length() > 10) {
            throw new IllegalStateException("The PKWIU '" + pkwiu + "' is not appropriate");
        }
    }

    // TODO: 23.05.2021 CONSIDER MEASURE UNIT - ANOTHER TABLE? CHECKING? IF YES - HOW? 
    
    public void ifFits(String name, String pkwiu) {
        checkName(name);
        checkPkwiu(pkwiu);
        ifNameTaken(name);
    }
}
