<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.java.Chambre" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>

<%
    List<Chambre> chambresDisponibles = (List<Chambre>) request.getAttribute("chambresDisponibles");
%>

<html>
<head>
    <title>Réservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input,
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        p.error-message {
            color: red;
        }
    </style>
</head>
<body>

<h2>Formulaire de Réservation</h2>
<p style="color: red;">
</p>
<form action="ReservationFormServlet" method="post" onsubmit="return validateForm()">
    <label for="clientName">Nom du client :</label>
    <input type="text" id="clientName" name="clientName" required><br>

    <label for="clientEmail">Email du client :</label>
    <input type="email" id="clientEmail" name="clientEmail" required><br>

    <label for="startDate">Date de début :</label>
    <input type="date" id="startDate" name="startDate" required><br>

    <label for="endDate">Date de fin :</label>
    <input type="date" id="endDate" name="endDate" required><br>
    <div id="errorDiv" style="color: red;"></div>


    <label for="roomType">Type de chambre :</label>
    <select id = "roomType" name="chambreId">
        <option value="">Choisir une chambre</option>
        <% if (chambresDisponibles.isEmpty()) { %>
        <option value="">Aucune chambre disponible</option>
        <% } else { %>
        <% for (Chambre chambre : chambresDisponibles) { %>
        <option value="<%= chambre.getIdChambre() %>">chamber <%= chambre.getIdChambre() %></option>
        <% } %>
        <% } %>
    </select><br>


    <button type="submit">Réserver</button>
</form>
<script>
    function validateForm() {
        var startDate = new Date(document.getElementById('startDate').value);
        var endDate = new Date(document.getElementById('endDate').value);

        // Check for the error condition
        if (startDate > endDate) {
            // Display the error message
            document.getElementById('errorDiv').innerHTML = "La date de début doit être avant la date de fin.";
            return false; // Prevent form submission
        } else {
            // Clear the error message
            document.getElementById('errorDiv').innerHTML = "";
            return true; // Allow form submission
        }
    }
</script>
 </body>
 </html>
