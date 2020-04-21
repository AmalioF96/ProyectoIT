<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Perfil - UPOMediaMarket</title>
        <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/principal.css" rel="stylesheet" type="text/css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <s:head />
    </head>


    <body>

        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">

            <div class="row">
                
                <div class="col-lg-3">

                </div>
                
                <!-- LISTA DE CATEGORÍAS -->
                <div class="col-lg-3">
                    <nav class="list-group">
                        <h4 class="text-center">Perfil De Usuario</h4>
                        <ul class="list-unstyled">
                            <li><a href="perfil.php" class="list-group-item active">Ver Perfil</a></li>
                            <li><a href="cambiarImagenDePerfil.php" class="list-group-item">Cambiar Imagen</a></li>

                        </ul>
                    </nav>
                </div>


                <div class="col-lg-3">

                    <div class="card mt-4">
                        <div class="card-body">


                            <img id="logo_main" class="img-fluid" src="/upomm/imagenes/UPOMediaMarket_Logo2.jpg" alt="Imagen de perfil">

                            <s:form action="editarPerfil" method="post">
                                <s:textfield name="nombre" label="Nombre" cssClass="form-control" value="%{#session.usuario.nombre}"></s:textfield>
                                <s:textfield name="email" label="Email" cssClass="form-control"  value="%{#session.usuario.email}" ></s:textfield>
                                <s:password name="password" label="Contraseña" cssClass="form-control" ></s:password>
                                <s:password name="passwordConfirm" label="Confirmar Contraseña" cssClass="form-control" ></s:password>
                                <s:checkbox name="vendedor" label="¿Desea ser vendedor?"></s:checkbox>
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




