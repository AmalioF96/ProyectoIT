<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="categorias==null">
    <s:action executeResult="true" name="listarCategorias"/>
</s:if>
<s:else>
    <s:if test="productos==null || #ordenar!=null">
        <s:action executeResult="true" name="listarProductos" />
    </s:if>
    <s:else>
        <!DOCTYPE html>
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <title>UMM-Principal</title>
                <%@include file="/views/utils/includes.jsp" %>
                <link href="/upomm/css/principal.css" rel="stylesheet" type="text/css"/>
                <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

            </head>
            <body>
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
                        
                        $("img.lazyload").lazyload();
                        
                        $("img").on("error", function () {
                            $(this).attr("src", "/upomm/imagenes/productDefaultImage.jpg");
                        });
                    });
                </script>
                <s:if test="%{#parameters.busqueda!=null && #parameters.busqueda[0].trim()!=''}">
                    <script>
                        $(document).ready(function () {
                            var results = $(".busca");
                            for (var i = 0; i < results.length; i++) {
                                var text = $(results[i]).text();
                                var busca = "<s:property value="#parameters.busqueda"/>";
                                var re = new RegExp(busca, 'gi');
                                results[i].innerHTML = results[i].innerHTML.replace(re, "<span class='highlight'>" + busca + "</span>");
                            }
                        });
                    </script>
                </s:if>
                <%@include file="utils/header.jsp" %>
                <main class="container-fluid">
                    <div class="row">
                        <div class="col-lg-3">
                            <nav id='categorias' class="list-group make-me-sticky">
                                <h4 class="text-center">Categorías</h4>
                                <ul class="list-unstyled">
                                    <s:iterator value="categorias">
                                        <s:url var="categoriaUrl" action="listarProductos">
                                            <s:param name="categoria" value="nombre"/>
                                        </s:url>
                                        <li class="list-group-item cat">
                                            <s:if test="nombre==#parameters.categoria[0]">
                                                <s:a cssClass="categoria active" href="%{categoriaUrl}">
                                                    <s:property value="nombre"/>
                                                </s:a>
                                            </s:if>
                                            <s:else>
                                                <s:a cssClass="categoria" href="%{categoriaUrl}">
                                                    <s:property value="nombre"/>
                                                </s:a>

                                            </s:else>
                                        </li>
                                    </s:iterator>
                                </ul>
                            </nav>
                        </div>


                        <div class="col-lg-9">
                            <s:set value="%{#parameters.ordenar[0]}" var="ordenar"/>
                            <%@include file="productos/barraBusqueda.jsp" %>
                            <div class="row">
                                <s:if test="%{#ordenar==0}">
                                    <s:bean name="modelo.comparators.ComparadorProductosMejorValorados" var="comparador"/>
                                </s:if>
                                <s:elseif test="%{#ordenar==1}">
                                    <s:bean name="modelo.comparators.ComparadorProductosMasVendidos" var="comparador"/>
                                </s:elseif>

                                <s:elseif test="%{#ordenar==2}">
                                    <s:bean name="modelo.comparators.ComparadorProductosMasRecientes" var="comparador"/>
                                </s:elseif>
                                <s:elseif test="%{#ordenar==3}">
                                    <s:bean name="modelo.comparators.ComparadorProductosPrecioAscendente" var="comparador"/>
                                </s:elseif>
                                <s:elseif test="%{#ordenar==4}">
                                    <s:bean name="modelo.comparators.ComparadorProductosPrecioDescendente" var="comparador"/>
                                </s:elseif>
                                <s:else>
                                    <s:bean name="modelo.comparators.ComparadorProductosPorDefecto" var="comparador"/>
                                </s:else>
                                <s:sort source="productos" comparator="#comparador">
                                    <s:iterator>
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="idProducto"/>
                                        </s:url>
                                        <s:if test="%{imagen==''}">
                                            <s:set var="img" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img" value="imagen"/>
                                        </s:else>
                                        <div class = "col-lg-4 col-md-6 mb-4">
                                            <div class = "card h-100">
                                                <s:a href = "%{idProductoUrl}">
                                                    <img class = "card-img-top lazyload" data-src = "<s:property value="#img"/>" alt = "Imagen producto">
                                                </s:a>
                                                <div class = "card-body">
                                                    <h4 class = "card-title">
                                                        <s:a href="%{idProductoUrl}" cssClass="productoLink">
                                                            <span class="busca"><s:property value="nombre"/></span>
                                                        </s:a>
                                                    </h4>
                                                    <h5><s:number name="precio" maximumFractionDigits="2" minimumFractionDigits="2"/>&euro;</h5>
                                                    <p class = "card-text busca">
                                                        <s:if test="descripcion.length()>50">
                                                            <s:property value="%{descripcion.substring(0,50)+'(...)'}"/>
                                                        </s:if>
                                                        <s:else>
                                                            <s:property value="descripcion"/>
                                                        </s:else>
                                                    </p>
                                                </div>
                                                <div class = "card-footer">
                                                    <small class = "text-muted stars">
                                                        <span hidden>
                                                            <s:number  name="puntuaciones[idProducto]" maximumFractionDigits="1" />
                                                        </span>
                                                    </small>
                                                    <small class="text-muted pull-right">
                                                        <s:property value="valoracioneses.size"/> opiniones
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </s:iterator>
                                </s:sort>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="utils/footer.html" %>
            </s:else>
        </s:else>
    </body>
</html>
