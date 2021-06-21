package com.polsl.factoringcompany.customer;

import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.transaction.TransactionEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "customer")
public class CustomerEntity {

    @Id
    @Column(name = "id", nullable = false)
    @SequenceGenerator(
            name = "customer_sequence",
            sequenceName = "customer_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "customer_sequence"
    )
    private Long id;

    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @Column(name = "company_name", nullable = false, length = 50)
    private String companyName;

    @Column(name = "country", nullable = false, length = 50)
    private String country;

    @Column(name = "city", nullable = false, length = 50)
    private String city;

    @Column(name = "street", nullable = false, length = 50)
    private String street;

    @Column(name = "postal_code", length = 15)
    private String postalCode;

    @Column(name = "phone", nullable = false, length = 15)
    private String phone;

    @Column(name = "blacklisted", nullable = false)
    private boolean blacklisted;

    @OneToMany(mappedBy = "customerByCustomerId")
    private Collection<InvoiceEntity> invoicesById;

    @OneToMany(mappedBy = "customerByCustomerId")
    private Collection<TransactionEntity> transactionsById;


    public CustomerEntity() {
    }

    public CustomerEntity(String firstName, String lastName, String companyName,
                          String country, String city, String street,
                          String postalCode, String phone, boolean blacklisted) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.companyName = companyName;
        this.country = country;
        this.city = city;
        this.street = street;
        this.postalCode = postalCode;
        this.phone = phone;
        this.blacklisted = blacklisted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CustomerEntity that = (CustomerEntity) o;
        return id == that.id &&
                blacklisted == that.blacklisted &&
                Objects.equals(firstName, that.firstName) &&
                Objects.equals(lastName, that.lastName) &&
                Objects.equals(companyName, that.companyName) &&
                Objects.equals(country, that.country) &&
                Objects.equals(city, that.city) &&
                Objects.equals(street, that.street) &&
                Objects.equals(postalCode, that.postalCode) &&
                Objects.equals(phone, that.phone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, firstName, lastName, companyName,
                country, city, street, postalCode, phone, blacklisted);
    }

}
