package com.polsl.factoringcompany.invoice;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceDto {

    private String invoiceNumber;
    private Timestamp creationDate;
    private Timestamp saleDate;
    private Timestamp paymentDeadline;
    private BigDecimal toPay;
    private BigDecimal paid;
    private String remarks;
    private String status;
    private int sellerId;
    private int customerId;
    private int paymentTypeId;
    private int currencyId;
    private int userId;

    public InvoiceDto(InvoiceCreateRequest invoiceCreateRequest, String invoiceNumber, Long sellerId, Long customerId,
                      Long paymentTypeId, Long currencyId, Long userId) {

        BigDecimal netValue = BigDecimal.valueOf(invoiceCreateRequest.getQuantity() * invoiceCreateRequest.getNet());
        BigDecimal vatValue = BigDecimal.valueOf(invoiceCreateRequest.getQuantity() * invoiceCreateRequest.getVat() * invoiceCreateRequest.getNet() / 100);

        this.invoiceNumber = invoiceNumber;
        this.creationDate = invoiceCreateRequest.getIssueDate();
        this.saleDate = invoiceCreateRequest.getPerformanceDate();
        this.paymentDeadline = Timestamp.valueOf(invoiceCreateRequest.getPerformanceDate()
                .toLocalDateTime().plusMonths(invoiceCreateRequest.getMonths()));
        this.toPay = BigDecimal.valueOf(netValue.doubleValue() + vatValue.doubleValue());
        this.paid = new BigDecimal(0);
        this.remarks = invoiceCreateRequest.getRemarks();
        this.status = "active";
        this.sellerId = Math.toIntExact(sellerId);
        this.customerId = Math.toIntExact(customerId);
        this.paymentTypeId = Math.toIntExact(paymentTypeId);
        this.currencyId = Math.toIntExact(currencyId);
        this.userId = Math.toIntExact(userId);
    }
}
