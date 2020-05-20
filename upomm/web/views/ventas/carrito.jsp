<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Carrito XXX - UPOMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                        $("#subtotal-" + idProducto).text(subtotal.toFixed(2));

                        var subtotales = $(".subtotal");
                        for (var i = 0; i < subtotales.length; i++) {
                            total += parseFloat($(subtotales[i]).text());
                        }

                        $("#precioTotalCarrito").text(total.toFixed(2));

                    });
                    var inputsCantidad = $("input.cantidad");

                    for (var i = 0, max = inputsCantidad.length; i < max; i++) {
                        var input = $(inputsCantidad).get(i);
                        input.value = 1;
                        $(input).change();
                    }
                });
            </script>
        </head>
        <body>
            <%--SCRIPT PAYPAL QUE NO SE QUE HACE
    <script src="https://www.paypal.com/sdk/js?client-id=Aag_BV9saCzCn3jZU7nRT-_qMd-sJuXnc9VKSeM5li-IXLAGDi2zUsiRtPpTu3Tvr46fIq9Ce6KSjkug"></script>
            --%>
            <%@include file="../utils/header.jsp" %>

            <!-- Page Content -->
            <main class="container">
                <div class="m-3">
                    <h3>Mi carrito</h3>
                    <hr>
                    <s:if test="%{#session.carrito==null || #session.carrito.empty}">
                        <div class='alert alert-info'>El carrito está vacío.</div>
                    </s:if>
                    <s:else>
                        <s:form action="accionProcesarCarrito" method="post" theme="css_xhtml">
                            <div class='table-responsive-sm'>
                                <table id="tableProductos" class="table table-light">
                                    <thead>
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Descripción</th>
                                            <th class='text-center'>Precio(&euro;)</th>
                                            <th class='text-center'>Cantidad</th>
                                            <th class='text-center'>Subtotal(&euro;)</th>
                                            <th class='text-center'>Eliminar </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <s:set var="cont" value="0" />
                                        <s:set var="total" value="0"/>
                                        <s:iterator var="i" value="#session.carrito">
                                            <s:url var="eliminarProducto" action="eliminarCarrito">
                                                <s:param name="idProducto" value="idProducto"/>
                                                <s:param name="origin" value="'carrito'"/>
                                            </s:url>
                                            <s:url var="productoId" value="/views/productos/producto.jsp">
                                                <s:param name="idProducto" value="idProducto"/>
                                            </s:url>
                                            <tr class='producto'>
                                                <td>
                                                    <s:a href="%{productoId}"> 
                                                        <s:property value="nombre"/>
                                                    </s:a>
                                                </td>
                                                <td> 
                                                    <s:property value="descripcion"/>
                                                </td>
                                                <td class='text-center'>
                                                    <span id="precio-<s:property value="idProducto"/>" class="precio">
                                                        <s:property value="precio"/>
                                                    </span>
                                                </td>
                                                <td class='text-center tdCantidad'>
                                                    <s:textfield id="cantidad-%{idProducto}"  cssClass="form-control cantidad" name="cantidad" type="number"/>
                                                </td>
                                                <td class='text-center tdSubtotal'>
                                                    <span id="subtotal-<s:property value="idProducto"/>" class="subtotal">
                                                        <s:number name="precio" maximumFractionDigits="2" minimumFractionDigits="2"/>
                                                    </span>
                                                </td>
                                                <td class='text-center tdBtnEliminar'>
                                                    <s:a href="%{eliminarProducto}" name='btnEliminarCarrito' cssClass='btn btn-sm btn-danger btnEliminar'  value="Eliminar" >Eliminar</s:a>

                                                    </td>

                                                </tr>
                                            <s:set var="total" value="%{#total+precio}" />
                                            <s:set var="cont" value="%{#cont+1}" />
                                        </s:iterator>

                                        <tr>
                                            <td colspan="5">
                                                <strong>
                                                    Total:
                                                </strong>
                                            </td>
                                            <td class="text-center">
                                                <span id="precioTotalCarrito" class="font-weight-bold"></span> €
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <div class="my-4">
                                <input id="btnProcesarCompra" class="btn btn-md btn-primary btn-block text-uppercase form-control" type="submit" onclick="" value="Procesar Compra" name="procesarCompra">
                            </div>

                        </s:form>
                    </s:else>
                </div>
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>