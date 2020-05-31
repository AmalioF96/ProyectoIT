<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Carrito - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>

            <script>
                $(document).ready(function () {
                    $("input.cantidad").change(function () {
                        var total = 0;
                        var id = $(this).attr("id");
                        var pos = id.indexOf("-");
                        var idProducto = parseInt(id.substring(pos + 1, id.length));
                        var cantidad = $(this).val();
                        var precio = parseFloat($("#precio-" + idProducto).text());
                        var subtotal = cantidad * precio;
                        $("#subtotal-" + idProducto).text(subtotal.toFixed(2).toString().replace(".", ","));

                        var subtotales = $(".subtotal");
                        for (var i = 0; i < subtotales.length; i++) {
                            total += parseFloat($(subtotales[i]).text());
                        }

                        $("#precioTotalCarrito").text(total.toFixed(2).toString().replace(".", ","));

                    });
                    $('[data-toggle="tooltip"]').tooltip();
                });
            </script>
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>

            <!-- Page Content -->
            <main class="container-fluid mt-4 mx-auto">
                <h3>Mi Carrito</h3>
                <hr>
                <s:if test="%{#session.carrito==null || #session.carrito.empty}">
                    <div class='alert alert-info'>El carrito está vacío.</div>
                </s:if>
                <s:else>
                    <s:if test="hasActionErrors()">
                        <s:actionerror cssClass="alert alert-danger list-unstyled"/>
                    </s:if>
                    <s:form action="accionProcesarCarrito" method="post" theme="css_xhtml">
                        <div class='table-responsive-md'>
                            <table id="tableProductos" class="table table-light text-center">
                                <thead>
                                    <tr>
                                        <th class="text-left">Nombre</th>
                                        <th class="text-left">Descripción</th>
                                        <th>Cantidad</th>
                                        <th>Precio(&euro;)</th>
                                        <th>Subtotal(&euro;)</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:set var="total" value="0"/>
                                    <s:iterator value="#session.carrito" var="prod">
                                        <s:url var="eliminarProducto" action="eliminarCarrito">
                                            <s:param name="idProducto" value="idProducto"/>
                                            <s:param name="origin" value="'carrito'"/>
                                        </s:url>
                                        <s:url var="productoId" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="idProducto"/>
                                        </s:url>
                                        <tr class='producto'>
                                            <td class="text-left">
                                                <s:a href="%{productoId}"> 
                                                    <s:property value="nombre"/>
                                                </s:a>
                                            </td>
                                            <td class="text-left"> 
                                                <s:property value="descripcion"/>
                                            </td>
                                            <td class='tdCantidad'>
                                                <s:if test="#session.cantidad==null || #session.cantidad[idProducto]==null">
                                                    <s:set var="cant" value="1"/>
                                                </s:if>
                                                <s:else>
                                                    <s:set var="cant" value="#session.cantidad[idProducto]"/>
                                                </s:else>
                                                <s:textfield id="cantidad-%{idProducto}"  cssClass="form-control cantidad text-center" name="cantidad" type="number" min="1" value="%{#cant}"/>
                                            </td>
                                            <td>
                                                <span id="precio-<s:property value="idProducto"/>" class="precio">
                                                    <s:number name="precio" maximumFractionDigits="2" minimumFractionDigits="2" />
                                                </span>
                                            </td>
                                            <td class='tdSubtotal'>
                                                <span id="subtotal-<s:property value="idProducto"/>" class="subtotal">
                                                    <s:number name="precio*#cant" maximumFractionDigits="2" minimumFractionDigits="2" />
                                                </span>
                                            </td>
                                            <td class='tdBtnEliminar'>
                                                <s:a href="%{eliminarProducto}" cssClass="mx-2">
                                                    <i class="fas fa-trash" data-toggle="tooltip" data-placement="top" title="Eliminar"></i>
                                                </s:a>
                                            </td>
                                        </tr>
                                        <s:set var="total" value="%{#total+(precio*#cant)}" />
                                    </s:iterator>
                                    <tr>
                                        <td colspan="3"></td>
                                        <td>
                                            <strong>
                                                Total:
                                            </strong>
                                        </td>
                                        <td class="font-weight-bold">
                                            <span id="precioTotalCarrito">
                                                <s:number name="#total" maximumFractionDigits="2" minimumFractionDigits="2"/></span>&euro;
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr/>
                        <div class="my-4">
                            <input id="btnProcesarCompra" class="btn btn-md btn-primary btn-block text-uppercase form-control" type="submit" onclick="" value="Procesar Compra" name="procesarCompra">
                        </div>
                    </s:form>
                </s:else>
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>