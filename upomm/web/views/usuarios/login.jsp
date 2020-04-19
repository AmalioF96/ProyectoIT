<%-- 
    Document   : login
    Created on : 19-abr-2020, 18:00:03
    Author     : Amalio
--%>

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
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="card card-signin my-5">
                        <div class="card-body">

                            <img id="logo" src="../../imagenes/UPOMediaMarket.jpg" alt="Logo de UPOMediaMarket"/>
                            
                            <h4 class="card-title text-center">Inicio de sesión</h4>
                            <s:form cssClass="form-signin" action="#" method="post">
                                <div class="form-label-group">
                                    <s:textfield name="email" cssClass="form-control" id="inputEmail" label="Correo electrónico"   />
                                </div>
                                <br />
                                <div class="form-label-group">
                                    <s:password name="password" cssClass="form-control" id="inputPassword" label="Contraseña"/>
                                </div>
                                <br />
                                <s:submit cssClass="btn btn-md btn-primary btn-block text-uppercase" name="btnLogin" value="Iniciar Sesión"/>
                                <br />
                                <p class="text-center">¿Aún no tienes una cuenta? <s:a href="signUp.php">¡Regístrate!</s:a></p>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
