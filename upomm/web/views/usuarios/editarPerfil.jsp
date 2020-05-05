<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Perfil - UPOMediaMarket</title>
        <link href="/upomm/css/perfil.css" rel="stylesheet" type="text/css"/>
        <%@include file="/views/utils/includes.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>
        <script>
            $(document).ready(function () {
                var a = $("#perfilForm").find("br");
                for (var i = 0; i < a.length; i++) {
                    $(a).remove();
                }
                $("img").on("error", function () {
                    $(this).attr("src", "/upomm/imagenes/defaultProfile.png");
                });
                $("img.lazyload").lazyload();
            });
        </script>
        <s:head />
    </head>


    <body>

        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">

            <div class="row">

                <div class="col-lg-1">

                </div>

                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav id="categorias" class="list-group make-me-sticky">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li><a href="/upomm/views/usuarios/perfil.jsp" class="list-group-item active">Ver Perfil</a></li>
                            <li><a href="/upomm/views/usuarios/cambiarImagenPerfil.jsp" class="list-group-item">Cambiar Imagen</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-4">
                    <div class="card mt-4">
                        <s:a href="./perfil.jsp"><i class="fas fa-window-close pull-right"></i></s:a>
                            <div class="card-body">
                                <img id="imgPerfil" class="img-fluid lazyload rounded mx-auto d-block mb-4" data-src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                            <s:form id="perfilForm" action="editarPerfil" theme="css_xhtml">
                                <s:textfield name="nombre" label="Nombre" cssClass="form-control" value="%{#session.usuario.nombre}"></s:textfield>
                                <s:password name="password" label="Contraseña actual" cssClass="form-control" ></s:password>
                                <s:password name="newPassword" label="Nueva Contraseña" cssClass="form-control" ></s:password>
                                <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" ></s:password>
                                <s:if test="%{#session.usuario.tipo=='cliente'}">
                                    <div class="custom-control custom-switch wwgrp">
                                    <s:checkbox id="vendedor" name="vendedor" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true"/>
                                    <label class="custom-control-label wwlbl" for="vendedor">¿Desea ser vendedor?</label>
                                </div>
                                </s:if>
                                <s:submit name="btnGuardar" value="Guardar" cssClass="btn btn-primary pull-left"></s:submit>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>




