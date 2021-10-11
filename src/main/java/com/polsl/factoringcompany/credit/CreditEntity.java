package com.polsl.factoringcompany.credit;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "credit", schema = "public", catalog = "factoring_company")
public class CreditEntity {
    private long id;
    private String creditNumber;
    private BigDecimal leftToPay;
    private BigDecimal amount;
    private BigDecimal nextPayment;
    private int installments;
    private BigDecimal balance;
    private BigDecimal rateOfInterest;
    private Date nextPaymentDate;
    private Date creationDate;
    private Date lastInstallmentDate;
    private int userId;
    private UserEntity userByUserId;

    @Id
    @Column(name = "id", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "credit_number", nullable = false, length = 15)
    public String getCreditNumber() {
        return creditNumber;
    }

    public void setCreditNumber(String creditNumber) {
        this.creditNumber = creditNumber;
    }

    @Basic
    @Column(name = "left_to_pay", nullable = false, precision = 2)
    public BigDecimal getLeftToPay() {
        return leftToPay;
    }

    public void setLeftToPay(BigDecimal leftToPay) {
        this.leftToPay = leftToPay;
    }

    @Basic
    @Column(name = "amount", nullable = false, precision = 2)
    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    @Basic
    @Column(name = "next_payment", nullable = false, precision = 2)
    public BigDecimal getNextPayment() {
        return nextPayment;
    }

    public void setNextPayment(BigDecimal nextPayment) {
        this.nextPayment = nextPayment;
    }

    @Basic
    @Column(name = "installments", nullable = false)
    public int getInstallments() {
        return installments;
    }

    public void setInstallments(int installments) {
        this.installments = installments;
    }

    @Basic
    @Column(name = "balance", nullable = false, precision = 2)
    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    @Basic
    @Column(name = "rate_of_interest", nullable = false, precision = 2)
    public BigDecimal getRateOfInterest() {
        return rateOfInterest;
    }

    public void setRateOfInterest(BigDecimal rateOfInterest) {
        this.rateOfInterest = rateOfInterest;
    }

    @Basic
    @Column(name = "next_payment_date", nullable = false)
    public Date getNextPaymentDate() {
        return nextPaymentDate;
    }

    public void setNextPaymentDate(Date nextPaymentDate) {
        this.nextPaymentDate = nextPaymentDate;
    }

    @Basic
    @Column(name = "creation_date", nullable = false)
    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    @Basic
    @Column(name = "last_installment_date", nullable = false)
    public Date getLastInstallmentDate() {
        return lastInstallmentDate;
    }

    public void setLastInstallmentDate(Date lastInstallmentDate) {
        this.lastInstallmentDate = lastInstallmentDate;
    }

    @Basic
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

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

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    public UserEntity getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(UserEntity userByUserId) {
        this.userByUserId = userByUserId;
    }
}
