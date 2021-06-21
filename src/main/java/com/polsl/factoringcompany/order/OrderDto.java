package com.polsl.factoringcompany.order;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Date;

@Getter
@Setter
public class OrderDto {
    private String orderType;
    private Date orderDate;
    private BigDecimal ammount;
    private BigDecimal commissionRate;
    private int invoiceId;
    private int userId;
    private int statusId;
}
