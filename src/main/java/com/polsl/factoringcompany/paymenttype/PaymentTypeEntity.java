package com.polsl.factoringcompany.paymenttype;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "payment_type")
public class PaymentTypeEntity {

    @Id
    @SequenceGenerator(
            name = "payment_type_id_seq",
            sequenceName = "currency_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "currency_id_seq"
    )
    private Long id;

    @Column(name = "name", nullable = false, length = 25, unique = true)
    private String name;

    @JsonIgnore
    @OneToMany(mappedBy = "paymentTypeByPaymentTypeId")
    private Collection<InvoiceEntity> invoicesById;


    public PaymentTypeEntity() {
    }

    public PaymentTypeEntity(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PaymentTypeEntity that = (PaymentTypeEntity) o;
        return Objects.equals(id, that.id) && Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
}
