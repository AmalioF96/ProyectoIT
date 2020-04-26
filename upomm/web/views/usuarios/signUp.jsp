<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro - UPOMarket</title>
        <link href="../../css/login.css" rel="stylesheet" type="text/css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="icon" type="image/png" href="/upomm/imagenes/icono.png">
        <s:head/>
    </head>
    <body id="body">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-md-offset-3">
                    <div class="card card-signin my-5">
                        <div class="card-body">
                            <s:a href="../principal.jsp">
                                <img id="logo" src="/upomm/imagenes/UPOMediaMarket.jpg" alt="Logo de UPOMediaMarket"/>
                            </s:a>
                            <h4 class="card-title text-center">Registro</h4>
                            <div class="contenedor">
                                <s:form action="signUp" cssClass="form-signin" method="post">
                                    <s:textfield name="usuario" label="Usuario" cssClass="form-control" ></s:textfield>
                                    <s:textfield name="email" label="Email" cssClass="form-control" ></s:textfield>
                                    <s:password name="password" label="Contraseña" cssClass="form-control" ></s:password>
                                    <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" ></s:password>
                                    <s:checkbox name="vendedor" label="¿Desea ser vendedor?"></s:checkbox>
                                    <s:textfield name="idProducto" value="%{#parameters.idProducto}" hidden="true"/>
                                    <s:submit name="btnRegistrar" value="Resgistrarse" id="inputVendedor" cssClass="btn btn-md btn-primary btn-block text-uppercase"></s:submit>
                                </s:form>
                            </div>
                            <p class="text-center">¿Ya tienes una cuenta? <s:a href="login.jsp">¡Inicia sesión!</s:a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
