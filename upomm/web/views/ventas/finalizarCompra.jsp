<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<html>
    <head>
        <title>Procesar Comprar - UPOMMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/views/utils/includes.jsp"%>
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
        <s:head/>
    </head>

    <body>

        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">
            <div class="m-3">
                <h3>Resumen de compra</h3>
                <hr>
                <s:if test="#session.carrito.size == 0">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:if>
                <s:elseif test="#session.carrito==null">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:elseif>
                <s:else>
                    <div class="table-responsive-sm">
                        <s:form method="post" action="accionFinalizarCompra" id="finalizarCompra" theme="css_xhtml">
                            <table id="tableProductos" class="table table-light">
                                <input type="hidden" name="email" value="<?php echo base64_encode(encriptar($_SESSION['email'])); ?>"/>
                                <input type="hidden" name="direccion" value="<?php echo base64_encode(encriptar($_SESSION['direccion'])); ?>"/>
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th class='text-center'>Precio(&euro;)</th>
                                        <th class='text-center'>Cantidad</th>
                                        <th class='text-center'>Subtotal(&euro;)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:set var="cont" value="0" />
                                    <s:set var="total" value="0"/>
                                    <s:iterator var="i" value="#session.carrito">
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
                                                <s:property value="precio"/>
                                            </td>
                                            <td class='text-center tdCantidad'>
                                                <s:property  value="#session.cantidad.get(#cont)"/>
                                            </td>
                                            <td class='text-center tdSubtotal'>
                                                <s:property value="%{precio*#session.cantidad.get(#cont)}" />
                                            </td>

                                        </tr>
                                        <s:set var="total" value="%{#total+(precio*#session.cantidad.get(#cont))}" />
                                        <s:set var="cont" value="%{#cont+1}" />
                                    </s:iterator>
                                    <tr>
                                        <td colspan="4"><strong>Total:</strong></td>
                                        <td id="precioTotalCarrito" class='text-center font-weight-bold'>
                                            <s:property  value="#total"/>&euro;
                                        </td>
                                    </tr>

                                </tbody>

                                <button type="submit" name="submitButton" value="finalizarCompra" id="botonFinalizar" hidden></button>

                            </table>
                        </div>
                        <hr>
                        <div class="custom-control custom-switch wwgrp row mx-auto my-4">
                            <s:checkbox id="terminosYCondiciones" name="terminosYCondiciones" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true"/>
                            <label class="custom-control-label wwlbl" for="terminosYCondiciones">
                                <a href="http://www.google.com/search?q=estafa" target="_blank">
                                    Acepto los términos y condiciones
                                </a>
                            </label>
                        </div>
                        <div class="row mx-auto my-4">
                            <s:submit cssClass="btn btn btn-warning text-uppercase pull-left" name="submitButton" value="Comprar" id="botonFinalizar" />
                        </div>
                    </s:form>
                </div>

                <script src="https://www.paypal.com/sdk/js?client-id=Aag_BV9saCzCn3jZU7nRT-_qMd-sJuXnc9VKSeM5li-IXLAGDi2zUsiRtPpTu3Tvr46fIq9Ce6KSjkug&currency=EUR"></script>
                <%-- <hr>--%>
                <div id="paypal-button-container"></div>

                <script>
                    $(document).ready(function () {
                        paypal.Buttons();
                    });
                </script>
                <script>
                    /*
                     * 
                     *Aquí cargamos los datos necesarios para interactuar con la API de paypal
                     */
                    paypal.Buttons({
                        style: {
                            size: 'small',
                            color: 'gold',
                            shape: 'pill'
                        },
                        createOrder: function (data, actions) {
                            return actions.order.create("<?php echo json_encode(buildRequestBody(round($total, 2), $array_productos, $direccion)); ?>");
                        },
                        onApprove: function (data, actions) {

                            return actions.order.capture().then(function (details) {

                                var formCompra = document.getElementById("finalizarCompra");
                                formCompra.submit();
                            });
                        }
                    }).render('#paypal-button-container');
                </script>

            </s:else>

        </div>
    </div>
    <!-- /.row -->

</main>
<!-- /.container -->
<%@include file="../utils/footer.html" %>
</body>

</html>