<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<s:if test="%{#parameters.idProducto==null}">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="%{producto==null && #request.error==null}">
    <s:action executeResult="true" name="seleccionarProducto">
        <s:param name="idProducto" value="#parameters.idProducto"/>
    </s:action>
</s:elseif>
<s:else>
    <html>
        <head>
            <title>Producto XXX - UPOMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/producto.css" rel="stylesheet" type="text/css"/>
            <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

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
                    $("img").on("error", function () {
                        $(this).attr("src", "/upomm/imagenes/productDefaultImage.jpg");
                    });
                    $("img.lazyload").lazyload();
                });
                /*
                 * Obtenemos la valoración actual de un producto
                 */
                function obtenerValoracion() {
                    $(".formValoracion").submit(function () {
                        var estrellas = $(this).find(".review");
                        var cont = 0;
                        for (var i = 0; i < estrellas.length; i++) {
                            if ($(estrellas[i]).hasClass("clicked")) {
                                cont++;
                            }
                        }
                        $(this).find("#puntuacion").val(cont);
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
                    $(".review").mouseenter(function () {
                        var id = $(this).attr('id');
                        var puntuacion = parseInt(id.substring(id.length - 1, id.length));
                        var estrellas = $(this).parent().find(".review");
                        for (var i = 0; i < estrellas.length; i++) {
                            if (i < puntuacion) {
                                $(estrellas[i]).addClass("checked");
                                $(estrellas[i]).removeClass("unchecked");
                            } else {
                                $(estrellas[i]).removeClass("checked");
                                //$(estrellas[i]).removeClass("clicked");
                                $(estrellas[i]).addClass("unchecked");
                            }
                        }
                    });
                    $(".review").mouseleave(function () {
                        var estrellas = $(this).parent().find(".review");
                        for (var i = 0; i < estrellas.length; i++) {
                            $(estrellas[i]).removeClass("checked");
                            $(estrellas[i]).addClass("unchecked");

                        }
                    });
                    $(".review").click(function () {
                        var id = $(this).attr('id');
                        var puntuacion = parseInt(id.substring(id.length - 1, id.length));
                        var estrellas = $(this).parent().find(".review");
                        for (var i = 0; i < estrellas.length; i++) {
                            if (i < puntuacion) {
                                $(estrellas[i]).addClass("clicked");
                            } else {
                                $(estrellas[i]).removeClass("clicked");
                                $(estrellas[i]).addClass("unchecked");
                            }
                        }
                    });
                }
                /*Controlar la edición de la valoración*/
                function mostrarEditable() {
                    $("#miValoracion").hide();
                    var descripcion = $("#miValoracion p").text();
                    var puntuacion = $("#miValoracion span.text-warning").children().length;
                    var form = $("<form id='formValoracionProductoEditable' class='formValoracion' method='post' action='/upomm/views/modificarValoracion.action'></form>");
                    var text = $("<textarea class='form-control' name='valoracion'></textarea>");
                    $(text).css("width", "100%");
                    $(text).val(descripcion);
                    $(form).append(text);
                    for (var i = 1; i <= 5; i++) {
                        if (i <= puntuacion) {
                            var valora = $("<span class='review fa fa-star clicked'></span>");
                        } else {
                            var valora = $("<span class='review fa fa-star unchecked'></span>");
                        }
                        $(valora).attr("id", "puntuacion-" + i);
                        $(form).append(valora);
                    }
                    var btn = $("<input type='submit' class='btn btn-sm btn-success btn-valoracion pull-right' value='Guardar' name='editarValoracion'>");
                    $(form).append(btn);
                    btn = $("<button type='button' class='btn btn-sm btn-warning btn-valoracion pull-right'>Cancelar</button>");
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
                        $("#formValoracionProductoEditable").remove();
                        $("#miValoracion").show();

                    });
                }
            </script>
            <s:head/>
            <s:if test="%{producto==null && #request.error==null}">
                <jsp:forward page="/views/principal.jsp"/>
            </s:if>
        </head>

        <body>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container">
                <div class="row">
                    <s:if test="#request.error">
                        <div class="alert alert-danger" role="alert">El producto no existe.</div>       
                    </s:if>
                    <s:elseif test="%{!producto.disponible && producto.usuarios!=#session.usuario}">
                        <div class="alert alert-warning" role="alert">Este producto no está disponible.</div>
                    </s:elseif>
                    <s:else>
                        <!-- LISTA DE CATEGORÍAS -->
                        <div class="col-lg-3">
                            <nav id='categorias' class="list-group make-me-sticky">
                                <h4 class="text-center">Categorías del producto</h4>
                                <ul class="list-unstyled">
                                    <s:bean name="modelo.comparators.ComparadorCategoriasProductos" var="comparadorCats"/>
                                    <s:sort comparator="#comparadorCats" source="producto.categoriasProductoses">
                                        <s:iterator>
                                            <s:url var="categoriaUrl" action="listarProductos">
                                                <s:param name="categoria" value="id.nombre"/>
                                            </s:url>
                                            <li class="list-group-item cat">
                                                <s:a href="%{categoriaUrl}" cssClass="categoria">
                                                    <s:property value="id.nombre"/>

                                                </s:a>
                                            </li>
                                        </s:iterator>
                                    </s:sort>

                                </ul>
                            </nav>
                        </div>
                        <!-- /.col-lg-3 -->
                        <div class="col-lg-9">
                            <div class="card mt-4">
                                <s:if test="%{producto.imagen==''}">
                                    <s:set var="img" value="'default'"/>
                                </s:if>
                                <s:else>
                                    <s:set var="img" value="producto.imagen"/>
                                </s:else>
                                <img id='imgProducto' class="card-img-top img-fluid lazyload" data-src="<s:property value="#img"/>" alt="Imagen del producto">
                                <div class="card-body">
                                    <h3 class="card-title"><s:property value="producto.nombre"/></h3>
                                    <h4><s:number name="producto.precio" maximumFractionDigits="2" minimumFractionDigits="2"/>&euro;</h4>
                                    <p class="card-text"><s:property value="producto.descripcion"/></p>
                                    <div class="text-warning">
                                        <span id="productRating"></span>
                                        <s:number name="puntuaciones[producto.idProducto]" maximumFractionDigits="1" minimumFractionDigits="1"/>
                                    </div>
                                    <div><a href="#valoraciones"><s:property value="producto.valoracioneses.size"/> opiniones</a></div>
                                    <br />
                                    <s:if test="#session.usuario != null">
                                        <s:if test="#session.usuario.tipo=='admin'">
                                            <s:form action="retirarProducto">
                                                <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                                <s:submit cssClass="btn btn-danger" name="btnRetirar" value="Retirar producto" />
                                            </s:form>
                                        </s:if>
                                        <s:elseif test="%{producto.usuarios==#session.usuario}">
                                            <s:url var="editarProductoUrl" value="/views/productos/crearProducto.jsp">
                                                <s:param name="idProducto" value="idProducto"/>
                                            </s:url>
                                            <s:a href="%{editarProductoUrl}" cssClass="btn btn-warning btn">Editar</s:a>
                                        </s:elseif>
                                        <s:elseif test="%{!#session.carrito.contains(producto)}">
                                            <s:form action="agregarCarrito" cssClass="float-left">
                                                <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                                <button class="btn btn-primary pull-left mr-4 mb-2" name="btnAgregarCarrito">
                                                    Agregar al carrito 
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            </s:form>
                                        </s:elseif>
                                        <s:else>
                                            <s:form action="eliminarCarrito" cssClass="float-left">
                                                <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                                <button class="btn btn-outline-primary pull-left mr-4 mb-2" name="btnEliminarCarrito">
                                                    Eliminar del carrito 
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </s:form>
                                        </s:else>
                                        <s:if test="%{producto.usuarios!=#session.usuario}">
                                            <s:if test="%{producto in #session.usuario.productoses_1}">
                                                <s:form action="eliminarDeseo" cssClass="float-left">
                                                    <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                                    <s:textfield name="origin" value="producto" hidden="true"/>
                                                    <button type="submit" class="btn btn-outline-secondary pull-left" name="btnDeseo">
                                                        Eliminar de la lista de deseos 
                                                        <i style="color:red" class="fas fa-heart"></i>
                                                    </button>
                                                </s:form>
                                            </s:if>
                                            <s:else>
                                                <s:form action="crearDeseo" cssClass="float-left">
                                                    <s:textfield name="idProducto" value="%{producto.idProducto}" hidden="true"/>
                                                    <button type="submit" class="btn btn-secondary pull-left" name="btnDeseo">
                                                        Añadir a mi lista de deseos 
                                                        <i style="color:red" class="fas fa-heart"></i>
                                                    </button>
                                                </s:form>
                                            </s:else>
                                        </s:if>
                                    </s:if>
                                    <s:else>
                                        <div class="alert alert-info">
                                            <s:url var="idProductoLoginUrl" value="/views/usuarios/login.jsp">
                                                <s:param name="idProducto" value="producto.idProducto"/>
                                            </s:url>
                                            <s:url var="idProductoSignUpUrl" value="/views/usuarios/signUp.jsp">
                                                <s:param name="idProducto" value="producto.idProducto"/>
                                            </s:url>
                                            <s:a href="%{idProductoLoginUrl}">Inicia sesión</s:a> o 
                                            <s:a href="%{idProductoSignUpUrl}">regístrate</s:a> para comprar este producto
                                            </div>
                                    </s:else>
                                </div>
                            </div>
                            <!-- /.card caracteristicas -->
                            <div class="card card-outline-secondary my-4">
                                <div class="card-header">Características</div>
                                <div class="card-body">
                                    <table class="list-group list-group-flush table">
                                        <s:bean name="modelo.comparators.ComparadorCaracteristicasProductos" var="comparadorCars"/>
                                        <s:sort comparator="#comparadorCars" source="producto.caracteristicasProductoses">
                                            <s:iterator>
                                                <tr class="list-group-item d-flex">
                                                    <td class="col-5">
                                                        <strong><s:property value="id.nombre" /></strong>
                                                    </td>
                                                    <td class="col-7">
                                                        <s:property value="valor" />
                                                    </td>
                                                </tr>

                                            </s:iterator>
                                        </s:sort>
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
                                        <s:form id='formValoracionProducto' cssStyle="display:none" cssClass="formValoracion" action="insertarValoracion" theme="simple">
                                            <hr>
                                            <s:textarea cssClass="form-control" name="valoracion" placeholder="Valora el producto" required="true"/>
                                            <s:iterator begin="1" end="5" step="1" var="index">
                                                <span id = 'puntuacion-<s:property value="#index"/>' class = 'review fa fa-star unchecked'></span>
                                            </s:iterator>
                                            <s:textfield id="puntuacion" name="puntuacion" hidden="true"/>
                                            <s:textfield name="idProducto" type="number" value="%{producto.idProducto}" hidden="true"/>
                                            <s:textfield value="insertar" name="operacion" hidden="true"/>
                                            <s:submit name="enviarValoracion" value="Enviar" cssClass="btn btn-primary btn-sm pull-right btn-valoracion"/>
                                            <hr>
                                        </s:form>
                                    </s:if>
                                    <s:else>
                                        <s:bean name="modelo.comparators.ComparadorValoraciones" var="comparador">
                                            <s:param name="emailCliente" value="#session.usuario.email"/>
                                        </s:bean>
                                        <s:sort source="producto.valoracioneses" comparator="#comparador">
                                            <s:iterator>
                                                <s:if test="%{usuarios==#session.usuario}">
                                                    <s:set value="true" var="valorado"/>
                                                    <div id=miValoracion>
                                                    </s:if>
                                                    <s:else>
                                                        <div>
                                                        </s:else>
                                                        <span class='text-warning'>
                                                            <s:iterator begin="0" end="puntuacion-1" >
                                                                <span>&#9733;</span>
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
                                            </s:sort>
                                        </s:else>
                                        <s:if test="%{#session.usuario.comprases !=null && !#session.usuario.comprases.empty}">
                                            <s:iterator value="#session.usuario.comprases">
                                                <s:iterator value="lineasDeCompras">
                                                    <s:if test="productos==producto">
                                                        <s:set value="true" var="comprado"/>
                                                    </s:if>
                                                </s:iterator>
                                            </s:iterator>
                                        </s:if>
                                        <s:if test="#valorado==null && #comprado!=null">
                                            <script>
                                                $(document).ready(function () {
                                                    $("#formValoracionProducto").show();
                                                });
                                            </script>
                                        </s:if>
                                    </div>
                                </div>
                                <!-- fin /.card Opiniones-->
                            </div>
                            <!-- /.col-lg-9 -->
                        </div>
                    </s:else>
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