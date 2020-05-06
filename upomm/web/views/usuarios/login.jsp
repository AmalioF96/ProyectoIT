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
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <s:head/>
        <s:if test="#session.usuario!=null">
            <jsp:forward page="/views/principal.jsp"/>
        </s:if>
        <script>
            $(document).ready(function () {
                $('#modalLogin').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
                var a = $("#loginForm").find("br");
                for (var i = 0; i < a.length; i++) {
                    $(a).remove();
                }
                $("#send").click(function () {
                    $("#loginForm").submit();
                });
            });
        </script>
    </head>
    <body>
        <div class="container-fluid">
            <!-- Modal -->
            <div class="modal fade" id="modalLogin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered cascading-modal" role="document">
                    <div class="modal-content">
                        <div class="modal-header pb-0">
                            <s:a href="/upomm/views/principal.jsp" cssClass="close">
                                <span aria-hidden="true">&times;</span>
                            </s:a>
                        </div>
                        <div class="modal-header pt-0">
                            <s:a id="logo" href="../principal.jsp">
                                <img src="/upomm/imagenes/UPOMediaMarket_Logo2.jpg" alt="Logo de UPOMediaMarket"/>
                            </s:a>
                        </div>
                        <div class="modal-body pt-0">
                            <h4 class="modal-title text-center">Inicio de sesión</h4>
                            <s:if test="hasActionErrors()">
                                <s:actionerror cssClass="errorMessage text-center"/>
                            </s:if>
                            <div class="contenedor mt-2">
                                <s:form id="loginForm" cssClass="form-signin" action="accionLogin" theme="css_xhtml">
                                    <s:textfield name="email" cssClass="form-control" id="inputEmail" label="Email"   />
                                    <s:password name="password" cssClass="form-control" id="inputPassword" label="Contraseña"/>
                                    <s:hidden name="idProducto" value="%{#parameters.idProducto}"/>
                                </s:form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="send" class="btn btn-primary btn-block text-uppercase">Iniciar Sesión</button>
                        </div>
                        <p class="text-center">¿Aún no tienes una cuenta? 
                            <s:a href="signUp.jsp">¡Regístrate!</s:a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
