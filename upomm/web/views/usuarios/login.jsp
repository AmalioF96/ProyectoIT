<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión - UPOMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../../css/login.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <s:head/>
    </head>
    <body id="body">
        <div class="container">
            <div class="row justify-content-center">
                <div id="card" class="col-md-6 col-md-offset-3">
                    <div class="card card-signin my-5">
                        <div class="card-body">
                            <s:a>
                                <img id="logo" src="../../imagenes/UPOMediaMarket.jpg" alt="Logo de UPOMediaMarket"/>
                            </s:a>
                            <h4 class="card-title text-center">Inicio de sesión</h4>
                            <div class="contenedor">
                                <s:form cssClass="form-signin" action="#" method="post">
                                    <s:textfield name="email" cssClass="form-control" id="inputEmail" label="Correo electrónico"   />
                                    <s:password name="password" cssClass="form-control" id="inputPassword" label="Contraseña"/><br>
                                    <s:submit cssClass="btn btn-md btn-primary btn-block text-uppercase" name="btnLogin" value="Iniciar Sesión"/>
                                </s:form>
                            </div>
                            <p class="text-center">¿Aún no tienes una cuenta? <s:a href="signUp.php">¡Regístrate!</s:a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
