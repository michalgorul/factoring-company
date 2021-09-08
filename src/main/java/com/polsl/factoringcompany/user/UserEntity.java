package com.polsl.factoringcompany.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.company.CompanyEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.files.FileEntity;
import com.polsl.factoringcompany.order.OrderEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "user", schema = "public", catalog = "factoring_company")
public class UserEntity {

    @Id
    @SequenceGenerator(
            name = "user_sequence",
            sequenceName = "user_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "user_sequence"
    )
    private Long id;

    @Column(name = "username", nullable = false, length = 50, unique = true)
    private String username;

    @Column(name = "password", nullable = false, length = 100)
    private String password;

    @Column(name = "email", nullable = false, length = 50, unique = true)
    private String email;

    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 50)
    private String lastName;

    @Column(name = "country", nullable = false, length = 50)
    private String country;

    @Column(name = "city", nullable = false, length = 50)
    private String city;

    @Column(name = "street", nullable = false, length = 50)
    private String street;

    @Column(name = "postal_code", nullable = true, length = 15)
    private String postalCode;

    @Column(name = "phone", nullable = false, length = 15)
    private String phone;

    @Column(name = "company_id", nullable = false)
    private int companyId;

    @OneToMany(mappedBy = "userByUserId")
    private Collection<OrderEntity> ordersById;

    @OneToMany(mappedBy = "userByUserId")
    private Collection<CustomerEntity> customersById;

    @OneToMany(mappedBy = "userByUserId")
    private Collection<FileEntity> filesById;



    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "company_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private CompanyEntity companyByCompanyId;

    public UserEntity() {
    }

    public UserEntity(String username, String password, String email, String firstName,
                      String lastName, String country, String city, String street,
                      String postalCode, String phone, int companyId) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.country = country;
        this.city = city;
        this.street = street;
        this.postalCode = postalCode;
        this.phone = phone;
        this.companyId = companyId;
    }

    public UserEntity(UserEntity userEntity) {
        this.username = userEntity.getUsername();
        this.password = userEntity.getPassword();
        this.email = userEntity.getEmail();
        this.firstName = userEntity.getFirstName();
        this.lastName = userEntity.getLastName();
        this.country = userEntity.getCountry();
        this.city = userEntity.getCity();
        this.street = userEntity.getStreet();
        this.postalCode = userEntity.getPostalCode();
        this.phone = userEntity.getPhone();
        this.companyId = userEntity.getCompanyId();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntity that = (UserEntity) o;
        return companyId == that.companyId && Objects.equals(id, that.id) && Objects.equals(username, that.username) && Objects.equals(password, that.password) && Objects.equals(email, that.email) && Objects.equals(firstName, that.firstName) && Objects.equals(lastName, that.lastName) && Objects.equals(country, that.country) && Objects.equals(city, that.city) && Objects.equals(street, that.street) && Objects.equals(postalCode, that.postalCode) && Objects.equals(phone, that.phone) && Objects.equals(ordersById, that.ordersById) && Objects.equals(customersById, that.customersById) && Objects.equals(filesById, that.filesById) && Objects.equals(companyByCompanyId, that.companyByCompanyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, password, email, firstName, lastName, country, city, street, postalCode, phone, companyId, ordersById, customersById, filesById, companyByCompanyId);
    }
}
