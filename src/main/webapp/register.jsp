
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<form  action="loginServlet-servlet" class="form" method="post">
    <!-- 2 column grid layout with text inputs for the first and last names -->
    <div class="row mb-4">
        <div class="col">
            <div data-mdb-input-init class="form-outline">
                <label class="form-label" for="form6Example1" >First name :</label>
                <input type="text" name="firstname" required id="form6Example1" class="form-control" />
            </div>
        </div>
        <div class="col">
            <div data-mdb-input-init class="form-outline">
                <label class="form-label" for="form6Example2">Last name :</label>
                <input type="text" required name="lastname" id="form6Example2" class="form-control" />
            </div>
        </div>
    </div>

    <!-- Text input -->
    <div data-mdb-input-init class="form-outline mb-4">
        <label class="form-label" for="form6Example3">password :</label>
        <input type="text" required name="password" id="form6Example3" class="form-control" />
    </div>


    <!-- Email input -->
    <div data-mdb-input-init class="form-outline mb-4">
        <label class="form-label" for="form6Example5">Email :</label>
        <input type="email" id="form6Example5" required name="email" class="form-control" />
        <strong style="color: red">${requestScope.error}</strong>
    </div>

    <!-- Number input -->
    <div data-mdb-input-init class="form-outline mb-4">
        <label class="form-label" for="form6Example6">Phone :</label>
        <input type="tel" id="form6Example6" name="phone" class="form-control" />
    </div>

    <!-- Submit button -->
    <button  data-mdb-ripple-init type="submit" class="btn btn-primary btn-block mb-4">New Compte</button>
</form>
<style>
    /* Custom styles for the form */
    form {
        background-color: #f8f9fa; /* Light grey background */
        padding: 20px; /* Spacing around the form elements */
        border-radius: 8px; /* Rounded corners */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    }
    body{
        background:#333333 ;
    }

    /* Style for form outlines */
    .form-outline {
        margin-bottom: 15px; /* Spacing between form fields */
    }

    /* Style for input fields */
    .form-control {
        border: 1px solid #ced4da; /* Solid border for inputs */
        border-radius: 4px; /* Rounded corners for inputs */
    }

    /* Style for labels */
    .form-label {
        font-size: 0.9rem; /* Smaller font size for labels */
        color: #495057; /* Dark grey color for text */
    }

    /* Hover effect for input fields */
    .form-control:hover {
        border-color: #80bdff; /* Blue border on hover */
    }

    /* Focus effect for input fields */
    .form-control:focus {
        border-color: #80bdff; /* Blue border on focus */
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Blue glow on focus */
    }
    .form{
        margin: 0 auto; /* Définit les marges gauche et droite à auto */
        width: 50%; /* Définit la largeur du formulaire à 50% de la largeur de la page */
    }
</style>
