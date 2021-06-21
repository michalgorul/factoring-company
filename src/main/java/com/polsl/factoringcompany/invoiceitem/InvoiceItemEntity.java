package com.polsl.factoringcompany.invoiceitem;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.product.ProductEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "invoice_item", schema = "public", catalog = "factoring_company")
public class InvoiceItemEntity {

    @Id
    @SequenceGenerator(
            name = "invoice_item_sequence",
            sequenceName = "invoice_item_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "invoice_item_sequence"
    )
    private long id;

    @Column(name = "quentity", nullable = false)
    private int quentity;

    @Column(name = "net_price", nullable = false, precision = 2)
    private BigDecimal netPrice;

    @Column(name = "net_value", nullable = false, precision = 2)
    private BigDecimal netValue;

    @Column(name = "vat_rate", nullable = false, precision = 2)
    private BigDecimal vatRate;

    @Column(name = "vat_value", nullable = false, precision = 2)
    private BigDecimal vatValue;

    @Column(name = "gross_value", nullable = false, precision = 2)
    private BigDecimal grossValue;

    @Column(name = "product_id", nullable = false)
    private int productId;

    @Column(name = "invoice_id", nullable = false)
    private int invoiceId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "product_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private ProductEntity productByProductId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "invoice_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private InvoiceEntity invoiceByInvoiceId;

    public InvoiceItemEntity() {
    }

    public InvoiceItemEntity(InvoiceItemDto invoiceItemDto) {
        BigDecimal netValue = BigDecimal.valueOf(invoiceItemDto.getQuentity() * invoiceItemDto.getNetPrice().doubleValue());
        BigDecimal vatValue = BigDecimal.valueOf(invoiceItemDto.getVatRate().doubleValue() * invoiceItemDto.getNetPrice().doubleValue());

        this.quentity = invoiceItemDto.getQuentity();
        this.netPrice = invoiceItemDto.getNetPrice();
        this.netValue = netValue;
        this.vatRate = invoiceItemDto.getVatRate();
        this.vatValue = vatValue;
        this.grossValue = BigDecimal.valueOf(netValue.doubleValue() + vatValue.doubleValue());
        this.productId = invoiceItemDto.getProductId();
        this.invoiceId = invoiceItemDto.getInvoiceId();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InvoiceItemEntity that = (InvoiceItemEntity) o;
        return id == that.id &&
                quentity == that.quentity &&
                productId == that.productId &&
                invoiceId == that.invoiceId &&
                Objects.equals(netPrice, that.netPrice) &&
                Objects.equals(netValue, that.netValue) &&
                Objects.equals(vatRate, that.vatRate) &&
                Objects.equals(vatValue, that.vatValue) &&
                Objects.equals(grossValue, that.grossValue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, quentity, netPrice, netValue, vatRate, vatValue, grossValue, productId, invoiceId);
    }


}
