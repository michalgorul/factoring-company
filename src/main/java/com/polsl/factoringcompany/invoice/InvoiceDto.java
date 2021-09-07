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
}
