package com.polsl.factoringcompany.order;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.status.StatusEntity;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "order", schema = "public", catalog = "factoring_company")
public class OrderEntity {

//    private final double COMMISSION_RATE_CONST = 0.01d;

    @Id
    @SequenceGenerator(
            name = "order_sequence",
            sequenceName = "order_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "order_sequence"
    )
    private long id;

    @Column(name = "order_number", nullable = false, length = 50)
    private String orderNumber;

    @Column(name = "order_type", nullable = false, length = 50)
    private String orderType;

    @Column(name = "order_date", nullable = false)
    private Date orderDate;

    @Column(name = "first_pay_ammount", nullable = false, precision = 2)
    private BigDecimal firstPayAmmount;

    @Column(name = "second_pay_ammount", nullable = false, precision = 2)
    private BigDecimal secondPayAmmount;

    @Column(name = "commission_rate", nullable = false, precision = 2)
    private BigDecimal commissionRate;

    @Column(name = "commission_value", nullable = false, precision = 2)
    private BigDecimal commissionValue;

    @Column(name = "invoice_id", nullable = false)
    private int invoiceId;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Column(name = "status_id", nullable = false)
    private int statusId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "invoice_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private InvoiceEntity invoiceByInvoiceId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private UserEntity userByUserId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "status_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private StatusEntity statusByStatusId;

    public OrderEntity() {
    }

    public OrderEntity(OrderDto orderDto) {

        UUID uuid = UUID.randomUUID();
        this.orderNumber = uuid.toString();
        this.orderType = orderDto.getOrderType();
        this.orderDate = orderDto.getOrderDate();
        this.firstPayAmmount = BigDecimal.valueOf(orderDto.getAmmount().doubleValue() * 0.80f);
        this.secondPayAmmount = BigDecimal.valueOf(orderDto.getAmmount().doubleValue() * 0.20f);
        this.commissionRate = orderDto.getCommissionRate();
        this.commissionValue = BigDecimal.valueOf(orderDto.getAmmount().doubleValue() * orderDto.getCommissionRate().doubleValue());
        this.invoiceId = orderDto.getInvoiceId();
        this.userId = orderDto.getUserId();
        this.statusId = orderDto.getStatusId();
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderEntity that = (OrderEntity) o;
        return id == that.id && invoiceId == that.invoiceId && userId == that.userId && statusId == that.statusId && Objects.equals(orderNumber, that.orderNumber) && Objects.equals(orderType, that.orderType) && Objects.equals(orderDate, that.orderDate) && Objects.equals(firstPayAmmount, that.firstPayAmmount) && Objects.equals(secondPayAmmount, that.secondPayAmmount) && Objects.equals(commissionRate, that.commissionRate) && Objects.equals(commissionValue, that.commissionValue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, orderNumber, orderType, orderDate, firstPayAmmount, secondPayAmmount, commissionRate, commissionValue, invoiceId, userId, statusId);
    }

}
