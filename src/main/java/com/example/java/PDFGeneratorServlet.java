package com.example.java;

import com.itextpdf.kernel.colors.Color;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;

import static com.itextpdf.kernel.pdf.PdfName.Color;

@WebServlet(name = "PDFGeneratorServlet", value = "/PDFGeneratorServlet")
public class PDFGeneratorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer les paramètres de l'URL
            String clientName = request.getParameter("clientName");
            String clientEmail = request.getParameter("clientEmail");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String numberOfNights = request.getParameter("numberOfNights");
            String totalPrice = request.getParameter("totalPrice");


            // Configuration de la réponse pour générer un PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=reservation_details.pdf");

            // Création du document PDF
            try (OutputStream outputStream = response.getOutputStream();
                 PdfWriter pdfWriter = new PdfWriter(outputStream);
                 PdfDocument pdfDocument = new PdfDocument(pdfWriter);
                 Document document = new Document(pdfDocument)) {

                // Ajout du contenu au document PDF
                document.add(new Paragraph("Détails de la réservation"));

                document.add(new Paragraph("Client Name: " + clientName));
                document.add(new Paragraph("Client Email: " + clientEmail));
                document.add(new Paragraph("Date de début: " + startDate));
                document.add(new Paragraph("Date de fin: " + endDate));
                document.add(new Paragraph("Nombre de nuits: " + numberOfNights));
                document.add(new Paragraph("Prix total: " + totalPrice));

                float[] columnWidths = {150f, 150f};
                Table table = new Table(columnWidths);
                table.addCell(new Cell().add(new Paragraph("Prix total")).setBold());

// Ajouter les détails dans le tableau
                table.addCell(new Cell().add(new Paragraph(totalPrice + " €")));
                document.add(table);

                // Ajouter un paragraphe de remerciement
                Color greenColor = new DeviceRgb(0, 255, 0); // Vert en RGB
                document.add(new Paragraph("Nous vous remercions pour votre réservation et vous souhaitons un agréable séjour!")
                        .setFontColor(greenColor).setFontSize(16));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Une erreur s'est produite lors de la génération du PDF.");
        }
    }
}
