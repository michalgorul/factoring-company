package com.polsl.factoringcompany.reports.vat;

import com.polsl.factoringcompany.company.CompanyEntity;
import com.polsl.factoringcompany.customer.CustomerEntity;
import lombok.*;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.*;
import java.util.stream.Collectors;

@EqualsAndHashCode
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Component
public class VatReportInformation {

    private String name;
    private String nip;
    private String statusVat;
    private String regon;
    private String pesel;
    private String krs;
    private String residenceAddress;
    private String workingAddress;
    private List<String> representatives;
    private List<String> authorizedClerks;
    private List<String> partners;
    private String registrationLegalDate;
    private Object registrationDenialBasis;
    private Object registrationDenialDate;
    private Object restorationBasis;
    private Object restorationDate;
    private Object removalBasis;
    private Object removalDate;
    private List<String> accountNumbers;
    private boolean hasVirtualAccounts;

    private String customerName;
    private String customerEmail;
    private String customerCountry;
    private String customerCity;
    private String customerStreet;
    private String customerPostalCode;
    private String customerPhone;

    private String customerCompanyName;
    private String customerCompanyCountry;
    private String customerCompanyCity;
    private String customerCompanyStreet;
    private String customerCompanyPostalCode;
    private String customerCompanyNip;
    private String customerCompanyRegon;


    VatReportInformation(HashMap<String, Object> vatInformationInMap, CustomerEntity customerEntity, CompanyEntity companyEntity) {

        List<Object> tempRepresentatives = new ArrayList<>();
        List<Object> tempAuthorizedClerks = new ArrayList<>();
        List<Object> tempPartners = new ArrayList<>();
        List<Object> tempAccountNumbers = new ArrayList<>();


        this.name = (String) vatInformationInMap.get("name");
        this.nip = (String) vatInformationInMap.get("nip");
        this.statusVat = (String) vatInformationInMap.get("statusVat");
        this.regon = (String) vatInformationInMap.get("regon");
        this.pesel = (String) vatInformationInMap.get("pesel");
        this.krs = (String) vatInformationInMap.get("krs");
        this.residenceAddress = (String) vatInformationInMap.get("residenceAddress");
        this.workingAddress = (String) vatInformationInMap.get("workingAddress");

        tempRepresentatives = (List<Object>) Collections.singletonList(vatInformationInMap.get("tempRepresentatives")).get(0);
        if (tempRepresentatives != null)
            this.representatives = tempRepresentatives.stream().map(object -> Objects.toString(object, null))
                    .collect(Collectors.toList());
        else
            this.representatives = null;

        tempAuthorizedClerks = (List<Object>) Collections.singletonList(vatInformationInMap.get("tempAuthorizedClerks")).get(0);
        if (tempAuthorizedClerks != null)
            this.authorizedClerks = tempAuthorizedClerks.stream().map(object -> Objects.toString(object, null))
                    .collect(Collectors.toList());
        else
            this.authorizedClerks = null;

        tempPartners = (List<Object>) Collections.singletonList(vatInformationInMap.get("partners")).get(0);
        if (tempPartners != null)
            this.partners = tempPartners.stream().map(object -> Objects.toString(object, null))
                    .collect(Collectors.toList());
        else
            this.partners = null;

        this.registrationLegalDate = (String) vatInformationInMap.get("registrationLegalDate");
        this.registrationDenialBasis = vatInformationInMap.get("registrationDenialBasis");
        this.registrationDenialDate = vatInformationInMap.get("registrationDenialDate");
        this.restorationBasis = vatInformationInMap.get("restorationBasis");
        this.restorationDate = vatInformationInMap.get("restorationDate");
        this.removalBasis = vatInformationInMap.get("removalBasis");
        this.removalDate = vatInformationInMap.get("removalDate");

        tempAccountNumbers = (List<Object>) Collections.singletonList(vatInformationInMap.get("accountNumbers")).get(0);
        if (tempAccountNumbers != null)
            this.accountNumbers = tempAccountNumbers.stream().map(object -> Objects.toString(object, null))
                    .collect(Collectors.toList());
        else
            this.accountNumbers = null;


        this.hasVirtualAccounts = (boolean) vatInformationInMap.get("hasVirtualAccounts");

        this.customerName = customerEntity.getFirstName() + " " + customerEntity.getLastName();
        this.customerCountry = customerEntity.getCountry();
        this.customerCountry = customerEntity.getCity();
        this.customerCountry = customerEntity.getStreet();
        this.customerCountry = customerEntity.getPostalCode();
        this.customerCountry = customerEntity.getPhone();

        this.customerCompanyName = companyEntity.getCompanyName();
        this.customerCompanyCountry = companyEntity.getCountry();
        this.customerCompanyCity = companyEntity.getCity();
        this.customerCompanyStreet = companyEntity.getStreet();
        this.customerCompanyPostalCode = companyEntity.getStreet();
        this.customerCompanyNip = companyEntity.getNip();
        this.customerCompanyRegon = companyEntity.getRegon();
    }

    public HashMap<String, String> getVariablesInHashMap() {
        HashMap<String, String> variables = new HashMap<>();

        Field[] declaredFields = getClass().getDeclaredFields();

        for(Field field: declaredFields){
            variables.put(field.getName(), field.getName());
        }

//        variables.put("name", this.name);
//        variables.put("nip", this.nip);
//        variables.put("statusVat", this.statusVat);
//        variables.put("regon", this.regon);
//        variables.put("pesel", this.pesel);
//        variables.put("krs", this.krs);
//        variables.put("residenceAddress", this.deliveryMethod);
//        variables.put("workingAddress", this.deliveryDescription);
//        variables.put("payment_method", this.paymentMethod);
//        variables.put("representatives", this.itemName);
//        variables.put("authorizedClerks", this.pkwiu);
//        variables.put("partners", this.quantity);
//        variables.put("registrationLegalDate", this.unit);
//        variables.put("registrationDenialBasis", this.vat);
//        variables.put("registrationDenialDate", this.gross);
//        variables.put("restorationBasis", this.net);
//        variables.put("restorationDate", this.vatValue);
//        variables.put("removalBasis", this.toPay);
//        variables.put("removalDate", this.toPayInWords);
//        variables.put("accountNumbers", this.sellerCompany);
//        variables.put("hasVirtualAccounts", this.sellerStreet);
//        variables.put("customerName", this.sellerPostalCode);
//        variables.put("customerEmail", this.sellerCity);
//        variables.put("customerCountry", this.sellerCountry);
//        variables.put("customerCity", this.sellerPhone);
//        variables.put("customerStreet", this.sellerNip);
//        variables.put("customerPostalCode", this.sellerRegon);
//        variables.put("customerPhone", this.sellerRegon);
//        variables.put("customerCompanyName", this.sellerRegon);
//        variables.put("customerCompanyCountry", this.sellerRegon);
//        variables.put("customerCompanyCity", this.sellerRegon);
//        variables.put("customerCompanyStreet", this.sellerRegon);
//        variables.put("customerCompanyPostalCode", this.sellerRegon);
//        variables.put("customerCompanyNip", this.sellerRegon);
//        variables.put("customerCompanyRegon", this.sellerRegon);

        return variables;
    }


}

