package com.polsl.factoringcompany.product;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @SequenceGenerator(
            name = "product_sequence",
            sequenceName = "product_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "product_sequence"
    )
    private Long id;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "pkwiu", nullable = false, length = 10)
    private String pkwiu;

    @Column(name = "measure_unit", nullable = false, length = 8)
    private String measureUnit;

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
