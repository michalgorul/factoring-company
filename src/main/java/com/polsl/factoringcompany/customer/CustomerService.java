package com.polsl.factoringcompany.customer;

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

        validator(customerEntity);

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
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Customer", "companyName", customerEntity.getCompanyName());
                }
            }
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

        validator(customerEntity);

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
        } catch (DataIntegrityViolationException e) {
            Throwable rootCause = com.google.common.base.Throwables.getRootCause(e);
            if (rootCause instanceof SQLException) {
                if ("23505".equals(((SQLException) rootCause).getSQLState())) {
                    throw new NotUniqueException("Customer", "companyName", customerEntity.getCompanyName());
                }
            }
            throw new RuntimeException(e);
        }
    }

    private void validator(CustomerEntity customerEntity) {
        if (nameImproper(customerEntity.getFirstName(), 50)) {
            throw new ValueImproperException(customerEntity.getFirstName());
        }

        if (nameImproper(customerEntity.getLastName(), 50)) {
            throw new ValueImproperException(customerEntity.getLastName());
        }

        if (nameImproper(customerEntity.getCompanyName(), 50)) {
            throw new ValueImproperException(customerEntity.getCompanyName());
        }

        if (nameImproper(customerEntity.getCountry(), 50)) {
            throw new ValueImproperException(customerEntity.getCountry());
        }

        if (nameImproper(customerEntity.getCity(), 50)) {
            throw new ValueImproperException(customerEntity.getCity());
        }
    }

    public boolean nameImproper(String name, int length) {
        return name == null || name.length() <= 0 || name.length() > length || !onlyLettersSpaces(name);
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
