package com.polsl.factoringcompany.credit;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "credit", schema = "public", catalog = "factoring_company")
public class CreditEntity {

    @Id
    @SequenceGenerator(
            name = "credit_id_sequence",
            sequenceName = "credit_id_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "credit_id_sequence"
    )
    private long id;

    @Column(name = "credit_number", nullable = false, length = 15)
    private String creditNumber;

    @Column(name = "left_to_pay", nullable = false, precision = 2)
    private BigDecimal leftToPay;

    @Column(name = "amount", nullable = false, precision = 2)
    private BigDecimal amount;

    @Column(name = "next_payment", nullable = false, precision = 2)
    private BigDecimal nextPayment;

    @Column(name = "installments", nullable = false)
    private int installments;

    @Column(name = "balance", nullable = false, precision = 2)
    private BigDecimal balance;

    @Column(name = "rate_of_interest", nullable = false, precision = 2)
    private BigDecimal rateOfInterest;

    @Column(name = "next_payment_date", nullable = false)
    private Date nextPaymentDate;

    @Column(name = "creation_date", nullable = false)
    private Date creationDate;

    @Column(name = "last_installment_date", nullable = false)
    private Date lastInstallmentDate;

    @Column(name = "status", nullable = false, length = 50)
    private String status;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private UserEntity userByUserId;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CreditEntity that = (CreditEntity) o;
        return id == that.id && installments == that.installments && userId == that.userId && Objects.equals(creditNumber, that.creditNumber) && Objects.equals(leftToPay, that.leftToPay) && Objects.equals(amount, that.amount) && Objects.equals(nextPayment, that.nextPayment) && Objects.equals(balance, that.balance) && Objects.equals(rateOfInterest, that.rateOfInterest) && Objects.equals(nextPaymentDate, that.nextPaymentDate) && Objects.equals(creationDate, that.creationDate) && Objects.equals(lastInstallmentDate, that.lastInstallmentDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, creditNumber, leftToPay, amount, nextPayment, installments, balance, rateOfInterest, nextPaymentDate, creationDate, lastInstallmentDate, userId);
    }

}
