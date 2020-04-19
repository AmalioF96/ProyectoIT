<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro - UPOMarket</title>
        <link href="../../css/login.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body id="body">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-md-offset-3">
                    <div class="card card-signin my-5">
                        <div class="card-body">
                            <a href="">
                                <img id="logo" src="../../imagenes/UPOMediaMarket.jpg" alt="Logo de UPOMarket"/>
                            </a>
                            <h4 class="card-title text-center">Registro</h4>
                            <div class="contenedor">
                                <s:form action="" cssClass="form-signin">
                                <s:textfield name="usuario" label="Usuario" cssClass="form-control" ></s:textfield>
                                <s:textfield name="email" label="Email" cssClass="form-control" ></s:textfield>
                                <s:password name="password" label="Contraseña" cssClass="form-control" ></s:password>
                                <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" ></s:password>
                                <s:checkbox name="vendedor" label="¿Desea ser vendedor?"></s:checkbox>
                                <s:submit name="btnReistrar" label="Resgistrarse" id="inputVendedor" cssClass="btn btn-md btn-primary btn-block text-uppercase"></s:submit>
                            </s:form>
                            </div>
                            <p class="text-center">¿Ya tienes una cuenta? <a href="login.php">¡Inicia sesión!</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
