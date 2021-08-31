package com.polsl.factoringcompany.product;

import com.polsl.factoringcompany.invoiceitem.InvoiceItemEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @SequenceGenerator(
            name = "product_id_seq",
            sequenceName = "currency_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "currency_id_seq"
    )
    private Long id;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "pkwiu", nullable = false, length = 10)
    private String pkwiu;

    @Column(name = "measure_unit", nullable = false, length = 8)
    private String measureUnit;

    @OneToMany(mappedBy = "productByProductId")
    private Collection<InvoiceItemEntity> invoiceItemsById;


    public ProductEntity() {
    }

    public ProductEntity(String name, String pkwiu, String measureUnit) {
        this.name = name;
        this.pkwiu = pkwiu;
        this.measureUnit = measureUnit;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductEntity that = (ProductEntity) o;
        return Objects.equals(id, that.id) && Objects.equals(name, that.name) && Objects.equals(pkwiu, that.pkwiu) &&
                Objects.equals(measureUnit, that.measureUnit);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, pkwiu, measureUnit);
    }
}
