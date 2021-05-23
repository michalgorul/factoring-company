package com.polsl.factoringcompany.company;

import lombok.Getter;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Entity
@Table(name = "company")
public class CompanyEntity {

    @Id
    @SequenceGenerator(
            name = "company_sequence",
            sequenceName = "company_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "company_sequence"
    )
    private Long id;

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

    public CompanyEntity() {

    }

    public CompanyEntity(String companyName, String country, String city, String street, String postalCode, String nip, String regon) {
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
        CompanyEntity that = (CompanyEntity) o;
        return Objects.equals(id, that.id) && Objects.equals(companyName, that.companyName) &&
                Objects.equals(country, that.country) && Objects.equals(city, that.city) &&
                Objects.equals(street, that.street) && Objects.equals(postalCode, that.postalCode) &&
                Objects.equals(nip, that.nip) && Objects.equals(regon, that.regon);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, companyName, country, city, street, postalCode, nip, regon);
    }
}
