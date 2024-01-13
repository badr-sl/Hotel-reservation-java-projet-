<%@ page contentType="text/html;charset=UTF-8"  %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0">
    <title>Document</title>

    <!-- Bootstrap javascript link -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        select {
            padding: 10px; /* Ajoute de l'espace autour du texte à l'intérieur du select */
            font-size: 16px; /* Taille de la police */
            border: 1px solid #ccc; /* Bordure */
            border-radius: 5px; /* Coins arrondis */
        }

        /* Style au survol */
        select:hover {
            border-color: #555; /* Couleur de la bordure au survol */
        }

        /* Style au focus */
        select:focus {
            outline: none; /* Supprime la bordure bleue par défaut au focus */
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.3); /* Ajoute une légère ombre au focus */
        }

        /* Style pour les options du select */
        select option {
            background-color: #fff; /* Couleur de fond des options */
            color: #333; /* Couleur du texte des options */
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50; /* Couleur de fond */
            color: #fff; /* Couleur du texte */
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .container {
            display: flex;
            align-items: center;
            justify-content: space-between;

            margin: 20px auto;

            padding: 10px;
        }
        h2{
            padding-bottom: 90px;
        }


        .image {
            max-width: 40%;
            margin-right: 10px;
        }

        .description {
            max-width: 50%;
        }
        body {
            background: #cccccc;
        }

        .brand {
            color: #FF9138;
        }

        .border-hover {
            border-top: 5px solid transparent;
            transform: translateY(-4px);
        }

        .border-hover:hover {
            border-top: 5px solid #333333;
            transform: translateY(-4px);
        }

        #sign-in {
            background: #333333;
            border-top-left-radius: 50px;
            border-bottom-left-radius: 50px;
        }

        .navbar-toggler {
            border: 3px solid #333333;
        }




        .navbar-toggler:focus {
            box-shadow: none;
        }

        #nav-length {
            width: 90%;
        }

        @media screen and (max-width : 992px) {
            #nav-length {
                width: 100%;
            }

            .border-hover {
                border-top: 0;
            }

            .border-hover:hover {
                border-top: 0;
            }

            #sign-in {
                border-radius: 50px;
            }
        }
        nav{
            padding-right: 96px;
            background-color: #DC8E47;
        }

        footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        .contact-section {
            margin-top: 20px;
        }

        .contact-info {
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: #444;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .contact-info p {
            margin: 0;
            color: #fff;
        }

        h2 {
            color: #fff;
        }

        p {
            margin-bottom: 10px;
        }

        a {
            color: #cccccc;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }




    </style>
</head>

<body>
<nav>
    <div class="navbar navbar-expand-lg pt-4">
        <div class="container-fluid">
            <a href="#" class="brand text-decoration-none d-block d-lg-none fw-bold fs-1 ">LOGO</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                <ul id="nav-length" class="navbar-nav justify-content-between border-top border-2 text-center">

                    <li class="nav-item">
                        <a href="#" class="nav-link border-hover py-3 text-white">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a href="#a1" class="nav-link border-hover py-3 text-white">Our Services</a>
                    </li>
                    <li class="nav-item">
                        <a href="#f1" class="nav-link border-hover py-3 text-white">Contact Us</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.isLoggedIn and sessionScope.isLoggedIn}">
                            <!-- If the user is logged in, display the welcome message -->
                            <li class="nav-item">
                                Welcome, ${sessionScope.clientName} | <a href="LogoutServlet">Déconnexion</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- If the user is not logged in, display the Sign In link -->
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/login.jsp" id="sign-in" class="nav-link my-2 px-4 text-white">
                                    Sign In
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>

                </ul>
            </div>
        </div>
    </div>
