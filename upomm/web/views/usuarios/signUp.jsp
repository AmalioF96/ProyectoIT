<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro - UPOMediaMarket</title>
        <link href="/upomm/css/login.css" rel="stylesheet" type="text/css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="icon" type="image/png" href="/upomm/imagenes/icono.png">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function () {
                $('#modalRegistro').modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });
                var a = $("#registroForm").find("br");
                for (var i = 0; i < a.length; i++) {
                    $(a).remove();
                }
                $("#send").click(function () {
                    $("#registroForm").submit();
                });
            });
        </script>
        <s:head/>
    </head>
    <body>
        <div class="container-fluid">
            <!-- Modal -->
            <div class="modal fade" id="modalRegistro" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered cascading-modal" role="document">
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
                            <h4 class="modal-title text-center">Registro</h4>
                            <div class="contenedor mt-2">
                                <s:form id="registroForm" action="signUp" cssClass="form-signin" theme="css_xhtml">
                                    <s:textfield name="usuario" label="Usuario" cssClass="form-control" />
                                    <s:textfield name="email" label="Email" cssClass="form-control" />
                                    <s:password name="password" label="Contraseña" cssClass="form-control" />
                                    <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" />
                                    <div class="custom-control custom-switch wwgrp">
                                        <s:checkbox id="vendedor" name="vendedor" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true"/>
                                        <label class="custom-control-label wwlbl" for="vendedor">¿Desea ser vendedor?</label>
                                    </div>
                                    <s:hidden name="idProducto" value="%{#parameters.idProducto}"/>
                                </s:form>
                            </div>
                        </div>
                        <div class="modal-footer mt-3">
                            <button id="send" class="btn btn-primary btn-block text-uppercase">Registrarse</button>
                        </div>
                        <p class="text-center">¿Ya tienes una cuenta?
                            <s:a href="login.jsp">¡Inicia Sesión!</s:a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
