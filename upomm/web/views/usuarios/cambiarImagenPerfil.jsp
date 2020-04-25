<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil - UMM</title>
        <link href="/upomm/css/perfil.css" rel="stylesheet" type="text/css"/>
        <%@include file="/views/utils/includes.jsp" %>

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
                    <nav id="categorias" class="list-group">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li><a href="/upomm/views/usuarios/perfil.jsp" class="list-group-item">Ver Perfil</a></li>
                            <li><a href="/upomm/views/usuarios/cambiarImagenPerfil.jsp" class="list-group-item active">Cambiar Imagen</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-4">
                    <div class="card mt-4">
                        <div class="card-body">
                            <img id="imgPerfil" class="img-fluid" src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                            <s:form action="cambiarImagenPerfil" method="post" enctype="multipart/form-data" theme="simple">
                                <s:file id="imgPerfilInput" name="imagenPerfil" accept="image/jpeg, image/png"></s:file>
                                <s:submit name="btnGuardar" value="Guardar" cssClass="btn btn-primary"></s:submit>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>


