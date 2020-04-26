<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión - UPOMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/upomm/css/login.css" rel="stylesheet" type="text/css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="icon" type="image/png" href="/upomm/imagenes/icono.png">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <s:head/>
        <s:if test="#session.usuario!=null">
            <jsp:forward page="/views/principal.jsp"/>
        </s:if>
    </head>
    <body id="body">
        <div class="container">
            <div class="row justify-content-center">
                <div id="card" class="col-md-6 col-md-offset-3">
                    <div class="card card-signin my-5">
                        <div class="card-body">
                            <s:a href="../principal.jsp">
                                <img id="logo" src="/upomm/imagenes/UPOMediaMarket.jpg" alt="Logo de UPOMediaMarket"/>
                            </s:a>
                            <h4 class="card-title text-center">Inicio de sesión</h4>
                            <s:if test="#request.error==true">
                                <p class="errorMessage">Las credenciales no son válidas</p>
                            </s:if>
                            <div class="contenedor">
                                <s:form cssClass="form-signin" action="accionLogin" method="post">
                                    <s:textfield name="email" cssClass="form-control" id="inputEmail" label="Correo electrónico"   />
                                    <s:password name="password" cssClass="form-control" id="inputPassword" label="Contraseña"/><br>
                                    <s:submit cssClass="btn btn-md btn-primary btn-block text-uppercase" name="btnLogin" value="Iniciar Sesión"/>
                                    <s:textfield name="idProducto" value="%{#parameters.idProducto}" hidden="true"/>
                                </s:form>
                            </div>
                            <p class="text-center">¿Aún no tienes una cuenta? <s:a href="./signUp.jsp">¡Regístrate!</s:a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
