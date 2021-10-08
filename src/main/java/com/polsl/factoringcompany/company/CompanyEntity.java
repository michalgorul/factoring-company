package com.polsl.factoringcompany.company;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.bankaccount.BankAccountEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "company")
public class CompanyEntity {

    @Id
    @SequenceGenerator(
            name = "company_id_seq",
            sequenceName = "company_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "company_id_seq"
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

    @Column(name = "nip", nullable = false, length = 10, unique = true)
    private String nip;

    @Column(name = "regon", nullable = false, length = 14, unique = true)
    private String regon;

    @OneToMany(mappedBy = "companyByCompanyId")
    @JsonIgnore
    private Collection<BankAccountEntity> bankAccountsById;

    @OneToMany(mappedBy = "companyByCompanyId")
    @JsonIgnore
    private Collection<UserEntity> usersById;

    @OneToMany(mappedBy = "companyByCompanyId")
    @JsonIgnore
    private Collection<CustomerEntity> customersById;


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
        return Objects.equals(id, that.id) &&
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
        return Objects.hash(id, companyName,
                country, city, street, postalCode, nip, regon);
    }

}
