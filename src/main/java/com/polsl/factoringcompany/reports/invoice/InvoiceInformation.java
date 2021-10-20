package com.polsl.factoringcompany.reports.invoice;

import com.polsl.factoringcompany.customer.CustomerEntity;
import com.polsl.factoringcompany.invoice.InvoiceEntity;
import com.polsl.factoringcompany.invoiceitem.InvoiceItemEntity;
import com.polsl.factoringcompany.product.ProductEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Component
public class InvoiceInformation {
    private String invoiceNumber;
    private String deliveryDate;
    private String issueDate;
    private String customerName;
    private String customerStreet;
    private String customerCity;
    private String deliveryMethod;
    private String deliveryDescription;
    private String paymentMethod;
    private String itemName;
    private String pkwiu;
    private String quantity;
    private String unit;
    private String vat;
    private String gross;
    private String net;
    private String vatValue;
    private String toPay;
    private String toPayInWords;

    public static ApplicationContext ctx;

    public InvoiceInformation(InvoiceEntity invoiceEntity, CustomerEntity customerEntity,
                              InvoiceItemEntity invoiceItemEntity, ProductEntity productEntity,
                              String currencyCode, String paymentMethod) {

        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        String deliveryDateFormat = df.format(invoiceEntity.getSaleDate());
        String issueDateFormat = df.format(invoiceEntity.getCreationDate());

        this.invoiceNumber = invoiceEntity.getInvoiceNumber();
        this.deliveryDate = deliveryDateFormat;
        this.issueDate = issueDateFormat;
        this.customerName = String.format("%s %s", customerEntity.getFirstName(), customerEntity.getLastName());
        this.customerStreet = String.format("%s", customerEntity.getStreet());
        this.customerCity = String.format("%s %s %s", customerEntity.getCity(), customerEntity.getPostalCode(),
                customerEntity.getCountry());

        this.deliveryMethod = "UPS";
        this.deliveryDescription = "lorem ipsum";

        this.paymentMethod = paymentMethod;
        this.itemName = productEntity.getName();
        this.pkwiu = productEntity.getPkwiu();
        this.quantity = String.valueOf(invoiceItemEntity.getQuentity());
        this.unit = productEntity.getMeasureUnit();
        this.vat = String.valueOf(invoiceItemEntity.getVatRate()) + "%";
        this.gross = String.valueOf(invoiceItemEntity.getGrossValue());
        this.net = String.valueOf(invoiceItemEntity.getNetValue());
        this.vatValue = String.valueOf(invoiceItemEntity.getVatValue());
        this.toPay = String.valueOf(invoiceEntity.getToPay()) + " " + currencyCode;
        this.toPayInWords = invoiceEntity.getToPayInWords() + " " + currencyCode;
    }

    public HashMap<String, String> getVariablesInHashMap() {
        HashMap<String, String> variables = new HashMap<>();
        variables.put("invoice_number", this.invoiceNumber);
        variables.put("delivery_date", this.deliveryDate);
        variables.put("issue_date", this.issueDate);
        variables.put("customer_name", this.customerName);
        variables.put("customer_street", this.customerStreet);
        variables.put("customer_city", this.customerCity);
        variables.put("delivery_method", this.deliveryMethod);
        variables.put("delivery_description", this.deliveryDescription);
        variables.put("payment_method", this.paymentMethod);
        variables.put("item_name", this.itemName);
        variables.put("pkwiu", this.pkwiu);
        variables.put("qnt", this.quantity);
        variables.put("unit", this.unit);
        variables.put("vat", this.vat);
        variables.put("gross", this.gross);
        variables.put("net", this.net);
        variables.put("vat_value", this.vatValue);
        variables.put("to_pay", this.toPay);
        variables.put("to_pay_in_words", this.toPayInWords);

        return variables;
    }
}
