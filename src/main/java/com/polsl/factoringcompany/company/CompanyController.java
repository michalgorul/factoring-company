package com.polsl.factoringcompany.company;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/company")
public class CompanyController {

    private final CompanyService companyService;


    @GetMapping
    public List<CompanyEntity> getPaymentTypes() {
        return companyService.getCompanies();
    }


    @GetMapping(path = "/{id}")
    public CompanyEntity getPaymentType(@PathVariable Long id) {
        return this.companyService.getCompany(id);
    }


    @PostMapping
    public CompanyEntity addPaymentType(@RequestParam String companyName,
                                        @RequestParam String country,
                                        @RequestParam String city,
                                        @RequestParam String street,
                                        @RequestParam String postalCode,
                                        @RequestParam String nip,
                                        @RequestParam String regon) {
        return this.companyService.addCompany(companyName, country, city, street, postalCode, nip, regon);
    }


    @PutMapping("/{id}")
    public CompanyEntity updatePaymentType(@PathVariable Long id,
                                           @RequestParam String companyName,
                                           @RequestParam String country,
                                           @RequestParam String city,
                                           @RequestParam String street,
                                           @RequestParam String postalCode,
                                           @RequestParam String nip,
                                           @RequestParam String regon) {
        return this.companyService.updateCompany(id, companyName, country, city, street, postalCode, nip, regon);
    }


    @DeleteMapping("/{id}")
    public void deletePaymentType(@PathVariable Long id) {
        companyService.deleteCompany(id);
    }
}
