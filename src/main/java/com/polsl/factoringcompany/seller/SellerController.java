package com.polsl.factoringcompany.seller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/seller")
public class SellerController {

    private final SellerService sellerService;

    @GetMapping
    public List<SellerEntity> getSellers() {
        return sellerService.getSellers();
    }


    @GetMapping(path = "/{id}")
    public SellerEntity getSeller(@PathVariable Long id) {
        return this.sellerService.getSeller(id);
    }


    @PostMapping
    public SellerEntity addSeller(@RequestBody SellerEntity sellerEntity) {
        return this.sellerService.addSeller(sellerEntity);
    }


    @PutMapping("/{id}")
    public SellerEntity updateSeller(@PathVariable Long id, @RequestBody SellerEntity sellerEntity) {
        return this.sellerService.updateSeller(id, sellerEntity);
    }


    @DeleteMapping("/{id}")
    public void deleteSeller(@PathVariable Long id) {
        this.sellerService.deleteSeller(id);
    }
}
