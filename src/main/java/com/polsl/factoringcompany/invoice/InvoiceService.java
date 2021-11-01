package com.polsl.factoringcompany.invoice;

import com.polsl.factoringcompany.currency.CurrencyEntity;
import com.polsl.factoringcompany.currency.CurrencyService;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.customer.CustomerService;
import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.invoiceitem.InvoiceItemDto;
import com.polsl.factoringcompany.invoiceitem.InvoiceItemService;
import com.polsl.factoringcompany.paymenttype.PaymentTypeEntity;
import com.polsl.factoringcompany.paymenttype.PaymentTypeService;
import com.polsl.factoringcompany.product.ProductEntity;
import com.polsl.factoringcompany.product.ProductService;
import com.polsl.factoringcompany.seller.SellerEntity;
import com.polsl.factoringcompany.seller.SellerService;
import com.polsl.factoringcompany.user.UserService;
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
    private final UserService userService;
    private final CurrencyService currencyService;
    private final PaymentTypeService paymentTypeService;
    private final CustomerService customerService;
    private final SellerService sellerService;
    private final ProductService productService;
    private final InvoiceItemService invoiceItemService;

    public List<InvoiceEntity> getInvoices() {
        return this.invoiceRepository.findAll();
    }


    public List<InvoiceEntity> getInvoicesCurrentUser() {
        Long currentUserId = userService.getCurrentUserId();
        return this.invoiceRepository.findAllByUserId(Math.toIntExact(currentUserId));
    }

    public InvoiceEntity getInvoice(Long id) {
        return this.invoiceRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Invoice", id));
    }


    public InvoiceEntity addInvoice(InvoiceCreateRequest invoiceCreateRequest) {

        try {
            String newInvoiceNumber = getNewInvoiceNumber(invoiceCreateRequest);
            CurrencyEntity currency = currencyService.getCurrencyByCurrencyName(invoiceCreateRequest.getCurrencyName());
            PaymentTypeEntity paymentType = paymentTypeService.getPaymentTypeEntityByName(invoiceCreateRequest.getPaymentTypeName());
            CustomerEntity customer = customerService.getCustomerByPhone(invoiceCreateRequest.getCustomerPhone());
            SellerEntity seller = sellerService.getSeller(2L);
            ProductEntity product = productService.getProductByName(invoiceCreateRequest.getProductName());
            Long currentUserId = userService.getCurrentUserId();

            InvoiceDto invoiceDto = new InvoiceDto(
                    invoiceCreateRequest,
                    newInvoiceNumber,
                    seller.getId(),
                    customer.getId(),
                    paymentType.getId(),
                    currency.getId(),
                    currentUserId);


            InvoiceEntity invoiceEntity = this.invoiceRepository.save(new InvoiceEntity(invoiceDto));

            InvoiceItemDto invoiceItemDto = new InvoiceItemDto(invoiceCreateRequest, product.getId(), invoiceEntity.getId());
            invoiceItemService.addInvoiceItem(invoiceItemDto);

            return invoiceEntity;


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
            invoiceEntityOptional.get().setStatus(invoiceDto.getStatus());
            invoiceEntityOptional.get().setSellerId(invoiceDto.getSellerId());
            invoiceEntityOptional.get().setCurrencyId(invoiceDto.getCurrencyId());
            invoiceEntityOptional.get().setPaymentTypeId(invoiceDto.getPaymentTypeId());

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

    public String getInvoiceCurrencyCode(Long invoiceId) {
        InvoiceEntity invoiceEntity = this.getInvoice(invoiceId);
        return currencyService.getCurrency((long) invoiceEntity.getCurrencyId()).getCode();

    }

    public String getPaymentMethod(Long invoiceId) {
        InvoiceEntity invoiceEntity = this.getInvoice(invoiceId);
        return paymentTypeService.getPaymentType((long) invoiceEntity.getPaymentTypeId()).getPaymentTypeName();
    }

    private String getNewInvoiceNumber(InvoiceCreateRequest invoiceCreateRequest) {
        StringBuilder newInvoiceNumber = new StringBuilder();
        Formatter formatter = new Formatter(newInvoiceNumber);
        int month = invoiceCreateRequest.getIssueDate().toLocalDateTime().getMonthValue();
        int year = invoiceCreateRequest.getIssueDate().toLocalDateTime().getYear();
        long lastInvoiceIdPlusOne = 1L;

        try {
            lastInvoiceIdPlusOne =
                    invoiceRepository.getInvoiceNumber(month, year) + 1;
        } catch (NullPointerException ignored) {
        }
        formatter.format("%d/%d/%d", lastInvoiceIdPlusOne, month, year);

        return newInvoiceNumber.toString();
    }

    public InvoiceEntity updateInvoicePaymentInfo(Long id, InvoicePaymentInfoUpdateRequest invoicePaymentInfoUpdateRequest) {

        Optional<InvoiceEntity> invoiceEntityOptional = invoiceRepository.findById(id);

        if (invoiceEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Invoice", id);

        try {
            CurrencyEntity currencyEntity =
                    currencyService.getCurrencyByCurrencyName(invoicePaymentInfoUpdateRequest.getCurrencyName());
            PaymentTypeEntity paymentTypeEntity =
                    paymentTypeService.getPaymentTypeEntityByName(invoicePaymentInfoUpdateRequest.getPaymentTypeName());

            invoiceEntityOptional.get().setCurrencyId(Math.toIntExact(currencyEntity.getId()));
            invoiceEntityOptional.get().setPaymentTypeId(Math.toIntExact(paymentTypeEntity.getId()));


            return this.invoiceRepository.save(invoiceEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }

    }
}
