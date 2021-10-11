package com.polsl.factoringcompany.reports;

import org.docx4j.Docx4J;
import org.docx4j.model.datastorage.migration.VariablePrepare;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;

public class GenerateInvoicePdf {

    private final static String PATH = "src/main/resources/static/invoice_template.docx";

    public static void generateDocxFileFromTemplate() throws Exception {

        File invoiceTemplate = new File(PATH);

        WordprocessingMLPackage wordMLPackage = WordprocessingMLPackage.load(invoiceTemplate);

        MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();

        VariablePrepare.prepare(wordMLPackage);

        HashMap<String, String> variables = new HashMap<>();
        variables.put("var", "test");

        documentPart.variableReplace(variables);
        FileOutputStream os = new FileOutputStream("test.pdf");

        Docx4J.toPDF(wordMLPackage,os);
        os.flush();
        os.close();




    }

}
