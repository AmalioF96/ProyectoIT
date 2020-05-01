<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="#parameters.idVenta==null">
    <s:action executeResult="true" name="listarVentas"/>
</s:elseif>
<s:elseif test="venta==null">
    <s:action executeResult="true" name="seleccionarVenta"/>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Venta - UPOMediaMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/compra.css" rel="stylesheet">
            <link href="/upomm/css/misProductos.css" rel="stylesheet" type="text/css"/>
            <script>
                $(document).ready(function () {
                    var seleccionado = null;
                    $(".reclamar").click(function () {
                        $("#descripcion").show();
                        $('#modalReclamaciones').modal('show');
                        seleccionado = $(this).parent();
                    });
                    $("#send").click(function () {
                        var descripcion = $("#descripcion");
                        $(descripcion).hide();
                        $(seleccionado).append(descripcion);
                        $(seleccionado).submit();
                    });
                    $("img").on("error", function () {
                        $(this).attr("src", "/upomm/imagenes/productDefaultImage.jpg");
                    });
                });
            </script>
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <main class="container-fluid">


                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item active">Mis Ventas</a></li>
                                <li><a href="/upomm/views/productos/misProductos.jsp" class="list-group-item">Mis Productos</a></li>
                                <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear Producto</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-9 contendor table-responsive-sm">

                        <div class="col-sm">
                            <table>
                                <tr>
                                    <td><strong>Número de pedido:</strong></td>
                                    <td class="text-left"><s:property value="venta.productos.idProducto"/></td>
                                </tr>
                                <tr>
                                    <td><strong>Número de productos:</strong></td>
                                    <td class="text-left"><s:property value="venta.cantidad"/></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm text-right">
                            <table class="pull-right">
                                <tr>
                                    <td class="text-left"><strong>Fecha:</strong></td>
                                    <td><s:date name="venta.compras.fecha" format="dd/MM/yyyy"/></td>
                                </tr>
                                <tr>
                                    <td class="text-left"><strong>Importe:</strong></td>
                                    <td><s:property value="venta.getImporte()"/>&euro;</td>
                                </tr>
                            </table>
                        </div>
                        <div class="col" style="margin-top:1%">
                            <h3>Productos comprados</h3>
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Descripcion</th>
                                        <th>Imagen</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                        <s:param name="idProducto" value="productos.idProducto"/>
                                    </s:url>
                                    <tr>
                                        <td>
                                            <s:a href = "%{idProductoUrl}">
                                                <s:property value="venta.productos.nombre"/>
                                            </s:a>
                                        </td>
                                        <td><s:property value="venta.productos.descripcion"/></td>
                                        <s:if test="venta.productos.imagen.length()>0">
                                            <td>
                                                <img data-src = "<s:property value="venta.productos.imagen"/>" alt = "Imagen producto">
                                            </td>
                                        </s:if>
                                        <s:else>
                                            <td>
                                                <img class="mostrarImagen little" src="/upomm/imagenes/productDefaultImage.jpg" alt = "Imagen producto">
                                            </td>
                                        </s:else>

                                        <td><s:property value="venta.productos.precio"/></td>
                                        <td><s:property value="venta.cantidad"/></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>