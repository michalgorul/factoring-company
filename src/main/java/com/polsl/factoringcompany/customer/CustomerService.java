package com.polsl.factoringcompany.customer;

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
public class CustomerService {

    private final CustomerRepository customerRepository;

    public List<CustomerEntity> getCustomers() {
        return this.customerRepository.findAll();
    }

    public CustomerEntity getCustomer(Long id) {
        return this.customerRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Customer", id));
    }

    public CustomerEntity addCustomer(CustomerEntity customerEntity) {

        nameValidator(customerEntity);

        try {
            return this.customerRepository.save(new CustomerEntity(
                    StringUtils.capitalize(customerEntity.getFirstName()),
                    StringUtils.capitalize(customerEntity.getLastName()),
                    StringUtils.capitalize(customerEntity.getCompanyName()),
                    StringUtils.capitalize(customerEntity.getCountry()),
                    StringUtils.capitalize(customerEntity.getCity()),
                    StringUtils.capitalize(customerEntity.getStreet()),
                    customerEntity.getPostalCode(),
                    customerEntity.getPhone(),
                    customerEntity.isBlacklisted()));
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteCustomer(Long id) {
        try {
            this.customerRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Customer", id);
        }
    }

    public CustomerEntity updateCustomer(Long id, CustomerEntity customerEntity) {

        Optional<CustomerEntity> customerEntityOptional = customerRepository.findById(id);

        if (customerEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Customer", id);

        nameValidator(customerEntity);

        try {
            customerEntityOptional.get().setFirstName(StringUtils.capitalize(customerEntity.getFirstName()));
            customerEntityOptional.get().setLastName(StringUtils.capitalize(customerEntity.getLastName()));
            customerEntityOptional.get().setCompanyName(StringUtils.capitalize(customerEntity.getCompanyName()));
            customerEntityOptional.get().setCountry(StringUtils.capitalize(customerEntity.getCountry()));
            customerEntityOptional.get().setCity(StringUtils.capitalize(customerEntity.getCity()));
            customerEntityOptional.get().setStreet(StringUtils.capitalize(customerEntity.getStreet()));
            customerEntityOptional.get().setPostalCode(customerEntity.getPostalCode());
            customerEntityOptional.get().setPhone(customerEntity.getPhone());
            customerEntityOptional.get().setBlacklisted(customerEntity.isBlacklisted());

            return this.customerRepository.save(customerEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    private void nameValidator(CustomerEntity customerEntity) {
        if (StringValidator.stringWithSpacesImproper(customerEntity.getFirstName(), 50)) {
            throw new ValueImproperException(customerEntity.getFirstName());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getLastName(), 50)) {
            throw new ValueImproperException(customerEntity.getLastName());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getCompanyName(), 50)) {
            throw new ValueImproperException(customerEntity.getCompanyName());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getCountry(), 50)) {
            throw new ValueImproperException(customerEntity.getCountry());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getCity(), 50)) {
            throw new ValueImproperException(customerEntity.getCity());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getStreet(), 50)) {
            throw new ValueImproperException(customerEntity.getStreet());
        }

        else if (StringValidator.stringWithSpacesImproper(customerEntity.getPostalCode(), 15)) {
            throw new ValueImproperException(customerEntity.getPostalCode());
        }

        else if (!StringValidator.isPhoneNumberValid(customerEntity.getPhone())) {
            throw new ValueImproperException(customerEntity.getPhone());
        }

    }


}
