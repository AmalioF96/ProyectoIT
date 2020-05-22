<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='vendedor'">
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
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <main class="container-fluid">


                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item active">Mis Ventas>Venta</a></li>
                                <li><a href="/upomm/views/productos/misProductos.jsp" class="list-group-item">Mis Productos</a></li>
                                <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear Producto</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-8 contendor table-responsive-sm mt-3 mx-auto">
                        <s:set var="importe" value="0"/>
                        <s:iterator value="venta">
                            <s:set var="importe" value="%{#importe+(productos.precio*cantidad)}"/>
                        </s:iterator>
                        <div class="row">
                            <div class="col-sm">
                                <table>
                                    <tr>
                                        <td class="text-left"><strong>Número de pedido:</strong></td>
                                        <td class="text-left"><s:property value="venta[0].compras.idCompra"/></td>
                                    </tr>
                                    <tr>
                                        <td class="text-right"><strong>Número de productos:</strong></td>
                                        <td class="text-right"><s:property value="venta.size"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-sm text-right">
                                <table class="pull-right">
                                    <tr>
                                        <td class="text-left"><strong>Fecha:</strong></td>
                                        <td class="text-left"><s:date name="venta[0].compras.fecha" format="dd/MM/yyyy"/></td>
                                    </tr>
                                    <tr>
                                        <td class="text-right"><strong>Importe:</strong></td>
                                        <td class="text-right"><s:property value="#importe"/>&euro;</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <hr/>
                        <div class="row">
                            <div class="col">
                                <h3>Productos vendidos</h3>
                                <table class="table table-striped table-bordered" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th class="text-left">Producto</th>
                                            <th>Precio(&euro;)</th>
                                            <th>Cantidad</th>
                                            <th>Subtotal(&euro;)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <s:iterator value="venta">
                                            <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                                <s:param name="idProducto" value="productos.idProducto"/>
                                            </s:url>
                                            <tr>
                                                <td class="text-left">
                                                    <s:a href = "%{idProductoUrl}">
                                                        <s:property value="productos.nombre"/>
                                                    </s:a>
                                                </td>
                                                <td><s:property value="productos.precio"/></td>
                                                <td><s:property value="cantidad"/></td>
                                                <td><s:property value="%{productos.precio*cantidad}"/></td>
                                            </tr>
                                        </s:iterator>
                                    </tbody>
                                </table>
                            </div>
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