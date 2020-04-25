<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<s:if test="%{producto==null}">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <html>
        <head>
            <title>Producto XXX - UPOMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/producto.css" rel="stylesheet" type="text/css"/>
            
            <script>
                $(document).ready(function () {
                    animaEstrellas();
                    obtenerValoracion();
                    var puntuacion = parseFloat(<s:property  value="getText('{0,number,#,##0.0}',{puntuaciones[producto.idProducto]})"/>);
                    var k = 0;
                    for (k = 0; k < puntuacion; k++) {
                        var text = $("#productRating").text();
                        if (k < puntuacion && k + 1 > puntuacion)
                            $("#productRating").append($("<i class='fas fa-star-half-alt'></i>"));
                        else
                            $("#productRating").append($("<i class='fas fa-star'></i>"));
                    }
                    for (var j = k; j < 5; j++) {
                        $("#productRating").append($("<i class='far fa-star'></i>"));
                    }
                    $("#btnEliminar").click(function () {
                        var idProducto = $('<input name="idProducto" type="text" hidden="true"/>');
                        $(idProducto).val(<s:property value="producto.idProducto"/>);
                        $("#formEliminarValoracion").append(idProducto);
                        $("#formEliminarValoracion").submit();
                    });
                });
                /*
                 * Obtenemos la valoración actual de un producto
                 */
                function obtenerValoracion() {
                    $("#formValoracionProducto").submit(function () {
                        var estrellas = $("#formValoracionProducto .fa-star");
                        var cont = 0;
                        for (var i = 0; i < estrellas.length; i++) {
                            if ($(estrellas[i]).hasClass("checked")) {
                                cont++;
                            }
                        }
                        $("#puntuacion").val(cont);
                        if (cont > 0) {
                            return true;
                        } else {
                            alert("Debe puntuar el producto");
                            return false;
                        }

                    });
                }
                /*Animación de la valoración*/
                function animaEstrellas() {
                    $(".review").click(function () {
                        var id = $(this).attr('id');
                        var puntuacion = parseInt(id.substring(id.length - 1, id.length));
                        var estrellas = $(".review");
                        for (var i = 0; i < estrellas.length; i++) {
                            if (i < puntuacion) {
                                $(estrellas[i]).addClass("checked");
                                $(estrellas[i]).removeClass("unchecked");
                            } else {
                                $(estrellas[i]).removeClass("checked");
                                $(estrellas[i]).addClass("unchecked");
                            }
                        }
                    });
                }
                /*Controlar la edición de la valoración*/
                function mostrarEditable() {
                    $("#miValoracion").hide();
                    var descripcion = $("#miValoracion p").text();
                    var puntuacion = $("#miValoracion span").text().length;
                    var form = $("<form id='formValoracionProducto' method='post' action='/upomm/views/modificarValoracion.action'></form>");
                    var text = $("<textarea class='form-control' name='valoracion'></textarea>");
                    $(text).css("width", "100%");
                    $(text).val(descripcion);
                    $(form).append(text);
                    for (var i = 1; i <= 5; i++) {
                        var valora = $("<span class='review fa fa-star unchecked'></span>");
                        $(valora).attr("id", "puntuacion-" + i);
                        $(form).append(valora);
                    }
                    var btn = $("<input type='submit' class='btn btn-sm btn-success btn-valoracion pull-right' value='Guardar' name='editarValoracion'>");
                    //$(btn).css("display", "block");
                    $(form).append(btn);
                    btn = $("<button type='button' class='btn btn-sm btn-warning btn-valoracion pull-right'>Cancelar</button>");
                    //$(btn).css("display", "block");
                    $(form).append(btn);
                    $(form).append($("<input id='puntuacion' type='number' name='puntuacion' hidden>"));
                    $(form).append($("<input id='operacion' type='text' name='operacion' value='insertar' hidden>"));
                    var idProducto = $('<input name="idProducto" type="number" hidden>');
                    $(idProducto).val(<s:property value="producto.idProducto"/>);
                    $(form).append(idProducto);
                    $("#miValoracion").after(form);
                    animaEstrellas();
                    obtenerValoracion();
                    $(btn).click(function () {
                        $("#formValoracionProducto").remove();
                        $("#miValoracion").show();

                    });
                }
            </script>
            <s:head/>
            <s:if test="producto==null">
                <jsp:forward page="/views/principal.jsp"/>
            </s:if>
        </head>

        <body>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container">
                <div class="row">

                    <!-- LISTA DE CATEGORÍAS -->
                    <div class="col-lg-3">
                        <nav id='categorias' class="list-group">
                            <ul class="list-unstyled">
                                <h4 class="text-center">Categorías</h4>
                                <s:iterator value="producto.categoriasProductoses" step="1">
                                    <s:url var="urlCategoria" action="#">
                                        <s:param name="categoria" value="nombre"/>
                                    </s:url>
                                    <li class="list-group-item cat"><s:a href="%{urlCategoria}" cssClass="categoria"> <s:property value="id.nombre"/></s:a></li>
                                        <s:property value="nombre"/>
                                    </s:iterator>

                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-9">
                        <%--<?php
                        include './barraBusqueda.php';
                        ?>--%>
                        <div class="card mt-4">
                            <img id='imgProducto' class="card-img-top img-fluid" src='' alt="">
                            <div class="card-body">
                                <h3 class="card-title"><s:property value="producto.nombre"/></h3>
                                <h4><s:number name="producto.precio" maximumFractionDigits="2" minimumFractionDigits="2"/>€</h4>
                                <p class="card-text"><s:property value="producto.descripcion"/></p>
                                <div class="text-warning">
                                    <span id="productRating"></span>
                                    <s:number name="puntuaciones[producto.idProducto]" maximumFractionDigits="1" minimumFractionDigits="1"/>
                                </div>
                                <div><a href="#valoraciones"><s:property value="producto.valoracioneses.size"/> opiniones</a></div>
                                <br />
                                <s:if test="#session.usuario != null">
                                    <s:if test="%{!#session.carrito.contains(producto)}">
                                        <s:form action="agregarCarrito">
                                            <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                            <s:submit cssClass="btn btn-primary" name="btnAgregarCarrito" value="Agregar al carrito" />
                                        </s:form>
                                    </s:if>
                                    <s:else>
                                        <s:form action="eliminarCarrito">
                                            <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                            <s:submit cssClass="btn btn-primary" name="btnEliminarCarrito" value="Eliminar del carrito" />
                                        </s:form>
                                    </s:else>
                                </s:if>
                                <s:else>
                                    <div class="alert alert-info"><a href="/upomm/views/usuarios/login.jsp">Inicia sesión</a> o <a href="/upomm/views/usuarios/signUp.jsp">regístrate</a> para comprar este producto</div>
                                </s:else>
                            </div>
                        </div>
                        <!-- /.card caracteristicas -->
                        <div class="card card-outline-secondary my-4">
                            <div class="card-header">Características</div>
                            <div class="card-body">
                                <table class="list-group list-group-flush table">
                                    <s:iterator var="i" value="producto.caracteristicasProductoses" step="1">

                                        <tr class="list-group-item d-flex">
                                            <td class="col-5">
                                                <strong><s:property value="id.nombre" /></strong>
                                            </td>
                                            <td class="col-7">
                                                <s:property value="valor" />
                                            </td>
                                        </tr>

                                    </s:iterator>

                                </table>
                            </div>
                        </div>
                        <!-- fin /.card caracteristicas-->
                        <!-- /.card Opiniones-->
                        <div id="valoraciones" class="card card-outline-secondary my-4">
                            <div class="card-header">
                                Opiniones del producto
                            </div>
                            <div class="card-body">
                                <s:if test="producto.valoracioneses.isEmpty()">
                                    <p>Aún no hay opiniones para este producto.</p>
                                </s:if>
                                <s:else>
                                    <s:iterator value="producto.valoracioneses">
                                        <s:if test="%{usuarios==#session.usuario}">
                                            <s:set value="true" var="valorado"/>
                                            <div id=miValoracion>
                                            </s:if>
                                            <s:else>
                                                <div>
                                                </s:else>
                                                <span class='text-warning'>
                                                    <s:iterator begin="0" end="puntuacion-1" >
                                                        &#9733;
                                                    </s:iterator>
                                                </span>
                                                <br>
                                                <p><s:property value="descripcion"/></p>
                                                <small>Por: <s:property value="usuarios.email"/></small>
                                                <br>
                                                <small>Fecha: <s:date name="fecha" format="dd/MM/yyyy" /></small>
                                                <s:if test="%{usuarios==#session.usuario}">
                                                    <button id="btnEliminar" class="btn btn-sm btn-danger pull-right btn-valoracion">Eliminar</button>
                                                    <button class="btn btn-sm btn-warning pull-right btn-valoracion" onclick="mostrarEditable()">Editar</button>
                                                </s:if>
                                            </div>
                                            <hr>
                                        </s:iterator>
                                    </s:else>
                                    <s:iterator value="#session.usuario.comprases">
                                        <s:iterator value="lineasDeCompras">
                                            <s:if test="productos.equals(producto)">
                                                <s:set value="true" var="comprado"/>
                                            </s:if>
                                        </s:iterator>
                                    </s:iterator>
                                    <s:if test="#valorado==null && #comprado!=null">
                                        <s:form id='formValoracionProducto' cssClass="md-form mr-auto mb-4" action="insertarValoracion" theme="simple">
                                            <s:textarea cssClass="form-control" name="valoracion" placeholder="Valora el producto" required="true"></s:textarea>
                                            <s:iterator begin="1" end="5" step="1" var="index">
                                                <span id = 'puntuacion-<s:property value="#index"/>' class = 'review fa fa-star unchecked'></span>
                                            </s:iterator>
                                            <s:textfield id="puntuacion" name="puntuacion" hidden="true"/>
                                            <s:textfield name="idProducto" type="number" value="%{producto.idProducto}" hidden="true"/>
                                            <s:textfield value="insertar" name="operacion" hidden="true"/>
                                            <br>
                                            <s:submit id="btn-coment" name="enviarValoracion" value="Enviar" cssClass="btn btn-success"/>
                                        </s:form>
                                    </s:if>
                                </div>
                            </div>
                            <!-- fin /.card Opiniones-->
                        </div>
                        <!-- /.col-lg-9 -->
                        <%--<?php }
                        ?>--%>
                    </div>
            </main>
            <!-- /.container -->
            <s:form id="formEliminarValoracion" action="eliminarValoracion" theme="simple">
                <s:textfield value="eliminar" name="operacion" hidden="true"/>
                <s:submit hidden="true"/>
            </s:form>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>