package com.polsl.factoringcompany.invoice;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import pl.allegro.finance.tradukisto.MoneyConverters;

import java.math.BigDecimal;
import java.util.Formatter;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class InvoiceService {

    private final InvoiceRepository invoiceRepository;

    public List<InvoiceEntity> getInvoices() {
        return this.invoiceRepository.findAll();
    }

    public InvoiceEntity getInvoice(Long id) {
        return this.invoiceRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Invoice", id));
    }


    public InvoiceEntity addInvoice(InvoiceDto invoiceDto) {

        try {
            StringBuilder newInvoiceNumber = new StringBuilder();
            Formatter formatter = new Formatter(newInvoiceNumber);
            int month = invoiceDto.getCreationDate().toLocalDateTime().getMonthValue();
            int year = invoiceDto.getCreationDate().toLocalDateTime().getYear();
            long lastInvoiceIdPlusOne = 1L;

            try {
                lastInvoiceIdPlusOne =
                        invoiceRepository.getInvoiceNumber(month, year) + 1;
            }
            catch (NullPointerException ignored){
            }

            formatter.format("%d/%d/%d", lastInvoiceIdPlusOne, month, year);

            return this.invoiceRepository.save(new InvoiceEntity(invoiceDto, newInvoiceNumber.toString()));

        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public InvoiceEntity updateInvoice(Long id, InvoiceDto invoiceDto) {

        Optional<InvoiceEntity> invoiceEntityOptional = invoiceRepository.findById(id);

        if (invoiceEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Invoice", id);



        try {
            invoiceEntityOptional.get().setInvoiceNumber(invoiceEntityOptional.get().getInvoiceNumber());
            invoiceEntityOptional.get().setCreationDate(invoiceEntityOptional.get().getCreationDate());
            invoiceEntityOptional.get().setSaleDate(invoiceDto.getSaleDate());
            invoiceEntityOptional.get().setPaymentDeadline(invoiceDto.getPaymentDeadline());
            invoiceEntityOptional.get().setToPay(invoiceDto.getToPay());

            MoneyConverters converter = MoneyConverters.ENGLISH_BANKING_MONEY_VALUE;
            String toPayInWords = converter.asWords(invoiceDto.getToPay());

            invoiceEntityOptional.get().setToPayInWords(toPayInWords);
            invoiceEntityOptional.get().setPaid(invoiceDto.getPaid());
            invoiceEntityOptional.get().setLeftToPay(BigDecimal.valueOf(invoiceDto.getToPay().doubleValue() -
                    invoiceDto.getPaid().doubleValue()));
            invoiceEntityOptional.get().setRemarks(invoiceDto.getRemarks());
            invoiceEntityOptional.get().setSellerId(invoiceDto.getSellerId());
            invoiceEntityOptional.get().setCurrencyId(invoiceDto.getCurrencyId());
            invoiceEntityOptional.get().setPaymentTypeId(invoiceDto.getPaymentTypeId());
            invoiceEntityOptional.get().setCurrencyId(invoiceDto.getCurrencyId());


            return this.invoiceRepository.save(invoiceEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteInvoice(Long id) {
        try {
            this.invoiceRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Invoice", id);
        }
    }


}
