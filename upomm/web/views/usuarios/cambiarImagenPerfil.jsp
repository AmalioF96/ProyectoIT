<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil - UMM</title>
        <link href="/upomm/css/perfil.css" rel="stylesheet" type="text/css"/>
        <%@include file="/views/utils/includes.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>
        <script>
            $(document).ready(function () {
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
                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav id="categorias" class="list-group make-me-sticky">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li class="list-group-item">
                                <a href="/upomm/views/usuarios/perfil.jsp" class="menu-link">Ver Perfil</a>
                            </li>
                            <li class="list-group-item">
                                <a href="/upomm/views/usuarios/cambiarImagenPerfil.jsp" class="menu-link active">Cambiar Imagen</a>
                            </li>
                            <s:if test="#session.usuario.tipo!='admin'">
                                <li class="list-group-item">
                                    <a href="/upomm/views/usuarios/deseos.jsp" class="menu-link">Lista de deseos</a>
                                </li>
                            </s:if>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-4">
                    <div class="card mt-4">
                        <div class="card-body">
                            <img id="imgPerfil" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block mb-4" data-src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                            <s:form action="cambiarImagenPerfil" enctype="multipart/form-data" theme="simple">
                                <div class="custom-file">
                                <s:file id="imgPerfilInput" name="imagenPerfil" accept="image/jpeg, image/png" cssClass="custom-file-input"/>
                                <label class="custom-file-label" for="imgPerfilInput">Selecciona una imagen</label>
                                </div>
                                <s:submit name="btnGuardar" value="Guardar" cssClass="btn btn-primary"/>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>


