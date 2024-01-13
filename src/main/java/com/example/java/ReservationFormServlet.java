package com.example.java;

import com.twilio.Twilio;
import com.twilio.exception.TwilioException;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import jakarta.mail.*;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@WebServlet(name = "ReservationFormServlet", value = "/ReservationFormServlet")
public class ReservationFormServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hoteldb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";


    private Connection connection;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String typeId = request.getParameter("typeId");
            List<Chambre> chambresDisponibles = getAvailableRoomsByType(typeId);
            request.setAttribute("chambresDisponibles", chambresDisponibles);
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors du chargement du formulaire.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private List<Chambre> getAvailableRoomsByType(String typeId) throws SQLException {
        List<Chambre> chambresDisponibles = new ArrayList<>();
        String sql = "SELECT * FROM Chambre WHERE idType = ? AND disponibilite = true";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(typeId));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Chambre chambre = new Chambre();
                    chambre.setIdChambre(rs.getString("idChambre"));
                    chambresDisponibles.add(chambre);
                }
            }
        }
        return chambresDisponibles;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String clientName = request.getParameter("clientName");
            String clientEmail = request.getParameter("clientEmail");
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
            int chambreId = Integer.parseInt(request.getParameter("chambreId"));
            HttpSession session = request.getSession();
            String clientPhoneNumber = getClientPhoneNumber(clientEmail);


            int typeId = getTypeIdFromChambreId(chambreId);

            // Get the price from the Type table
            double price = getPriceFromTypeId(typeId);

            // Calculate the number of nights
            int numberOfNights = (int) ((endDate.toEpochDay() - startDate.toEpochDay()) + 1);

            // Calculate the total price
            double totalPrice = price * numberOfNights;

            if (startDate.isAfter(endDate)) {
                // Set the error message in the request scope
                request.setAttribute("errorDate", "La date de début doit être avant la date de fin.");

                // Forward to the JSP file
                request.getRequestDispatcher("/reservation.jsp").forward(request, response);
                return; // Make sure to return to stop further processing
            }

            // Insert reservation into the database
            String insertSql = "INSERT INTO Reservation (idClient, idChambre, Date_debut, Date_fin, PrixTotale,Status) VALUES (?, ?, ?, ?, ? ,?)";
            try (PreparedStatement stmt = connection.prepareStatement(insertSql)) {
                stmt.setInt(1, getClientIdFromEmail(clientEmail));
                stmt.setInt(2, chambreId);
                stmt.setDate(3, Date.valueOf(startDate));
                stmt.setDate(4, Date.valueOf(endDate));
                stmt.setDouble(5, totalPrice);
                stmt.setString(6, "enabled");
                stmt.executeUpdate();
            }

            session = request.getSession();
            session.setAttribute("clientName", clientName);
            session.setAttribute("startDate", startDate);
            session.setAttribute("endDate", endDate);
            session.setAttribute("numberOfNights", numberOfNights);
            session.setAttribute("totalPrice", totalPrice);
            session.setAttribute("clientEmail", clientEmail);

            // Update room availability
            String updateSql = "UPDATE Chambre SET disponibilite = false WHERE idChambre = ?";
            try (PreparedStatement stmt = connection.prepareStatement(updateSql)) {
                stmt.setInt(1, chambreId);
                stmt.executeUpdate();

                // Set up Gmail SMTP server properties
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", "587"); // Use 587 for TLS
                props.put("mail.smtp.starttls.enable", "true");

                // Gmail account credentials
                final String username = "hotel.golden620@gmail.com";
                final String password = "eeuw akod uqps wzpv";

                // Create a session with authentication
                Session mailSession = Session.getInstance(props,
                        new jakarta.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(username, password);
                            }
                        });

                // Create a default MimeMessage object
                jakarta.mail.Message message = new MimeMessage(mailSession);

                // Set the From and To addresses
                message.setFrom(new InternetAddress(username));
                message.setRecipients(jakarta.mail.Message.RecipientType.TO, InternetAddress.parse(clientEmail));

                // Set the email subject and content
                message.setSubject("Reservation Confirmation");
                message.setText( "Bonjour " + clientName + ",\nVotre réservation a été confirmée !\n" +
                        "Détails de la réservation :\n" +
                        "Date de début : " + startDate + "\n" +
                        "Date de fin : " + endDate + "\n" +
                        "Nombre de nuits : " + numberOfNights + "\n" +
                        "Prix total : " + totalPrice + " €\n" +
                        "L'équipe de l'hôtel");

                // Send the message
                Transport.send(message);

                System.out.println("Email sent successfully!");
            } catch (SQLException | MessagingException e) {
                throw new RuntimeException(e);
            }

            request.setAttribute("successMessage", "La réservation a été effectuée avec succès!");
            request.getRequestDispatcher("success.jsp").forward(request, response);

            // Send confirmation SMS
            sendConfirmationSMS(clientName, clientPhoneNumber, startDate, endDate, numberOfNights, totalPrice);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors du chargement du formulaire.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


    private String getClientPhoneNumber(String clientEmail) throws SQLException {
        String query = "SELECT phone FROM client WHERE email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, clientEmail);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("phone");
            }
        }
        return null;
    }


    private void sendConfirmationSMS(String clientName,String clientPhoneNumber, LocalDate startDate, LocalDate endDate, int numberOfNights, double totalPrice) {
        try {
            // Replace with your actual Twilio account SID and auth token
            Twilio.init("ACa0f839a9b82b119e07456b216516c408", "2cd8ee29995b3835dade065fd7d662df");

            String smsContent = "Bonjour " + clientName + ",\nVotre réservation a été confirmée !\n" +
                    "Détails de la réservation :\n" +
                    "Date de début : " + startDate + "\n" +
                    "Date de fin : " + endDate + "\n" +
                    "Nombre de nuits : " + numberOfNights + "\n" +
                    "Prix total : " + totalPrice + " €\n" +
                    "L'équipe de l'hôtel";

            // Create the message with appropriate formatting
            Message message = Message.creator(
                            new com.twilio.type.PhoneNumber(clientPhoneNumber), // Recipient's phone number
                            new com.twilio.type.PhoneNumber("+19287568048"), // Your Twilio phone number
                            smsContent)
                    .create();

            System.out.println("SMS sent successfully! SID: " + message.getSid());
        } catch (TwilioException e) {
            System.err.println("Error sending SMS: " + e.getMessage());
            // Handle the exception appropriately, e.g., log the error, notify the user, or retry
        }
    }


    private int getClientIdFromEmail(String clientEmail) throws SQLException {
        String sql = "SELECT idClient FROM client WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, clientEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("idClient");
                } else {
                    throw new RuntimeException("Aucun client trouvé avec l'email " + clientEmail);
                }
            }
        }
    }

    private int getTypeIdFromChambreId(int chambreId) throws SQLException {
        String sql = "SELECT idType FROM Chambre WHERE idChambre = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, chambreId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("idType");
                } else {
                    throw new RuntimeException("Aucune chambre trouvée avec l'ID " + chambreId);
                }
            }
        }
    }

    private double getPriceFromTypeId(int typeId) throws SQLException {
        String sql = "SELECT PrixUnitaire FROM Type WHERE idType = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, typeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("PrixUnitaire");
                } else {
                    throw new RuntimeException("Aucun type trouvé avec l'ID " + typeId);
                }
            }
        }
    }
}
