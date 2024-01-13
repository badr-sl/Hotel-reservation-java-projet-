<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Réservation effectuée</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Helvetica', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }

        p {
            font-size: 18px;
            color: #555555;
            margin-bottom: 15px;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        li {
            font-size: 16px;
            color: #777777;
            margin-bottom: 10px;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        .btn {
            display: inline-block;
            border: none;
            outline: none;
            padding: 10px 20px;
            font-size: 18px;
            color: #ffffff;
            background-color: #007bff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .btn-primary {
            background-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

    </style>
</head>

<body>

<div class="container">
    <h1>Réservation effectuée</h1>
    <p>Votre réservation a été effectuée avec succès !</p>
    <p>Voici les détails de votre réservation :</p>
    <ul>
        <li>Nom du client : ${clientName} </li>
        <li>Adresse e-mail du client : ${clientEmail}</li>
        <li>Date de début de la réservation : ${startDate}</li>
        <li>Date de fin de la réservation : ${endDate}</li>
        <li>Nombre de nuits : ${numberOfNights}</li>
        <li>Prix total : ${totalPrice}</li>
    </ul>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Retour à l'accueil</a>
    <a href="${pageContext.request.contextPath}/PDFGeneratorServlet?clientName=${clientName}&clientEmail=${clientEmail}&startDate=${startDate}&endDate=${endDate}&numberOfNights=${numberOfNights}&totalPrice=${totalPrice}" class="btn btn-primary" download="reservation_details.pdf">Télécharger la facture en PDF</a>

</div>
</body>
</html>