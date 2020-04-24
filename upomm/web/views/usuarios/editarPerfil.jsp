<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Perfil - UPOMediaMarket</title>
        <%@include file="/views/utils/includes.jsp" %>
        <s:head />
    </head>


    <body>

        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">

            <div class="row">
                
                <div class="col-lg-2">

                </div>
                
                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav class="list-group">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li><a href="/upomm/views/usuarios/perfil.jsp" class="list-group-item active">Ver Perfil</a></li>
                            <li><a href="/upomm/views/usuarios/cambiarImagenPerfil.jsp" class="list-group-item">Cambiar Imagen</a></li>

                        </ul>
                    </nav>
                </div>


                <div class="col-lg-4">

                    <div class="card mt-4">
                        <div class="card-body">


                            <img id="logo_main" class="img-fluid" src="<s:property value="#session.usuario.foto"/>" alt="Imagen de perfil">
                            <br />
                            <s:form action="editarPerfil" method="post">
                                <s:textfield name="nombre" label="Nombre" cssClass="form-control" value="%{#session.usuario.nombre}"></s:textfield>
                                <s:password name="password" label="Contraseña" cssClass="form-control" ></s:password>
                                <s:password name="newPassword" label="Nueva Contraseña" cssClass="form-control" ></s:password>
                                <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" ></s:password>
                                <s:checkbox name="vendedor" label="¿Desea ser vendedor?"></s:checkbox>
                                <s:submit name="btnGuardar" value="Guardar" cssClass="btn btn-primary"></s:submit>
                            </s:form>
                            <s:a href="./perfil.jsp" cssClass="btn btn-danger">Cancelar</s:a>
                        </div>
                    </div>

                </div>

                

            </div>

        </main>
        <%@include file="../utils/footer.html" %>
    </body>
</html>




