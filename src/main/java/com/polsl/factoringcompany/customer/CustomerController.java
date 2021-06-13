package com.polsl.factoringcompany.customer;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/customer")
public class CustomerController {

    private final CustomerService customerService;

    @GetMapping
    public List<CustomerEntity> getCustomers() {
        return customerService.getCustomers();
    }


    @GetMapping(path = "/{id}")
    public CustomerEntity getCustomer(@PathVariable Long id) {
        return this.customerService.getCustomer(id);
    }


    @PostMapping
    public CustomerEntity addCustomer(@RequestBody CustomerEntity customerEntity) {
        return this.customerService.addCustomer(customerEntity);
    }


    @PutMapping("/{id}")
    public CustomerEntity updateCustomer(@PathVariable Long id, @RequestBody CustomerEntity customerEntity) {
        return this.customerService.updateCustomer(id, customerEntity);
    }


    @DeleteMapping("/{id}")
    public void deleteCustomer(@PathVariable Long id) {
        customerService.deleteCustomer(id);
    }
}
