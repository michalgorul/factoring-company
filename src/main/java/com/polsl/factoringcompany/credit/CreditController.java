package com.polsl.factoringcompany.credit;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/api/credit")
public class CreditController {
    private final CreditService creditService;

    @GetMapping
    public List<CreditEntity> getCredits(){
        return this.creditService.getCredits();
    }

    @GetMapping(path = "/{id}")
    public CreditEntity getCredit(@PathVariable Long id){
        return this.creditService.getCredit(id);
    }

    @DeleteMapping(path = "/{id}")
    public void deleteCredit(@PathVariable Long id){
        this.creditService.deleteCredit(id);
    }
}
