package com.polsl.factoringcompany.invoice;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.currency.CurrencyEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.invoiceitem.InvoiceItemEntity;
import com.polsl.factoringcompany.order.OrderEntity;
import com.polsl.factoringcompany.paymenttype.PaymentTypeEntity;
import com.polsl.factoringcompany.seller.SellerEntity;
import com.polsl.factoringcompany.transaction.TransactionEntity;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import pl.allegro.finance.tradukisto.MoneyConverters;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Objects;

@EqualsAndHashCode
@Getter
@Setter
@Entity(name = "invoice")
@Table(name = "invoice", schema = "public", catalog = "factoring_company")
public class InvoiceEntity {
    @Id
    @SequenceGenerator(
            name = "invoice_id_seq",
            sequenceName = "invoice_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "invoice_id_seq"
    )
    private long id;

    @Column(name = "invoice_number", nullable = false, length = 50)
    private String invoiceNumber;

    @Column(name = "creation_date", nullable = false)
    private Timestamp creationDate;

    @Column(name = "sale_date", nullable = false)
    private Timestamp saleDate;

    @Column(name = "payment_deadline", nullable = false)
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

    @Column(name = "status", nullable = false, length = 50)
    private String status;

    @Column(name = "seller_id", nullable = false)
    private int sellerId;

    @Column(name = "customer_id", nullable = false)
    private int customerId;

    @Column(name = "payment_type_id", nullable = false)
    private int paymentTypeId;

    @Column(name = "currency_id", nullable = false)
    private int currencyId;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "seller_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private SellerEntity sellerBySellerId;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private CustomerEntity customerByCustomerId;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "payment_type_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private PaymentTypeEntity paymentTypeByPaymentTypeId;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "currency_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private CurrencyEntity currencyByCurrencyId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "user_id", referencedColumnName = "id", insertable = false, updatable = false)
    private UserEntity userByUserId;

    @OneToMany(mappedBy = "invoiceByInvoiceId")
    @JsonIgnore
    private Collection<InvoiceItemEntity> invoiceItemsById;

    @OneToMany(mappedBy = "invoiceByInvoiceId")
    @JsonIgnore
    private Collection<TransactionEntity> transactionsById;

    @OneToMany(mappedBy = "invoiceByInvoiceId")
    @JsonIgnore
    private Collection<OrderEntity> ordersById;


    public InvoiceEntity() {
    }


    public InvoiceEntity(InvoiceDto invoiceDto) {
        MoneyConverters converter = MoneyConverters.ENGLISH_BANKING_MONEY_VALUE;
        String toPayInWords = converter.asWords(invoiceDto.getToPay());

        this.invoiceNumber = invoiceDto.getInvoiceNumber();
        this.creationDate = invoiceDto.getCreationDate();
        this.saleDate = invoiceDto.getSaleDate();
        this.paymentDeadline = invoiceDto.getPaymentDeadline();
        this.toPay = invoiceDto.getToPay();
        this.toPayInWords = toPayInWords.replaceAll(" £", "");
        this.paid = invoiceDto.getPaid();
        this.leftToPay = BigDecimal.valueOf(invoiceDto.getToPay().doubleValue() - invoiceDto.getPaid().doubleValue());
        this.remarks = invoiceDto.getRemarks();
        this.status = invoiceDto.getStatus();
        this.sellerId = invoiceDto.getSellerId();
        this.customerId = invoiceDto.getCustomerId();
        this.paymentTypeId = invoiceDto.getPaymentTypeId();
        this.currencyId = invoiceDto.getCurrencyId();
        this.userId = invoiceDto.getUserId();
    }

}
