package com.polsl.factoringcompany.bankaccount;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.company.CompanyEntity;
import com.polsl.factoringcompany.seller.SellerEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "bank_account", schema = "public", catalog = "factoring_company")
public class BankAccountEntity {
    @Id
    @SequenceGenerator(
            name = "bank_account_sequence",
            sequenceName = "bank_account_sequence",
            allocationSize = 1
    )
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "bank_account_sequence"
    )
    private Long id;

    @Column(name = "bank_swift", nullable = false, length = 8)
    private String bankSwift;

    @Column(name = "bank_account_number", nullable = false, length = 28, unique = true)
    private String bankAccountNumber;

    @Column(name = "bank_name", nullable = false, length = 16)
    private String bankName;

    @Column(name = "seller_id", nullable = true)
    private Integer sellerId;

    @Column(name = "company_id", nullable = true)
    private Integer companyId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "seller_id", referencedColumnName = "id", insertable = false, updatable = false)
    private SellerEntity sellerBySellerId;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "company_id", referencedColumnName = "id", insertable = false, updatable = false)
    private CompanyEntity companyByCompanyId;

    public BankAccountEntity() {
    }

    public BankAccountEntity(String bankSwift, String bankAccountNumber,
                             String bankName, Integer sellerId, Integer companyId) {
        this.bankSwift = bankSwift;
        this.bankAccountNumber = bankAccountNumber;
        this.bankName = bankName;
        this.sellerId = sellerId;
        this.companyId = companyId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BankAccountEntity that = (BankAccountEntity) o;
        return id == that.id &&
                Objects.equals(bankSwift, that.bankSwift) &&
                Objects.equals(bankAccountNumber, that.bankAccountNumber) &&
                Objects.equals(bankName, that.bankName) &&
                Objects.equals(sellerId, that.sellerId) &&
                Objects.equals(companyId, that.companyId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, bankSwift, bankAccountNumber, bankName, sellerId, companyId);
    }

}