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
        <main class="container-fluid mt-4">
            <div class="row">
                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav id="categorias" class="list-group make-me-sticky">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li class="list-group-item">
                                <a href="/upomm/views/usuarios/perfil.jsp" class="menu-link active">Ver Perfil>Editar</a>
                            </li>
                            <s:if test="#session.usuario.tipo!='admin'">
                                <li class="list-group-item">
                                    <a href="/upomm/views/usuarios/deseos.jsp" class="menu-link">Lista de Deseos</a>
                                </li>
                            </s:if>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-9 mx-auto my-auto">
                    <s:if test="hasActionErrors()">
                        <s:actionerror cssClass="alert alert-danger list-unstyled" />
                    </s:if>
                    <div class="card mt-2">
                        <span>
                            <s:a href="./perfil.jsp"><i class="fas fa-window-close pull-right"></i></s:a>
                        </span>
                            <div class="card-body row pt-0">
                                <div class="col-sm-6 mx-auto">
                                    <img id="imgPerfil" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block mb-4" data-src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                                <s:form action="cambiarImagenPerfil" method="POST" enctype="multipart/form-data" theme="simple">
                                    <div class="custom-file">
                                        <s:file id="imgPerfilInput" name="imagenPerfil" accept="image/jpeg, image/png" cssClass="custom-file-input"/>
                                        <label class="custom-file-label" for="imgPerfilInput">Selecciona una imagen</label>
                                    </div>
                                        <s:submit id="btn-img" name="btnGuardar" value="Guardar" cssClass="btn btn-primary position-absolute" cssStyle="bottom:0; left:15px"/>
                                </s:form>
                            </div>
                            <div class="col-sm-6 my-auto mx-auto border-left">
                                <s:form id="perfilForm" action="editarPerfil" theme="css_xhtml">
                                    <s:textfield name="nombre" label="Nombre*" cssClass="form-control" value="%{#session.usuario.nombre}" required="true"/>
                                    <s:password name="password" label="Contraseña actual*" cssClass="form-control" required="true"/>
                                    <s:password name="newPassword" label="Nueva Contraseña" cssClass="form-control"/>
                                    <s:password name="passwordConfirm" label="Confirmar Nueva Contraseña" cssClass="form-control"/>
                                    <s:if test="%{#session.usuario.tipo=='cliente'}">
                                        <div class="custom-control custom-switch wwgrp">
                                            <s:checkbox id="vendedor" name="vendedor" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true"/>
                                            <label class="custom-control-label wwlbl" for="vendedor">¿Desea ser vendedor?</label>
                                        </div>
                                    </s:if>
                                    <s:submit name="btnGuardar" value="Guardar" cssClass="btn btn-primary pull-left"></s:submit>
                                </s:form>
                                <small class="pull-right font-weight-bold">*Campos obligatorios</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>




