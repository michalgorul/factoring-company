package com.polsl.factoringcompany.invoice;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.currency.CurrencyEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.paymenttype.PaymentTypeEntity;
import com.polsl.factoringcompany.seller.SellerEntity;
import lombok.Getter;
import lombok.Setter;
import pl.allegro.finance.tradukisto.MoneyConverters;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Objects;

@Getter
@Setter
@Entity(name = "invoice")
@Table(name = "invoice", schema = "public", catalog = "factoring_company")
public class InvoiceEntity {
    @Id
    @SequenceGenerator(
            name = "invoice_sequence",
            sequenceName = "invoice_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "invoice_sequence"
    )
    private long id;

    @Column(name = "invoice_number", nullable = false, length = 50)
    private String invoiceNumber;

    @Column(name = "creation_date", nullable = false)
    @JsonIgnore
    private Timestamp creationDate;

    @Column(name = "sale_date", nullable = false)
    @JsonIgnore
    private Timestamp saleDate;

    @Column(name = "payment_deadline", nullable = false)
    @JsonIgnore
    private Timestamp paymentDeadline;

    @Column(name = "to_pay", nullable = false, precision = 2)
    private BigDecimal toPay;

    @Column(name = "to_pay_in_words", nullable = false, length = 100)
    private String toPayInWords;

    @Column(name = "paid", nullable = false, precision = 2)
    private BigDecimal paid;

    @Column(name = "left_to_pay", nullable = false, precision = 2)
    private BigDecimal leftToPay;

    @Column(name = "remarks", nullable = true, length = 100)
    private String remarks;

    @Column(name = "seller_id", nullable = false)
    private int sellerId;

    @Column(name = "customer_id", nullable = false)
    private int customerId;

    @Column(name = "payment_type_id", nullable = false)
    private int paymentTypeId;

    @Column(name = "currency_id", nullable = false)
    private int currencyId;

    @ManyToOne
    @JoinColumn(name = "seller_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private SellerEntity sellerBySellerId;

    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private CustomerEntity customerByCustomerId;

    @ManyToOne
    @JoinColumn(name = "payment_type_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private PaymentTypeEntity paymentTypeByPaymentTypeId;

    @ManyToOne
    @JoinColumn(name = "currency_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private CurrencyEntity currencyByCurrencyId;


    public InvoiceEntity() {
    }


    public InvoiceEntity(InvoiceDto invoiceDto, String invoiceNumber) {
        MoneyConverters converter = MoneyConverters.ENGLISH_BANKING_MONEY_VALUE;
        String toPayInWords = converter.asWords(invoiceDto.getToPay());

        this.invoiceNumber = invoiceNumber;
        this.creationDate = invoiceDto.getCreationDate();
        this.saleDate = invoiceDto.getSaleDate();
        this.paymentDeadline = invoiceDto.getPaymentDeadline();
        this.toPay = invoiceDto.getToPay();
        this.toPayInWords = toPayInWords;
        this.paid = invoiceDto.getPaid();
        this.leftToPay = BigDecimal.valueOf(invoiceDto.getToPay().doubleValue() - invoiceDto.getPaid().doubleValue());
        this.remarks = invoiceDto.getRemarks();
        this.sellerId = invoiceDto.getSellerId();
        this.customerId = invoiceDto.getCustomerId();
        this.paymentTypeId = invoiceDto.getPaymentTypeId();
        this.currencyId = invoiceDto.getCurrencyId();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InvoiceEntity that = (InvoiceEntity) o;
        return id == that.id &&
                sellerId == that.sellerId &&
                customerId == that.customerId &&
                paymentTypeId == that.paymentTypeId &&
                currencyId == that.currencyId &&
                Objects.equals(invoiceNumber, that.invoiceNumber) &&
                Objects.equals(creationDate, that.creationDate) &&
                Objects.equals(saleDate, that.saleDate) &&
                Objects.equals(paymentDeadline, that.paymentDeadline) &&
                Objects.equals(toPay, that.toPay) &&
                Objects.equals(toPayInWords, that.toPayInWords) &&
                Objects.equals(paid, that.paid) &&
                Objects.equals(leftToPay, that.leftToPay) &&
                Objects.equals(remarks, that.remarks) &&
                Objects.equals(sellerBySellerId, that.sellerBySellerId) &&
                Objects.equals(customerByCustomerId, that.customerByCustomerId) &&
                Objects.equals(paymentTypeByPaymentTypeId, that.paymentTypeByPaymentTypeId) &&
                Objects.equals(currencyByCurrencyId, that.currencyByCurrencyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, invoiceNumber, creationDate, saleDate, paymentDeadline, toPay,
                toPayInWords, paid, leftToPay, remarks, sellerId, customerId, paymentTypeId,
                currencyId, sellerBySellerId, customerByCustomerId,
                paymentTypeByPaymentTypeId, currencyByCurrencyId);
    }
}
