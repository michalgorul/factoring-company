package com.polsl.factoringcompany.company;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/company")
public class CompanyController {

    private final CompanyService companyService;


    @GetMapping
    public List<CompanyEntity> getCompanies() {
        return this.companyService.getCompanies();
    }


    @GetMapping(path = "/{id}")
    public CompanyEntity getCompany(@PathVariable Long id) {
        return this.companyService.getCompany(id);
    }


    @PostMapping
    public CompanyEntity addCompany(@RequestBody CompanyEntity companyEntity) {
        return this.companyService.addCompany(companyEntity);
    }


    @PutMapping("/{id}")
    public CompanyEntity updateCompany(@PathVariable Long id, @RequestBody CompanyEntity companyEntity) {
        return this.companyService.updateCompany(id, companyEntity);
    }


    @DeleteMapping("/{id}")
    public void deleteCompany(@PathVariable Long id) {
        this.companyService.deleteCompany(id);
    }
}
