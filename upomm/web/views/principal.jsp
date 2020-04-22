<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>UMM-Principal</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/principal.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

    </head>
    <body>
        <s:if test="categorias==null">
            <s:action executeResult="true" name="listarCategorias"/>
        </s:if>
        <s:else>
            <s:if test="productos==null">
                <s:action executeResult="true" name="listarProductos"/> 
            </s:if>
            <s:else>
                <script>
                    $(document).ready(function () {
                        var estrellas = $(".stars");
                        for (var i = 0; i < estrellas.length; i++) {
                            var puntuacion = parseFloat($(estrellas[i]).first().text());
                            if (isNaN(puntuacion)) {
                                puntuacion = 0;
                            }
                            var k = 0;
                            for (k = 0; k < puntuacion; k++) {
                                if (k < puntuacion && k + 1 > puntuacion)
                                    $(estrellas[i]).append($("<i class='fas fa-star-half-alt'></i>"));
                                else
                                    $(estrellas[i]).append($("<i class='fas fa-star'></i>"));
                            }
                            for (var j = k; j < 5; j++) {
                                $(estrellas[i]).append($("<i class='far fa-star'></i>"));
                            }
                        }
                        $("img").onerror = function () {
                            $(this).attr("src", "../img/productDefaultImage.jpg");
                        };

                        $("img.lazyload").lazyload();
                    });
                </script>
                <%@include file="utils/header.jsp" %>
                <main class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <nav id='categorias' class="list-group">
                                <h4 class="text-center">Categorías</h4>
                                <ul class="list-unstyled">
                                    <s:iterator value="categorias">
                                        <li class="list-group-item cat"><a class="categoria" href=""><s:property value="nombre"/></a></li>
                                        </s:iterator>
                                </ul>
                            </nav>
                        </div>


                        <div class="col-lg-9">
                            <div class="row">
                                <s:iterator value="productos">
                                    <s:url var="idProductoUrl" action="seleccionarProducto">
                                        <s:param name="id" value="idProducto"/>
                                    </s:url>
                                    <div class = "col-lg-4 col-md-6 mb-4">
                                        <div class = "card h-100">
                                            <a href = ""><img class = "card-img-top lazyload" data-src = "" alt = ""></a>
                                            <div class = "card-body">
                                                <h4 class = "card-title">
                                                    <s:a href="%{idProductoUrl}" cssClass="productoLink"><s:property value="nombre"/></s:a>
                                                    </h4>
                                                    <h5><s:property value="precio"/>&euro;</h5>
                                                <p class = "card-text">
                                                    <s:property value="descripcion"/>
                                                </p>
                                            </div>
                                            <div class = "card-footer">
                                                <small class = "text-muted stars"><span hidden><s:property value="puntuaciones[idProducto]"/></span></small>
                                            </div>
                                        </div>
                                    </div>
                                </s:iterator>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="utils/footer.html" %>
            </s:else>
        </s:else>
    </body>
</html>
