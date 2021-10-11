package com.polsl.factoringcompany.invoice;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/invoice")
public class InvoiceController {

    private final InvoiceService invoiceService;

    @GetMapping
    public List<InvoiceEntity> getInvoices() {
        return this.invoiceService.getInvoices();
    }

    @GetMapping(path = "/current")
    public List<InvoiceEntity> getInvoicesCurrentUser() {
        return this.invoiceService.getInvoicesCurrentUser();
    }

    @GetMapping(path = "/{id}")
    public InvoiceEntity getInvoice(@PathVariable Long id) {
        return this.invoiceService.getInvoice(id);
    }


    @PostMapping
    public InvoiceEntity addInvoice(@RequestBody InvoiceDto invoiceDto) {
        return this.invoiceService.addInvoice(invoiceDto);
    }


    @PutMapping("/{id}")
    public InvoiceEntity updateInvoice(@PathVariable Long id, @RequestBody InvoiceDto invoiceDto) {
        return this.invoiceService.updateInvoice(id, invoiceDto);
    }


    @DeleteMapping("/{id}")
    public void deleteInvoice(@PathVariable Long id) {
        this.invoiceService.deleteInvoice(id);
    }
}
