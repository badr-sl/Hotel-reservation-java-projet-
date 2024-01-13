package com.example.java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "loginServletServlet", value = "/loginServlet-servlet")
public class LoginServlet extends HttpServlet {

    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hoteldb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    private Connection connection;

    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error connecting to database", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user input from the login form
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String fullName = firstName + lastName;
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            if (isEmailUnique(email)) {
                // Insert data into the database
                try (PreparedStatement preparedStatement = connection.prepareStatement(
                        "INSERT INTO client (nom, email, password, phone) VALUES (?, ?, ?, ?)")) {
                    preparedStatement.setString(1, fullName);
                    preparedStatement.setString(2, email);
                    preparedStatement.setString(3, password);
                    preparedStatement.setString(4, phone);
                    preparedStatement.executeUpdate();
                }

                // Successful registration
                HttpSession session = request.getSession();
                session.setAttribute("fullname", fullName);
                session.setAttribute("phone", phone);
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                // Email already exists
                request.setAttribute("error", "Email already exists.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error during registration", e);
        }
    }

    private boolean isEmailUnique(String email) throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT * FROM client WHERE email = ?")) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            return !resultSet.next();
        }
    }
}