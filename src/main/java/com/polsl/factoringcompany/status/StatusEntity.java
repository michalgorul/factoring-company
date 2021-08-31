package com.polsl.factoringcompany.status;

import com.polsl.factoringcompany.order.OrderEntity;
import com.polsl.factoringcompany.transaction.TransactionEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "status")
public class StatusEntity {

    @Id
    @SequenceGenerator(
            name = "status_id_seq",
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

    @OneToMany(mappedBy = "statusByStatusId")
    private Collection<TransactionEntity> transactionsById;

    @OneToMany(mappedBy = "statusByStatusId")
    private Collection<OrderEntity> ordersById;


    public StatusEntity() {
    }

    public StatusEntity(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StatusEntity that = (StatusEntity) o;
        return Objects.equals(id, that.id) && Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name);
    }
}
