package com.polsl.factoringcompany.transaction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.credit.CreditEntity;
import com.polsl.factoringcompany.currency.CurrencyEntity;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;

@NoArgsConstructor
@EqualsAndHashCode
@Getter
@Setter
@Entity
@Table(name = "transaction", schema = "public", catalog = "factoring_company")
public class TransactionEntity {

    @Id
    @SequenceGenerator(
            name = "transaction_id_seq",
            sequenceName = "transaction_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "transaction_id_seq"
    )private long id;

    @Column(name = "transaction_date", nullable = false)
    private Date transactionDate;

    @Column(name = "value", nullable = false, precision = 2)
    private BigDecimal value;

    @Column(name = "status", nullable = false)
    private String statusId;

    @Column(name = "user_id", nullable = false)
    private int customerId;

    @Column(name = "invoice_id", nullable = false)
    private int invoiceId;

    @Column(name = "credit_id", nullable = false)
    private int creditId;

    @Column(name = "currency_id", nullable = false)
    private int currencyId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private UserEntity userByUserId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "invoice_id", referencedColumnName = "id", insertable = false, updatable = false)
    private InvoiceEntity invoiceByInvoiceId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "credit_id", referencedColumnName = "id", insertable = false, updatable = false)
    private CreditEntity creditByCreditId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "currency_id", referencedColumnName = "id", insertable = false, updatable = false)
    private CurrencyEntity currencyByCurrencyId;

}
