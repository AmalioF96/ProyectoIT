<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="%{#session.carrito==null || #session.carrito.empty}">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<html>
    <head>
        <title>Procesar Comprar - UPOMMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/views/utils/includes.jsp"%>
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
        <script src="https://www.paypal.com/sdk/js?client-id=Ab3EXFpwjNUJHeMDtoZ6ALhOfX8sSX7SJrCi4b41ghRqI-4aIRowbB2GHwXRbhAiaOsWv66O2y5VkXEl&currency=EUR"></script>

        <script>
            $(document).ready(function () {
                paypal.Buttons();
            });
        </script>
        <s:head/>
    </head>

    <body>
        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">
            <div class="m-3">
                <h3>Resumen de compra</h3>
                <hr>
                <s:form method="post" action="accionFinalizarCompra" id="finalizarCompra" theme="css_xhtml">
                    <div class="table-responsive-sm">
                        <table id="tableProductos" class="table table-light text-center">
                            <thead>
                                <tr>
                                    <th class="text-left">Nombre</th>
                                    <th class="text-left">Descripción</th>
                                    <th>Precio(&euro;)</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal(&euro;)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:set var="total" value="0"/>
                                <s:iterator value="#session.carrito" status="incr">
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
                                        <td >
                                            <s:property value="precio"/>
                                        </td>
                                        <td class='tdCantidad'>
                                            <s:property  value="#session.cantidad.get(#incr.index)"/>
                                        </td>
                                        <td class='tdSubtotal'>
                                            <s:property value="%{precio*#session.cantidad.get(#incr.index)}" />
                                        </td>

                                    </tr>
                                    <s:set var="total" value="%{#total+(precio*#session.cantidad.get(#incr.index))}" />
                                </s:iterator>
                                <tr>
                                    <td colspan="3"></td>
                                    <td><strong>Total:</strong></td>
                                    <td id="precioTotalCarrito" class='text-center font-weight-bold'>
                                        <s:property  value="#total"/>&euro;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <s:fielderror fieldName="terminosYCondiciones" cssClass="list-unstyled errorMessage"/>
                    <div class="custom-control custom-switch wwgrp row mx-auto my-4">
                        <s:checkbox id="terminosYCondiciones" name="terminosYCondiciones" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true" required="true"/>
                        <label class="custom-control-label wwlbl" for="terminosYCondiciones">
                            <a href="http://www.google.com/search?q=estafa" target="_blank">
                                Acepto los términos y condiciones
                            </a>
                        </label>
                    </div>
                    <%--<s:submit cssClass="btn btn-warning pull-left" value="COMPRAR"/>--%>
                </s:form>
                <div class="row mx-auto mt-4">
                    <div id="paypal-button-container" class="col-sm-4 px-0"></div>
                </div>
                <script>
                    /*
                     * 
                     *Aquí cargamos los datos necesarios para interactuar con la API de paypal
                     */
                    paypal.Buttons({
                        style: {
                            size: 'responsive',
                            color: 'gold',
                            shape: 'pill',
                            label: 'pay',
                            tagline: 'true',
                            layout: 'horizontal'
                        },
                        createOrder: function (data, actions) {
                            return actions.order.create({
                                intent: "CAPTURE",
                                application_context: {
                                    brand_name: 'UPOMediaMarket',
                                    locale: 'es-ES',
                                    landing_page: 'BILLING',
                                    user_action: 'PAY_NOW'
                                },
                                purchase_units: [{
                                        amount: {
                                            currency_code: 'EUR',
                                            value: <s:property value="#total"/>,
                                            breakdown: {
                                                item_total: {
                                                    currency_code: 'EUR',
                                                    value: <s:property value="#total"/>
                                                }
                                            }
                                        },
                                        items: <s:property value="items"/>
                                    }]
                            });
                        },
                        onApprove: function (data, actions) {
                            return actions.order.capture().then(function (details) {
                                $("#finalizarCompra").submit();
                            });
                        }
                    }).render('#paypal-button-container');
                </script>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>