<%@ page contentType="text/html;charset=UTF-8"  %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<style>
    body{
        background: #333333;
    }
    .a {
        color: red;
    }

    @media (min-width: 1025px) {
        .h-custom-2 {
            height: 100%;
        }
    }
    .vh-100{
        margin: 0 auto;
        width: 70%;
    }
</style>

<section class="vh-100">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6 text-black">

                <div class="px-5 ms-xl-4">
                    <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;"></i>
                    <span style="color: white" class="h1 fw-bold mb-0">Logo</span>
                </div>

                <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">

                    <form style="width: 23rem;" action="verificationServlet-servlet" method="post">

                        <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Log in</h3>

                        <div class="form-outline mb-4">
                            <label style="color: white" class="form-label" for="form2Example18">Email address :</label>
                            <input type="email" id="form2Example18" required name="email" class="form-control form-control-lg" aria-describedby="error-email" />
                            <div id="error-email" class="a" role="alert" style="display: ${requestScope.errorEmail}">
                                <i class="icon-remove-sign"></i>
                                <strong>${requestScope.errorEmail}</strong>
                            </div>
                        </div>

                        <div class="form-outline mb-4">
                            <label style="color: white" class="form-label" for="form2Example28">Password :</label>
                            <input type="password" id="form2Example28" required name="password" class="form-control form-control-lg" aria-describedby="error-password" />
                            <div id="error-password" class="a" role="alert"  style="display: ${requestScope.errorPassword}">
                                <i class="icon-remove-sign"></i>
                                <strong>${requestScope.errorPassword}</strong>
                            </div>
                        </div>

                        <div class="pt-1 mb-4">
                            <button class="btn btn-info btn-lg btn-block" type="submit">Login</button>
                        </div>

                        <p style="color: white"  class="small mb-5 pb-lg-2"><a class="text-muted" href="#!">Forgot password?</a></p>
                        <p>Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="link-info">Register here</a></p>

                    </form>
                </div>

            </div>
            <div class="col-sm-6 px-0 d-none d-sm-block">
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img3.webp"
                     alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
            </div>
        </div>
    </div>
</section>

