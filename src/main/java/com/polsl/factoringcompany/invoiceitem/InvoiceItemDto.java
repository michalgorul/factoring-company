package com.polsl.factoringcompany.invoiceitem;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class InvoiceItemDto {

    private int quentity;
    private BigDecimal netPrice;
    private BigDecimal vatRate;
    private BigDecimal grossValue;
    private int productId;
    private int invoiceId;

}
