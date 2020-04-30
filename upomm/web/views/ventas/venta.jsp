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
            <title>Compra - UPOMediaMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/compra.css" rel="stylesheet">
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
                });
            </script>
        </head>
        <body>
            <main>
                <div class="col-lg-3">
                    <nav id="categorias" class="list-group make-me-sticky">
                        <h4 class="text-center">Menú de Vendedor</h4>
                        <ul class="list-unstyled">
                            <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item">Mis Ventas</a></li>
                            <li><a href="/upomm/views/productos/misProductos.jsp" class="list-group-item active">Mis Productos</a></li>
                            <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear Producto</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-9 contendor table-responsive-sm">
                    <div class="row">
                        <div class="col-sm">
                            <table>
                                <tr>
                                    <td><strong>Número de pedido:</strong></td>
                                    <td class="text-left"><s:property value="compra.idProducto"/></td>
                                </tr>
                                <tr>
                                    <td><strong>Número de productos:</strong></td>
                                    <td class="text-left"><s:property value="compra.lineasDeCompras.size"/></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm text-right">
                            <table class="pull-right">
                                <tr>
                                    <td class="text-left"><strong>Fecha:</strong></td>
                                    <td><s:date name="compra.fecha" format="dd/MM/yyyy"/></td>
                                </tr>
                                <tr>
                                    <td class="text-left"><strong>Importe:</strong></td>
                                    <td><s:property value="compra.getImporte()"/>&euro;</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col" style="margin-top:1%">
                            <h3>Productos comprados</h3>
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Vendedor</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="compra.lineasDeCompras">
                                        <s:iterator value="compra.reclamacioneses">
                                            <s:if test="id.idCompra==compra.idCompra && id.idProducto==productos.idProducto">
                                                <s:set var="reclamado" value="true"/>                                        
                                            </s:if>
                                        </s:iterator>
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="productos.idProducto"/>
                                        </s:url>
                                        <tr>
                                            <td>
                                                <s:a href = "%{idProductoUrl}">
                                                    <s:property value="productos.nombre"/>
                                                </s:a>
                                            </td>
                                            <td><s:property value="productos.usuarios.nombre"/></td>
                                            <td><s:property value="productos.precio"/></td>
                                            <td><s:property value="cantidad"/></td>
                                            <td>
                                                <s:form action="crearReclamacion" cssClass="formReclamacion" theme="simple">
                                                    <s:textfield name="idProducto" value="%{productos.idProducto}" hidden="true"/>
                                                    <s:textfield name="idCompra" value="%{idCompra}" hidden="true"/>
                                                    <s:if test="#reclamado!=null">
                                                        <s:textfield type="button" cssClass="btn btn-danger reclamar" value="Reclamar" disabled="true"/>
                                                    </s:if>
                                                    <s:else>
                                                        <s:textfield type="button" cssClass="btn btn-danger reclamar" value="Reclamar"/>  
                                                    </s:else>
                                                </s:form>
                                            </td>
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