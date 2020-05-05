<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil - UPOMediaMarket</title>
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
                <div class="col-lg-1">
                </div>
                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav id="categorias" class="list-group make-me-sticky">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li><a href="/upomm/views/usuarios/perfil.jsp" class="list-group-item active">Ver Perfil</a></li>
                            <li><a href="/upomm/views/usuarios/cambiarImagenPerfil.jsp" class="list-group-item">Cambiar Imagen</a></li>
                            <li><a href="/upomm/views/usuarios/deseos.jsp" class="list-group-item">Lista de deseos</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-4">
                    <div class="card mt-4">
                        <div class="card-body">
                            <img id="logo_main" class="img-fluid lazyload rounded mx-auto d-block mb-4" data-src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                            <h6 class="labelPerfil"><b>Nombre:</b></h6>
                            <p>
                                <s:property value="#session.usuario.nombre"/>
                            </p>
                            <h6 class="labelPerfil"><b>Email:</b></h6>
                            <p>
                                <s:property value="#session.usuario.email"/>
                            </p>
                            <h6 class="labelPerfil"><b>Tipo de Usuario:</b></h6>
                            <p>
                                <s:property value="#session.usuario.tipo"/>
                            </p>
                            <s:a href="./editarPerfil.jsp" cssClass="btn btn-primary">Editar Perfil</s:a>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>




