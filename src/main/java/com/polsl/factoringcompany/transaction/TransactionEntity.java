package com.polsl.factoringcompany.transaction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.currency.CurrencyEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.status.StatusEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "transaction", schema = "public", catalog = "factoring_company")
public class TransactionEntity {

    @Id
    @SequenceGenerator(
            name = "transaction_sequence",
            sequenceName = "transaction_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "transaction_sequence"
    )private long id;

    @Column(name = "transaction_date", nullable = false)
    private Date transactionDate;

    @Column(name = "value", nullable = false, precision = 2)
    private BigDecimal value;

    @Column(name = "status_id", nullable = false)
    private int statusId;

    @Column(name = "customer_id", nullable = false)
    private int customerId;

    @Column(name = "invoice_id", nullable = false)
    private int invoiceId;

    @Column(name = "currency_id", nullable = false)
    private int currencyId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "status_id", referencedColumnName = "id", nullable = false)
    private StatusEntity statusByStatusId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "customer_id", referencedColumnName = "id", nullable = false)
    private CustomerEntity customerByCustomerId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "invoice_id", referencedColumnName = "id", nullable = false)
    private InvoiceEntity invoiceByInvoiceId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "currency_id", referencedColumnName = "id", nullable = false)
    private CurrencyEntity currencyByCurrencyId;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TransactionEntity that = (TransactionEntity) o;
        return id == that.id &&
                statusId == that.statusId &&
                customerId == that.customerId &&
                invoiceId == that.invoiceId &&
                currencyId == that.currencyId &&
                Objects.equals(transactionDate, that.transactionDate) &&
                Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, transactionDate, value, statusId, customerId, invoiceId, currencyId);
    }
}
