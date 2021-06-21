package com.polsl.factoringcompany.invoice;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceRepository extends JpaRepository<InvoiceEntity, Long> {

    @Query(value = "SELECT max(i.id) FROM invoice i " +
            "WHERE FUNCTION('MONTH', i.creationDate) = ?1 AND " +
            "FUNCTION('YEAR', i.creationDate) = ?2")
    Long getInvoiceNumber(int month, int year);
}
