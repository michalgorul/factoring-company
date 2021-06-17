package com.polsl.factoringcompany.seller;

import com.polsl.factoringcompany.bankaccount.BankAccountEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "seller", schema = "public")
public class SellerEntity {

    @Id
    @Column(name = "id", nullable = false)
    @SequenceGenerator(
            name = "seller_sequence",
            sequenceName = "seller_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "seller_sequence"
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

    @Column(name = "nip", nullable = false, length = 10)
    private String nip;

    @Column(name = "regon", nullable = false, length = 14)
    private String regon;

    @OneToMany(mappedBy = "sellerBySellerId")
    private Collection<BankAccountEntity> bankAccountsById;



    public SellerEntity() {
    }

    public SellerEntity(String firstName, String lastName, String companyName,
                        String country, String city, String street,
                        String postalCode, String nip, String regon) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.companyName = companyName;
        this.country = country;
        this.city = city;
        this.street = street;
        this.postalCode = postalCode;
        this.nip = nip;
        this.regon = regon;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SellerEntity that = (SellerEntity) o;
        return id == that.id &&
                Objects.equals(firstName, that.firstName) &&
                Objects.equals(lastName, that.lastName) &&
                Objects.equals(companyName, that.companyName) &&
                Objects.equals(country, that.country) &&
                Objects.equals(city, that.city) &&
                Objects.equals(street, that.street) &&
                Objects.equals(postalCode, that.postalCode) &&
                Objects.equals(nip, that.nip) &&
                Objects.equals(regon, that.regon);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, firstName, lastName, companyName,
                country, city, street, postalCode, nip, regon);
    }

}