</nav>
<div id="carouselExampleIndicators" class="carousel slide  " data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img class="d-block w-100" src="https://e1.pxfuel.com/desktop-wallpaper/433/947/desktop-wallpaper-luxury-vacation-luxury-hotel.jpg" alt="First slide">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="https://e0.pxfuel.com/wallpapers/23/507/desktop-wallpaper-luxury-hotel-luxurious-hotel-hotel-five-star-hotel.jpg" alt="Second slide">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="https://e0.pxfuel.com/wallpapers/285/120/desktop-wallpaper-tropical-beach-resort-luxury-vacation.jpg" alt="Third slide">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="https://e0.pxfuel.com/wallpapers/807/909/desktop-wallpaper-phuket-thailand-hotel-luxurious-hotel-phuket-thailand-thailand-hotel-luxury-hotel.jpg" alt="Third slide">
        </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<div id="a1">
    <div class="container">
        <div class="description">
            <h2>l'Hôtel Étoile Dorée chambre type 1 :</h2>
            <p>Découvrez le charme incomparable de l'Hôtel Étoile Dorée, votre oasis de tranquillité au cœur de la ville. Niché dans un quartier élégant, notre établissement offre un mélange harmonieux de confort moderne et d'élégance intemporelle.</p>
            <button onclick="loadForm('1')">Chambre Standard</button>
        </div>
        <img src="https://www.deco.fr/sites/default/files/styles/width_880/public/migration-images/101529.webp?itok=Mh1sTy6h" alt="Description de l'image" class="image">
    </div>
    <div class="container">
        <img src="https://www.deco.fr/sites/default/files/styles/width_880/public/migration-images/101531.webp?itok=tJql4vjp" alt="Description de l'image" class="image">
        <div class="description">
            <h2 class="titre">l'Hôtel Étoile Dorée chambre type 2 :</h2>
            <p>Découvrez le charme incomparable de l'Hôtel Étoile Dorée, votre oasis de tranquillité au cœur de la ville. Niché dans un quartier élégant, notre établissement offre un mélange harmonieux de confort moderne et d'élégance intemporelle.</p>
            <button onclick="loadForm('2')">Suite Junior </button>
        </div>
    </div>
    <div class="container">
        <div class="description">
            <h2>l'Hôtel Étoile Dorée chambre type 3 :</h2>
            <p>Découvrez le charme incomparable de l'Hôtel Étoile Dorée, votre oasis de tranquillité au cœur de la ville. Niché dans un quartier élégant, notre établissement offre un mélange harmonieux de confort moderne et d'élégance intemporelle.</p>
            <button onclick="loadForm('3')">Suite Exécutive</button>
        </div>
        <img src="https://www.deco.fr/sites/default/files/styles/width_880/public/migration-images/101539.webp?itok=B1D7gVVN" alt="Description de l'image" class="image">
    </div>
</div>
<div class="container">
    <img src="https://www.deco.fr/sites/default/files/styles/width_880/public/migration-images/101531.webp?itok=tJql4vjp" alt="Description de l'image" class="image">
    <div class="description">
        <h2 class="titre">l'Hôtel Étoile Dorée chambre type 2 :</h2>
        <p>Découvrez le charme incomparable de l'Hôtel Étoile Dorée, votre oasis de tranquillité au cœur de la ville. Niché dans un quartier élégant, notre établissement offre un mélange harmonieux de confort moderne et d'élégance intemporelle.</p>
        <button onclick="loadForm('4')">Suite de Luxe </button>
    </div>
</div>
<footer id="f1">
    <div class="contact-section">
        <h2>Contactez-nous</h2>
        <div class="contact-info">
            <p>Email: <a href="hotel.golden620@gmail.com">hotel.golden620@gmail.com</a></p>
            <p>Téléphone: +1 123 456 7890</p>
            <p>Adresse: 123 Rue de l'avenu, Ville</p>
        </div>
    </div>
    <p>&copy; 2023 badr | Tous droits réservés</p>
</footer>


<!-- bootstrap Script File -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    function loadForm(typeId) {
        // Redirigez vers la servlet avec le type de chambre en tant que paramètre
        window.location.href = "ReservationFormServlet?typeId=" + typeId;
    }
</script>


</body>

</html>